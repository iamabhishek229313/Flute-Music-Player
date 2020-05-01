import 'dart:async';

class PlayBloc {
  final StreamController<bool> _playing_bloc = new StreamController() ;

  get currentStatus => _playing_bloc.stream ;
  get changeStatus =>  _playing_bloc.sink ;
}