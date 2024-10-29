import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/util/colors.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: verticalSpace(context, 1),
        width: horizontalSpace(context, 1),
        color: KColors.black,
        child: const Image(
          image: AssetImage('assets/images/background_animated.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}