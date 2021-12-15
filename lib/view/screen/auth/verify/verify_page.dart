import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_otp.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/auth/verify/verify_controller.dart';

class VerifyPage extends GetView<VerifyController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundOtp(),
      body: GetBuilder(
        init: VerifyController(),
        builder: (VerifyController controller) {
          return Container(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            child: Center(
              child: IZIOtp(
                lables: label(),
                onTap: () {},
                isEnabled: true,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> label() {
    return [
      Container(
        margin: EdgeInsets.only(
          top: IZIDimensions.ONE_UNIT_SIZE * 60,
          right: IZIDimensions.SPACE_SIZE_2X,
          left: IZIDimensions.SPACE_SIZE_2X,
        ),
        child: IZIText(
          text: "Xác thực tài khoản",
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: IZIDimensions.SPACE_SIZE_2X,
          right: IZIDimensions.SPACE_SIZE_2X,
          left: IZIDimensions.SPACE_SIZE_2X,
          bottom: IZIDimensions.SPACE_SIZE_5X,
        ),
        child: IZIText(
          text: "Mã xác thực sẽ được gửi đến số điện thoại của bạn",
          maxLine: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6,
          ),
        ),
      )
    ];
  }
}
