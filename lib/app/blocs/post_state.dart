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

  LoadedPostState({this.posts}) : super([posts]);

  LoadedPostState copyWith({List<Post> posts}) {
    return LoadedPostState(posts: posts ?? this.posts);
  }

  @override
  String toString() {
    return 'LoadedPostState{posts: $posts}';
  }
}

class ErrorPostState extends PostState {}
