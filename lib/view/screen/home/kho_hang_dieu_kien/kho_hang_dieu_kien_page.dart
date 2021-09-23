import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/home/kho_hang_dieu_kien/kho_hang_dieu_kien_controller.dart';

class KhoHangDieuKienPage extends GetView<KhoHangDieuKienController> {
  Widget _sanPhamDanhMucBtn(
      BuildContext context, Image image, String label, int money) {
    return SizedBox(
        height: 280,
        width: Dimensions.SQUARE_CATEGORY_SIZE,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: ClipRRect(
                      // borderRadius: BorderRadius.circular(20),
                      child: image)),
              const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
              Container(
                height: DeviceUtils.getScaledSize(context, 0.14),
                alignment: Alignment.topLeft,
                child: Text(
                  label,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Color(0xFF27272A),
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${controller.moneyNormalize(money, ",")} vnd",
                  style: const TextStyle(
                    color: Color(0xFF27272A),
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _sanPham(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Row(children: [
          _sanPhamDanhMucBtn(
            context,
            Image.asset(
              Images.sp3,
              width: Dimensions.SQUARE_CATEGORY_SIZE,
              height: Dimensions.SQUARE_CATEGORY_SIZE,
            ),
            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
            138000,
          ),
          const Spacer(),
          _sanPhamDanhMucBtn(
            context,
            Image.asset(
              Images.sp4,
              width: Dimensions.SQUARE_CATEGORY_SIZE,
              height: Dimensions.SQUARE_CATEGORY_SIZE,
            ),
            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
            138000,
          ),
        ]),
        const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT * 2),
        Row(children: [
          _sanPhamDanhMucBtn(
            context,
            Image.asset(
              Images.sp3,
              width: Dimensions.SQUARE_CATEGORY_SIZE,
              height: Dimensions.SQUARE_CATEGORY_SIZE,
            ),
            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
            138000,
          ),
          const Spacer(),
          _sanPhamDanhMucBtn(
            context,
            Image.asset(
              Images.sp4,
              width: Dimensions.SQUARE_CATEGORY_SIZE,
              height: Dimensions.SQUARE_CATEGORY_SIZE,
            ),
            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
            138000,
          ),
        ]),
        Row(children: [
          _sanPhamDanhMucBtn(
            context,
            Image.asset(
              Images.sp3,
              width: Dimensions.SQUARE_CATEGORY_SIZE,
              height: Dimensions.SQUARE_CATEGORY_SIZE,
            ),
            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
            138000,
          ),
          const Spacer(),
          _sanPhamDanhMucBtn(
            context,
            Image.asset(
              Images.sp4,
              width: Dimensions.SQUARE_CATEGORY_SIZE,
              height: Dimensions.SQUARE_CATEGORY_SIZE,
            ),
            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
            138000,
          ),
        ])
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KhoHangDieuKienController>(
        init: KhoHangDieuKienController(),
        builder: (KhoHangDieuKienController value) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: CustomAppBar().customAppBar(title: "Kho hàng điều kiện"),
            body: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: SingleChildScrollView(
                child: Column(
                  children: [_sanPham(context)],
                ),
              ),
            ),
          );
        });
  }
}
