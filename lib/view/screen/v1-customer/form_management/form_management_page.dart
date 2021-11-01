import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/screen/v1-customer/form_management/form_management_controller.dart';

class V1FormManagementPage extends GetView<V1FormManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1FormManagementController>(
      init: V1FormManagementController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Column(
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
              Expanded(child: _itemList()),
            ],
          ),
        );
      },
    );
  }

  ///
  /// selected tab
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
        width: DeviceUtils.getScaledWidth(context, .9).roundToDouble() / 2,
        decoration: BoxDecoration(
          borderRadius: isRight == false
              ? const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomRight:
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                ),
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
                : ColorResources.BLACK,
          ),
        ),
      ),
    );
  }

  ///
  /// tab
  ///
  Widget tabBarWidget(
      {required BuildContext context,
      required V1FormManagementController controller}) {
    return Container(
      alignment: Alignment.center,
      width: DeviceUtils.getScaledWidth(context, .9).roundToDouble(),
      height: DeviceUtils.getScaledHeight(context, .07),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          onSelectedTab(context, controller,
              title: controller.titleTabBar['DPH']!, index: 0, isRight: false),
          onSelectedTab(context, controller,
              title: controller.titleTabBar['CPH']!, index: 1, isRight: true),
        ],
      ),
    );
  }

  ///
  ///item list
  ///
  Widget _itemList() {
    return GetBuilder<V1FormManagementController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: true,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          footer: const ClassicFooter(
            loadingText: "Đang tải...",
            noDataText: "Không có dữ liệu",
            canLoadingText: "Kéo lên để tải thêm dữ liệu",
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.donDichVuList.length,
            itemBuilder: (BuildContext ctx, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: ItemListWidget(
                  title: controller.donDichVuList[index].tieuDe.toString(),
                  onTap: () => controller.onProductResponseClick(index: index),
                  urlImage:
                      controller.donDichVuList[index].hinhAnhBaoGia.toString(),
                  rowText2: DateConverter.formatDateTimeFull(
                    dateTime:
                        controller.donDichVuList[index].createdAt.toString(),
                  ),
                  isSpaceBetween: true,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
