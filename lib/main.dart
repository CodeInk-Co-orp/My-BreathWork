import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/views/background/background.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const BackgroundScreen()
      },
    )
  );
}