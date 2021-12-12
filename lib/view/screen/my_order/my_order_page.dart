import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_tabbar.dart';
import 'package:template/base_widget/izi_tabview.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/my_order/my_order_controller.dart';

class MyOrderPage extends GetView<MyOrderController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      isSingleChildScrollView: false,
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Đơn hàng của tôi",
      ),
      body: GetBuilder(
        init: MyOrderController(),
        builder: (MyOrderController controller) {
          return Column(
            children: [
              IZITabBar(
                data: controller.tieuDe,
                itemCount: controller.tieuDe.length,
                onTapChangedTabbar: (index) => controller.onChangeTab(index: index),
                currentIndex: controller.currentIndex,
                label: (index) => controller.tieuDe[index].toString(),
              ),
              IZITabView(
                onRefresh: controller.onRefresh,
                onLoading: controller.onLoading,
                refreshController: controller.refreshControllerList![controller.currentIndex],
                enablePullDown: true,
                itemCount: controller.data.length,
                isLoading: controller.isLoading,
                builder: (index) {
                  return IZICard(
                    marginCard: EdgeInsets.symmetric(
                      vertical: IZIDimensions.SPACE_SIZE_2X,
                      horizontal: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    urlImage: "https://i.ytimg.com/vi/QOcNo0DC7Qg/maxresdefault.jpg",
                    cardType: IZICardType.CARD_ORDER,
                    row1Left: "Đơn hàng 1",
                    row2Left: "200",
                    row3Left: "22/07/2021",
                    row2Right: "100.460.000",
                    statusOrder: controller.data[index]["status"] == 1
                        ? IZIStatusOrder.XAC_NHAN
                        : controller.data[index]["status"] == 2
                            ? IZIStatusOrder.HUY_DON
                            : controller.data[index]["status"] == 3
                                ? IZIStatusOrder.DANG_GIAO
                                : controller.data[index]["status"] == 4
                                    ? IZIStatusOrder.DA_GIAO
                                    : IZIStatusOrder.HUY_DON,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
