import 'package:flute_music/neuromorphic_UI/neuromorphic_custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Song_Detail_Page extends StatefulWidget {
  final bool isDark;
  final SongInfo info;

  Song_Detail_Page(this.info, this.isDark);
  @override
  _Song_Detail_PageState createState() => _Song_Detail_PageState();
}

class _Song_Detail_PageState extends State<Song_Detail_Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: new SafeArea(
        child: Column(
          children: [
            new Container(
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
                    style: widget.isDark ? dark_softUI : light_softUI,
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
                    style: widget.isDark ? dark_softUI : light_softUI,
                    child: new Icon(
                      Icons.search,
                      color: Theme.of(context).highlightColor,
                    ),
                  )
                ],
              ),
            ),
            new SizedBox(
              height: ScreenUtil().setHeight(30.0),
            ),
            Stack(
              children: <Widget>[
                Align(
                  child: new Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: new Neumorphic(
                      boxShape: NeumorphicBoxShape.circle(),
                      margin: EdgeInsets.all(ScreenUtil().setWidth(90.0)),
                      style: widget.isDark
                          ? dark_softUI.copyWith(
                              intensity: 1,
                              shadowDarkColor: Colors.black54,
                              depth: 6)
                          : light_softUI.copyWith(
                              intensity: 1,
                              shadowDarkColor: Colors.black26,
                              depth: 8),
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.015,
                  child: new Container(
                    // color: Colors.blue,
                    height: MediaQuery.of(context).size.height * 0.37,
                    width: MediaQuery.of(context).size.width,
                    child: new Neumorphic(
                        boxShape: NeumorphicBoxShape.circle(),
                        margin: EdgeInsets.all(ScreenUtil().setWidth(90.0)),
                        style: widget.isDark
                            ? dark_softUI.copyWith(
                                intensity: 1,
                                shadowDarkColor: Colors.black54,
                                depth: -1)
                            : light_softUI.copyWith(
                                intensity: 1,
                                shadowDarkColor: Colors.black26,
                                depth: -1),
                        child: Hero(
                          tag: widget.info.filePath,
                          child: new Container(
                              color: Colors.redAccent,
                              child: widget.info.albumArtwork == null
                                  ? null
                                  : null),//Image.network(widget.info.albumArtwork)),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
