import 'package:bloc/bloc.dart';

class SongDataEvent{

}

class ChangeSongId extends SongDataEvent {
  final String id ;
  ChangeSongId(this.id) ;
}

// evnets 

class SongDataBloc extends Bloc<SongDataEvent, String> {
  @override
  String get initialState => '' ;

  @override
  void onTransition(Transition<SongDataEvent, String> transition) {
    print(transition) ;
  }

  @override
  Stream<String> mapEventToState(
    SongDataEvent event,
  ) async* {
    if(event is ChangeSongId){
      yield event.id ;
    }
  }
}

