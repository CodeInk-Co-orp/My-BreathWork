import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

Uint8List? myCustomSource;

Future<void> sendRequest(String input, int user) async {
  List<String> voiceType = ['JBFqnCBsd6RMkjVDRZzb', 'cgSgspJ2msm6clMCkdW9','bIHbv24MWmeRgasZH58o', 'EXAVITQu4vr4xnSDxMaL'];
  try{
    await http.post(
      // encoding: Encoding,
      Uri.parse("https://api.elevenlabs.io/v1/text-to-speech/${voiceType[user]}"),
      body: jsonEncode({
        'text': input,
        'voice_settings': {
          'stability': 1,
          'similarity_boost': 0.9
        },
      }),
      headers: {
        // 'xi-api-key': 'sk_551afec91d9a8017066146f6c2bca1da1ea3ff4a23cb611d',
        'xi-api-key': 'cbb45823b2c4ddce4ffe0eeef3f5dd99',
        'Content-Type': 'application/json'
      },
    ).then(
      (value) {
        myCustomSource = value.bodyBytes;
      },
    );
  } on FormatException {
    // rethrow;
  }
}

// Feed your own stream of bytes into the player
// class MyCustomSource {
//   final List<int> bytes;
//   MyCustomSource(this.bytes);
  
//   @override
//   Future request([int? start, int? end]) async {
//     start ??= 0;
//     end ??= bytes.length;
//     // return StreamAudioResponse(
//     //   sourceLength: bytes.length,
//     //   contentLength: end - start,
//     //   offset: start,
//     //   stream: Stream.value(bytes.sublist(start, end)),
//     //   contentType: 'audio/mpeg',
//     // );
//   }
// }