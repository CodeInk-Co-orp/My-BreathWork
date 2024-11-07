import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_breath_work/app/data/dummy.dart';
import 'package:my_breath_work/app/http/providers/text_to_speech_provider.dart';
import 'package:my_breath_work/app/services/local_storage.dart';

class ChooseController extends GetxController{
  RxInt voice = 1.obs;
  RxInt music = 1.obs;
  RxInt purpose = 1.obs;
  RxBool loading = false.obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> togglePlayer({String? language}) async {
    String text = await replaceData(dummyVoices[voice.value]);
    await sendRequest(text, voice.value);
    await audioPlayer.setAudioSource(myCustomSource!);
    await audioPlayer.play();
  }

  Future<void> loadMusic(String asset) async {
    ByteData byteData = await rootBundle.load(asset);
    Uint8List bytes = byteData.buffer.asUint8List();
    MyCustomSource choice = MyCustomSource(bytes);
    await audioPlayer.setAudioSource(choice);
    await audioPlayer.play();
  }

  Future<void> createBreathwork() async {
    loading.value = true;
    try{
      await firebaseFirestore.collection('breathwork')
      .add(
        {
          'user': FirebaseAuth.instance.currentUser!.email,
          'voice': voices[voice.value]['name'],
          'music': tracks[music.value]['label'],
          'purpose': purposes[purpose.value]['label'],
        }
      );
      Get.offNamed('/my_breathwork');
      loading.value = false;
    } catch(e){
      loading.value = false;
      rethrow;
    }
  }

  @override
  void onInit() {
    togglePlayer();
    super.onInit();
  }
}