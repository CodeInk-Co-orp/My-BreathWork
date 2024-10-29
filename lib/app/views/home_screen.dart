import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundScreen(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage('assets/home_icon.png'),
          ),
        ],
      ),
    );
  }
}