import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/data/dummy.dart';
import 'package:my_breath_work/app/http/providers/text_to_speech_provider.dart';
import 'package:my_breath_work/app/services/local_storage.dart';
import 'package:my_breath_work/app/services/logging.dart';

class ChooseController extends GetxController{
  RxInt voice = 1.obs;
  RxInt music = 1.obs;
  RxInt purpose = 1.obs;
  RxBool loading = false.obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer voiceAudioPlayer = AudioPlayer();

  Future<void> togglePlayer({String? language}) async {
    try{
      String text = await replaceData(dummyVoices[voice.value]);
      await sendRequest(text, voice.value);
      // await voiceAudioPlayer.setAudioSource(myCustomSource!);
      // await voiceAudioPlayer.play();
    } catch(e){
      Logging.print("Error: $e");
      // rethrow;
    }
  }

  Future<void> loadMusic(String asset) async {
    ByteData byteData = await rootBundle.load(asset);
    Uint8List bytes = byteData.buffer.asUint8List();
    MyCustomSource choice = MyCustomSource(bytes);
    // await audioPlayer.setAudioSource(choice);
    // await audioPlayer.play();
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
          'title': "Breathwork ${DateTime.now().millisecondsSinceEpoch}.mp3",
        }
      ).then((value) async {
        await storeId(value.id);
        Get.toNamed(
          '/my_breathwork',
          arguments: {
            'breathwork_id': value.id,
          }
        );
      });
      loading.value = false;
    } catch(e){
      Get.snackbar("Failed!!!", e.toString());
      loading.value = false;
      // rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> breathworkSnapshots(){
    return firebaseFirestore.collection('breathwork').snapshots();
  }

  void stopAllPlayers(){
    audioPlayer.stop();
    voiceAudioPlayer.stop();
  }

  redirect(){
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null){
      // Get.offNamed('/login');
    }
  }

  @override
  void onInit() {
    redirect();
    super.onInit();
  }
}