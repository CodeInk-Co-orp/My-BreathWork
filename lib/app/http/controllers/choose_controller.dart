import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class ChooseController extends GetxController{
  RxInt voice = 1.obs;
  RxInt music = 1.obs;
  RxInt purpose = 1.obs;

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> toggleSound() async {

  }
}