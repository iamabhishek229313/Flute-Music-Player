import 'package:flute_music/detail_page/repository/play_bloc.dart';
import 'package:flute_music/detail_page/repository/playing_song_data_bloc.dart';
import 'package:flute_music/home_page/home_page.dart';
import 'package:flute_music/neuromorphic_UI/neuromorphic_custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:just_audio/just_audio.dart';

class Play_Pause_Button extends StatelessWidget {
  const Play_Pause_Button({
    Key key,
    @required this.info,
    @required this.player,
    @required this.isDark,
  }) : super(key: key);
  final SongInfo info;
  final AudioPlayer player;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final playBloc = BlocProvider.of<PlayBloc>(context);
    final songData = BlocProvider.of<SongDataBloc>(context);
    return BlocBuilder<SongDataBloc, String>(
        builder: (BuildContext context, String id) {
      return Expanded(
        flex: 1,
        child: new NeumorphicButton(
            boxShape: NeumorphicBoxShape.circle(),
            onClick: () {
              print("Audio Player State ==== " + player.playbackState.toString());
              if (songData.state != info.filePath && songData.state != '') {
                // Some other media ia being played .
                playBloc.add(PlayEvent.triggerChange);
               // player.stop(); // stop previous song .
                player.setUrl(info.filePath); // start a new song .
                player.play();
              } else if (songData.state == info.filePath &&
                  (player.playbackState == AudioPlaybackState.playing)) {
                // If the current song is being playerd and now it's time to pause it .
                player.pause();
              } else if (songData.state == info.filePath &&
                  (player.playbackState == AudioPlaybackState.paused)) {
                player.play();
              }
              songData.add(ChangeSongId(
                  info.filePath)); // Register the new song to the bloc .
              playBloc.add(PlayEvent
                  .triggerChange); // Trigger the change of state of PlayBloc .

              print("Audio Player State ==== Ends    " + player.playbackState.toString());
              
            },
            style: isDark ? dark_softUI : light_softUI,
            child: BlocBuilder<PlayBloc, bool>(
              builder: (BuildContext context, bool isPlaying) {
                return Icon(
                  (id == info.filePath && isPlaying)
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Theme.of(context).highlightColor,
                );
              },
            )),
      );
    });
  }
}
