import 'package:flutter/material.dart';

class animated_progress extends StatefulWidget {
  @override
  _animated_progressState createState() => _animated_progressState();
}

class _animated_progressState extends State<animated_progress>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _bigger;
  Animation<double> _smaller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = new AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this);

    _bigger = new Tween(
      begin: 0.0,
      end: 100.0,
    ).animate(
        new CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _smaller = new Tween(begin: 100.0, end: 0.0).animate(
        new CurvedAnimation(parent: _animationController, curve: Curves.ease));

    _animationController.forward();

    _animationController
      ..addListener(() {
        this.setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _animationController.repeat();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Align(
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade200,
                        ),
                        width: _bigger.value,
                        height: _bigger.value,
                      ),
                    ),
                    Align(
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                        ),
                        width: _smaller.value,
                        height: _smaller.value,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            new SizedBox(
              height: 10.0,
            ),
            new Text(
              "Fetching Music ...",
              style: new TextStyle(fontFamily: 'Nunito', fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
