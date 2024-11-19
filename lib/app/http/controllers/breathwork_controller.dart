import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_breath_work/app/services/local_storage.dart';
import 'package:my_breath_work/app/services/logging.dart';
import '../providers/text_to_speech_provider.dart';

class BreathworkController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxDouble mix1 = .7.obs; 
  RxDouble mix2 = .7.obs; 
  RxDouble mix3 = .7.obs; 
  RxDouble mix4 = .7.obs;
  RxBool started = false.obs;
  MyCustomSource? choice;
  Timer? timer;
  String? previousBreathwork;
  RxBool isPlaying = false.obs;
  var sliderValue = 0.0.obs; 
  var   duration = 0.0.obs;
  var duration1 = 0.0.obs;
  var duration2 = 0.0.obs;
  var duration3 = 0.0.obs;
  var duration4 = 0.0.obs;
  var volume = 0.0.obs;
  var audioFiles = <Map<String, dynamic>>[].obs; 
  final RxBool _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;

  Stream<DocumentSnapshot<Map<String, dynamic>>> dataStream(String id){
    return firebaseFirestore.collection('breathwork').doc(id).snapshots();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer mix1Player = AudioPlayer();
  AudioPlayer mix2Player = AudioPlayer();
  AudioPlayer mix3Player = AudioPlayer();
  AudioPlayer mix4Player = AudioPlayer();

  Future<void> setId() async {
    previousBreathwork = await fetchId();
    Logging.print(previousBreathwork);
  }

  Future<void> play(String url,String url1,String url2,String url3) async {
    // audioPlayer.play();
    mix1Player.play();
    mix2Player.play();
    mix3Player.play();
    mix4Player.play();
    // mix1Player.setLoopMode(LoopMode.all);
    // audioPlayer.setLoopMode(LoopMode.all);
    // mix1Player.setLoopMode(LoopMode.all);
    // mix2Player.setLoopMode(LoopMode.all);
    // mix3Player.setLoopMode(LoopMode.all);
    isPlaying.value = true;
    started.value = true;
    audioplay(url, url1, url2, url3);
    count();
  }

  void count(){
    if(sliderValue.value < 660){
      timer = Timer.periodic(const Duration(milliseconds: 250), (timer){
        sliderValue.value += .25;
      });
    } else {
      timer!.cancel();
    }
  }

  Future<void> pause() async {
    await audioPlayer.pause();
    await mix1Player.pause();
    await mix2Player.pause();
    await mix3Player.pause();
    await mix4Player.pause();
    isPlaying.value = false;
    timer!.cancel();
  }

  Future<void> resume() async {
    await audioPlayer.play();
    await mix1Player.play();
    await mix2Player.play();
    await mix3Player.play();
    await mix4Player.play();
    isPlaying.value = true;
    count();
  }
  
  void audioplay(String url,String url1,String url2,String url3) async {
    _isLoaded.value = false;
    await audioPlayer.setUrl(url);
    await mix1Player.setUrl(url1);
    await mix2Player.setUrl(url2);
    await mix3Player.setUrl(url3);
    audioPlayer.durationStream.listen(
      (audioDuration) {
        if (audioDuration != null) {
          duration.value = audioDuration.inSeconds.toDouble();
          _isLoaded.value = true;
        }
      }      
    );
    mix1Player.durationStream.listen(
      (audioDuration) {
        if (audioDuration != null) {
          duration1.value = audioDuration.inSeconds.toDouble(); 
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
    await audioPlayer.play();
    await mix1Player.play();
    await mix2Player.play();
    await mix3Player.play();
    await mix4Player.play();
    isPlaying.value = true;
    audioPlayer.positionStream.listen((position) {
      sliderValue.value = position.inSeconds.toDouble();
    }
  );
    mix1Player.positionStream.listen((position) {
        mix1.value = position.inSeconds.toDouble();
      }
    );
    mix2Player.positionStream.listen((position) {
        mix2.value = position.inSeconds.toDouble();
      }
    );
    mix3Player.positionStream.listen((position) {
        mix3.value = position.inSeconds.toDouble();
      }
    );
    mix4Player.positionStream.listen((position) {
        mix4.value = position.inSeconds.toDouble();
      }
    );
}
  void seek(double value) {
    if (value <= duration.value) {
      audioPlayer.seek(Duration(seconds: value.toInt()));
      mix1Player.seek(Duration(seconds: value.toInt()));
      mix2Player.seek(Duration(seconds: value.toInt()));
      mix3Player.seek(Duration(seconds: value.toInt()));
      mix4Player.seek(Duration(seconds: value.toInt()));
      sliderValue.value = value;
      mix1.value = value;
      mix2.value = value;
      mix3.value = value;
      mix4.value = value;
    }
}
  @override
  void onInit() {
    setId();
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.stop();
    mix1Player.stop();
    mix2Player.stop();
    mix3Player.stop();
    mix4Player.stop();
    super.onClose();
  }
}