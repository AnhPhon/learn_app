import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
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
            backgroundColor: const Color(0xffe8ffd9),
            appBar: CustomAppBar().customAppBar(title: "Kho hàng điều kiện"),
            body: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.productList.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.72,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorResources.WHITE),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image.network(
                                      controller.productList[index].thumbnail!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 0.01)),
                                SizedBox(
                                  height:
                                      DeviceUtils.getScaledSize(context, 0.101),
                                  child: Text(
                                    controller.productList[index].name!,
                                    maxLines: 2,
                                    style: Dimensions.fontSizeStyle14w600(),
                                  ),
                                ),
                                Text(PriceConverter.convertPrice(
                                    context,
                                    double.parse(
                                        controller.productList[index].prices!)))
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
