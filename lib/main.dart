import 'package:flute_music/home_page/home_page.dart';
import 'package:flute_music/theming/dynamic_theming._bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeBloc _themeBloc = new ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, bool>(
          builder: (BuildContext context, bool isDark) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flute Music Player @github : iamabhishek229313',
            theme: isDark
                ? ThemeData.dark().copyWith(
                    cardColor: Color.fromRGBO(176, 0, 32, 1.0),
                    primaryColor: Color.fromRGBO(30, 31, 35, 1.0),
                    highlightColor: Colors.white)
                : ThemeData.light().copyWith(
                    cardColor: Color.fromRGBO(176, 0, 32, 1.0),
                    primaryColor: Color.fromRGBO(225, 230, 236, 1.0),
                    highlightColor: Colors.black),
            home: MyHomePage(),
          );
        }));
  }
}
