import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/thong_tin_khach_hang/thong_tin_khach_hang_controller.dart';

class V3ThongTinKhachHangPage extends GetView<V3ThongTinKhachHangController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3ThongTinKhachHangController>(
        init: V3ThongTinKhachHangController(),
        builder: (V3ThongTinKhachHangController controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  donThanhCongWidget(context),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, .58)),
                  twoButton(context)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// don thanh cong widget
  ///
  Widget donThanhCongWidget(BuildContext context) {
    return Column(
      children: [
        // label
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Đơn hàng thành công",
            style: TextStyle(
              color: ColorResources.BLACKGREY,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        // content
        Stack(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_SMALL,
              ),
              alignment: Alignment.topLeft,
              decoration: const BoxDecoration(
                color: ColorResources.WHITE,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Dimensions.BORDER_RADIUS_SMALL,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorResources.LIGHT_GREY,
                    blurRadius: 2,
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tên khách hàng: ${controller.tenKhachHang.toString()}",
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Địa chỉ khách hàng: ${controller.diaChiKH.toString()}",
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Địa chỉ: ${controller.address}",
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "SDT: ${controller.number.toString()}",
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  ///
  ///
  ///
  Widget twoButton(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            controller.twoButtons[0]["onTap"]();
          },
          child: SizedBox(
            width: DeviceUtils.getScaledWidth(context, .45),
            child: LongButton(
              title: controller.twoButtons[0]["label"].toString(),
              color: ColorResources.LIGHT_BLACK,
              onPressed: () {
                controller.twoButtons[0]["onTap"]();
              },
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            controller.twoButtons[1]["onTap"]();
          },
          child: SizedBox(
            width: DeviceUtils.getScaledWidth(context, .45),
            child: LongButton(
              title: controller.twoButtons[1]["label"].toString(),
              color: ColorResources.THEME_DEFAULT,
              onPressed: () {
                controller.twoButtons[1]["onTap"]();
              },
            ),
          ),
        ),
      ],
    );
  }
}
