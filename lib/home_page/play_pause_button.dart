import 'package:flute_music/home_page/home_page.dart';
import 'package:flute_music/neuromorphic_UI/neuromorphic_custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Play_Pause_Button extends StatelessWidget {
  const Play_Pause_Button({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final MyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      flex: 1,
      child: new NeumorphicButton(
        boxShape: NeumorphicBoxShape.circle(),
        onClick: () {},
        style: widget.isDark ? dark_softUI : light_softUI,
        child: new Icon(
          Icons.play_arrow,
          color: Theme.of(context).highlightColor,
        ),
      ),
    );
  }
}