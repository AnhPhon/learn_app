import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_glass.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_controller.dart';

class ForgetPasswordPage extends GetView<ForgetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundOtp(),
      body: GetBuilder(
        init: ForgetPasswordController(),
        builder: (ForgetPasswordController controller) {
          return SizedBox(
            height: IZIDimensions.iziSize.height,
            child: Center(
              child: IZIGlass(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      phone(),
                      button(
                        controller,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget phone() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: "Nhập số điện thoại",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
    );
  }

  Widget button(ForgetPasswordController controller) {
    return Row(
      children: [
        IZIButton(
          padding: EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_3X,
          ),
          onTap: () {
            controller.onBack();
          },
          icon: Icons.arrow_back,
          colorBG: ColorResources.WHITE,
          colorIcon: ColorResources.CIRCLE_COLOR_BG3,
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_3X,
        ),
        Expanded(
          child: IZIButton(
            colorBG: ColorResources.WHITE,
            colorText: ColorResources.CIRCLE_COLOR_BG3,
            padding: EdgeInsets.all(
              IZIDimensions.SPACE_SIZE_3X,
            ),
            onTap: () {
              controller.onConfirm();
            },
            isEnabled: controller.isEnalbeConfirm,
            label: 'Xác thực',
          ),
        ),
      ],
    );
  }
}
