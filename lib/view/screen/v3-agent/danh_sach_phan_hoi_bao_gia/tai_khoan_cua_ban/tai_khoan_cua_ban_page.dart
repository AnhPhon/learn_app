import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/tai_khoan_cua_ban/tai_khoan_cua_ban_controller.dart';

class V3TaiKhoanCuaBanPage extends GetView<V3TaiKhoanCuaBanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3TaiKhoanCuaBanController>(
        init: V3TaiKhoanCuaBanController(),
        builder: (V3TaiKhoanCuaBanController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              height: DeviceUtils.getScaledHeight(context, .7),
              decoration: const BoxDecoration(
                color: ColorResources.WHITE,
                boxShadow: [
                  BoxShadow(
                    color: ColorResources.LIGHT_BLACK,
                    blurRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Dimensions.BORDER_RADIUS_SMALL,
                  ),
                ),
              ),
              child: Column(
                children: [
                  quanLyTaiKhoanWidget(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// quản lý tài khoản
  ///
  Widget quanLyTaiKhoanWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Quản lý tài khoản",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
        ),
        Container(
          //margin: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT),
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL
          ),
          child: Column(
            children: [
              ...controller.labels.map((e){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...e.map((e) => Text(
                        e is String ? e.toString() : '${PriceConverter.convertPrice(context, double.parse(e.toString()))} VND',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: e is String ? ColorResources.BLACK : ColorResources.RED
                        ),
                        ),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
        const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
        LongButton(
          title: "Đồng ý thanh toán",
          color: (controller.tienConLai >= 0)
              ? ColorResources.THEME_DEFAULT
              : ColorResources.LIGHT_GREY,
          onPressed: () {
            if (controller.tienConLai >= 0) {
              controller.onDongYThanhToanClick();
            }
          },
        ),
        const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
        Container(
          alignment: Alignment.center,
          child: const Text(
            "(Nếu số dư lớn hơn hoặc bằng số tiền thanh toán thì bạn chọn đồng ý thanh toán, lúc này tài khoản sẽ tự trừ qua app)",
            style: TextStyle(color: ColorResources.RED),
          ),
        ),
        const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
        LongButton(
          title: "Nạp tiền",
          color: ColorResources.THEME_DEFAULT,
          onPressed: () {
            controller.onNapTienClick();
          },
        ),
        const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
        const Text(
          "Nếu bạn nộp dư thì số dư sẽ được tích lũy",
          style: TextStyle(color: ColorResources.RED),
        ),
      ],
    );
  }
}
