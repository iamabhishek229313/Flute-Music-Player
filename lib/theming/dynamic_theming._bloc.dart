import 'package:bloc/bloc.dart';

// Events 
enum ThemeEvent{
  lightTheme ,
  darkTheme
}

// Our Business Logic
class ThemeBloc extends Bloc<ThemeEvent, bool> {
  @override
  bool get initialState => false ;

  @override
  void onTransition(Transition<ThemeEvent, bool> transition) {
    print(transition);
  }
  
  @override
  Stream<bool> mapEventToState(
    ThemeEvent event,
  ) async* {
    switch(event){
      case ThemeEvent.lightTheme:
        yield false ;
        break ;
      case ThemeEvent.darkTheme :
        yield true ;
        break ;
    }
  }
}

// State will be at the Flutter Code .
