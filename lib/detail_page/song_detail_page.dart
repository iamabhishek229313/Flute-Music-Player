// import 'dart:math';

// import 'package:audio_service/audio_service.dart';
// import 'package:flute_music/detail_page/repository/play_bloc.dart';
// import 'package:flute_music/neuromorphic_UI/neuromorphic_custom_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_audio_query/flutter_audio_query.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:just_audio/just_audio.dart';

// class Song_Detail_Page extends StatefulWidget {
//   final bool isDark;
//   final SongInfo info;
//   final Color albumArt;
//   Song_Detail_Page(this.info, this.albumArt, this.isDark);
//   @override
//   _Song_Detail_PageState createState() => _Song_Detail_PageState();
// }

// class _Song_Detail_PageState extends State<Song_Detail_Page> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   static AudioPlayer player;
//   PlayBloc playing_bloc;

//   @override
//   void initState() {
//     super.initState();
//     playing_bloc = new PlayBloc();
//     player = AudioPlayer();
//   }

//   setup_player() async {
//     await player.setUrl(widget.info.filePath);
//     return Container();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         body: FutureBuilder(
//             future: setup_player(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 print(widget.info.filePath);
//                 return new SafeArea(
//                   child: Column(
//                     children: [
//                       Custom_App_Bar(widget: widget),
//                       new SizedBox(
//                         height: ScreenUtil().setHeight(30.0),
//                       ),
//                       Album_Art_widget(widget: widget),
//                       Song_Detail(widget: widget),
//                       new Container(
//                           height: MediaQuery.of(context).size.height * 0.11,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: ScreenUtil().setWidth(0.0)),
//                           child: new SliderTheme(
//                               data: SliderTheme.of(context).copyWith(
//                                   activeTrackColor: widget.albumArt,
//                                   inactiveTrackColor: Colors.grey,
//                                   thumbColor: Theme.of(context).highlightColor,
//                                   trackHeight: ScreenUtil().setHeight(10.0)),
//                               child: Slider(
//                                 min: 0.0,
//                                 max: 100.0,
//                                 value: 20.0,
//                                 onChanged: (val) {},
//                               ))),
//                       new SizedBox(
//                         height: ScreenUtil().setHeight(60.0),
//                       ),
//                       new StreamBuilder(
//                           initialData: false,
//                           stream: playing_bloc.currentStatus,
//                           builder: (context, snapshot) {
//                             return new Column(
//                               children: [
//                                 new Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.10,
//                                   child: new Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Container(
//                                         height:
//                                             MediaQuery.of(context).size.width *
//                                                 0.5,
//                                         child: NeumorphicButton(
//                                           onClick: () {},
//                                           provideHapticFeedback: true,
//                                           boxShape: NeumorphicBoxShape.circle(),
//                                           style: widget.isDark
//                                               ? dark_softUI
//                                               : light_softUI,
//                                           child: new Icon(Icons.skip_previous),
//                                         ),
//                                       ),
//                                       Container(
//                                         height:
//                                             MediaQuery.of(context).size.width *
//                                                 0.8,
//                                         child: NeumorphicButton(
//                                           onClick: () async {
//                                             print(playing_bloc.currentStatus);

//                                             if (snapshot.data)
//                                               await player.pause();
//                                             else
//                                               player.play();

//                                             playing_bloc.changeStatus
//                                                 .add(!playing_bloc.currentStatus);

//                                             print(playing_bloc.currentStatus);
//                                           },
//                                           provideHapticFeedback: true,
//                                           boxShape: NeumorphicBoxShape.circle(),
//                                           style: widget.isDark
//                                               ? dark_softUI
//                                               : light_softUI,
//                                           child: new Icon(
//                                               snapshot.data
//                                                   ? Icons.pause
//                                                   : Icons.play_arrow,
//                                               size: 60.0),
//                                         ),
//                                       ),
//                                       Container(
//                                         height:
//                                             MediaQuery.of(context).size.width *
//                                                 0.5,
//                                         child: NeumorphicButton(
//                                           onClick: () {},
//                                           boxShape: NeumorphicBoxShape.circle(),
//                                           style: widget.isDark
//                                               ? dark_softUI
//                                               : light_softUI,
//                                           child: new Icon(Icons.skip_next),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 new Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.10,
//                                   child: new Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       new NeumorphicButton(
//                                         onClick: () {},
//                                         boxShape: NeumorphicBoxShape.roundRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0)),
//                                         style: widget.isDark
//                                             ? dark_softUI
//                                             : light_softUI,
//                                         child: new Icon(Icons.all_inclusive),
//                                       ),
//                                       new NeumorphicButton(
//                                         onClick: () {},
//                                         boxShape: NeumorphicBoxShape.roundRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0)),
//                                         style: widget.isDark
//                                             ? dark_softUI
//                                             : light_softUI,
//                                         child: new Icon(
//                                           Icons.favorite,
//                                           color: Theme.of(context).cardColor,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             );
//                           })
//                     ],
//                   ),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.waiting)
//                 return Center(child: CircularProgressIndicator());
//             }));
//   }

//   @override
//   void dispose() {
//     if (!(player.playbackState == AudioPlaybackState.playing)) player.dispose();
//     super.dispose();
//   }
// }

// class Custom_App_Bar extends StatelessWidget {
//   const Custom_App_Bar({
//     Key key,
//     @required this.widget,
//   }) : super(key: key);

//   final Song_Detail_Page widget;

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       height: MediaQuery.of(context).size.height * 0.07,
//       color: Theme.of(context).primaryColor,
//       child: new Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           NeumorphicButton(
//             margin: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
//             boxShape: NeumorphicBoxShape.circle(),
//             onClick: () {
//               Navigator.pop(context);
//             },
//             style: widget.isDark ? dark_softUI : light_softUI,
//             child: new Icon(
//               Icons.arrow_back,
//               color: Theme.of(context).highlightColor,
//             ),
//           ),
//           new Text(
//             "PLAYING NOW",
//             style: new TextStyle(
//                 fontFamily: "Nunito",
//                 fontSize: ScreenUtil().setSp(40.0),
//                 fontWeight: FontWeight.w900,
//                 color: Colors.grey),
//           ),
//           NeumorphicButton(
//             margin: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
//             boxShape: NeumorphicBoxShape.circle(),
//             onClick: () {},
//             style: widget.isDark ? dark_softUI : light_softUI,
//             child: new Icon(
//               Icons.search,
//               color: Theme.of(context).highlightColor,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class Song_Detail extends StatelessWidget {
//   const Song_Detail({
//     Key key,
//     @required this.widget,
//   }) : super(key: key);

//   final Song_Detail_Page widget;

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40.0)),
//       height: MediaQuery.of(context).size.height * 0.08,
//       child: new Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           new Text(
//             widget.info.title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: new TextStyle(
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey,
//                 fontSize: ScreenUtil().setSp(60.0)),
//           ),
//           new RichText(
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               text: TextSpan(children: [
//                 new TextSpan(
//                   text: "Artist  ",
//                   style: new TextStyle(
//                       fontFamily: 'Nunito',
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey,
//                       fontSize: ScreenUtil().setSp(30.0)),
//                 ),
//                 new TextSpan(
//                   text: widget.info.artist,
//                   style: new TextStyle(
//                       fontFamily: 'Nunito',
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey,
//                       fontSize: ScreenUtil().setSp(30.0)),
//                 )
//               ])),
//         ],
//       ),
//     );
//   }
// }

// class Album_Art_widget extends StatelessWidget {
//   const Album_Art_widget({
//     Key key,
//     @required this.widget,
//   }) : super(key: key);

//   final Song_Detail_Page widget;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Align(
//           child: new Container(
//             height: MediaQuery.of(context).size.height * 0.4,
//             width: MediaQuery.of(context).size.width,
//             child: new Neumorphic(
//               boxShape: NeumorphicBoxShape.circle(),
//               margin: EdgeInsets.all(ScreenUtil().setWidth(90.0)),
//               style: widget.isDark
//                   ? dark_softUI.copyWith(
//                       intensity: 1, shadowDarkColor: Colors.black54, depth: 6)
//                   : light_softUI.copyWith(
//                       intensity: 1, shadowDarkColor: Colors.black26, depth: 8),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: MediaQuery.of(context).size.height * 0.010,
//           child: new Container(
//             // color: Colors.blue,
//             height: MediaQuery.of(context).size.height * 0.38,
//             width: MediaQuery.of(context).size.width,
//             child: new Neumorphic(
//                 boxShape: NeumorphicBoxShape.circle(),
//                 margin: EdgeInsets.all(ScreenUtil().setWidth(90.0)),
//                 style: widget.isDark
//                     ? dark_softUI.copyWith(
//                         intensity: 1,
//                         shadowDarkColor: Colors.black54,
//                         depth: -1)
//                     : light_softUI.copyWith(
//                         intensity: 1,
//                         shadowDarkColor: Colors.black26,
//                         depth: -1),
//                 child: Hero(
//                     tag: widget.info.filePath,
//                     child: new Container(
//                       color: widget.albumArt,
//                       // child: widget.info.albumArtwork == null
//                       //     ? null
//                       //     : null),
//                     ) //Image.network(widget.info.albumArtwork)),
//                     )),
//           ),
//         ),
//       ],
//     );
//   }
// }
