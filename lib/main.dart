import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/views/auth/login_screen.dart';
import 'package:my_breath_work/app/views/auth/regest_screen.dart';
import 'package:my_breath_work/app/views/auth/try_free_screen.dart';
import 'package:my_breath_work/app/views/choose_screen.dart';
import 'package:my_breath_work/app/views/home_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomeScreen(),
        "/try_free": (context) => TryFreeScreen(),
        "/login": (context) =>  LoginScreen(),
        "/choose": (context) => const ChooseScreen(),
        "/regest": (context) =>  RegestScreen(),
      },
    )
  );
}