import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_breath_work/app/services/local_storage.dart';
import 'package:my_breath_work/app/services/logging.dart';

import '../providers/text_to_speech_provider.dart';

class BreathworkController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxDouble sliderValue = 0.0.obs;  
  RxDouble volume = .7.obs; 
  RxDouble mix1 = .7.obs; 
  RxDouble mix2 = .7.obs; 
  RxDouble mix3 = .7.obs; 
  RxDouble mix4 = .7.obs;
  RxBool playing = false.obs;
  RxBool started = false.obs;
  MyCustomSource? choice;
  Timer? timer;
  String? previousBreathwork;

  Stream<DocumentSnapshot<Map<String, dynamic>>> dataStream(String id){
    return firebaseFirestore.collection('breathwork').doc(id).snapshots();
  }
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer mix1Player = AudioPlayer();
  AudioPlayer mix2Player = AudioPlayer();
  AudioPlayer mix3Player = AudioPlayer();
  AudioPlayer mix4Player = AudioPlayer();

  Future<void> loadMusic(String asset) async {
    ByteData byteData = await rootBundle.load(asset);
    Uint8List bytes = byteData.buffer.asUint8List();
    choice = MyCustomSource(bytes);
    await audioPlayer.setAudioSource(choice!);
  }

   Future<void> readMusic(String asset, String mix1, String mix2, String mix3/*, String mix4*/) async {
    await audioPlayer.setAudioSource(AudioSource.asset('music/speech/amelia_english.wav'));
    await mix1Player.setAudioSource(AudioSource.asset(mix1));
    await mix2Player.setAudioSource(AudioSource.asset(mix2));
    await mix3Player.setAudioSource(AudioSource.asset(mix3));
  }

  Future<void> setId() async {
    previousBreathwork = await fetchId();
    Logging.print(previousBreathwork);
  }

  Future<void> play() async {
    audioPlayer.play();
    mix1Player.play();
    mix2Player.play();
    mix3Player.play();
    playing.value = true;
    started.value = true;
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
    audioPlayer.pause();
    mix1Player.pause();
    mix2Player.pause();
    mix3Player.pause();
    playing.value = false;
    timer!.cancel();
  }

  Future<void> resume() async {
    audioPlayer.play();
    mix1Player.play();
    mix2Player.play();
    mix3Player.play();
    playing.value = true;
    count();
  }

  @override
  void onInit() {
    setId();
    super.onInit();
  }
}