

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

void showSnackBar({required String title, required String message}){
  Get.snackbar(
    title, // title
    message, // message
    shouldIconPulse: true,
    isDismissible: true,
    backgroundColor: const Color(0xffFFEBEE),
    icon: const Icon(Icons.error_outline),
    duration: const Duration(seconds: 2),
  );
}