import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_auth.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_glass.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAuth(),
      body: GetBuilder(
        init: LoginController(),
        builder: (LoginController controller) {
          return SizedBox(
            height: IZIDimensions.iziSize.height,
            child: Center(
              child: IZIGlass(
                width: IZIDimensions.iziSize.width * 0.9,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Column(
                    children: [
                      label(),

                      phone(),

                      password(),

                      button(controller),

                      fingerprint(),

                      Expanded(
                        child: other(controller),
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

  Widget label() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: IZIText(
        text: "Đăng nhập",
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H4,
          fontWeight: FontWeight.bold,
          color: ColorResources.WHITE,
        ),
      ),
    );
  }

  Widget phone() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: "Số điện thoại",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      prefixIcon: Icon(
        Icons.account_circle_outlined,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
      ),
    );
  }

  Widget password() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: "Nhập mật khẩu",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      prefixIcon: Icon(
        Icons.lock,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
      ),
      suffixIcon: GestureDetector(
        onTap: () {
          controller.onFingerprintUnlock();
        },
        child: Icon(
          Icons.fingerprint,
          size: IZIDimensions.ONE_UNIT_SIZE * 40,
        ),
      ),
    );
  }

  Widget button(LoginController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onLogin();
      },
      label: 'Đăng nhập',
    );
  }

  Widget fingerprint() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.fingerprint),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          const IZIText(
            text: "Mở khóa bằng vân tay",
          )
        ],
      ),
    );
  }

  Widget other(LoginController controller) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.onToForgetPasswordPage();
            },
            child: const IZIText(
              text: "Quên mật khẩu?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          GestureDetector(
            onTap: () {
              controller.onToSignUpPage();
            },
            child: const IZIText(
              text: "Đăng ký",
              style: TextStyle(
                color: ColorResources.CIRCLE_COLOR_BG3,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
