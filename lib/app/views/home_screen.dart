import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/background.dart';
import 'package:my_breath_work/app/widgets/space.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage('assets/mybreathwork_logo_001.png'),
            height: verticalSpace(context, .2),
            width: horizontalSpace(context, .3),
          ),
        ],
      ),
    );
  }
}