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
import 'package:template/view/screen/transfers/contact/contact_controller.dart';

class ContactPage extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "Danh bạ",
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
        init: ContactController(),
        builder: (ContactController controller) {
          return Container(
            child: Column(
              children: [
                search(),
                contact(),
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
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: IZIInput(
        type: IZIInputType.TEXT,
        borderRadius: IZIDimensions.BLUR_RADIUS_3X,
        placeHolder: "Tìm kiếm trong danh bạ",
        prefixIcon: Container(
          margin: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: const Icon(
            Icons.search,
            color: ColorResources.LIGHT_GREY,
          ),
        ),
        onChanged: (val) {
          controller.onSearch(term: val);
        },
      ),
    );
  }

  Widget contact() {
    return Expanded(
      child: SingleChildScrollView(
        child: IZIListView(
          itemCount: controller.data.keys.length,
          builder: (index) {
            return Column(
              children: [
                aphabet(index),
                contactList(index),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget aphabet(int index) {
    return Container(
      width: IZIDimensions.iziSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1.2,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: IZIText(
              text: controller.data.keys.toList()[index].toString(),
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            thickness: 1.2,
          ),
        ],
      ),
    );
  }

  Widget contactList(int index) {
    return Container(
      padding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
        left: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: IZIListView(
        itemCount: controller.data[controller.data.keys.toList()[index]]!.length,
        builder: (i) {
          return IZICard(
              cardType: IZICardType.CARD_CONTACT,
              row1Left: controller.data[controller.data.keys.toList()[index]]![i]['name'].toString(),
              row2Left: controller.data[controller.data.keys.toList()[index]]![i]['phone'].toString(),
              heightCard: IZIDimensions.ONE_UNIT_SIZE * 110,
              isShowLineContact: i != controller.data[controller.data.keys.toList()[index]]!.length - 1,
              title: controller.data[controller.data.keys.toList()[index]]![i]['name'].toString()[0].toUpperCase(),
              onTap: () {
                controller.onToTransfersPage();
              });
        },
      ),
    );
  }
}
