import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarUtils {
  static void showSnackBar(
      {required String title,
      required String message,
      Color? backgroundColor}) {
    Get.snackbar(
      title, // title
      message, // message
      shouldIconPulse: true,
      isDismissible: true,
      backgroundColor: backgroundColor ?? const Color(0xffFFEBEE),
      icon: const Icon(Icons.error_outline),
      duration: const Duration(seconds: 2),
    );
  }

  static void showSnackBarSuccess(
      {required String title,
      required String message,
      Color? backgroundColor}) {
    Get.snackbar(
      title, // title
      message, // message
      shouldIconPulse: true,
      isDismissible: true,
      backgroundColor: backgroundColor ?? const Color(0xff97e7b9),
      icon: const Icon(Icons.check_circle),
      duration: const Duration(seconds: 2),
    );
  }
}
