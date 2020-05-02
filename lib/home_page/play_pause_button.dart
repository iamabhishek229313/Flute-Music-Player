import 'package:flute_music/detail_page/repository/play_bloc.dart';
import 'package:flute_music/detail_page/repository/playing_song_data_bloc.dart';
import 'package:flute_music/home_page/home_page.dart';
import 'package:flute_music/neuromorphic_UI/neuromorphic_custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Play_Pause_Button extends StatelessWidget {
  const Play_Pause_Button({
    Key key,
    @required this.info,
    @required this.isDark,
  }) : super(key: key);
  final SongInfo info;
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
              playBloc.add(PlayEvent.triggerChange);
              songData.add(ChangeSongId(info.filePath));
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
