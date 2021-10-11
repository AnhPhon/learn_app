import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/wallet/wallet_controller.dart';
import 'package:template/view/screen/v3-agent/component_customer/my_clipper.dart';

class V3WalletPage extends GetView<V3WalletController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3WalletController>(
        init: V3WalletController(),
        builder: (controller) {
          return Stack(
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: SizedBox(
                  height: DeviceUtils.getScaledHeight(context, .3),
                  width: double.infinity,
                  child: AppBarWidget(title: controller.title),
                ),
              ),
              Column(
                children: [
                  //wallet status
                  _walletStatus(context),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE +
                        Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //title
                  _title(),

                  //history
                  _history(context, controller),
                ],
              ),
            ],
          );
        });
  }

  ///
  ///wallet status
  ///
  Widget _walletStatus(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: DeviceUtils.getScaledHeight(context, .31),
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        height: DeviceUtils.getScaledHeight(context, .12),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(
            Dimensions.BORDER_RADIUS_DEFAULT,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tài khoản FSS",
                  style: Dimensions.fontSizeStyle14w600(),
                ),
                Row(
                  children: [
                    if (controller.isShow)
                      Text(
                        "7.000.000 vnđ",
                        style: Dimensions.fontSizeStyle18w600(),
                      )
                    else
                      Text(
                        "Xem số dư",
                        style: Dimensions.fontSizeStyle18w600(),
                      ),
                    const SizedBox(
                      width: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),
                    GestureDetector(
                      onTap: () => controller.setShow(),
                      child: controller.isShow
                          ? const Icon(
                              Icons.visibility_off,
                              color: ColorResources.GREY,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: ColorResources.GREY,
                            ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: ColorResources.PRIMARY,
                    size: Dimensions.ICON_SIZE_EXTRA_LARGE,
                  ),
                  Text(
                    "Nạp tiền",
                    style: Dimensions.fontSizeStyle14w600(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///title
  ///
  Widget _title() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
          topRight: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
        ),
      ),
      child: Text(
        "Lịch sử giao dịch",
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle18w600().copyWith(
          color: ColorResources.RED,
        ),
      ),
    );
  }

  ///
  ///item history
  ///
  Widget _itemHistory(BuildContext context,
      {required String id,
      required String price,
      required String content,
      required String time,
      required int status}) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //icon
          const Expanded(
            child: Icon(
              Icons.monetization_on_outlined,
              color: ColorResources.PRIMARY,
            ),
          ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //id
                      Text(
                        id,
                        style: Dimensions.fontSizeStyle16w600(),
                      ),

                      //price
                      Text(
                        price,
                        style: Dimensions.fontSizeStyle16w600().copyWith(
                          color: ColorResources.RED,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                  ),

                  //content
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(content),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                  ),

                  //time and status
                  Row(
                    children: [
                      //time
                      Text(time),
                      const SizedBox(
                        width: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //color status
                      Container(
                        width: DeviceUtils.getScaledWidth(context, .025),
                        height: DeviceUtils.getScaledHeight(context, .013),
                        decoration: BoxDecoration(
                            color: status == 0
                                ? ColorResources.RED
                                : ColorResources.GREEN,
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_LARGE - 5)),
                      ),
                      const SizedBox(
                        width: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      //status
                      Text(
                        status == 0 ? "Thất bại" : "Thành công",
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///history
  ///
  Widget _history(BuildContext context, V3WalletController controller) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: ColorResources.WHITE,
        ),
        child: //show history
            ListView.builder(
                shrinkWrap: true,
                itemCount: controller.historyList.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Column(
                    children: [
                      const Divider(
                        thickness: 2,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.historyList[index].dateTime
                                .toUpperCase(),
                            style: Dimensions.fontSizeStyle18w600().copyWith(
                              color: ColorResources.GREY,
                            ),
                          ),
                        ),
                      ),

                      const Divider(
                        thickness: 2,
                      ),

                      //show item history
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.historyList[index].itemHistory.length,
                        itemBuilder: (BuildContext ctx, int i) {
                          return Column(
                            children: [
                              _itemHistory(
                                context,
                                id: controller
                                    .historyList[index].itemHistory[i].id,
                                price: controller
                                    .historyList[index].itemHistory[i].price,
                                content: controller
                                    .historyList[index].itemHistory[i].content,
                                time: controller
                                    .historyList[index].itemHistory[i].time,
                                status: controller
                                    .historyList[index].itemHistory[i].status,
                              ),
                              if (i ==
                                  controller.historyList[index].itemHistory
                                          .length -
                                      1)
                                const SizedBox.shrink()
                              else
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }),
      ),
    );
  }
}

class History {
  String dateTime;
  List<ItemHistory> itemHistory;
  History({
    required this.dateTime,
    required this.itemHistory,
  });
}

class ItemHistory {
  String id;
  String price;
  String content;
  String time;
  int status;
  ItemHistory(
      {required this.id,
      required this.price,
      required this.content,
      required this.time,
      required this.status});
}
