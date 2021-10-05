import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/form_management/form_management_controller.dart';

class V1FormManagementPage extends GetView<V1FormManagementController> {
  ///
  /// Khi chọn tab
  ///
  Widget onSelectedTab(
      BuildContext context, V1FormManagementController controller,
      {required String title, required int index, required bool isRight}) {
    return GestureDetector(
      onTap: () {
        controller.onChangeTab(index);
      },
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: DeviceUtils.getScaledWidth(context, 0.9).roundToDouble() / 2,
        decoration: BoxDecoration(
          borderRadius: isRight == false
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
              : const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
          color: controller.currentIndex == index
              ? ColorResources.PRIMARY
              : ColorResources.WHITE,
          border: controller.currentIndex == index
              ? null
              : Border.all(color: ColorResources.PRIMARY),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: controller.currentIndex == index
                  ? ColorResources.WHITE
                  : ColorResources.BLACK),
        ),
      ),
    );
  }

  ///
  /// Thanh chọn tab
  ///
  Widget tabBarWidget(
      {required BuildContext context,
      required V1FormManagementController controller}) {
    return Container(
      alignment: Alignment.center,
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, 0.1),
      child: Container(
        alignment: Alignment.center,
        width: DeviceUtils.getScaledWidth(context, 0.9).roundToDouble(),
        height: DeviceUtils.getScaledHeight(context, 0.07),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            onSelectedTab(context, controller,
                title: controller.titleTabBar['DPH']!,
                index: 0,
                isRight: false),
            onSelectedTab(context, controller,
                title: controller.titleTabBar['CPH']!, index: 1, isRight: true),
          ],
        ),
      ),
    );
  }

  ///
  /// item list
  ///
  Widget _itemList(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onProductResponseClick();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 0.025),
            vertical: DeviceUtils.getScaledWidth(context, 0.026)),
        height: DeviceUtils.getScaledHeight(context, 0.118),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorResources.WHITE,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset("assets/images/news_template.png",
                    fit: BoxFit.fill,
                    height: DeviceUtils.getScaledHeight(context, 0.118),
                    width: DeviceUtils.getScaledWidth(context, 0.26))),
            SizedBox(width: DeviceUtils.getScaledWidth(context, 0.025)),
            const Flexible(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Thợ ốp lát: Công trình khách hàng 5 sao",
                style: TextStyle(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
              ),
            )),
          ],
        ),
      ),
    );
  }

  ///
  /// build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1FormManagementController>(
        init: V1FormManagementController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xFFF6F6F7),
            body: Column(
              children: [
                AppBarWidget(title: controller.title),
                tabBarWidget(context: context, controller: controller),
                ...List.generate(5, (index) => _itemList(context)),
              ],
            ),
          );
        });
  }
}
