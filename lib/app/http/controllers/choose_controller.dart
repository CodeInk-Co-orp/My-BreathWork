import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_breath_work/app/data/dummy.dart';
import 'package:my_breath_work/app/http/models/api_response.dart';
import 'package:my_breath_work/app/http/providers/text_to_speech_provider.dart';
import 'package:my_breath_work/app/services/logging.dart';

class ChooseController extends GetxController{
  TextToSpeechProvider provider = TextToSpeechProvider();
  RxInt voice = 1.obs;
  RxInt music = 1.obs;
  RxInt purpose = 1.obs;

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> togglePlayer({String? language}) async {
    ApiResponse response = await provider.getSpeech(dummyVoices[voice.value][language ?? 'en']);
    Logging.print(response);
  }

  @override
  void onInit() {
    togglePlayer();
    super.onInit();
  }
}