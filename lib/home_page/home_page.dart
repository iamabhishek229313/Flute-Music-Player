import 'package:flute_music/home_page/animated_progress.dart';
import 'package:flute_music/neuromorphic_UI/neuromorphic_custom_styles.dart';
import 'package:flute_music/song_data/fetch_songs.dart';
import 'package:flute_music/theming/dynamic_theming._bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  final ThemeBloc bloc;
  final bool isDark;
  MyHomePage(this.isDark, this.bloc);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  FetchSongs fetchSongs;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSongs = new FetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: _drawer(isDark: widget.isDark, bloc: widget.bloc),
      body: SafeArea(
        child: Column(
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
                          image:
                              AssetImage('assets/images/abhishekProfile.JPG'),
                        ),
                      ),
                    ),
                  ),
                  NeumorphicButton(
                    margin: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
                    boxShape: NeumorphicBoxShape.circle(),
                    onClick: (){
                    },
                    style: widget.isDark ? dark_softUI : light_softUI,
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
                      print(snapshot.data.length);
                      return Container(
                        color: Theme.of(context).primaryColor,
                      );
                    }
                    return animated_progress();
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _drawer extends StatelessWidget {
  const _drawer({
    Key key,
    @required this.isDark,
    @required this.bloc,
  }) : super(key: key);

  final bool isDark;
  final ThemeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: new Text("Dark Mode"),
            trailing: new Switch(
              value: this.isDark,
              onChanged: bloc.changeTheme,
            ),
          )
        ],
      ),
    );
  }
}
