import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TryFreeController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  RxBool sayName = false.obs;
}