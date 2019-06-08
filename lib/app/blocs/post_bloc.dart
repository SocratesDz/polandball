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
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is Fetch) {
      try {
        if (currentState is UninitializedPostState) {
          final postsData = await api.getPostsData();
          yield LoadedPostState(
              posts: postsData.children,
              after: postsData.after,
              before: postsData.before);
          return;
        }
        if (currentState is LoadedPostState) {
          final currentPostDataState = currentState as LoadedPostState;
          if (currentPostDataState == null) {
            yield currentState;
            return;
          }
          final postsData = await api.getPostsData(
              after: currentPostDataState.after,
              before: currentPostDataState.before);
          yield currentPostDataState.copyWith(
              posts: currentPostDataState.posts + postsData.children,
              after: postsData.after,
              before: postsData.before);
          return;
        }
      } catch (ex) {
        debugPrint(ex);
        yield ErrorPostState();
      }
    }
  }
}
