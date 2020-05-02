import 'package:bloc/bloc.dart';

// Our Event .
enum PlayEvent { makeTrue , makeFalse }


// Our Business Logic 
class PlayBloc extends Bloc<PlayEvent, bool> {
  @override
  bool get initialState => false; // not being played .


@override
  void onTransition(Transition<PlayEvent, bool> transition) {
    print(transition);
  }
  
  @override
  Stream<bool> mapEventToState(
    PlayEvent event,
  ) async* {
    switch (event) {
      case PlayEvent.makeTrue:
        yield true ;
        break ;
      case PlayEvent.makeFalse:
        yield false ;
        break ;
    }
  }
}

// Our State will be at the Flutter files .