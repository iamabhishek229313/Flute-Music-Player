// import 'package:flute_music/detail_page/repository/page_delegate_bloc.dart';
// import 'package:flute_music/detail_page/repository/play_bloc.dart';
// import 'package:flute_music/detail_page/repository/playing_song_data_bloc.dart';
// import 'package:flute_music/detail_page/song_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_audio/just_audio.dart';

// class AudioPlayerWrapper extends StatefulWidget {
//   @override
//   _AudioPlayerWrapperState createState() => _AudioPlayerWrapperState();
// }

// class _AudioPlayerWrapperState extends State<AudioPlayerWrapper> {
//   static AudioPlayer player ;

//   @override
//   void initState() {
//     super.initState();
//     player = new AudioPlayer() ;
//   }

//   setup_player(String url) async {
//     await player.setUrl(url);
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _songDataBloc = BlocProvider.of<SongDataBloc>(context);
//     return BlocBuilder<PageDelegateBloc,bool>(
//       builder: (BuildContext context, bool isDetailPage) {
//         return isDetailPage ? Song_Detail_Page(_songDataBloc.state, , );
//       },
//     ),
//   }
// }