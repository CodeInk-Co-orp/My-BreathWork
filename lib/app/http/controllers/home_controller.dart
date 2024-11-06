import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class HomeController extends GetxController{
  RxBool seemore = false.obs;

  AudioPlayer audioPlayer = AudioPlayer();

  // initiateMusic() async {
  //   await audioPlayer.setAsset("assets/music/Space_[music_background_audio_file].mp3");
  //   await audioPlayer.play();
  // }

  @override
  void onInit() {
    // initiateMusic();
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.stop();
    super.onClose();
  }
}