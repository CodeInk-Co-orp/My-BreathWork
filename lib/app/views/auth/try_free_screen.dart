import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/input.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class TryFreeScreen extends StatelessWidget {
  TryFreeScreen({super.key});
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: Padding(
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
              text: "Try for free",
              fontSize: 28,
              textColor: KColors.white,
              fontWeight: FontWeight.bold,
            ),
            const CustomSpacing(height: .02),
            Container(
              width: 400,
              decoration: const BoxDecoration(
                color: KColors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextInput(
                    controller: nameController,
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
                  DropdownMenu<String>(
                    width: double.infinity,
                    inputDecorationTheme: InputDecorationTheme(
                      // prefixIcon: prefix,
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    dropdownMenuEntries: [
                      ...List.generate(
                        2,
                        (index) => DropdownMenuEntry<String>(
                          value: "Item ${index + 1}",
                          label: "Item ${index + 1}",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}