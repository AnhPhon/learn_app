import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/transfers/transfers_detail/transfers_detail_controller.dart';

class TransfersDetailPage extends GetView<TransfersDetailController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "Chuyển tiền đến SĐT",
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
        init: TransfersDetailController(),
        builder: (TransfersDetailController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
              vertical: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              children: [
                card(),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: button(
                      controller: controller,
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

  Widget card() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
      constraints: BoxConstraints(
        maxHeight: IZIDimensions.ONE_UNIT_SIZE * 500,
      ),
      width: IZIDimensions.iziSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BLUR_RADIUS_4X,
        ),
        color: ColorResources.WHITE,
        boxShadow: IZIOther().boxShadow,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            content(
              text1: 'Tên người nhận',
              text2: "Nguyễn Thị Thu Hương",
            ),
            content(
              text1: 'Số điện thoại',
              text2: "0961-225-417",
            ),
            Container(
              margin: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_2X,
              ),
              child: const Divider(),
            ),
            IZIInput(
              type: IZIInputType.PRICE,
              placeHolder: "Nhập nội dung (không bắt buộc)",
              disbleError: true,
            ),
            Container(
              margin: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_2X,
              ),
              child: const Divider(),
            ),
            IZIInput(
              type: IZIInputType.TEXT,
              placeHolder: "Nhập nội dung (không bắt buộc)",
              disbleError: true,
            )
          ],
        ),
      ),
    );
  }

  Widget content({required String text1, required String text2}) {
    return Container(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
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
              maxLine: 2,
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

  Widget button({required TransfersDetailController controller}) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onToTransfersDetailPage();
      },
      label: 'Tiếp theo',
    );
  }
}
