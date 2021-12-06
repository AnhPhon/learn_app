import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/screen/v1-customer/quote/list/vattulist_controller.dart';

class V1VatTuListPage extends GetView<V1VatTuListController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(title: controller.title),
        body: GetBuilder(
          init: V1VatTuListController(),
          builder: (V1VatTuListController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //tab
                tabBarWidget(context: context, controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //item list
                Expanded(
                    child: controller.currentIndex == 0
                        ? _itemDaList()
                        : _itemChuaList()),
              ],
            );
          },
        ),
      ),
    );
  }

  ///
  /// tab
  ///
  Widget tabBarWidget(
      {required BuildContext context,
      required V1VatTuListController controller}) {
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
  ///item list
  ///
  Widget _itemDaList() {
    return GetBuilder<V1VatTuListController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SmartRefresher(
          controller: controller.refreshDaPhanHoiController!,
          enablePullUp: controller.daPhanHoiDDV.isNotEmpty,
          onRefresh: controller.onDaDonPhanHoiRefresh,
          onLoading: controller.onDaDonPhanHoiLoading,
          footer: const ClassicFooter(
            loadingText: "Đang tải...",
            noDataText: "Không có dữ liệu",
            canLoadingText: "Kéo lên để tải thêm dữ liệu",
          ),
          child: (controller.daPhanHoiDDV.isEmpty)
              ? const Center(
                  child: Text("Chưa có đơn tạo"),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      controller.daPhanHoiDDV.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: ItemListWidget(
                          title:
                              controller.daPhanHoiDDV[index].tieuDe.toString(),
                          onTap: () {
                            controller.onProductResponseClick(
                                controller.daPhanHoiDDV[index]);
                          },
                          urlImage: controller
                              .daPhanHoiDDV[index].idNhomDichVu!.hinhAnhDaiDien,
                          rowText1: controller.daPhanHoiDDV[index]
                                      .idTrangThaiDonDichVu!.id! ==
                                  THAT_BAI
                              ? "Thất bại"
                              : null,
                          colorRowText1: ColorResources.RED,
                          rowText2: DateConverter.formatDateTimeFull(
                            dateTime: controller.daPhanHoiDDV[index].createdAt
                                .toString(),
                          ),
                          isSpaceBetween: true,
                          scaleHeight: .138,
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  ///
  /// chua item list
  ///
  Widget _itemChuaList() {
    return GetBuilder<V1VatTuListController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SmartRefresher(
          controller: controller.refreshChuaPhanHoiController!,
          enablePullUp: controller.chuaPhanHoiDDV.isNotEmpty,
          onRefresh: controller.onChuaDonPhanHoiRefresh,
          onLoading: controller.onChuaDonPhanHoiLoading,
          footer: const ClassicFooter(
            loadingText: "Đang tải...",
            noDataText: "Không có dữ liệu",
            canLoadingText: "Kéo lên để tải thêm dữ liệu",
          ),
          child: (controller.chuaPhanHoiDDV.isEmpty)
              ? const Center(
                  child: Text("Chưa có đơn tạo"),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      controller.chuaPhanHoiDDV.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: ItemListWidget(
                          title: controller.chuaPhanHoiDDV[index].tieuDe
                              .toString(),
                          onTap: () {
                            controller.onProductNoResponseClick(
                                controller.chuaPhanHoiDDV[index]);
                          },
                          urlImage: controller.chuaPhanHoiDDV[index]
                              .idNhomDichVu!.hinhAnhDaiDien,
                          rowText2: DateConverter.formatDateTimeFull(
                            dateTime: controller.chuaPhanHoiDDV[index].createdAt
                                .toString(),
                          ),
                          isSpaceBetween: true,
                          scaleHeight: .138,
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
