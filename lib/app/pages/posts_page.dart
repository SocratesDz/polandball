import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polandball/app/blocs/post/bloc.dart';
import 'package:polandball/app/widgets/grid_post_image.dart';
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
    _bloc.add(Fetch());
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
                cubit: _bloc,
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
                          return GridPostImage(
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
                                  _bloc.add(Fetch());
                                })));
                  }
                  return Container();
                })));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.add(Fetch());
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}