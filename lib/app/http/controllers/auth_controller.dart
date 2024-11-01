import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_breath_work/app/widgets/text.dart';
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

  void tooglecheckbox(){
    checked.value = !checked.value;
  }
  
  void displayMessage(String message,BuildContext context, String title){
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
      if (context.mounted) {
        Get.offNamed("/choose");
      }
      clearFields();
      loading.value = false;
    } on FirebaseAuthException catch (e) {
        loading.value = false;
        displayMessage(e.message!,context,"Error!!");
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
        displayMessage(e.code,context,"Error!!");
        loading.value = false;
        // Get.back();
    }
  }
}
