import "package:my_breath_work/app/widgets/text.dart";
import "package:flutter/material.dart";
import "package:my_breath_work/util/colors.dart";

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? color;
  final double? width;
  
  const CustomButton({
    super.key, 
    required this.onPressed,
    required this.text,
    this.horizontalPadding,
    this.verticalPadding,
    this.color, this.width
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: KColors.white
      ),
      child: SizedBox(
        width: width ?? 120,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CustomText(
              text: text.toUpperCase(),
              fontSize: 20, 
              textColor: KColors.secondaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}