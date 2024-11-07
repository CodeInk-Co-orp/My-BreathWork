import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class BreathworkController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxDouble sliderValue = 0.0.obs;  
  RxDouble volume = 4.0.obs; 
  RxDouble mix1 = 8.0.obs; 
  RxDouble mix2 = 4.0.obs; 
  RxDouble mix3 = 6.0.obs; 
  RxDouble mix4 = 3.0.obs; 
  Stream<DocumentSnapshot> dataStream(String id){
    return firebaseFirestore.collection('breathwork').doc(id).snapshots();
  }
  AudioPlayer audioPlayer = AudioPlayer();
}