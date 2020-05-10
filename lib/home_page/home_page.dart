import 'dart:math';

import 'package:flute_music/detail_page/repository/play_bloc.dart';
import 'package:flute_music/detail_page/repository/playing_song_data_bloc.dart';
import 'package:flute_music/detail_page/song_detail_page.dart';
import 'package:flute_music/home_page/animated_progress.dart';
import 'package:flute_music/home_page/song_card_details.dart';
import 'package:flute_music/neuromorphic_UI/neuromorphic_custom_styles.dart';
import 'package:flute_music/song_data/fetch_songs.dart';
import 'package:flute_music/theming/dynamic_theming._bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  FetchSongs fetchSongs;
  static AudioPlayer player;
  var dragValue;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    fetchSongs = new FetchSongs();
    player = new AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "---------------------------------------DEBUG KIND OF-------------------------------------------");
    print("State of the playing condition " +
        BlocProvider.of<PlayBloc>(context).state.toString());
    print("State of the songData revceicved " +
        BlocProvider.of<SongDataBloc>(context).state.toString());

    final playBloc = BlocProvider.of<PlayBloc>(context);
    final songData = BlocProvider.of<SongDataBloc>(context);

    ScreenUtil.init(context);
    return BlocBuilder<ThemeBloc, bool>(builder: (context, bool isDark) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        drawer: _drawer(),
        body: SafeArea(
          child: new Stack(
            children: <Widget>[
              Column(
                children: [
                  new Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    color: Theme.of(context).primaryColor,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(11.0),
                          child: InkWell(
                            onTap: () => _scaffoldKey.currentState.openDrawer(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: new Image(
                                image: AssetImage(
                                    'assets/images/abhishekProfile.JPG'),
                              ),
                            ),
                          ),
                        ),
                        NeumorphicButton(
                          margin: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
                          boxShape: NeumorphicBoxShape.circle(),
                          onClick: () {},
                          style: isDark ? dark_softUI : light_softUI,
                          child: new Icon(
                            Icons.search,
                            color: Theme.of(context).highlightColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new FutureBuilder(
                        future: fetchSongs.songs_list(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data);
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  final SongInfo info = snapshot.data[index];
                                  final Color albumArt =
                                      info.albumArtwork == null
                                          ? Colors.primaries[Random()
                                              .nextInt(Colors.primaries.length)]
                                          : Colors.black;
                                  final double duration =
                                      int.parse(info.duration) / 1000 / 60;
                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        margin: index == 0
                                            ? EdgeInsets.only(top: 10.0)
                                            : null,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            new Expanded(
                                                flex: 4,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Song_Detail_Page(
                                                                  info,
                                                                  player,
                                                                  albumArt,
                                                                )));
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: new Row(
                                                      children: [
                                                        new Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          95.0),
                                                              width: ScreenUtil()
                                                                  .setHeight(
                                                                      95.0),
                                                              decoration: new BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: info.albumArtwork ==
                                                                          null
                                                                      ? Colors.primaries[Random().nextInt(Colors
                                                                          .primaries
                                                                          .length)]
                                                                      : Colors
                                                                          .black),
                                                            )),
                                                        Song_Card_Details(
                                                            info: info,
                                                            duration: duration)
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: new NeumorphicButton(
                                                  boxShape: NeumorphicBoxShape
                                                      .circle(),
                                                  onClick: () async {
                                                    if (songData.state ==
                                                        info.filePath) {
                                                      // Does the play and pause thing .
                                                      if (playBloc.state &&
                                                          (player.playbackState ==
                                                              AudioPlaybackState
                                                                  .playing)) {
                                                        print("First");
                                                        player.pause();
                                                      } else if (!playBloc
                                                              .state &&
                                                          (player.playbackState ==
                                                              AudioPlaybackState
                                                                  .paused)) {
                                                        print("Second");
                                                        player.play();
                                                      }
                                                    } else if (songData.state !=
                                                        info.filePath) {
                                                      // if something is being played and another button is clicked .
                                                      if (playBloc
                                                          .state) if (songData
                                                              .state !=
                                                          '') {
                                                        if (player
                                                                .playbackState ==
                                                            AudioPlaybackState
                                                                .playing)
                                                          playBloc.add(PlayEvent
                                                              .triggerChange); // Change previous button state .
                                                      }
                                                      player
                                                          .stop(); // Wehteher previous one is being played or paused we delete it through lineup .
                                                      await player.setUrl(info
                                                          .filePath); // Trigger out new song into the player .
                                                      player
                                                          .play(); // Play the new song .
                                                      print("Fourth");
                                                    } else if (!playBloc.state &&
                                                        (songData.state ==
                                                            '') &&
                                                        (player.playbackState ==
                                                            AudioPlaybackState
                                                                .none)) {
                                                      // First time play  .
                                                      await player.setUrl(
                                                          info.filePath);
                                                      player.play();
                                                      print("last one");
                                                    }
                                                    playBloc.add(PlayEvent
                                                        .triggerChange);
                                                    songData.add(ChangeSongId(
                                                        info.filePath));
                                                  },
                                                  style: isDark
                                                      ? dark_softUI
                                                      : light_softUI,
                                                  child: BlocBuilder<PlayBloc,
                                                      bool>(
                                                    builder:
                                                        (BuildContext context,
                                                            bool isPlaying) {
                                                      return Icon(
                                                        (songData.state ==
                                                                    info.filePath &&
                                                                isPlaying)
                                                            ? Icons.pause
                                                            : Icons.play_arrow,
                                                        color: Theme.of(context)
                                                            .highlightColor,
                                                      );
                                                    },
                                                  )),
                                            )
                                            // Play_Pause_Button(
                                            //     isDark: isDark, info: info ,player : player)
                                          ],
                                        ),
                                      ),
                                      index == snapshot.data.length - 1
                                          ? Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                            )
                                          : Container()
                                    ],
                                  );
                                });
                          }
                          return animated_progress();
                        }),
                  )
                ],
              ),
              BlocBuilder<PlayBloc, bool>(
                builder: (BuildContext context, bool isPlaying) {
                  return isPlaying
                      ? new Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: isDark ? Colors.black : Colors.grey.shade400,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: new Row(
                              children: [
                                new Expanded(
                                    child: new Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    new Text(
                                      songData.state,
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: ScreenUtil().setSp(30.0),
                                          ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: new SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(
                                                      activeTrackColor:
                                                          Colors.blue,
                                                      inactiveTrackColor:
                                                          Colors.grey,
                                                      thumbColor:
                                                          Theme.of(context)
                                                              .highlightColor,
                                                      trackHeight: ScreenUtil()
                                                          .setHeight(5.0)),
                                              child: StreamBuilder<Duration>(
                                                stream: player.durationStream,
                                                builder: (context, snapshot) {
                                                  var duration =
                                                      snapshot.data ??
                                                          Duration.zero;
                                                  return StreamBuilder(
                                                    stream: player
                                                        .getPositionStream(),
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                      var position =
                                                          snapshot.data ??
                                                              Duration.zero;
                                                      if (position > duration) {
                                                        position = duration;
                                                      }
                                                      return Slider(
                                                        min: 0.0,
                                                        max: duration
                                                            .inMilliseconds
                                                            .toDouble(),
                                                        value: dragValue ??
                                                            position
                                                                .inMilliseconds
                                                                .toDouble(),
                                                        onChanged: (val) {
                                                          setState(() {
                                                            dragValue = val;
                                                            player.seek(Duration(
                                                                milliseconds: val
                                                                    .round()));
                                                            if (val ==
                                                                duration
                                                                    .inMilliseconds
                                                                    .toDouble()) {
                                                              player.stop();
                                                              playBloc.add(PlayEvent
                                                                  .triggerChange);
                                                              print(
                                                                  "completed task !");
                                                            }
                                                          });
                                                        },
                                                        onChangeEnd: (endVal) {
                                                          setState(() {
                                                            dragValue = null;
                                                            player.seek(Duration(
                                                                milliseconds:
                                                                    endVal
                                                                        .round()));
                                                          });
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              )),
                                        ),
                                        InkWell(
                                            onTap: () async{
                                              print("Executing");
                                              playBloc.add(PlayEvent.triggerChange);
                                              if(player.playbackState == AudioPlaybackState.playing){
                                                await player.pause();
                                              }else if(player.playbackState == AudioPlaybackState.paused){
                                                await player.play() ;
                                              }
                                            },
                                            child: new Icon(isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow , size: ScreenUtil().setSp(100.0),) ),
                                      ],
                                    ),
                                  ],
                                )),
                                new Container(
                                  margin: EdgeInsets.all(
                                      ScreenUtil().setHeight(10.0)),
                                  width:
                                      MediaQuery.of(context).size.height * 0.09,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                )
                              ],
                            ),
                          ))
                      : SizedBox();
                },
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return BlocBuilder<ThemeBloc, bool>(builder: (context, bool isDark) {
      return new Drawer(
          child: ListView(
        children: [
          ListTile(
            leading: new Text("Dark Mode"),
            trailing: new Switch(
              value: isDark,
              //onChanged: bloc.changeTheme,
              onChanged: (value) {
                if (isDark)
                  themeBloc.add(ThemeEvent.lightTheme);
                else
                  themeBloc.add(ThemeEvent.darkTheme);
              },
            ),
          )
        ],
      ));
    });
  }
}
