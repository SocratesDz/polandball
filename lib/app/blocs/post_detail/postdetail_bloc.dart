import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  @override
  PostDetailState get initialState => InitialPostDetailState();

  @override
  Stream<PostDetailState> mapEventToState(
    PostDetailEvent event,
  ) async* {
    if(event is LoadPicture) {

    }
  }
}
