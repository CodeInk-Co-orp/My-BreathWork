import "package:my_breath_work/app/widgets/space.dart";
import "package:my_breath_work/app/widgets/text.dart";
import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? color;
  
  const CustomButton({
    super.key, 
    required this.onPressed,
    required this.text,
    this.horizontalPadding,
    this.verticalPadding,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalSpace(context, horizontalPadding ?? 0),
        vertical: verticalSpace(context, verticalSpace(context, verticalPadding ?? 0)),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: text,
                fontSize: 20, 
                textColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}