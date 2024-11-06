import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/try_free_controller.dart';
import 'package:my_breath_work/app/services/local_storage.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/button.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/input.dart';
import 'package:my_breath_work/app/widgets/language_dropdown.dart';
import 'package:my_breath_work/app/widgets/logo.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class TryFreeScreen extends StatelessWidget {
  TryFreeScreen({super.key});
  final TryFreeController tryFreeController = Get.put(TryFreeController());
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomLogo(),
              const CustomSpacing(height: .012),
              const CustomText(
                text: "Try for free",
                fontSize: 28,
                textColor: KColors.white,
                fontWeight: FontWeight.bold,
              ),
              const CustomSpacing(height: .05),
              Container(
                width: 400,
                decoration: const BoxDecoration(
                  color: KColors.white,
                ),
                child: Form(
                  key: tryFreeController.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextInput(
                        controller: tryFreeController.nameController,
                        validator: (value){
                          return value!.isEmpty ? "Field cannot be blank" : null;
                        },
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        hintText: "Name",
                        prefix: const Icon(
                          Icons.person,
                        ),
                      ),
                      const CustomSpacing(height: .01),
                      LanguageDropdown(controller: tryFreeController.languageController)
                    ],
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
                            value: tryFreeController.sayName.value,
                            onChanged: (value){
                              tryFreeController.sayName.value = value!;
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
                    CustomButton(
                      onPressed: () async {
                        if(tryFreeController.formKey.currentState!.validate()){
                          await storeData(
                            tryFreeController.nameController.text,
                            language: tryFreeController.languageController.text == 'Swedish' ? 'se' : 'en',
                            sayName: tryFreeController.sayName.value
                          );
                          Get.toNamed('/choose');
                        }
                      },
                      text: "Let's Go",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}