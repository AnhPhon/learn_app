import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/screen/v2-builder/workflow_management/workflow_management_controller.dart';

class V2WorkflowManagementPage extends GetView<V2WorkflowManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2WorkflowManagementController>(
      init: V2WorkflowManagementController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
              Expanded(child: _itemList(context)),
            ],
          ),
        );
      },
    );
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget({required BuildContext context, required V2WorkflowManagementController controller}) {
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
    return GetBuilder<V2WorkflowManagementController>(
      builder: (controller) {
        if (controller.isLoadingList) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SmartRefresher(
          enablePullUp: controller.donDichVuList.isNotEmpty,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          controller: controller.refreshController,
          footer: const ClassicFooter(
            loadingText: "Đang tải...",
            noDataText: "Không có dữ liệu",
            canLoadingText: "Kéo lên để tải thêm dữ liệu",
          ),
          child: (controller.donDichVuList.isEmpty)
              ? const Center(
                  child: Text("Chưa có dữ liệu"),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.donDichVuList.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              left: Dimensions.PADDING_SIZE_LARGE,
                              right: Dimensions.PADDING_SIZE_LARGE,
                            ),
                            child: ItemListWidget(
                              textOverImage: true,
                              stringTextOverImage: controller.donDichVuList[index].idTinhTp != null ? controller.donDichVuList[index].idTinhTp!.ten : null,
                              title: controller.donDichVuList[index].tieuDe.toString(),
                              rowText1: controller.donDichVuList[index].idQuanHuyen == null ? null : controller.donDichVuList[index].idQuanHuyen!.ten.toString(),
                              icon1: controller.donDichVuList[index].idQuanHuyen == null
                                  ? null
                                  : const Icon(
                                      Icons.location_on,
                                      size: Dimensions.ICON_SIZE_SMALL,
                                    ),
                              rowText2: (controller.currentIndex == 0)
                              ? (controller.donDichVuList[index].ngayKetThuc == 'null')
                                  ? controller.getDeadline(
                                      start: controller.donDichVuList[index].ngayBatDau.toString(),
                                      end: DateTime.now().toIso8601String(),
                                    )
                                  : controller.getDeadline(
                                      start: controller.donDichVuList[index].ngayBatDau.toString(),
                                      end: controller.donDichVuList[index].ngayKetThuc.toString(),
                                    )
                              : TRANG_THAI_DON_DICH_VU_DA_LAM[controller.donDichVuList[index].idTrangThaiDonDichVu!.id],
                              icon2: (controller.currentIndex == 0)
                                ? const Icon(
                                    Icons.access_time_outlined,
                                    size: Dimensions.ICON_SIZE_SMALL,
                                  )
                                : null,
                              onTap: () => controller.onWorkPageClick(donDichVuResponse: controller.donDichVuList[index]),
                              isSpaceBetween: true,
                              urlImage: controller.donDichVuList[index].idNhomDichVu!.hinhAnhDaiDien,
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
