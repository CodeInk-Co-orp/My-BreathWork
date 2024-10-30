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
  void tooglecheckbox(){
    checked.value = !checked.value;
  }
  @override
  void onClose() {
    formKey;
    super.onClose();
  }
}