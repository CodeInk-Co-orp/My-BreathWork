import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/widgets/text.dart';
import 'dart:async';
import 'package:my_breath_work/util/colors.dart';

class AuthController extends GetxController{
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController language = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final regestKey = GlobalKey<FormState>();
  RxBool checked = false.obs;
  final loading = false.obs;
  late final isverified = false.obs;
  RxInt seconds = 0.obs;
  Timer? timer;

  void tooglecheckbox(){
    checked.value = !checked.value;
  }
  
  void displayMessage(String message,BuildContext context, String title, void Function()? onTap){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: CustomText(
          text: title, 
          fontSize: 20, 
          textColor: KColors.black
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: KColors.black,
                fontSize: 16
              ),
            )
          ],
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: KColors.primary,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      text: "OK", 
                      fontSize: 18, 
                      textColor: KColors.white
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: KColors.primary,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      text: "OK", 
                      fontSize: 18, 
                      textColor: KColors.white
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
  
  void clearFields(){
    email.clear();
    password.clear();
    name.clear();
    language.clear();
  }

  void disposeFields(){
    email.clear();
    password.clear();
    name.clear();
    language.clear();
  }

  void signUp(BuildContext context) async {
    loading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text, 
            password: password.text
        );
      await FirebaseFirestore.instance
        .collection('users')
        .add({
          "name": name.text,
          "email": email.text,
          "language": language.text,
          'checked': checked.value,
          'user_id': userCredential.user!.uid,
        }
      );
      clearFields();
      loading.value = false;
      Get.offNamed("/choose");
    } on FirebaseAuthException catch (e) {
        loading.value = false;
        displayMessage(e.message!,context,"Error!!",(){});
        clearFields();
        Get.back();
    }
  }
  
  void signIn(BuildContext context) async {
    loading.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text
      );
      if (context.mounted) {
        Get.offNamed("/choose");
      }
      loading.value = false;
      clearFields();
    } on FirebaseAuthException catch (e) {
        displayMessage(e.code,context,"Error!!",(){});
        loading.value = false;
    }
  }
  Future<void> resetPassword(BuildContext context) async {
    loading.value = true;
    try {
      bool isEmailRegistered = await isEmailRegisteredFunction(email.text);
      if (!isEmailRegistered) {
        displayMessage("Email not found. Try to register instead", context, "Error",(){});
        loading.value = false;
      } else {
        loading.value = false;
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        Get.back();
        displayMessage(
          "Password reset successfully. Kindly check your email.", 
          context,
           "success", 
           (){}
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      displayMessage(
        e.message.toString(), 
        context, 
        "Error", 
        (){}
      );
    } catch (e) {
      Get.back();
      displayMessage(
        "An error occured while processing. Please try again later.", 
        context, 
        "Error", 
        (){}
      );
    }
  }
  Future sendVerification() async {
    seconds.value = 300;
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          seconds.value -= 1;
          if(seconds > 0){
            checkVerified();
          } else {
            seconds.value = 0;
            timer.cancel();
            return;
          }
        }
      );
    } catch (e) {
      rethrow;
    }
  }

  Future checkVerified () async {
    await FirebaseAuth.instance.currentUser!.reload();    
    isverified.value = FirebaseAuth.instance.currentUser!.emailVerified;
    if(isverified.value){
      Get.to("/choose");
    }
  }
  Future<bool> isEmailRegisteredFunction(String email) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
      return query.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
