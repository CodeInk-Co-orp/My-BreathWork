import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  Future<void> uploadAudio({
    required String category,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (result != null) {
        File audioFile = File(result.files.single.path!);
        String audioName = result.files.single.name;
        final String path = 'audio/$category/$audioName';
        final storageRef = FirebaseStorage.instance.ref().child(path);
        UploadTask uploadTask = storageRef.putFile(audioFile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
        String downloadUrl = await snapshot.ref.getDownloadURL();
        final firestoreRef = FirebaseFirestore.instance.collection('audio').doc();
        Map<String, dynamic> audioData = {
          'category': category,
          'name': audioName,
          'url': downloadUrl,
          'timestamp': FieldValue.serverTimestamp(),
        };
        await firestoreRef.set(audioData);
        print("Audio uploaded and link stored successfully.");
      } else {
        print("No file selected.");
      }
    } catch (e) {
      print("Failed to upload audio: $e");
    }
  }
}
