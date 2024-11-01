import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/data/dummy.dart';
import 'package:my_breath_work/app/http/controllers/choose_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/choose_label.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/home_row.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

class ChooseScreen extends StatelessWidget {
  ChooseScreen({super.key});
  final ChooseController chooseController = Get.put(ChooseController());

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      transparent: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeRow(),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: verticalSpace(context, .03),
                        horizontal: horizontalSpace(context, .02)
                      ),
                      child: const CustomText(
                        text: "Create your personal Breathwork session",
                        fontSize: 25,
                        textColor: KColors.white,
                        fontWeight: FontWeight.bold,
                        centerText: true,
                      ),
                    ),
                    const ChooseLabel(icon: Icons.emoji_emotions, label: "1. Select Voice"),
                    const CustomSpacing(height: .02),
                    SizedBox(
                      height: verticalSpace(context, .425),
                      width: 380,
                      child: Center(
                        child: cs.CarouselSlider(
                          items: [
                            ...List.generate(
                              voices.length,
                              (index) => Column(
                                children: [
                                  // Obx(
                                  //   () => 
                                    Transform(
                                      // transform: Matrix4.rotationY(index != chooseController.voice.value ? index > chooseController.voice.value ? (pi / 2.5) : (pi / -2.5) : 0),
                                      transform: Matrix4.rotationY(2),
                                      child: Container(
                                        height: verticalSpace(context, .35),
                                        color: Colors.white,
                                        child: Image(
                                          image: AssetImage('assets/images/${voices[index]['image']}.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  // ),
                                  const CustomSpacing(height: .02),
                                  CustomText(
                                    text: voices[index]['name'],
                                    fontSize: 20,
                                    textColor: KColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                          options: cs.CarouselOptions(
                            initialPage: chooseController.voice.value,
                            height: verticalSpace(context, .5),
                            viewportFraction: .7,
                            enlargeFactor: .175,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason){
                              chooseController.voice.value = index;
                            },
                            enableInfiniteScroll: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => CustomText(
                  text: voices[chooseController.voice.value]['label'],
                  fontSize: 14,
                  textColor: KColors.primaryTransparent,
                ),
              ),
              const CustomSpacing(height: .075),
              const ChooseLabel(icon: Icons.music_note, label: "2. Select Music"),
              const CustomSpacing(height: .05),
              SizedBox(
                height: 50,
                width: 300,
                child: Center(
                  child: cs.CarouselSlider(
                    items: [
                      ...List.generate(
                        3,
                        (index) => Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: index == chooseController.voice.value ? KColors.primaryDark : KColors.secondary,
                          ),
                          child: const Center(
                            child: CustomText(
                              text: "Something",
                              fontSize: 18,
                              textColor: Colors.white,
                              centerText: true,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                    options: cs.CarouselOptions(
                      initialPage: chooseController.voice.value,
                      height: 50,
                      viewportFraction: .6,
                      enlargeFactor: .2,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason){
                        chooseController.music.value = index;
                      },
                      enableInfiniteScroll: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}