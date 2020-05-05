import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

enum AudioPlayerEvent { triggerAudioPlayer }

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, bool> {
  final AudioPlayer player = new AudioPlayer();
  @override
  bool get initialState => false; 

  @override
  void onTransition(Transition<AudioPlayerEvent, bool> transition) {
    print(transition);
  }

  @override
  Stream<bool> mapEventToState(
    AudioPlayerEvent event,
  ) async* {
    if (event == AudioPlayerEvent.triggerAudioPlayer) yield !state;
  }
}
