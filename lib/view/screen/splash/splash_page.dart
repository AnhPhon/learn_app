import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/base_widget/izi_file.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_otp.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';
import 'package:template/view/screen/test/test_component.dart';

class SplashPage extends GetView<SplashController> {
  SplashPage({Key? key}) : super(key: key);
  final keyList = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: BackgroundOtp(),
      appBar: const IZIAppBar(
        title: "Splash Page",
      ),
      body: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Column(
            children: [
              SizedBox(
                height: IZIDimensions.iziSize.height,
                child: Center(
                  child: IZIOtp(
                    lables: [
                    Container(
                      margin: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_5X,
                      ),
                      child: IZIText(
                        text: "Xác thực tài khoản",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: IZIDimensions.FONT_SIZE_H4,
                          color: ColorResources.CIRCLE_COLOR_BG3,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: IZIText(
                        text:"Nôi dung miêu tả xác thực tài khoản",
                        textAlign: TextAlign.center,
                        maxLine: 4,
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                        ),
                      ),
                    ),
                    ],
                    codeLength: 4,
                    countDown: 10,
                    isEnabled: true,
                    onTapSendSMS: (){
                      
                    },
                    onTap: (){
                      Get.to(TestComponentPage());
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
