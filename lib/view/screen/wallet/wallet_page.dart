import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/my_clipper.dart';
import 'package:template/view/screen/wallet/wallet_controller.dart';

class WalletPage extends GetView<WalletController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
        init: WalletController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => controller.onBtnBackClick(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorResources.WHITE,
                ),
              ),
              title: const Text('Ví của bạn'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: SizedBox(
                    height: DeviceUtils.getScaledHeight(context, .3),
                    width: double.infinity,
                    child: const AppBarWidget(title: ''),
                  ),
                ),
                Column(
                  children: [
                    //wallet status
                    _walletStatus(context, controller: controller),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
                    ),

                    //title
                    _title(),

                    if (controller.lichSuViTienResponse.isEmpty)
                      const Divider(
                        height: 0,
                        color: ColorResources.BLACK,
                      ),

                    //history
                    _history(context, controller: controller),
                  ],
                ),
              ],
            ),
          );
        });
  }

  ///
  ///wallet status
  ///
  Widget _walletStatus(BuildContext context,
      {required WalletController controller}) {
    return SizedBox(
      height: DeviceUtils.getScaledHeight(context, .3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            // height: DeviceUtils.getScaledHeight(context, .14),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius: BorderRadius.circular(
                Dimensions.BORDER_RADIUS_DEFAULT,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //status wallet
                    Row(
                      children: [
                        Text(
                          "Tài khoản FSS",
                          style: Dimensions.fontSizeStyle16w600(),
                        ),

                        const SizedBox(
                          width: Dimensions.MARGIN_SIZE_SMALL,
                        ),

                        //color status
                        Container(
                          width: DeviceUtils.getScaledWidth(context, .025),
                          height: DeviceUtils.getScaledHeight(context, .013),
                          decoration: BoxDecoration(
                              color: controller.viTienResponse.trangThai == "1"
                                  ? ColorResources.GREEN
                                  : ColorResources.RED,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_LARGE - 5)),
                        ),
                        const SizedBox(
                          width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                        ),

                        //status
                        Text(
                          controller.viTienResponse.trangThai == "1"
                              ? "Đang hoạt động"
                              : "Tài khoản tạm khoá",
                          style: TextStyle(
                              color:
                                  (controller.viTienResponse.trangThai == "1")
                                      ? ColorResources.GREEN
                                      : ColorResources.RED),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //balance
                    Row(
                      children: [
                        Text(
                          (controller.isShow)
                              ? "${PriceConverter.convertPrice(
                                  context,
                                  double.parse(
                                      controller.viTienResponse.tongTien!),
                                )} vnđ"
                              : "Xem số dư",
                          style: Dimensions.fontSizeStyle16w600(),
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
                  onTap: () => controller.onRecharge(),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet_rounded,
                        color: ColorResources.PRIMARY,
                        size: Dimensions.ICON_SIZE_EXTRA_LARGE,
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
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
        ],
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
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
          topRight: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
        ),
      ),
      child: Text(
        "Lịch sử giao dịch",
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle22w600().copyWith(
          color: ColorResources.RED,
        ),
      ),
    );
  }

  ///
  ///item history
  ///
  Widget _itemHistory(
    BuildContext context, {
    required String price,
    required String content,
    required String time,
    required String status,
  }) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //content
                  Text(
                    content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Dimensions.fontSizeStyle16w600(),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                  ),

                  //price
                  Text(
                    price,
                    style: Dimensions.fontSizeStyle16w600().copyWith(
                      color: ColorResources.RED,
                    ),
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
                            color: status == "1"
                                ? ColorResources.YELLOW
                                : status == "2"
                                    ? ColorResources.GREEN
                                    : ColorResources.RED,
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_LARGE - 5)),
                      ),
                      const SizedBox(
                        width: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      //status
                      Text(
                        status == "1"
                            ? "Đang đợi"
                            : status == "2"
                                ? "Thành công"
                                : "Thất bại",
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
  Widget _history(BuildContext context,
      {required WalletController controller}) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: ColorResources.WHITE,
        ),
        //show history
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: controller.lichSuViTienResponse.isNotEmpty,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          footer: const ClassicFooter(
            loadingText: "Đang tải...",
            noDataText: "Không có dữ liệu",
            canLoadingText: "Kéo lên để tải thêm dữ liệu",
          ),
          child: (controller.lichSuViTienResponse.isEmpty)
              ? Center(
                  child: Text("Chưa có lịch sử giao dịch",
                      style: Dimensions.fontSizeStyle18w600()),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(controller.lichSuViTien.keys.length,
                          (index) {
                        return Column(
                          children: [
                            const Divider(
                              thickness: 2,
                            ),

                            //MM-yyyy
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Tháng ${controller.lichSuViTien[controller.lichSuViTien.keys.toList()[index]]!.keys.toList()[index]}/${controller.lichSuViTien.keys.toList()[index]}"
                                      .toUpperCase(),
                                  style:
                                      Dimensions.fontSizeStyle18w600().copyWith(
                                    color: ColorResources.GREY,
                                  ),
                                ),
                              ),
                            ),

                            const Divider(
                              thickness: 2,
                            ),

                            //show item history

                            ...List.generate(
                                controller
                                    .lichSuViTien[controller.lichSuViTien.keys
                                            .toList()[index]]![
                                        controller
                                            .lichSuViTien[controller
                                                .lichSuViTien.keys
                                                .toList()[index]]!
                                            .keys
                                            .toList()[index]]!
                                    .length, (i) {
                              final lichSuViTien = controller.lichSuViTien[
                                  controller.lichSuViTien.keys
                                      .toList()[index]]![controller
                                  .lichSuViTien[controller.lichSuViTien.keys
                                      .toList()[index]]!
                                  .keys
                                  .toList()[index]]!;
                              final giaoDich =
                                  "${lichSuViTien[i].loaiGiaoDich! == '1' ? '+' : '-'}${"${PriceConverter.convertPrice(context, double.parse(lichSuViTien[i].soTien!))} vnđ"}";
                              return Column(
                                children: [
                                  _itemHistory(
                                    context,
                                    price: giaoDich,
                                    content: lichSuViTien[i].noiDung!,
                                    time: DateConverter.formatDateTimeFull(
                                        dateTime: lichSuViTien[i].createdAt!),
                                    status: lichSuViTien[i].trangThai!,
                                  ),
                                  if (i == lichSuViTien.length - 1)
                                    const SizedBox.shrink()
                                  else
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                      ),
                                      child: Divider(
                                        thickness: 2,
                                      ),
                                    ),
                                ],
                              );
                            }),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
