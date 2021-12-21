import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/transfers/transfers_status/fail/transfers_fail_controller.dart';

class TransfersFailPage extends GetView<TransfersFailController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "Thông báo",
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
      ),
      body: GetBuilder(
        init: TransfersFailController(),
        builder: (TransfersFailController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              children: [
                image(),
                title(),
                Expanded(
                  child: buttons(
                    controller: controller,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget image() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
      ),
      height: IZIDimensions.ONE_UNIT_SIZE * 450,
      child: IZIImage(
        ImagesPath.fail,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget title() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IZIText(
            text: 'Giao dịch thất bại',
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H4,
              color: ColorResources.RED,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_5X,
          ),
          Text(
            'Số dư tài khoản không đủ để thực hiện giao dịch. Quý khách vui lòng nạp tiền vào tài khoản và thực hiện tiếp giao dịch',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.BLACK,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons({required TransfersFailController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          goHomeBackButton(
            controller: controller,
          ),
          textButton(
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget goHomeBackButton({required TransfersFailController controller}) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onToHomePage();
      },
      label: 'Tiếp theo',
    );
  }

  Widget textButton({required TransfersFailController controller}) {
    return GestureDetector(
      onTap: () {
        controller.onToOtherTransfersPage();
      },
      child: IZIText(
        text: 'Thực hiện giao dịch khác',
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6,
          color: ColorResources.RED,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
