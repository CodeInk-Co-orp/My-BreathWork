import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/auth_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/button.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/input.dart';
import 'package:my_breath_work/app/widgets/logo.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalSpace(context, .075),
          ),
          child: Column(
            children: [
              const CustomLogo(),
              const CustomSpacing(
                height: 0.04,
              ),
              const Center(
                child: CustomText(
                  text: "Log in", 
                  fontSize: 25, 
                  fontWeight: FontWeight.bold,
                  textColor: KColors.white
                ),
              ),
              const CustomSpacing(
                height: 0.05,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: KColors.white,
                ),
                width: 400,
                child: Form(
                  key: authController.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomTextInput(
                          controller: authController.email, 
                          validator: (value){
                            return value!.isEmpty ? "Enter email to proceed" : null;
                          }, 
                          textInputType: TextInputType.emailAddress, 
                          hintText: "Email", 
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomTextInput(
                          controller: authController.password, 
                          validator: (value){
                            return value!.isEmpty || value.length < 8 ? "Enter valid email of min of 8 characters" : null;
                          }, 
                          textInputType: TextInputType.emailAddress, 
                          hintText: "Password"
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.offNamed("/regester");
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "New user? Click ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: KColors.primaryLight
                                ),
                              ),
                              TextSpan(
                                text: "here ",
                                recognizer:TapGestureRecognizer()..onTap = () {
                                  Get.offNamed("/regester");
                                },
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: KColors.secondary,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              const TextSpan(
                                text: " to create an account.",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: KColors.primaryLight
                                )
                              ),
                            ]
                          )
                        )
                      ),
                      const CustomSpacing(
                        height: 0.02,
                      ),
                    ],
                  ),
                ),
              ),          
              const CustomSpacing(
                height: 0.05,
              ),
              CustomButton(
                onPressed: (){
                  if(authController.formKey.currentState!.validate()){
          
                  }
                }, 
                text: "Lets Go"
              ),
            ],
          ),
        ),
      )
    );
  }
}