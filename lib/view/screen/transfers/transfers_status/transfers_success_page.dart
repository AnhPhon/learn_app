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
import 'package:template/view/screen/transfers/transfers_status/transfers_success_controller.dart';

class TransfersSuccessPage extends GetView<TransfersSuccessController> {
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
        init: TransfersSuccessController(),
        builder: (TransfersSuccessController controller) {
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
        ImagesPath.success,
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
            text: 'Chuyển tiền thành công',
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H4,
              color: ColorResources.GREEN,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_5X,
          ),
          Text(
            'Bạn đã thực hiện chuyển tiền thành công! Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ của chúng tôi',
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

  Widget buttons({required TransfersSuccessController controller}) {
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

  Widget goHomeBackButton({required TransfersSuccessController controller}) {
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

  Widget textButton({required TransfersSuccessController controller}) {
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
