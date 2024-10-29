import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:my_breath_work/app/widgets/space.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        vsync: this, 
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            spawnMaxSpeed: 25,
            particleCount: int.parse((verticalSpace(context, .01).floor() * horizontalSpace(context, 1).floor() ~/ 5).toString()),
            spawnMinSpeed: 15,
            spawnOpacity: .75,
            baseColor: Colors.white,
          ),
        ),
        child: Container(
          height: verticalSpace(context, 1),
          width: horizontalSpace(context, 1),
          color: Colors.black,
        ),
      ),
    );
  }
}