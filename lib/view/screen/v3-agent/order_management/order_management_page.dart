import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/v1-customer/component_customer/app_bar_with_tabbar.dart';
import 'package:template/view/screen/v3-agent/order_management/order_management_controller.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

class V3OrderManagementPage extends GetView<V3OrderManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3OrderManagementController>(
        init: V3OrderManagementController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWithTabBar(
              title: controller.title,
              bottom: TabBar(
                controller: controller.tabController,
                isScrollable: true,
                indicatorColor: ColorResources.PRIMARY,
                labelColor: ColorResources.PRIMARY,
                unselectedLabelColor: Colors.grey,
                tabs: app_constants.quanLyDonHangMap.keys.toList().map(
                  (element) {
                    return Tab(
                      text: element,
                    );
                  },
                ).toList(),
              ),
            ),
            body: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  List.generate(app_constants.quanLyDonHangMap.length, (index) {
                return _tabIndex(context, indexRefreshController: index);
              }),
            ),
          );
        });
  }

  ///
  ///tab index
  ///
  Widget _tabIndex(BuildContext context,
      {required int indexRefreshController}) {
    return GetBuilder<V3OrderManagementController>(
      builder: (controller) {
        if (controller.isLoadingOrder) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scrollbar(
          child: SmartRefresher(
            controller: controller.refreshController![indexRefreshController],
            enablePullUp: true,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            footer: const ClassicFooter(
              loadingText: "Đang tải...",
              noDataText: "Không có dữ liệu",
              canLoadingText: "Kéo lên để tải thêm dữ liệu",
            ),
            child: (controller.donHangResponse.isEmpty)
                ? const Center(
                    child: Text("Chưa có đơn hàng"),
                  )
                : ListView.builder(
                    itemCount: controller.donHangResponse.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(controller.donHangResponse.length);
                      return GestureDetector(
                        onTap: () {
                          // controller.onOrderWidgetClick(
                          //     i: i, index: (int.parse(index) + 1).toString());
                        },
                        child: _orderWidget(
                          context,
                          controller,
                          status: controller
                              .donHangResponse[index].idTrangThaiDonHang!.tieuDe
                              .toString(),
                          imgUrl:
                              "controller.donHangResponse[index].hinhAnhHoaDon",
                          idOrder:
                              controller.donHangResponse[index].id.toString(),
                          dateTime: DateConverter.formatDateTime(
                            controller.donHangResponse[index].createdAt
                                .toString(),
                          ),
                          paymentStatus: controller.donHangResponse[index]
                                      .idTrangThaiThanhToan ==
                                  null
                              ? ""
                              : controller.donHangResponse[index]
                                  .idTrangThaiThanhToan!.tieuDe
                                  .toString(),
                          price: "${PriceConverter.convertPrice(
                            context,
                            double.parse(
                              controller.donHangResponse[index].tongTien
                                  .toString(),
                            ),
                          )} vnđ",
                          indexOrder: index,
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  ///
  ///order widget
  ///
  Widget _orderWidget(
    BuildContext context,
    V3OrderManagementController controller, {
    required String status,
    required String imgUrl,
    required String idOrder,
    required String dateTime,
    required String paymentStatus,
    required String price,
    required int indexOrder,
  }) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropDownButton1<String>(
            value: status,
            onChanged: (val) =>
                controller.onChangedDropdown(value: val, index: indexOrder),
            data: app_constants.trangThaiDonHangMap.keys.toList(),
            width: .4,
            isBorder: false,
            fillColor: controller.statusBackgroundColor[status],
            colorText: controller.statusColor[status],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
          //product info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  image: imgUrl,
                  height: DeviceUtils.getScaledSize(context, 0.2),
                  width: DeviceUtils.getScaledSize(context, 0.22),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    Images.placeholder,
                    height: DeviceUtils.getScaledSize(context, 0.2),
                    width: DeviceUtils.getScaledSize(context, 0.22),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: Dimensions.MARGIN_SIZE_SMALL,
              ),
              Expanded(
                child: SizedBox(
                  height: DeviceUtils.getScaledSize(context, 0.152),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Id: $idOrder",
                        maxLines: 2,
                        style: Dimensions.fontSizeStyle16(),
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(paymentStatus),
                            VerticalDivider(
                              color: ColorResources.BLACK.withOpacity(.7),
                            ),
                            Text(price),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Dimensions().paddingDivider(context),

          //payment method
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateTime),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
