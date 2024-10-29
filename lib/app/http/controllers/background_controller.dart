import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class BackgroundController extends GetxController{
  VideoPlayerController videoPlayerController = VideoPlayerController.asset('assets/videos/background_star.mov');
  
  void initiatePlayer() async {
    VideoPlayer videoPlayer = VideoPlayer(videoPlayerController);
    videoPlayer.controller.play();
  }

  @override
  void onInit() {
    initiatePlayer();
    super.onInit();
  }
}