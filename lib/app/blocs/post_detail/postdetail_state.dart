import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostDetailState extends Equatable {
  PostDetailState([List props = const []]) : super(props);
}

class InitialPostDetailState extends PostDetailState {}
