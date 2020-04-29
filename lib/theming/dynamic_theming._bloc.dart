import 'dart:async';

class ThemeBloc {
  final _dynamic_theming_bloc = StreamController<bool>() ;

  get changeTheme => _dynamic_theming_bloc.sink.add ;

  get currentTheme => _dynamic_theming_bloc.stream ;
} 

 // Sink In 
 // Stream Out .