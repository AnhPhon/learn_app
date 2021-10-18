

import 'package:get/get.dart';

void showSnackBar({required String title, required String message}){
  Get.snackbar(
    title, // title
    message, // message
    shouldIconPulse: true,
    isDismissible: true,
    duration: const Duration(seconds: 2),
  );
}