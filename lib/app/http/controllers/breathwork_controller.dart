import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/services/local_storage.dart';
import 'package:my_breath_work/app/services/logging.dart';

class BreathworkController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
      try {
        FirebaseFirestore.instance
          .collection('audio')
          .where('category', isEqualTo: 'background') 
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            Map<String, dynamic> audioData = snapshot.docs.first.data();
            String? audioUrl = audioData['url'];
            if (audioUrl != null && audioUrl.isNotEmpty) {
              await backgroundPlayer.play(UrlSource(audioUrl,mimeType: "mp3"));
              await backgroundPlayer.setVolume(1.0);
              print('Audio started playing successfully.');
            } else {
              print('Audio URL is empty.');
            }
          } else {
            print('No audio documents found in the collection.');
          }
        });
      } catch (e) {
        print('Error fetching audio: $e');
    }
  }

  void pauseBackground(){
    backgroundPlayer.pause();
  }

  void resumeBackground(){
    backgroundPlayer.resume();
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
    // timer!.cancel();
  }

  Future<void> resume() async {
    pauseBackground();
    audioPlayer.resume();
    mix2Player.resume();
    mix3Player.resume();
    mix4Player.resume();
    isPlaying.value = true;
  }
  
  Future<void> audioplay(String url, String url1, String url2, String url3) async {
  try {
    pauseBackground();
    _isLoaded.value = false;
    isPlaying.value = false;
    started.value = false;
    audioPlayer.onDurationChanged.listen((audioDuration) {
      duration.value = audioDuration.inSeconds.toDouble();
    });
    mix2Player.onDurationChanged.listen((audioDuration) {
      duration2.value = audioDuration.inSeconds.toDouble();
    });
    mix3Player.onDurationChanged.listen((audioDuration) {
      duration3.value = audioDuration.inSeconds.toDouble();
    });
    mix4Player.onDurationChanged.listen((audioDuration) {
      duration4.value = audioDuration.inSeconds.toDouble();
    });
    audioPlayer.onPositionChanged.listen((position) {
      sliderValue.value = position.inSeconds.toDouble();
    });
    await audioPlayer.play(UrlSource(url, mimeType: "audio/mpeg"), volume: mix1.value);
    await mix2Player.play(UrlSource(url1, mimeType: "audio/mpeg"), volume: mix2.value);
    await mix3Player.play(UrlSource(url2, mimeType: "audio/mpeg"), volume: mix3.value);
    await mix4Player.play(UrlSource(url3, mimeType: "audio/mpeg"), volume: mix4.value);
    isPlaying.value = true;
    started.value = true;
    _isLoaded.value = true;
  } catch (e) {
    Logging.print("Error in audioplay: $e");
  }
}

  void seek(double value) {
  if (value < 0) {
    return;
  }
  if (value <= duration.value) {
    if (audioPlayer.state == PlayerState.playing || audioPlayer.state == PlayerState.paused) {
      audioPlayer.seek(Duration(seconds: value.toInt()));
      sliderValue.value = value;
    } else {
      print("Audio player is not ready for seeking.");
    }
  } else {
    print("Seek value exceeds audio duration.");
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