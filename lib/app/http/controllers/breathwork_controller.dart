import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../providers/text_to_speech_provider.dart';

class BreathworkController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxDouble sliderValue = 0.0.obs;  
  RxDouble volume = 4.0.obs; 
  RxDouble mix1 = 8.0.obs; 
  RxDouble mix2 = 4.0.obs; 
  RxDouble mix3 = 6.0.obs; 
  RxDouble mix4 = 3.0.obs; 
  RxBool playing = false.obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> dataStream(String id){
    return firebaseFirestore.collection('breathwork').doc(id).snapshots();
  }
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> loadMusic(String asset) async {
    ByteData byteData = await rootBundle.load(asset);
    Uint8List bytes = byteData.buffer.asUint8List();
    MyCustomSource choice = MyCustomSource(bytes);
    await audioPlayer.setAudioSource(choice);
  }

  Future<void> play() async {
    await audioPlayer.play();
    playing.value = true;
  }

  Future<void> pause() async {
    await audioPlayer.pause();
    playing.value = false;
  }
}