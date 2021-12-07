import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_four.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: BackgroundFour(),
      child: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Center(
            child: Column(
              children: [
                IZIInput(
                  borderSize: 2,
                  allowEdit: true,
                  label: 'Email',
                  holdplacer: "Email",
                  type: IZIInputType.TEXT,
                  isRequired: true,
                  // validate: IZIValidate.email,
                  onChanged: (val){
                  },
                  isValidate: (val){
                    print("Validate ${val}");
                  },
                ),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
