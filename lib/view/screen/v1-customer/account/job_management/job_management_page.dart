import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/job_management/job_management_controller.dart';

class V1JobManagementPage extends GetView<V1JobManagementController> {
  ///
  /// build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1JobManagementController>(
      init: V1JobManagementController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F7),
          appBar: AppBarWidget(title: controller.title),
          body: Column(
            children: [
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //tab
              _tabBarWidget(context: context, controller: controller),

              //item list
              _itemList(context),
            ],
          ),
        );
      },
    );
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V1JobManagementController controller}) {
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
            title: controller.titleTabBar[index].toString(),
          );
        },
      ),
    );
  }

  ///
  ///list item
  ///
  Widget _itemList(BuildContext context) {
    return GetBuilder<V1JobManagementController>(
      builder: (controller) {
        // if (controller.isLoadingLienHe) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        left: Dimensions.PADDING_SIZE_LARGE,
                        right: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      child: ItemListWidget(
                        textOverImage: true,
                        StringTextOverImage: "Đà Nẵng",
                        title: "sadasdadasd",
                        rowText1: "Ngux hanf son",
                        icon1: const Icon(
                          Icons.location_on,
                          size: Dimensions.ICON_SIZE_SMALL,
                        ),
                        rowText2: "35 ngayf",
                        icon2: const Icon(
                          Icons.access_time_outlined,
                          size: Dimensions.ICON_SIZE_SMALL,
                        ),
                        onTap: () {},
                        isSpaceBetween: true,
                        urlImage: "",
                        boxShadow: boxShadowALitle,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_SMALL,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
