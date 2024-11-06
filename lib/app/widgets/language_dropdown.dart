import 'package:flutter/material.dart';
import 'package:my_breath_work/app/data/dummy.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      controller: controller,
      enableSearch: false,
      label: const Row(
        children: [
          Icon(
            Icons.language
          ),
          SizedBox(width: 12),
          CustomText(
            text: "Language",
            fontSize: 14,
            textColor: KColors.black
          )
        ],
      ),
      width: 400,
      inputDecorationTheme: InputDecorationTheme(
        // prefixIcon: prefix,
        fillColor: KColors.white,
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
          borderSide: const BorderSide(color: KColors.secondaryLight),
          borderRadius: BorderRadius.circular(0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: KColors.secondaryLight),
          borderRadius: BorderRadius.circular(0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dropdownMenuEntries: [
        ...List.generate(
          languages.length,
          (index) => DropdownMenuEntry<String>(
            value: languages[index],
            label: languages[index],
          ),
        ),
      ],
    );
  }
}