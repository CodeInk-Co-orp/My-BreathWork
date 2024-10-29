import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/button.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: const AssetImage('assets/mybreathwork_logo_001.png'),
            height: verticalSpace(context, .3),
            width: horizontalSpace(context, .4),
            color: KColors.primaryTransparent,
          ),
          const CustomSpacing(height: .012),
          const CustomText(
            text: "Personalized",
            fontSize: 30,
            textColor: KColors.white,
            fontWeight: FontWeight.bold,
          ),
          const CustomText(
            text: "Breathwork",
            fontSize: 28,
            textColor: KColors.white,
            fontWeight: FontWeight.bold,
          ),
          const CustomSpacing(height: .02),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomText(
              text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu nisl sit amet dui vestibulum laoreet quis et leo. Nulla a accumsan sem, ac varius sem. Duis vel magna vitae enim tristique iaculis vel a est.",
              fontSize: 20,
              textColor: KColors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          const CustomSpacing(height: .02),
          CustomButton(
            onPressed: (){

            },
            text: "TRY FREE",
          ),
          const CustomSpacing(height: .015),
          CustomButton(
            onPressed: (){

            },
            text: "LOGIN",
          ),
        ],
      ),
    );
  }
}