import 'package:flutter_audio_query/flutter_audio_query.dart';

class FetchSongs {
  final FlutterAudioQuery audioQuery = new FlutterAudioQuery();

  songs_list() async {
    List<SongInfo> songsData = await audioQuery.getSongs();
    await Future.delayed(Duration(seconds: 5));
    return songsData ;
  }
}
