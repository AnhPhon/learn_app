import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/job_management/job_management_controller.dart';

class V1JobManagementPage extends GetView<V1JobManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1JobManagementController>(
      init: V1JobManagementController(),
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
        return Expanded(
          child: SmartRefresher(
            enablePullUp: (controller.currentIndex == 0)
                ? controller.viecDangLam.isNotEmpty
                : controller.viecDaLam.isNotEmpty,
            enablePullDown: (controller.currentIndex == 0)
                ? controller.viecDangLam.isNotEmpty
                : controller.viecDaLam.isNotEmpty,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            controller: controller.refreshController,
            footer: const ClassicFooter(
              loadingText: "Đang tải...",
              noDataText: "Không có dữ liệu",
              canLoadingText: "Kéo lên để tải thêm dữ liệu",
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                  if (controller.currentIndex == 0)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.viecDangLam.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            left: Dimensions.PADDING_SIZE_LARGE,
                            right: Dimensions.PADDING_SIZE_LARGE,
                          ),
                          child: ItemListWidget(
                            textOverImage: true,
                            stringTextOverImage: controller
                                .viecDangLam[index].idTinhTp
                                .toString(),
                            title:
                                controller.viecDangLam[index].tieuDe.toString(),
                            rowText1: controller.viecDangLam[index].idQuanHuyen
                                .toString(),
                            icon1: const Icon(
                              Icons.location_on,
                              size: Dimensions.ICON_SIZE_SMALL,
                            ),
                            rowText2: (controller
                                        .viecDangLam[index].ngayKetThuc ==
                                    "null")
                                ? null
                                : controller.getDeadline(
                                    controller.viecDangLam[index].ngayKetThuc
                                        .toString(),
                                  ),
                            icon2: (controller.viecDangLam[index].ngayKetThuc ==
                                    null)
                                ? null
                                : const Icon(
                                    Icons.access_time_outlined,
                                    size: Dimensions.ICON_SIZE_SMALL,
                                  ),
                            onTap: () => controller.onWorkPageClick(
                                donDichVuResponse:
                                    controller.viecDangLam[index]),
                            isSpaceBetween: true,
                            urlImage: "",
                            boxShadow: boxShadowALitle,
                          ),
                        );
                      },
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.viecDaLam.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            left: Dimensions.PADDING_SIZE_LARGE,
                            right: Dimensions.PADDING_SIZE_LARGE,
                          ),
                          child: ItemListWidget(
                            textOverImage: true,
                            stringTextOverImage:
                                controller.viecDaLam[index].idTinhTp.toString(),
                            title:
                                controller.viecDaLam[index].tieuDe.toString(),
                            rowText1: controller.viecDaLam[index].idQuanHuyen
                                .toString(),
                            icon1: const Icon(
                              Icons.location_on,
                              size: Dimensions.ICON_SIZE_SMALL,
                            ),
                            rowText2: (controller.viecDaLam[index]
                                        .idTrangThaiDonDichVu ==
                                    null)
                                ? null
                                : controller.viecDaLam[index]
                                    .idTrangThaiDonDichVu!.tieuDe
                                    .toString(),
                            colorRowText2: (controller.viecDaLam[index]
                                        .idTrangThaiDonDichVu ==
                                    null)
                                ? null
                                : controller.viecDaLam[index]
                                            .idTrangThaiDonDichVu!.id ==
                                        CHUA_NGHIEM_THU
                                    ? ColorResources.RED
                                    : controller.viecDaLam[index]
                                                .idTrangThaiDonDichVu!.id ==
                                            DA_NGHIEM_THU
                                        ? ColorResources.PRIMARY
                                        : ColorResources.GREEN,
                            onTap: () => controller.onWorkPageClick(
                                donDichVuResponse: controller.viecDaLam[index]),
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
          ),
        );
      },
    );
  }
}
