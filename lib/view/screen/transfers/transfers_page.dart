import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/Transfers/Transfers_controller.dart';

class TransfersPage extends GetView<TransfersController> {
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
        init: TransfersController(),
        builder: (TransfersController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              children: [
                search(),
                listOfReceivers(controller: controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget search() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: IZIInput(
        type: IZIInputType.TEXT,
        placeHolder: "Nhập tên hoặc số điện thoại",
        suffixIcon: Container(
          margin: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: GestureDetector(
            onTap: () {
              controller.onToContactPage();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.contact_phone_rounded,
                  color: ColorResources.RED,
                ),
                IZIText(
                  text: "Danh bạ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listOfReceivers({required TransfersController controller}) {
    return Expanded(
      child: SingleChildScrollView(
        child: IZIListView(
          label: "DANH SÁCH NGƯỜI NHẬN",
          action: IZIText(
            text: "Tất cả(${controller.contactReceive.length})",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.RED,
            ),
          ),
          itemCount: controller.contactReceive.length,
          crossAxisCount: 4,
          mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 190,
          type: IZIListViewType.GRIDVIEW,
          builder: (index) {
            return Container(
              margin: EdgeInsets.only(
                top: IZIDimensions.SPACE_SIZE_4X,
              ),
              child: IZICard(
                marginCard: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_4X,
                ),
                cardType: IZICardType.CARD_CIRCLE,
                title: controller.contactReceive[index].toString()[0].toUpperCase(),
                row1Left: controller.contactReceive[index].toString().toUpperCase(),
                onTap: () {
                  controller.onToTransfersDetailPage();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
