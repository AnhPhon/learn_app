import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/transfers/transfers_confirm/transfers_confirm_controller.dart';

class TransfersConfirmPage extends GetView<TransfersConfirmController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "Xác nhận chuyển tiền",
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
        init: TransfersConfirmController(),
        builder: (TransfersConfirmController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      title(title: 'Thông tin tài khoản'),
                      card(),
                      title(title: 'Số tiền giao dịch'),
                      transactionAmount(),
                    ],
                  ),
                ),
                button(
                  controller: controller,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget title({required String title}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: IZIText(
        text: title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget card() {
    return Container(
      width: IZIDimensions.iziSize.width,
      child: Column(
        children: [
          content(
            text1: 'Tên người nhận',
            text2: "Nguyễn Thị Thu Hương",
          ),
          content(
            text1: 'Số điện thoại',
            text2: "0961-225-417",
          ),
          content(
            text1: 'Nội dung thanh toán',
            text2: "Test trường hợp chuyển tiền có nội dung dài",
            maxLine: 15,
          ),
          Container(
            margin: EdgeInsets.all(
              IZIDimensions.SPACE_SIZE_2X,
            ),
            child: const Divider(),
          ),
        ],
      ),
    );
  }

  Widget transactionAmount() {
    return Container(
      width: IZIDimensions.iziSize.width,
      child: Column(
        children: [
          content(
            text1: 'Số tiền',
            text2: "10.000 VNĐ",
          ),
          content(
            text1: 'Phí giao dịch',
            text2: "0 VNĐ",
          ),
        ],
      ),
    );
  }

  Widget content({required String text1, required String text2, int maxLine = 2}) {
    return Container(
      padding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: IZIText(
              text: text1,
              maxLine: 2,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          Flexible(
            child: IZIText(
              text: text2,
              textAlign: TextAlign.end,
              maxLine: maxLine,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button({required TransfersConfirmController controller}) {
    return IZIButton(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_4X,
      ),
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        // controller.showDialogConfirmPassword();
        controller.showDialogConfirmPassword();
      },
      label: 'Xác nhận',
    );
  }
}
