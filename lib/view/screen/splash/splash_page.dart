import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      appBar: const IZIAppBar(
        title: "Splash Page",
      ),
      body: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: IZIDimensions.ONE_UNIT_SIZE * 923,
                color: ColorResources.BACKGROUND,
                child: Column(
                  children: [
                    IZIButton(
                      margin: EdgeInsets.all(
                        IZIDimensions.ONE_UNIT_SIZE * 20,
                      ),
                      onTap: () => controller.goToMyOrder(),
                      label: "Click to Đơn hàng của tôi",
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
