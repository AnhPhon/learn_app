import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/drop_down_map_data_button.dart';
import 'package:template/view/screen/v1-customer/account/my_order/my_order_controller.dart';
import 'package:template/view/screen/v1-customer/component_customer/app_bar_with_tabbar.dart';

class V1MyOrderPage extends GetView<V1MyOrderController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1MyOrderController>(
        init: V1MyOrderController(),
        builder: (controller) {
          return DefaultTabController(
            length: controller.orderList.length,
            child: Scaffold(
              appBar: AppBarWithTabBar(
                title: controller.title,
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: ColorResources.PRIMARY,
                  labelColor: ColorResources.PRIMARY,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    ...List.generate(
                      controller.orderList.length,
                      (index) => Tab(
                          text: controller.statusLabel.values.toList()[index]),
                    )
                  ],
                ),
              ),
              body: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ...List.generate(
                      controller.orderList.length,
                      (index) => _tabIndex(context, controller,
                          index: (index).toString())),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///tab index
  ///
  Widget _tabIndex(BuildContext context, V1MyOrderController controller,
      {required String index}) {
    return ListView.builder(
        itemCount: controller.orderList.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            onTap: () {
              // controller.onOrderWidgetClick(
              //     i: i, index: (int.parse(index) + 1).toString());
            },
            child: _orderWidget(
              context,
              controller,
              status: controller.orderList[int.parse(index)].statusOrder,
              imgUrl: controller.orderList[int.parse(index)].image,
              idOrder: controller.orderList[int.parse(index)].id,
              dateTime: controller.orderList[int.parse(index)].dateTime,
            ),
          );
        });
  }

  ///
  ///order widget
  ///
  Widget _orderWidget(
    BuildContext context,
    V1MyOrderController controller, {
    required String status,
    required String imgUrl,
    required String idOrder,
    required String dateTime,
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
          //status order
          Container(
            padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.02)),
            decoration: BoxDecoration(
                color: status == "0"
                    ? Colors.white
                    : controller.statusBackgroundColor[status],
                borderRadius: BorderRadius.circular(16)),
            child: Text(
              controller.statusLabel[status].toString(),
              style: TextStyle(
                color: status == "0"
                    ? Colors.white
                    : controller.statusColor[status],
              ),
            ),
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
                  width: DeviceUtils.getScaledSize(context, 0.178),
                  height: DeviceUtils.getScaledSize(context, 0.152),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    Images.placeholder,
                    height: DeviceUtils.getScaledSize(context, 0.152),
                    width: DeviceUtils.getScaledSize(context, 0.178),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Id: $idOrder",
                        maxLines: 2,
                        style: Dimensions.fontSizeStyle16(),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            const Text("unit"),
                            VerticalDivider(
                              color: ColorResources.BLACK.withOpacity(.7),
                            ),
                            const Text("price"),
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
