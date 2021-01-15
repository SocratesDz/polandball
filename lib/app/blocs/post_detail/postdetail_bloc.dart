import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  PostDetailBloc() : super(InitialPostDetailState());

  @override
  Stream<PostDetailState> mapEventToState(
    PostDetailEvent event,
  ) async* {
    if (event is LoadPicture) {}
  }
}
