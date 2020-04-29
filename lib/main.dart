import 'package:flute_music/theming/dynamic_theming._bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeBloc theme_bloc = new ThemeBloc();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: theme_bloc.currentTheme,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: snapshot.data ? ThemeData.light() : ThemeData.dark() ,
          home: MyHomePage(snapshot.data,theme_bloc),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ThemeBloc bloc ;
  final bool isDark ;
  MyHomePage(this.isDark,this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      drawer: new Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: new Text("Dark Mode"),
              trailing: new Switch(value: this.isDark, onChanged: bloc.changeTheme,),
            )
          ],
        ),
      ),
    );
  }
}
