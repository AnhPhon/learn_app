import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account/account_information.dart/account_information_controller.dart';

class AccountInfomationPage extends GetView<AccountInfomationController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      body: GetBuilder(
        builder: (AccountInfomationController controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(
                  IZIDimensions.SPACE_SIZE_3X,
                ),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).padding.top + kToolbarHeight,
                child: GestureDetector(
                  onTap: (){
                    controller.onBack();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.iziSize.width,
                child: avatar(),
              ),
              input(),
            ],
          );
        },
      ),
    );
  }

  Widget avatar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: IZIDimensions.ONE_UNIT_SIZE * 90,
              child: IZIImage(
                ImagesPath.nature,
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorResources.WHITE,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 5,
                ),
                child: const Icon(
                  Icons.camera_alt,
                ),
              ),
            )
          ],
        ),
        userInfo(),
      ],
    );
  }

  Widget userInfo() {
    return Container(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: Column(
        children: [
          IZIText(
            text: "Đỗ Thanh Nhàn",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H4,
              fontWeight: FontWeight.w500,
            ),
          ),
          IZIText(
            text: "01029999999",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget input() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              lastName(),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              firtName(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              birthday(),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              gender(),
            ],
          ),
          phone(),
          email(),
          button(controller),
        ],
      ),
    );
  }

  Widget lastName() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Họ",
      isRequired: true,
      label: "Họ",
      width: IZIDimensions.iziSize.width * 0.52,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget firtName() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "Tên",
      label: "Tên",
      width: IZIDimensions.iziSize.width * 0.35,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget birthday() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Ngày sinh",
      isRequired: true,
      label: "Ngày sinh",
      width: IZIDimensions.iziSize.width * 0.52,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget gender() {
    return DropDownButton<String>(
      isRequired: true,
      hint: "Giới tính",
      label: "Giới tính",
      width: IZIDimensions.iziSize.width * 0.35,
      data: controller.genders,
      value: controller.gender,
    );
  }

  Widget phone() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Số điện thoại",
      isRequired: true,
      label: "Số điện thoại",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget email() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "example@gmail.com",
      label: "Email (nếu có)",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget button(AccountInfomationController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {},
      label: 'Cập nhập',
    );
  }
}
