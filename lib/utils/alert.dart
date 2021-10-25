import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

mixin Alert {
  static void error(
      {required String title,
      required String message,
      Color? backgroundColor}) {
    showToast(
      message.toString(),
      context: Get.context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      backgroundColor: backgroundColor ?? ColorResources.RED,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  static void success(
      {required String title,
      required String message,
      Color? backgroundColor}) {
    showToast(
      message.toString(),
      context: Get.context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      backgroundColor: backgroundColor ?? ColorResources.GREEN,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  static void info(
      {required String title,
      required String message,
      Color? backgroundColor}) {
    showToast(
      message.toString(),
      context: Get.context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      textStyle: const TextStyle(color: ColorResources.BLACK, fontWeight: FontWeight.w600),
      backgroundColor: backgroundColor ?? ColorResources.TEXT_BG,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }
}
