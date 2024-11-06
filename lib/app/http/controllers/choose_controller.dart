import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_breath_work/app/data/dummy.dart';
import 'package:my_breath_work/app/http/providers/text_to_speech_provider.dart';
import 'package:my_breath_work/app/services/local_storage.dart';

class ChooseController extends GetxController{
  RxInt voice = 1.obs;
  RxInt music = 1.obs;
  RxInt purpose = 1.obs;

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> togglePlayer({String? language}) async {
    String text = await replaceData(dummyVoices[voice.value]);
    await sendRequest(text);
    await audioPlayer.setAudioSource(myCustomSource!);
    await audioPlayer.play();
  }

  @override
  void onInit() {
    togglePlayer();
    super.onInit();
  }
}