import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/breathwork_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/home_row.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class BreathworkScreen extends StatelessWidget {
  final BreathworkController breathworkController = Get.put(BreathworkController());
  BreathworkScreen({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('audio').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData) {
            final audioList = snapshot.data!.docs;
            if (audioList.isEmpty) {
              return const Center(child: Text("No audio data found."));
            }
            final audio1 = audioList[0].data();
            final audio2 = audioList[1].data();
            final audio3 = audioList[2].data();
            final audio = audioList[3].data();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: verticalSpace(context, 0.3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/audio_image.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: HomeRow(),
                      ),
                    ),
                  ),
                  Obx(() => Slider(
                    value: breathworkController.sliderValue.value,
                    max: breathworkController.duration.value ?? 11.00,
                    min: 0.0,
                    onChanged: (value) {
                      breathworkController.seek(value);
                    },
                  )
                 ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: formatDuration(breathworkController.sliderValue.value),
                            fontSize: 15,
                            textColor: KColors.white,
                          ),
                          CustomText(
                            text: formatDuration(breathworkController.duration.value),
                            fontSize: 15,
                            textColor: KColors.white,
                          ),
                        ],
                      ),
                    );
                  }
                  ),
                  SizedBox(height: verticalSpace(context, 0.02)),
                  CustomText(
                    text: audio['name'],
                    fontSize: 15,
                    textColor: KColors.white,
                  ),
                  SizedBox(height: verticalSpace(context, 0.02)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.skip_previous,
                        color: KColors.white,
                        size: 35,
                      ),
                      const SizedBox(width: 12),
                      Obx(() => GestureDetector(
                          onTap: () async {
                            if (!breathworkController.isPlaying.value && !breathworkController.started.value) {
                              await breathworkController.play(audio['url'], audio1['url'], audio2['url'], audio3['url']);
                              breathworkController.started.value = true;
                              breathworkController.isPlaying.value = true;
                            } else if (!breathworkController.isPlaying.value) {
                              await breathworkController.resume();
                            } else {
                              await breathworkController.pause();
                            }
                          },
                          child: Icon(
                            breathworkController.isPlaying.value
                              ? CupertinoIcons.pause
                              : CupertinoIcons.play_circle_fill,
                            color: KColors.white,
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.skip_next,
                        color: KColors.white,
                        size: 35,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: breathworkController.audioPlayer.volume,
                            max: 4.0,
                            min: 0.0,
                            onChanged: (value) {
                              breathworkController.audioPlayer.setVolume(value);
                            },
                           ),
                         ),
                        const Icon(
                          Icons.volume_up_sharp,
                          color: KColors.white,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      final player = [
                        breathworkController.mix1Player,
                        breathworkController.mix2Player,
                        breathworkController.mix3Player,
                        breathworkController.mix4Player
                      ][index];
                      final mixValue = [
                        breathworkController.mix1,
                        breathworkController.mix2,
                        breathworkController.mix3,
                        breathworkController.mix4
                      ][index];
                      final sliderIcons = [
                        Icons.music_note,
                        Icons.audiotrack, 
                        Icons.volume_up, 
                        Icons.headset, 
                      ];
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: KColors.white,
                            child: Icon(
                              sliderIcons[index],
                              size: 28,
                              color: KColors.primary,
                            ),
                          ),
                          SizedBox(height: verticalSpace(context, 0.05)),
                          Transform.rotate(
                            angle: -pi / 2,
                            child: SizedBox(
                              width: 110,
                              child: Obx(()=>Slider(
                                value: mixValue.value,
                                onChanged: (value) {
                                  mixValue.value = value;
                                  // player.setVolume(value);
                                },
                                max: 1.0,
                                min: 0.0,
                             )
                            )
                           ),
                          ),
                        ],
                      );
                    }
                    ),
                  ),
                  SizedBox(height: verticalSpace(context, 0.03)),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  String formatDuration(double seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).toInt();
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }
}
