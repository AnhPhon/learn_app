import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_two.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: BackgroundTwo(),
      child: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Center(
            child: Text("Page"),
          );
        },
      ),
    );
  }
}
