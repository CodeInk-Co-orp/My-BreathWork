import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_breath_work/app/services/local_storage.dart';
import 'package:my_breath_work/app/services/logging.dart';
import '../providers/text_to_speech_provider.dart';

class BreathworkController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  MyCustomSource? choice;
  Timer? timer;
  String? previousBreathwork;
  bool get isLoaded => _isLoaded.value;

  // Observable
  final RxDouble mix1 = .7.obs; 
  final RxDouble mix2 = .7.obs; 
  final RxDouble mix3 = .7.obs; 
  final RxDouble mix4 = .7.obs;
  final RxDouble _audioVolume = .7.obs;
  RxBool started = false.obs;
  RxBool isPlaying = false.obs;
  var sliderValue = 0.0.obs; 
  var duration = 0.0.obs;
  var duration2 = 0.0.obs;
  var duration3 = 0.0.obs;
  var duration4 = 0.0.obs;
  var volume = 0.0.obs;
  var audioFiles = <Map<String, dynamic>>[].obs; 
  final RxBool _isLoaded = false.obs;


  // Getters
  // RxDouble get mix1 => _mix1.value.obs;
  // RxDouble get mix2 => _mix2.value.obs;
  // RxDouble get mix3 => _mix3.value.obs;
  // RxDouble get mix4 => _mix4.value.obs;
  double get audioVolume => _audioVolume.value;

  Stream<DocumentSnapshot<Map<String, dynamic>>> dataStream(String id){
    return firebaseFirestore.collection('breathwork').doc(id).snapshots();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer backgroundPlayer = AudioPlayer();
  AudioPlayer mix2Player = AudioPlayer();
  AudioPlayer mix3Player = AudioPlayer();
  AudioPlayer mix4Player = AudioPlayer();

  void initiateMusic() async {
    await backgroundPlayer.setAsset("assets/music/Space_[music_background_audio_file].mp3");
    backgroundPlayer..play()..setVolume(.5);
  }

  void pauseBackground(){
    backgroundPlayer.pause();
  }

  void resumeBackground(){
    backgroundPlayer.play();
  }

  Future<void> setId() async {
    previousBreathwork = await fetchId();
    Logging.print(previousBreathwork);
  }

  Future<void> pause() async {
    resumeBackground();
    audioPlayer.pause();
    mix2Player.pause();
    mix3Player.pause();
    mix4Player.pause();
    isPlaying.value = false;
    timer!.cancel();
  }

  Future<void> resume() async {
    pauseBackground();
    audioPlayer.play();
    mix2Player.play();
    mix3Player.play();
    mix4Player.play();
    isPlaying.value = true;
  }
  
  Future<void> audioplay(String url,String url1,String url2,String url3) async {
    pauseBackground();
    _isLoaded.value = false;
    audioPlayer.setUrl(url);
    mix2Player.setUrl(url1);
    mix3Player.setUrl(url2);
    audioPlayer.durationStream.listen(
      (audioDuration) {
        if (audioDuration != null) {
          duration.value = audioDuration.inSeconds.toDouble();
          _isLoaded.value = true;
        }
      }      
    );
    mix2Player.durationStream.listen(
      (audioDuration) {
        if (audioDuration != null) {
          duration2.value = audioDuration.inSeconds.toDouble(); 
        }
      }      
    );    
    mix3Player.durationStream.listen(
      (audioDuration) {
        if (audioDuration != null) {
          duration3.value = audioDuration.inSeconds.toDouble(); 
        }
      }      
    );
    mix4Player.durationStream.listen((audioDuration) {
        if (audioDuration != null) {
          duration4.value = audioDuration.inSeconds.toDouble(); 
        }
      }      
    );
    audioPlayer.setLoopMode(LoopMode.all);
    mix2Player.setLoopMode(LoopMode.all);
    mix3Player.setLoopMode(LoopMode.all);
    audioPlayer.play();
    mix2Player.play();
    mix3Player.play();
    mix4Player.play();
    isPlaying.value = true;
    started.value = true;
    audioPlayer.positionStream.listen(
      (position) {
        sliderValue.value = position.inSeconds.toDouble();
      }
    );
  }
  void seek(double value) {
    if (value <= duration.value) {
      audioPlayer.seek(Duration(seconds: value.toInt()));
      sliderValue.value = value;
    }
  }

  // Setters
  void setMix1(double value) => mix1.value = value;
  void setMix2(double value) => mix2.value = value;
  void setMix3(double value) => mix3.value = value;
  void setMix4(double value) => mix4.value = value;
  void setAudioplayer() => audioPlayer.setVolume(mix1.value);
  void setMixplayer2() => mix2Player.setVolume(mix2.value);
  void setMixplayer3() => mix3Player.setVolume(mix3.value);
  void setMixplayer4() => mix4Player.setVolume(mix4.value);

  void stopPlayers(){
    audioPlayer.stop();
    mix2Player.stop();
    mix3Player.stop();
    mix4Player.stop();
  }

  @override
  void onInit() {
    setId();
    initiateMusic();
    stopPlayers();
    super.onInit();
  }

  @override
  void onClose() {
    stopPlayers();
    super.onClose();
  }
}