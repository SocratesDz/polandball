import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polandball/app/blocs/post/bloc.dart';
import 'package:polandball/app/pages/post_detail_page.dart';
import 'package:polandball/data/repositories/api.dart';

class PostsPage extends StatefulWidget {
  static final PATH = "/posts";

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _bloc = PostBloc(api: RedditApi());
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _bloc.dispatch(Fetch());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Polandball"),
        ),
        body: Container(
            child: BlocBuilder(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is UninitializedPostState) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is LoadedPostState) {
                    var posts = state.posts;
                    posts =
                        posts.where((p) => p.data.postHint == "image").toList();
                    return GridView.builder(
                        controller: _scrollController,
                        itemCount: posts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          var post = posts[index];
                          return new _GridPostImage(
                              context: context,
                              id: post.data.id,
                              title: post.data.title,
                              thumbnailUrl: post.data.thumbnail,
                              imageUrl: post.data.url);
                        });
                  } else if (state is ErrorPostState) {
                    return Container(
                        child: Center(
                            child: IconButton(
                                icon: Icon(Icons.refresh),
                                onPressed: () {
                                  _bloc.dispatch(Fetch());
                                })));
                  }
                })));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.dispatch(Fetch());
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class _GridPostImage extends StatefulWidget {
  final BuildContext context;
  final String id;
  final String title;
  final String thumbnailUrl;
  final String imageUrl;

  _GridPostImage(
      {this.context, this.id, this.title, this.thumbnailUrl, this.imageUrl});

  @override
  __GridPostImageState createState() => __GridPostImageState();
}

class __GridPostImageState extends State<_GridPostImage>
    with TickerProviderStateMixin<_GridPostImage> {
  AnimationController _controller;
  Animation _fadeAnimation;
  Animation _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    var photoTag = PHOTO_DETAIL_HERO_TAG + widget.id;
    _controller.forward();
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black, blurRadius: 0.0, spreadRadius: 0.0)
                ],
                border: Border.all(color: Colors.grey[200]),
                borderRadius: BorderRadius.all(Radius.circular(2.0))),
            child: InkWell(
                child: GridTile(
                  child: Hero(
                      tag: photoTag,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.thumbnailUrl,
                        placeholder: (_, __) {
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorWidget: (_, __, ___) {
                          return Container(
                            child: Center(
                              child: IconButton(
                                  icon: Icon(Icons.error_outline),
                                  onPressed: () {}),
                            ),
                          );
                        },
                      )),
                  footer: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    child: GridTileBar(
                      backgroundColor: Colors.grey[200],
                      title: Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.black87, fontFamily: "Mali"),
                      ),
                    ),
                  ),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                        imageUrl: widget.imageUrl,
                        thumbnailImage: widget.thumbnailUrl,
                        photoDetailTag: photoTag)))),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
