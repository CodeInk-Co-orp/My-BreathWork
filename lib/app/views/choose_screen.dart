import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/data/dummy.dart';
import 'package:my_breath_work/app/http/controllers/choose_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
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
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: KColors.primaryDark,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundColor: KColors.black,
                            child: Icon(
                              Icons.emoji_emotions,
                              color: KColors.primaryDark,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      CustomText(
                        text: "1. Select Voice",
                        fontSize: 22,
                        textColor: KColors.white,
                      ),
                    ],
                  ),
                  const CustomSpacing(height: .02),
                  SizedBox(
                    height: verticalSpace(context, .4),
                    width: 400,
                    child: Center(
                      child: cs.CarouselSlider(
                        items: [
                          ...List.generate(
                            voices.length,
                            (index) => Container(
                              height: verticalSpace(context, .35),
                              color: Colors.white,
                              child: Image(
                                image: AssetImage('assets/images/${voices[index]['image']}.png')
                              ),
                            ),
                          ),
                        ],
                        options: cs.CarouselOptions(
                          initialPage: chooseController.selected.value,
                          height: verticalSpace(context, .35),
                          viewportFraction: .7,
                          enlargeFactor: .175,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason){
                            chooseController.selected.value = index;
                          },
                          enableInfiniteScroll: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}