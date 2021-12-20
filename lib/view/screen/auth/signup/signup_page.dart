import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/background/background_auth.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_file.dart';
import 'package:template/base_widget/izi_glass.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/signup/signup_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAuth(),
      body: GetBuilder(
        init: SignUpController(),
        builder: (SignUpController controller) {
          return Container(
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IZIGlass(
                  width: IZIDimensions.iziSize.width * 0.9,
                  height: IZIDimensions.iziSize.height * 0.8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          label(),
                          phone(),
                          accountInput(),
                          email(),
                          password(),
                          avatar(),
                          citizenID(),
                          other(
                            controller,
                          ),
                          button(
                            controller,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget label() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: IZIText(
        text: "Đăng ký",
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
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(
        Icons.phone,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget accountInput() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Nhập họ và tên",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(
        CupertinoIcons.person_crop_circle,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget email() {
    return IZIInput(
      type: IZIInputType.EMAIL,
      placeHolder: "Email",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(
        CupertinoIcons.mail,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget password() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: "Nhập mật khẩu",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.done,
      prefixIcon: Icon(
        Icons.lock,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
      suffixIcon: Icon(
        Icons.fingerprint,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget button(SignUpController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onToPageVerify();
      },
      label: 'Đăng ký',
    );
  }

  Widget avatar() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IZIFile(
            width: IZIDimensions.iziSize.width * 0.24,
            height: IZIDimensions.iziSize.width * 0.24,
            imageSource: ImageSource.camera,
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IZIText(
                text: "Chụp ảnh khuôn mặt đại diện  của bạn ",
              ),
              IZIText(
                text: "*",
                style: TextStyle(
                  color: ColorResources.RED,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget citizenID() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              IZIFile(
                width: IZIDimensions.iziSize.width * 0.24,
                height: IZIDimensions.iziSize.width * 0.24,
                imageSource: ImageSource.camera,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              IZIFile(
                width: IZIDimensions.iziSize.width * 0.24,
                height: IZIDimensions.iziSize.width * 0.24,
                imageSource: ImageSource.camera,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IZIText(
                text: " Chụp CMND/CCCD mặt trước/ mặt sau",
              ),
              IZIText(
                text: "*",
                style: TextStyle(
                  color: ColorResources.RED,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget other(SignUpController controller) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: const IZIText(
                text: "Đã có tài khoản?",
              ),
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_1X,
            ),
            GestureDetector(
              onTap: () {
                controller.onToPageLogin();
              },
              child: const IZIText(
                text: "Đăng nhập",
                style: TextStyle(
                  color: ColorResources.CIRCLE_COLOR_BG3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
