
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:template/provider/upload_image_provider.dart';
// import 'package:template/provider/user_provider.dart';

class V4InfoController extends GetxController {
  // khai báo is loading
  bool isLoading = true;

  //khai báo TextEditingController
  final nameController = TextEditingController();
  final birthdayController = TextEditingController();
  final indentityCardController = TextEditingController();
  final dateIndentityController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final addressIndentityController = TextEditingController();

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  // }
}
