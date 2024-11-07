import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/auth_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/button.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class VerifyEmail extends StatelessWidget {
   VerifyEmail({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(body: Container(
      width: horizontalSpace(context, 0.2),
      decoration: BoxDecoration(
        color: KColors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child:  Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: "Email verification sent, verify to proceed",          
              fontSize: 23, 
              textColor: KColors.black
            ),
            Obx(()=> authController.seconds.value != 0 ? CustomText(
              text: authController.formatTime(authController.seconds.value),          
              fontSize: 23, 
              textColor: KColors.black
             ):CustomButton(
                onPressed: (){
                  authController.sendVerification();
                },
                text: "Resend",
              ),
            )
          ],
        ),
      ),
    )
  );
  }
}