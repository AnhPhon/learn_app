import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/basewidget/getx_smart_refresh/getx_smart_refresh_page.dart';
import 'package:template/view/screen/v1-customer/project/project_controller.dart';

class V1ProjectPage extends GetView<V1ProjectController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProjectController>(
        init: V1ProjectController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(
              title: controller.title,
              isNotBack: true,
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),

                // Nut tabbar
                _tabBarWidget(context: context, controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),

                //tab view list
                _itemList(controller),
              ],
            ),
          );
        });
  }

  ///
  /// Nut tabbar
  ///
  Widget _tabBarWidget({required BuildContext context, required V1ProjectController controller}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .06),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.titleTabBar.length,
        itemBuilder: (BuildContext context, int index) {
          return TabBarWidget(
            onTap: () => controller.onChangeTab(index),
            index: index,
            currentIndex: controller.currentIndex.value,
            title: controller.titleTabBar[index]['tieuDe'].toString(),
          );
        },
      ),
    );
  }

  ///
  /// Tab view list
  ///
  Widget _itemList(V1ProjectController controller) {
    return Expanded(
      child: controller.initLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : DefaultTabController(
              length: controller.titleTabBar.length,
              child: Scaffold(
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(), // add
                  controller: controller.tabController,
                  children: List.generate(
                    controller.titleTabBar.length,
                    (index) {
                      return GetXSmartRefreshPage(
                        key: Key('GetXSmartRefreshPageV1Project_$index'),
                        enablePullUp: true,
                        enablePullDown: true,
                        onLoading: controller.onLoading,
                        onRefresh: controller.onRefresh,
                        child: Obx(
                          () => listViewItemBuilder(controller),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }

  Widget listViewItemBuilder(V1ProjectController controller) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.titleTabBar[controller.currentIndex.value]['duAnKhachHangResponse'].length as int,
      itemBuilder: (BuildContext ctx, int index) {
        return ItemListWidget(
          urlImage: controller.titleTabBar[controller.currentIndex.value]['duAnKhachHangResponse'][index].hinhAnhDaiDien.toString(),
          onTap: () => controller.onProjectDetailClick(controller.titleTabBar[controller.currentIndex.value]['duAnKhachHangResponse'][index].id.toString()),
          title: controller.titleTabBar[controller.currentIndex.value]['duAnKhachHangResponse'][index].ten.toString(),
          icon1: const Icon(Icons.location_city),
          rowText1: controller.titleTabBar[controller.currentIndex.value]['duAnKhachHangResponse'][index].idTinhTp != null ? controller.titleTabBar[controller.currentIndex.value]['duAnKhachHangResponse'][index].idTinhTp.toString() : '',
          colorRowText1: ColorResources.GREY,
          icon2: const Icon(Icons.calendar_today),
          rowText2: DateConverter.isoStringToddMMYYYY(controller.titleTabBar[controller.currentIndex.value]['duAnKhachHangResponse'][index].ngayBatDau!.toString()),
          colorRowText2: ColorResources.GREY,
          isSpaceBetween: true,
        );
      },
    );
  }
}
