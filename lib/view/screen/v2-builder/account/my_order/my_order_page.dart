import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/component/app_bar_with_tabbar.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/v2-builder/account/my_order/my_order_controller.dart';

class V2MyOrderPage extends GetView<V2MyOrderController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2MyOrderController>(
        init: V2MyOrderController(),
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
                tabs: List.generate(
                  trangThaiDonHangMap.length,
                  (index) => Tab(
                    text: trangThaiDonHangMap.keys.toList()[index],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(trangThaiDonHangMap.length,
                  (index) => _tabIndex(context, indexController: index)),
            ),
          );
        });
  }

  ///
  ///tab index
  ///
  Widget _tabIndex(BuildContext context, {required int indexController}) {
    return GetBuilder<V2MyOrderController>(builder: (controller) {
      if (controller.isLoadingOrder) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scrollbar(
        child: SmartRefresher(
          enablePullUp: controller.donHangResponse.isNotEmpty,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          controller: controller.refreshController[indexController],
          footer: const ClassicFooter(
            loadingText: "Đang tải...",
            noDataText: "Không có dữ liệu",
            canLoadingText: "Kéo lên để tải thêm dữ liệu",
          ),
          child: (controller.donHangResponse.isEmpty)
              ? const Center(
                  child: Text("Đơn hàng rỗng"),
                )
              : ListView.builder(
                  itemCount: controller.donHangResponse.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => controller.onOrderClick(index: index),
                      child: _orderWidget(
                        context,
                        status: controller
                            .donHangResponse[index].idTrangThaiDonHang!.tieuDe
                            .toString(),
                        idOrder: controller.donHangResponse[index].maDonHang
                            .toString()
                            .replaceFirst("D", "Đ"),
                        dateTime: DateConverter.formatDateTimeFull(
                          dateTime: controller.donHangResponse[index].updatedAt
                              .toString(),
                        ),
                        price: controller.donHangResponse[index].tongTien
                            .toString(),
                        paymentOrder: (controller.donHangResponse[index]
                                    .idTrangThaiThanhToan ==
                                null)
                            ? ""
                            : controller.donHangResponse[index]
                                .idTrangThaiThanhToan!.tieuDe
                                .toString(),
                        urlImage: (controller
                                    .donHangResponse[index].idTaiKhoanMuaHang ==
                                null)
                            ? ""
                            : controller.donHangResponse[index]
                                .idTaiKhoanMuaHang!.hinhDaiDien
                                .toString(),
                      ),
                    );
                  }),
        ),
      );
    });
  }

  ///
  ///order widget
  ///
  Widget _orderWidget(
    BuildContext context, {
    required String status,
    required String idOrder,
    required String dateTime,
    required String price,
    required String paymentOrder,
    required String urlImage,
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
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          //product info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: FadeInImageCustom(
                  urlImage: urlImage,
                  height: .16,
                  width: .178,
                ),
              ),
              const SizedBox(
                width: Dimensions.MARGIN_SIZE_SMALL,
              ),
              Expanded(
                child: SizedBox(
                  height: DeviceUtils.getScaledSize(context, 0.152),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //id order
                          Text(
                            "Id: $idOrder",
                            maxLines: 2,
                            style: Dimensions.fontSizeStyle16(),
                          ),

                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //payment status & total
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                // Text(paymentOrder),
                                // VerticalDivider(
                                //   color: ColorResources.BLACK.withOpacity(.7),
                                // ),
                                Text(
                                  "${PriceConverter.convertPrice(
                                    context,
                                    double.parse(price),
                                  )} vnđ",
                                  style: const TextStyle(
                                    color: ColorResources.RED,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //status order
                      Container(
                        padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        decoration: BoxDecoration(
                          color: controller.statusBackgroundColor[status],
                          borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_DEFAULT,
                          ),
                        ),
                        child: Text(
                          status.toString(),
                          style: TextStyle(
                            color: controller.statusColor[status],
                          ),
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
                Text(paymentOrder),
              ],
            ),
          )
        ],
      ),
    );
  }
}
