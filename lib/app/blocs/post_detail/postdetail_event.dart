import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostDetailEvent extends Equatable {
  PostDetailEvent([List props = const []]) : super(props);
}

class LoadPicture extends PostDetailEvent {}