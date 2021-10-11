import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/tab_bar_widget.dart';
import 'package:template/view/screen/v3-agent/project/project_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V3ProjectPage extends GetView<V3ProjectController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ProjectController>(
        init: V3ProjectController(),
        builder: (controller) {
          return Scaffold(
            appBar: const AppBarWidget(
              title: "Dự án",
              leading: false,
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),

                //tab bar
                _tabBarWidget(context: context, controller: controller),

                //items list
                _itemList(controller),
              ],
            ),
          );
        });
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V3ProjectController controller}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .07),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.titleTabBar.length,
          itemBuilder: (BuildContext context, int index) {
            return TabBarWidget(
                onTap: () => controller.onChangeTab(index),
                index: index,
                currentIndex: controller.currentIndex,
                title: controller.titleTabBar[index].toString());
          }),
    );
  }

  ///
  ///item list
  ///
  Widget _itemList(V3ProjectController controller) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_LARGE,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext ctx, int index) {
                  return ItemListWidget(
                    urlImage: "",
                    onTap: (){},//controller.onProjectDetailClick(),
                    title: "Thợ ốp lát: Công trình khách hàng 5 sao",
                    icon1: const Icon(Icons.location_on),
                    rowText1: "Ngũ Hàng Sơn",
                    colorRowText1: ColorResources.GREY,
                    icon2: const Icon(Icons.calendar_today),
                    rowText2: "30/09/2021",
                    colorRowText2: ColorResources.GREY,
                    isSpaceBetween: true,
                  );
                }),
          ],
        ),
      ),
    );
  }
}