import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/http/controllers/auth_controller.dart';
import 'package:my_breath_work/app/views/auth/login_screen.dart';
import 'package:my_breath_work/app/views/choose_screen.dart';

class CheckLoginStatus extends StatelessWidget {
  CheckLoginStatus({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {          
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return ChooseScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}