import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  void displayMessage(String message,BuildContext context){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message
            )
          ],
        ),
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
      Get.off('/choose');
      clearFields();
      loading.value = false;
    } on FirebaseAuthException catch (e) {
        loading.value = false;
        Get.back();
        displayMessage(e.message!,context);
        clearFields();
        Get.back();
    }
  }
  void signIn(BuildContext context) async {
    loading.value = true;
    const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 10,
      ),
    );
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
      loading.value = false;
      Get.back();
      displayMessage(e.code,context);
    }
  }
  @override
  void onClose() {
    formKey;
    super.onClose();
  }
}
