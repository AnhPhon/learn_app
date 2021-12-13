import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_glass.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/update_password/update_password_controller.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundOtp(),
      body: GetBuilder(
        init: UpdatePasswordController(),
        builder: (UpdatePasswordController controller) {
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
                      password(),
                      rePassword(),
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

  Widget password() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      placeHolder: "Nhập mật khẩu mới",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
    );
  }
  Widget rePassword() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      placeHolder: "Xác nhận mật khẩu",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
    );
  }

  Widget button(UpdatePasswordController controller) {
    return Container(
      child: IZIButton(
        colorBG: ColorResources.WHITE,
        colorText: controller.isEnalbeConfirm ? ColorResources.CIRCLE_COLOR_BG3 : ColorResources.BLACK,
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_3X,
        ),
        onTap: () {
          controller.onConfirm();
        },
        isEnabled: controller.isEnalbeConfirm,
        label: 'Xác thực',
      ),
    );
  }
}
