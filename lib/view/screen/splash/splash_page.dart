import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/background/background_auth.dart';
import 'package:template/base_widget/background/background_four.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: BackgroundAppBar(),
      child: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Column(
            children: [
              IZIAppBar(
                title: "Thanh toán",
                callbackSearch: (val) {
                  print("Search: ${val}");
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      // mainAxisExtent: 10
                    ),
                    itemBuilder: (context, index) {
                      return IZICard();
                    },
                    itemCount: 50,
                  )
                ),
              )

              
            ],
          );
        },
      ),
    );
  }
}
