import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button_icon.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/v2-builder/component_builder/item_list_widget.dart';
import 'package:template/view/screen/v2-builder/shorthanded/shorthanded_controller.dart';

class V2ShorthandedPage extends GetView<V2ShorthandedController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedController>(
        init: V2ShorthandedController(),
        builder: (controller) {
          return Scaffold(
            appBar: const AppBarWidget(title: "field tìm kiếm"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //filter
                  _filter(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //item list
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.shorthandedGroupList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ItemListWidget(
                          isSpaceBetween: true,
                          onTap: () => controller.onShorthandedGroup(index),
                          title: controller.shorthandedGroupList[index]['label']
                              .toString(),
                          icon: controller.shorthandedGroupList[index]['icon']
                              as Icon,
                          rowText1: controller.shorthandedGroupList[index]
                                  ['location']
                              .toString(),
                          rowText2: controller.shorthandedGroupList[index]
                                  ['status']
                              .toString(),
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///filter
  ///
  Widget _filter(BuildContext context,
      {required V2ShorthandedController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // controller.showDialog();
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT),
            child: DropDownButtonIcon<String>(
              width: DeviceUtils.getScaledWidth(context, 0.25),
              onChanged: (val) {},
              data: const [],
              icon: const Icon(
                Icons.filter_alt_outlined,
                size: Dimensions.ICON_SIZE_DEFAULT,
              ),
              hint: "Lọc",
              dropIcon: Container(),
              style: const TextStyle(color: ColorResources.BLACK),
            ),
          ),
        ),
        DropDownButton1<String>(
          value: " ",
          width: double.infinity,
          onChanged: (val) {},
          data: const [],
          hint: "Chọn nhóm công việc",
        ),
        DropDownButton1<String>(
          value: " ",
          width: double.infinity,
          onChanged: (val) {},
          data: const [],
          hint: "Chọn công việc",
        ),
        Row(
          children: [
            Expanded(
              child: DropDownButton1<String>(
                value: " ",
                width: double.infinity,
                onChanged: (val) {},
                data: const [],
                hint: "Tỉnh/TP",
              ),
            ),
            Expanded(
              child: DropDownButton1<String>(
                value: " ",
                width: double.infinity,
                onChanged: (val) {},
                data: const [],
                hint: "Quận",
              ),
            ),
            Expanded(
              child: DropDownButton1<String>(
                value: " ",
                width: double.infinity,
                onChanged: (val) {},
                data: const [],
                hint: "Phường",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
