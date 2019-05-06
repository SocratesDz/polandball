import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:polandball/data/repositories/api.dart';
import './bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final RedditApi api;

  PostBloc({this.api});

  @override
  PostState get initialState => UninitializedPostState();

  @override
  Stream<PostState> mapEventToState(PostEvent event,) async* {
    if (event is Fetch) {
      try {
        final posts = await api.getPosts();
        yield LoadedPostState(posts: posts);
      } catch (ex) {
        debugPrint(ex);
        yield ErrorPostState();
      }
    }
  }
}
