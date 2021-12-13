import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_splash.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundSplash(),
      body: GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return SizedBox(
            height: IZIDimensions.iziSize.height,
            child: Center(
              child: IZIImage(
                ImagesPath.logo,
              ),
            ),
          );
        },
      ),
    );
  }
}
