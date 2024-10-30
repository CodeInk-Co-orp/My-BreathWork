import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      transparent: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: AssetImage('assets/home_icon.png'),
                  width: 40,
                  height: 40,
                  color: KColors.primaryLight,
                ),
                Image(
                  image: AssetImage('assets/account_icon.png'),
                  width: 40,
                  height: 40,
                  color: KColors.primaryLight,
                ),
              ],
            ),
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
                  Row(
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
                      cs.CarouselSlider(
                        items: [
                          
                        ],
                        options: cs.CarouselOptions(

                        ),
                      ),
                    ],
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