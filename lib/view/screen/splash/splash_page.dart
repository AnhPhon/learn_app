import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        color: ColorResources.WHITE,
        child: Center(
            child: Image.asset(
          Images.logo_image,
          fit: BoxFit.contain,
        )),
      ),
    );
  }
}
