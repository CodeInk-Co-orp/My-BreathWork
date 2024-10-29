import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/custom_spacing.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/util/colors.dart';

class TryFreeScreen extends StatelessWidget {
  const TryFreeScreen({super.key});

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
          ],
        ),
      ),
    );
  }
}