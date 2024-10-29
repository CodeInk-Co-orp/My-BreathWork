import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/util/colors.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/mybreathwork_logo_001.png'),
      height: verticalSpace(context, .3),
      width: horizontalSpace(context, .4),
      color: KColors.primaryTransparent,
    );
  }
}