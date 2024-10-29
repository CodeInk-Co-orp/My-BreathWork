import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/home_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/button.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalSpace(context, .05),
          ),
          child: Column(
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Personalized breathwork sessions tailored to help you sleep better, reduce stress and boost overall well-being",
                        style: TextStyle(
                          fontSize: 20,
                          color: KColors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () => homeController.seemore.value = true,
                        text: " ...seemore",
                        style: const TextStyle(
                          fontSize: 18,
                          color: KColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const CustomSpacing(height: .05),
              Obx(
                () => Visibility(
                  visible: homeController.seemore.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomText(
                        text: "Change your Life",
                        fontSize: 25,
                        textColor: KColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      const CustomSpacing(height: .02),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Breathwork can significantly reduce stress and improve mental clarity by promoting relaxation and enhancing focus. Incorporating personalized breathing excercies into your daily routine can lead to better emotional well-being and...",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: KColors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()..onTap = () => homeController.seemore.value = false,
                                text: " ...seeless",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: KColors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
              const CustomSpacing(height: .05),
              CustomButton(
                onPressed: (){
                  Get.toNamed("/try_free");
                },
                text: "TRY FREE",
              ),
              const CustomSpacing(height: .015),
              CustomButton(
                onPressed: (){
                  Get.toNamed("/login");
                },
                text: "LOGIN",
              ),
            ],
          ),
        ),
      ),
    );
  }
}