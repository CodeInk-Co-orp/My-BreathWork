import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'package:my_breath_work/util/colors.dart';

class ChooseLabel extends StatelessWidget {
  const ChooseLabel({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: KColors.primaryDark,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor: KColors.black,
              child: Icon(
                icon,
                color: KColors.primaryDark,
                size: 35,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        CustomText(
          text: label,
          fontSize: 22,
          textColor: KColors.white,
        ),
      ],
    );
  }
}