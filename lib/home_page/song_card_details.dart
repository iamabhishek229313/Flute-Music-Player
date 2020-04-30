import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Song_Card_Details extends StatelessWidget {
  const Song_Card_Details({
    Key key,
    @required this.info,
    @required this.duration,
  }) : super(key: key);

  final SongInfo info;
  final double duration;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        flex: 4,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              info.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: new TextStyle(
                  fontFamily: 'Nunito', fontSize: ScreenUtil().setSp(40.0)),
            ),
            RichText(
              text: new TextSpan(children: [
                new TextSpan(
                    text: "Duration: ",
                    style: new TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Nunito',
                        fontSize: ScreenUtil().setSp(35),
                        fontWeight: FontWeight.w600)),
                new TextSpan(
                    text: "${duration.toStringAsPrecision(2)} ",
                    style: new TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Nunito',
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.w400)),
                new TextSpan(
                    text: "s",
                    style: new TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Nunito',
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight: FontWeight.w900)),
              ]),
            ),
            new Divider(
              height: 0.0,
            )
          ],
        ));
  }
}