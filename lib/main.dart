import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/views/auth/login_screen.dart';
import 'package:my_breath_work/app/views/auth/try_free_screen.dart';
import 'package:my_breath_work/app/views/home_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomeScreen(),
        "/try_free": (context) => const TryFreeScreen(),
        "/login": (context) => LoginScreen(),
      },
    )
  );
}