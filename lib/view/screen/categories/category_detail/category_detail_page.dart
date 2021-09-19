import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/data/template/categories.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/categories/category_detail/category_detail_controller.dart';

class CategoryDetailPage extends GetView<CategoryDetailController> {
  Widget _sanPhamDanhMucBtn(Image image, String label, int money) {
    return SizedBox(
        height: 280,
        width: Dimensions.SQUARE_CATEGORY_SIZE,
        child: GestureDetector(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: ClipRRect(
                      // borderRadius: BorderRadius.circular(20),
                      child: image)),
              const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  label,
                  style: const TextStyle(
                      color: Color(0xFF27272A),
                      fontSize: Dimensions.FONT_SIZE_LARGE),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          onTap: () {},
        ));
  }

  Widget _sanPhamMoi() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Row(children: [
          _sanPhamDanhMucBtn(
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
    return GetBuilder<CategoryDetailController>(
        init: CategoryDetailController(),
        builder: (CategoryDetailController value) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Chi tiết",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            body: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: SingleChildScrollView(
                child: Column(
                  children: [_sanPhamMoi()],
                ),
              ),
            ),
          );
        });
  }
}
