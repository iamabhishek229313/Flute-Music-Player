import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flute_music/detail_page/repository/play_bloc.dart';
import 'package:flute_music/detail_page/repository/playing_song_data_bloc.dart';
import 'package:flute_music/neuromorphic_UI/neuromorphic_custom_styles.dart';
import 'package:flute_music/theming/dynamic_theming._bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class Song_Detail_Page extends StatefulWidget {
  final SongInfo info;
  final AudioPlayer player;
  final Color albumArt;
  Song_Detail_Page(this.info, this.player, this.albumArt);
  @override
  _Song_Detail_PageState createState() => _Song_Detail_PageState();
}

class _Song_Detail_PageState extends State<Song_Detail_Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var dragValue ;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playBloc = BlocProvider.of<PlayBloc>(context);
    final songData = BlocProvider.of<SongDataBloc>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<ThemeBloc, bool>(
          builder: (BuildContext context, bool isDark) {
            return SafeArea(
              child: Column(
                children: [
                  Custom_App_Bar(isDark: isDark),
                  new SizedBox(
                    height: ScreenUtil().setHeight(30.0),
                  ),
                  Album_Art_widget(isDark, widget.info),
                  Song_Detail(widget: widget),
                  new Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(0.0)),
                      child: new SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              activeTrackColor: widget.albumArt,
                              inactiveTrackColor: Colors.grey,
                              thumbColor: Theme.of(context).highlightColor,
                              trackHeight: ScreenUtil().setHeight(10.0)),
                          child: StreamBuilder<Duration>(
                            stream: widget.player.durationStream,
                            builder: (context, snapshot) {
                              var duration = snapshot.data ?? Duration.zero;
                              return StreamBuilder(
                                stream: widget.player.getPositionStream(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  var position = snapshot.data ?? Duration.zero;
                                  if (position > duration) {
                                    position = duration;
                                  }
                                  return Slider(
                                    min: 0.0,
                                    max: duration.inMilliseconds.toDouble(),
                                    value: dragValue ?? position.inMilliseconds.toDouble(),
                                    onChanged: (val) {
                                      setState(() {
                                        dragValue = val ;
                                        widget.player.seek(Duration(milliseconds: val.round()));
                                        if(val == duration.inMilliseconds.toDouble()){
                                          widget.player.stop();
                                          playBloc.add(PlayEvent.triggerChange);
                                          print("completed task !");
                                        }
                                      });
                                    },
                                    onChangeEnd: (endVal){
                                      setState(() {
                                        dragValue = null ;
                                        widget.player.seek(Duration(milliseconds: endVal.round()));
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ))),
                  new SizedBox(
                    height: ScreenUtil().setHeight(60.0),
                  ),
                  new BlocBuilder<PlayBloc, bool>(
                      builder: (BuildContext context, bool isPlaying) {
                    return new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        new Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width * 0.5,
                                child: NeumorphicButton(
                                  onClick: () {},
                                  provideHapticFeedback: true,
                                  boxShape: NeumorphicBoxShape.circle(),
                                  style: isDark ? dark_softUI : light_softUI,
                                  child: new Icon(Icons.skip_previous),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width * 0.8,
                                child: NeumorphicButton(
                                  onClick: () async {
                                    if (songData.state ==
                                        widget.info.filePath) {
                                      // Does the play and pause thing .
                                      if (playBloc.state &&
                                          (widget.player.playbackState ==
                                              AudioPlaybackState.playing)) {
                                        //print("First") ;
                                        widget.player.pause();
                                      } else if (!playBloc.state &&
                                          (widget.player.playbackState ==
                                              AudioPlaybackState.paused)) {
                                        //print("Second") ;
                                        widget.player.play();
                                      }
                                    } else if (songData.state !=
                                        widget.info.filePath) {
                                      // if something is being played and another button is clicked .
                                      if (playBloc.state) if (songData.state !=
                                          '') {
                                        if (widget.player.playbackState ==
                                            AudioPlaybackState.playing)
                                          playBloc.add(PlayEvent
                                              .triggerChange); // Change previous button state .
                                      }
                                      widget.player
                                          .stop(); // Wehteher previous one is being played or paused we delete it through lineup .
                                      await widget.player.setUrl(widget.info
                                          .filePath); // Trigger out new song into the player .
                                      widget.player
                                          .play(); // Play the new song .
                                      print("Fourth");
                                    } else if (!playBloc.state &&
                                        (songData.state == '') &&
                                        (widget.player.playbackState ==
                                            AudioPlaybackState.none)) {
                                      // First time play  .
                                      await widget.player
                                          .setUrl(widget.info.filePath);
                                      widget.player.play();
                                      //print("last one");
                                    }
                                    songData.add(
                                        ChangeSongId(widget.info.filePath));

                                    playBloc.add(PlayEvent.triggerChange);
                                  },
                                  provideHapticFeedback: true,
                                  boxShape: NeumorphicBoxShape.circle(),
                                  style: isDark ? dark_softUI : light_softUI,
                                  child: new Icon(
                                      (isPlaying &&
                                              (songData.state ==
                                                  widget.info.filePath))
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 60.0),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width * 0.5,
                                child: NeumorphicButton(
                                  onClick: () {},
                                  boxShape: NeumorphicBoxShape.circle(),
                                  style: isDark ? dark_softUI : light_softUI,
                                  child: new Icon(Icons.skip_next),
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              new NeumorphicButton(
                                onClick: () {},
                                boxShape: NeumorphicBoxShape.roundRect(
                                    borderRadius: BorderRadius.circular(20.0)),
                                style: isDark ? dark_softUI : light_softUI,
                                child: new Icon(Icons.all_inclusive),
                              ),
                              new NeumorphicButton(
                                onClick: () {},
                                boxShape: NeumorphicBoxShape.roundRect(
                                    borderRadius: BorderRadius.circular(20.0)),
                                style: isDark ? dark_softUI : light_softUI,
                                child: new Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).cardColor,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  })
                ],
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class Custom_App_Bar extends StatelessWidget {
  const Custom_App_Bar({
    Key key,
    @required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.07,
      color: Theme.of(context).primaryColor,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NeumorphicButton(
            margin: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
            boxShape: NeumorphicBoxShape.circle(),
            onClick: () {
              Navigator.pop(context);
            },
            style: isDark ? dark_softUI : light_softUI,
            child: new Icon(
              Icons.arrow_back,
              color: Theme.of(context).highlightColor,
            ),
          ),
          new Text(
            "PLAYING NOW",
            style: new TextStyle(
                fontFamily: "Nunito",
                fontSize: ScreenUtil().setSp(40.0),
                fontWeight: FontWeight.w900,
                color: Colors.grey),
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
    );
  }
}

class Song_Detail extends StatelessWidget {
  const Song_Detail({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Song_Detail_Page widget;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40.0)),
      height: MediaQuery.of(context).size.height * 0.08,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Text(
            widget.info.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: ScreenUtil().setSp(60.0)),
          ),
          new RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(children: [
                new TextSpan(
                  text: "Artist  ",
                  style: new TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(30.0)),
                ),
                new TextSpan(
                  text: widget.info.artist,
                  style: new TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(30.0)),
                )
              ])),
        ],
      ),
    );
  }
}

class Album_Art_widget extends StatelessWidget {
  final bool isDark;
  final SongInfo info;
  const Album_Art_widget(this.isDark, this.info);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          child: new Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: new Neumorphic(
              boxShape: NeumorphicBoxShape.circle(),
              margin: EdgeInsets.all(ScreenUtil().setWidth(90.0)),
              style: isDark
                  ? dark_softUI.copyWith(
                      intensity: 1, shadowDarkColor: Colors.black54, depth: 6)
                  : light_softUI.copyWith(
                      intensity: 1, shadowDarkColor: Colors.black26, depth: 8),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.010,
          child: new Container(
            // color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.38,
            width: MediaQuery.of(context).size.width,
            child: new Neumorphic(
                boxShape: NeumorphicBoxShape.circle(),
                margin: EdgeInsets.all(ScreenUtil().setWidth(90.0)),
                style: isDark
                    ? dark_softUI.copyWith(
                        intensity: 1,
                        shadowDarkColor: Colors.black54,
                        depth: -1)
                    : light_softUI.copyWith(
                        intensity: 1,
                        shadowDarkColor: Colors.black26,
                        depth: -1),
                child: Hero(
                    tag: info.filePath,
                    child: new Container(
                      child : new Image(
                        image: new AssetImage('assets/images/steal_my_girl.jpg'),
                      )
                    ) //Image.network(widget.info.albumArtwork)),
                    )),
          ),
        ),
      ],
    );
  }
}
