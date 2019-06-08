import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:polandball/domain/entities/models.dart';

@immutable
abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

class UninitializedPostState extends PostState {}

class LoadedPostState extends PostState {
  final List<Post> posts;
  final String after;
  final String before;

  LoadedPostState({this.posts, this.after, this.before})
      : super([posts, after, before]);

  LoadedPostState copyWith({List<Post> posts, String after, String before}) {
    return LoadedPostState(
        posts: posts ?? this.posts,
        after: after ?? this.after,
        before: before ?? this.before);
  }

  @override
  String toString() {
    return 'LoadedPostState{posts: $posts}';
  }
}

class ErrorPostState extends PostState {}
