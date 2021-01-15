import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:polandball/data/repositories/api.dart';
import 'package:polandball/app/blocs/post/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final RedditApi api;

  PostBloc({this.api}): super(UninitializedPostState());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is Fetch) {
      try {
        if (state is UninitializedPostState) {
          final postsData = await api.getPostsData();
          yield LoadedPostState(
              posts: postsData.children,
              after: postsData.after,
              before: postsData.before);
          return;
        }
        if (state is LoadedPostState) {
          final currentPostDataState = state as LoadedPostState;
          if (currentPostDataState == null) {
            yield state;
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
