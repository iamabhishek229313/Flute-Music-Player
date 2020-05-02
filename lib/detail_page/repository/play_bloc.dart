import 'package:bloc/bloc.dart';

// Our Event .
enum PlayEvent { triggerChange }

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
    if (event == PlayEvent.triggerChange) yield !state;
  }
}

// Our State will be at the Flutter files .
