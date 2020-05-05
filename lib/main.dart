import 'package:flute_music/audio_player_wrapper.dart';
import 'package:flute_music/detail_page/repository/audio_player_bloc.dart';
import 'package:flute_music/detail_page/repository/page_delegate_bloc.dart';
import 'package:flute_music/detail_page/repository/play_bloc.dart';
import 'package:flute_music/detail_page/repository/playing_song_data_bloc.dart';
import 'package:flute_music/home_page/home_page.dart';
import 'package:flute_music/theming/dynamic_theming._bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
void main() {
  final previousCheck = Provider.debugCheckInvalidValueType;
  Provider.debugCheckInvalidValueType = <T>(T value) {
    if (value is Bloc) return;
    previousCheck<T>(value);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ThemeBloc>(create: (BuildContext context) => ThemeBloc(),),
        RepositoryProvider<PlayBloc>(create : (BuildContext context) => PlayBloc(),),
        RepositoryProvider<SongDataBloc>(create: (BuildContext context) => SongDataBloc(),),
        RepositoryProvider<AudioPlayerBloc>(create: (BuildContext context) => AudioPlayerBloc(),),
        RepositoryProvider<PageDelegateBloc>(create: (BuildContext context) => PageDelegateBloc(),)
      ],
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
