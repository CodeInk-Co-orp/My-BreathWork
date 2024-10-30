import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/music_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/home_row.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class MusicScreen extends StatelessWidget {
  final MusicController musicController = Get.put(MusicController());
   MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: verticalSpace(context, 0.3),
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/audio_image.jpg",
                  ),
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
            Slider(
              value: musicController.sliderValue.value, 
              onChanged: (value){
              }
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "00.00", 
                    fontSize: 15, 
                    textColor: KColors.white
                  ),
                  CustomText(
                    text: "04.39", 
                    fontSize: 15, 
                    textColor: KColors.white
                  ),
                ],
              ),
            ),
            const CustomText(
              text: "Be happy - space by Elle ", 
              fontSize: 20, 
              textColor: KColors.white,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(
              height: verticalSpace(context, 0.02),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.skip_next_sharp,
                  color: KColors.white,
                  size: 35,
                ),
                SizedBox(width: 12,),
                Icon(
                  CupertinoIcons.play_circle_fill,
                  color: KColors.white,
                  size: 35,
                ),
                SizedBox(width: 12,),
                Icon(
                  Icons.skip_next_sharp,
                  color: KColors.white,
                  size: 35,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalSpace(context, 0.03)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    value: musicController.volume.value,
                    max: 10,
                    min: 0,
                    onChanged: (value){
                    }
                  ),
                  const Icon(
                    Icons.volume_up_sharp,
                    color: KColors.white,
                    size: 28,
                  )
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.music_note_sharp,
                    size: 28,
                  ),
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.mic_external_on_outlined,
                    size: 28,
                  ),
                ),
                CircleAvatar(
                  child: Icon(
                    CupertinoIcons.speaker,
                    size: 28,
                  ),
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.record_voice_over_sharp,
                    size: 28,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: verticalSpace(context, 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Transform.rotate(
                    angle: -pi /2,
                    child: SizedBox(
                      width: 110,
                      child: Slider(
                        value: musicController.mix1.value,
                        onChanged: (value) {
                        },
                        max: 10,
                        min: 0,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      width: 110,
                      child: Slider(
                        value: musicController.mix2.value,
                        onChanged: (value) {
                        },
                        max: 10,
                        min: 0,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      width: 110,
                      child: Slider(
                        value: musicController.mix3.value,
                        onChanged: (value) {
                        },
                        max: 10,
                        min: 0,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      width: 110,
                      child: Slider(
                        value: musicController.mix4.value,
                        onChanged: (value) {
                        },
                        max: 10,
                        min: 0,
                       ),
                      ),
                  ),
               ],
            ),
            SizedBox(
              height: verticalSpace(context, 0.03),
            ),
          ],
        ),
      ),
    );
  }
}