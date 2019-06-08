import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polandball/app/blocs/bloc.dart';
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
        backgroundColor: Colors.black,
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
                    return GridView.count(
                        controller: _scrollController,
                        crossAxisCount: 2,
                        children: List.generate(posts.length, (index) {
                          var post = posts[index];
                          return _generateImage(post.data.id, post.data.title,
                              post.data.thumbnail, post.data.url);
                        }));
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

  Widget _generateImage(
      String id, String title, String thumbnailUrl, String imageUrl) {
    var photoTag = PHOTO_DETAIL_HERO_TAG + id;
    return InkWell(
        child: GridTile(
          child: Hero(
              tag: photoTag,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: thumbnailUrl,
                placeholder: (_, __) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorWidget: (_, __, ___) {
                  return Container(
                    child: Center(
                      child: IconButton(
                          icon: Icon(Icons.refresh), onPressed: () {}),
                    ),
                  );
                },
              )),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(title),
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => new PostDetailPage(
                imageUrl: imageUrl,
                thumbnailImage: thumbnailUrl,
                photoDetailTag: photoTag))));
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
