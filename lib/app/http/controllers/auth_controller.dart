import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
}