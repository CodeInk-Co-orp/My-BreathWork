import "package:my_breath_work/app/widgets/space.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:my_breath_work/util/colors.dart";

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool? obsecureText;
  final bool? enable;
  final String hintText;
  // final String label;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? outterPadding;
  final Iterable<String>? autofillHints;
  final int? maxLines;
  final int? maxLength;
  final double? width;
  final double? height;
  final Widget? prefix;
  final Widget? suffix;
  final Color? hintShade;
  final TextCapitalization? textCapitalization;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;

  const CustomTextInput({
    super.key, 
    required this.controller, 
    required this.validator, 
    required this.textInputType, 
    required this.hintText, 
    this.obsecureText,
    this.enable,
    this.contentPadding,
    this.autofillHints, 
    this.maxLines,
    this.maxLength,
    this.width,
    this.height,
    this.suffix,
    this.prefix,
    // required this.label,
    this.textCapitalization,
    this.outterPadding,
    this.hintShade,
    this.onEditingComplete,
    this.focusNode, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outterPadding ?? EdgeInsets.symmetric(
        vertical: verticalSpace(context, (height ?? 0))
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: textInputType,
        maxLines: maxLines,
        enabled: enable,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        obscureText: obsecureText ?? false,
        autofillHints: autofillHints,
        onChanged: onChanged,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength)
        ],
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          hintStyle: TextStyle(
            color: hintShade ?? KColors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          border: UnderlineInputBorder(
            borderSide: const BorderSide(color: KColors.grey),
            borderRadius: BorderRadius.circular(0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: KColors.grey),
            borderRadius: BorderRadius.circular(0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: KColors.primary, width: 2),
            borderRadius: BorderRadius.circular(0),
          ),
          suffix: suffix,
        ),
      ),
    );
  }
}