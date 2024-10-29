import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/auth_controller.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/button.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/input.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class RegestScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  RegestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: ListView(
        children: [
          Image.asset(
            "assets/mybreathwork_logo_001.png",
            height: MediaQuery.of(context).size.height * 0.3,
          ),
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
               color: KColors.white,
              borderRadius: BorderRadius.circular(10)
              ),
              child: Form(
                key: authController.regestKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextInput(
                        controller: authController.email, 
                        validator: (value){
                          return value!.isEmpty ? "Enter your name to proceed" : null;
                        }, 
                        textInputType: TextInputType.emailAddress, 
                        hintText: "Name", 
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextInput(
                        controller: authController.email,
                        validator: (value){
                          return value!.isEmpty ? "Enter your name to proceed" : null;
                        }, 
                        textInputType: TextInputType.emailAddress, 
                        hintText: "Name", 
                      ),
                    ),
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
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          Get.offNamed("/login");
                        },
                        child: const CustomText(
                          text: "Already registered? Log in.", 
                          fontSize: 15, 
                          textColor: KColors.secondaryLight
                        ),
                      ),
                    ),
                    const CustomSpacing(
                      height: 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const CustomSpacing(
            height: 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .05
            ),
            child: Row(
              children: [
                Obx(()=> Checkbox(
                  value: authController.checked.value, 
                  side: const BorderSide(
                    color: KColors.white
                  ),
                  onChanged: (value){
                    authController.tooglecheckbox();
                  }
                 ) 
                ),
                const CustomText(
                  text: "Say my name in the journey", 
                  fontSize: 15, 
                  textColor: KColors.white
                ),
              ],
            ),
          ),
          const CustomSpacing(
            height: 0.01,
          ),
          const Center(
            child: CustomText(
              text: "Note: name pronunciation is still in beta. You can go back and uncheck this box", 
              fontSize: 10, 
              textColor: KColors.white
            ),
          ),
          const CustomSpacing(
            height: 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .07
             ),
            child: CustomButton(
              onPressed: (){
                if(authController.regestKey.currentState!.validate()){
                }
              }, 
              text: "Lets Go"
            ),
          )
        ],
      )
    );
  }
}