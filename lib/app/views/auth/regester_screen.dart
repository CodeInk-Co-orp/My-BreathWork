import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/auth_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/button.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/input.dart';
import 'package:my_breath_work/app/widgets/language_dropdown.dart';
import 'package:my_breath_work/app/widgets/logo.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class RegesterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  RegesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: verticalSpace(context, .05),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomLogo(),
              const CustomSpacing(
                height: 0.04,
              ),
              const Center(
                child: CustomText(
                  text: "Create an account", 
                  fontSize: 25, 
                  fontWeight: FontWeight.bold,
                  textColor: KColors.white
                ),
              ),
              const CustomSpacing(
                height: 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .05
                ),
                child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                   color: KColors.white,
                  ),
                  child: Form(
                    key: authController.regestKey,
                    child: Column(
                      children: [
                        Obx(()=> Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomTextInput(
                            controller: authController.name, 
                            validator: (value){
                              return value!.isEmpty ? "Enter your name to proceed" : null;
                            }, 
                            enable: authController.loading.value ? false:true,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.words, 
                            hintText: "Name", 
                          ),
                          ),
                        ),
                        LanguageDropdown(controller: authController.language),
                        Obx(()=> Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomTextInput(
                            controller: authController.email,
                            validator: (value){
                              return !value!.isEmail ? "Invalid e-mail address" : null;
                            }, 
                            enable: authController.loading.value ? false:true,
                            textInputType: TextInputType.emailAddress, 
                            hintText: "E-mail", 
                          ),
                         ),
                        ),
                        Obx(()=> Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomTextInput(
                            controller: authController.password, 
                            validator: (value){
                              return value!.isEmpty || value.length < 8 ? "Enter valid email of min of 8 characters" : null;
                            }, 
                            enable: authController.loading.value ? false:true,
                            textInputType: TextInputType.emailAddress, 
                            hintText: "Password"
                          ),
                        ),),
                        RichText(text: 
                           TextSpan(
                            children: [
                              const TextSpan(
                                text: "Already registered?",
                                style: TextStyle(
                                  color: KColors.primaryLight,
                                  fontSize: 15
                                )
                              ),
                              TextSpan(
                                text: " Log in.",
                                recognizer: TapGestureRecognizer()..onTap=(){
                                  Get.offNamed("/login");
                                },
                                 style: const TextStyle(
                                  color: KColors.secondary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ]
                          )
                        ),
                        const CustomSpacing(
                          height: 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    const CustomSpacing(height: .05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Checkbox(
                            checkColor: KColors.white,
                            hoverColor: KColors.grey,
                            value: authController.checked.value,
                            onChanged: (value){
                              authController.checked.value = value!;
                            }
                          ),
                        ),
                        const SizedBox(width: 30),
                        const SizedBox(
                          width: 300,
                          child: CustomText(
                            text: "Say my name in the journey.\nNota that the name pronunciation is still in Beta. You can still go back and uncheck this box.",
                            fontSize: 15,
                            textColor: KColors.white,
                          ),
                        )
                      ],
                    ),
                    const CustomSpacing(height: .05),
                    Obx(()=>CustomButton(
                      onPressed: (){
                        if(authController.regestKey.currentState!.validate() && authController.checked.value == true){
                          authController.signUp(context);
                        }
                      },
                      text: authController.loading.value ? " Loading..." : "Lets Go"
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}