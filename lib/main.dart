import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/views/auth/check_login_status.dart';
import 'package:my_breath_work/app/views/auth/login_screen.dart';
import 'package:my_breath_work/app/views/auth/register_screen.dart';
import 'package:my_breath_work/app/views/auth/try_free_screen.dart';
import 'package:my_breath_work/app/views/auth/verify_email.dart';
import 'package:my_breath_work/app/views/choose_screen.dart';
import 'package:my_breath_work/app/views/home_screen.dart';
import 'package:my_breath_work/app/views/music_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => CheckLoginStatus(),
        "/home": (context) => HomeScreen(),
        "/try_free": (context) => TryFreeScreen(),
        "/login": (context) =>  LoginScreen(),
        "/choose": (context) => ChooseScreen(),
        "/regester": (context) =>  RegesterScreen(),
        "/my_breathwork" : (context) => BreathworkScreen(),
        "/verify" : (context) => VerifyEmail(),
      },
    ),
  );
}