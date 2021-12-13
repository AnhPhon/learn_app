import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_Home.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      body: GetBuilder(
        init: HomeController(),
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
