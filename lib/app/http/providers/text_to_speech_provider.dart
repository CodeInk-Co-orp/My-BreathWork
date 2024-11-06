import 'package:get/get.dart';
import 'package:my_breath_work/app/http/models/api_response.dart';
import 'package:my_breath_work/app/services/logging.dart';

class TextToSpeechProvider extends GetConnect{
  Future<ApiResponse> getSpeech(String input) async {
    ApiResponse apiResponse = ApiResponse();

    try{
      Logging.print("Starting...");
      final response = await post(
        "https://api.elevenlabs.io/v1/text-to-speech/9BWtsMINqrJLrRacOk9x",
        {
          'text': input,
          'voice_settings': {
            'stability': 1,
            'similarity_boost': 0.1 
          }
        },
        headers: {
          'xi-api-key': 'cbb45823b2c4ddce4ffe0eeef3f5dd99',
          'Content-Type': 'application/json'
        }
      );
      Logging.print("Code is: ${response.statusCode}");
    } catch(e){
      Logging.print("Error: $e");
    }

    return apiResponse;
  }
}