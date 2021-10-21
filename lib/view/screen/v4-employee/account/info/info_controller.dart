import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class V4InfoController extends GetxController {
  GetIt sl = GetIt.instance;
  // khai báo is loading
  bool isLoading = true;

  //khai báo TextEditingController
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController indentityCardController = TextEditingController();
  TextEditingController dateIndentityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressIndentityController = TextEditingController();
}
