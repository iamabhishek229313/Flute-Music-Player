
import 'package:flute_music/song_data/fetch_songs.dart';
import 'package:flute_music/theming/dynamic_theming._bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  final ThemeBloc bloc;
  final bool isDark;
  MyHomePage(this.isDark, this.bloc);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  FetchSongs fetchSongs ;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController _animationController ;
  Animation<double> _bigger ;
  Animation<double> _smaller ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSongs = new FetchSongs() ;
    _animationController = new AnimationController( duration: Duration(seconds: 2),vsync: this) ;
    _bigger = new Tween(
      begin: 0.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(parent: _animationController, curve: Curves.ease)
    );
    
    _animationController.forward() ;
    _animationController..addListener(() {
      this.setState(() { });
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed)
        _animationController.repeat();
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: new Image(
                image: AssetImage('assets/images/abhishekProfile.JPG'),
              ),
            ),
          ),
        ),
        actions: [
          new IconButton(
            icon: new Icon(
              Icons.search,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: _drawer(isDark: widget.isDark, bloc: widget.bloc),
      body: new FutureBuilder(
        future: fetchSongs.songs_list(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            print(snapshot.data);
            return Container(color: Colors.red,);
          }
          return Center(
            child: new Container(
              color: Colors.red,
              width: _bigger.value,
              height: _bigger.value,
            ),
          ) ;
      }),
    );
  }

  @override
  void dispose() { 
    _animationController.dispose();
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
