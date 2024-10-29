import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/util/colors.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: verticalSpace(context, 1),
        width: horizontalSpace(context, 1),
        color: KColors.black,
        child: Stack(
          children: [
            Transform.rotate(
              angle: pi,
              child: const Image(
                image: AssetImage('assets/images/background_animated.gif'),
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: body
            )
          ],
        ),
      ),
    );
  }
}