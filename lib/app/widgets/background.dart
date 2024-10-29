import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/home_controller.dart';
import 'package:my_breath_work/app/widgets/space.dart';
import 'package:my_breath_work/util/colors.dart';

class BackgroundScreen extends StatelessWidget {
  BackgroundScreen({super.key, required this.body, this.transparent});
  final Widget body;
  final bool? transparent;
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: verticalSpace(context, 1),
            width: horizontalSpace(context, 1),
            color: KColors.black,
            child: Transform.rotate(
              angle: pi,
              child: const Image(
                image: AssetImage('assets/images/background_animated.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              color: Colors.white.withOpacity(transparent == null ? .1 : transparent == true ? .0 : .1),
              width: 500,
              child: body
            ),
          ),
        ],
      ),
    );
  }
}