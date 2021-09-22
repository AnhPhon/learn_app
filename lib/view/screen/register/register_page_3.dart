// ignore_for_file: unnecessary_null_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';

// dimensions
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';

import 'register_controller.dart';

class RegisterPage3 extends GetView<RegisterController> {
  ///
  ///bottom payment button
  ///
  Widget _bottomContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.04),
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      height: DeviceUtils.getScaledSize(context, 0.55),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2, // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Với việc đăng ký tài khoản lần đầu, bạn được tặng voucher giảm 25% tổng giá trị đơn hàng. Để đăng ký tài khoản bạn phải thực hiện mua đơn hàng trị giá ít nhất 2,500,000 đ.",
            textAlign: TextAlign.justify,
            style: titilliumItalic.copyWith(
                color: ColorResources.PRIMARY, fontSize: 14),
          ),
          Text(
            "Lưu ý: Hoá đơn sau khi trừ 25% phải lớn hơn hoặc bằng 2,500,000 đ",
            style: titilliumSemiBold.copyWith(color: ColorResources.RED),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Tổng tiền phải trả là: ${PriceConverter.convertPrice(context, controller.sum * .75)}",
                style: titilliumBold.copyWith(fontSize: 16),
              ),
              SizedBox(width: DeviceUtils.getScaledSize(context, 0.015)),
              Text(
                PriceConverter.convertPrice(context, controller.sum.toDouble()),
                style: titilliumBold.copyWith(
                  color: ColorResources.GREY,
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black,
                  decorationStyle: TextDecorationStyle.double,
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
          //btn checkout
          GestureDetector(
            onTap: () {
              final double money = controller.sum * .75;
              final bool moneyValid = money > 2500000;
              if (moneyValid) {
                Get.toNamed(AppRoutes.REGISTER_PAGE_4);
              } else {
                Get.snackbar(
                  "Đăng ký thất bại",
                  "Hoá đơn hiện tại là ${PriceConverter.convertPrice(context, money)} đang thiếu ${PriceConverter.convertPrice(context, 2500000 - money)}",
                  colorText: ColorResources.RED,
                  backgroundGradient: const LinearGradient(colors: [
                    Color(0xffffb8b3),
                    Color(0xffff9b94),
                    Color(0xffffb8b3),
                  ], begin: Alignment(2, -1), end: Alignment(1, 5)),
                );
              }
            },
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.green,
                  ColorResources.PRIMARY,
                  Colors.green,
                ], begin: Alignment(0, -1), end: Alignment(0, 1)),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              alignment: Alignment.center,
              width: double.infinity,
              child: const Text(
                "Hoàn thành",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///icons quality
  ///
  Widget _iconsquality(BuildContext context,
      {VoidCallback? onTap, Icon? icon, String? text, Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.01)),
        height: DeviceUtils.getScaledSize(context, 0.064),
        width: DeviceUtils.getScaledSize(context, 0.064),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color ?? ColorResources.PRIMARY),
        ),
        child: text != null ? Align(child: Text(text)) : icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RegisterController());
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (RegisterController value) {
          return Scaffold(
            bottomNavigationBar: _bottomContainer(context),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: DeviceUtils.getScaledSize(context, 0.063)),
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: DeviceUtils.getScaledSize(context, 0.063),
                  ),
                  itemCount: controller.items.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.qualityProduct.value = 1;
                        if (controller.items[index].isChoose == false) {
                          Get.defaultDialog(
                            title: controller.items[index].title,
                            buttonColor: ColorResources.PRIMARY,
                            textConfirm: "Xác nhận",
                            textCancel: "Huỷ",
                            cancelTextColor: ColorResources.PRIMARY,
                            confirmTextColor: ColorResources.WHITE,
                            onConfirm: () {
                              Get.back();
                              controller.setSelected(index.toString());
                              controller.accept(index);
                              controller
                                  .countTotal(controller.items[index].amount);
                            },
                            content: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      DeviceUtils.getScaledSize(context, 0.025),
                                  vertical: DeviceUtils.getScaledSize(
                                      context, 0.025)),
                              color: ColorResources.WHITE,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.asset(
                                          controller.items[index].url,
                                          height: DeviceUtils.getScaledSize(
                                              context, 0.25),
                                          width: DeviceUtils.getScaledSize(
                                              context, 0.25),
                                        ),
                                      ),
                                      SizedBox(
                                        width: DeviceUtils.getScaledSize(
                                            context, 0.063),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(
                                            () => Text(
                                              PriceConverter.convertPrice(
                                                  context,
                                                  (controller.items[index]
                                                              .amount *
                                                          controller
                                                              .qualityProduct
                                                              .value)
                                                      .toDouble()),
                                              style: titilliumSemiBold.copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 18),
                                            ),
                                          ),

                                          SizedBox(
                                              height: DeviceUtils.getScaledSize(
                                                  context, 0.02)),

                                          //button quanlity
                                          Obx(() => Row(
                                                children: [
                                                  //decrementQuality
                                                  _iconsquality(context,
                                                      onTap: () {
                                                    controller
                                                        .decrementQuality();
                                                  },
                                                      icon: Icon(Icons.remove,
                                                          color: controller
                                                                      .qualityProduct
                                                                      .value >
                                                                  1
                                                              ? ColorResources
                                                                  .PRIMARY
                                                              : ColorResources
                                                                  .GREY),
                                                      color: controller
                                                                  .qualityProduct
                                                                  .value >
                                                              1
                                                          ? ColorResources
                                                              .PRIMARY
                                                          : ColorResources
                                                              .GREY),

                                                  //quanlity
                                                  _iconsquality(context,
                                                      text: controller
                                                          .qualityProduct.value
                                                          .toString()),

                                                  //incrementQuality
                                                  _iconsquality(context,
                                                      onTap: () {
                                                    controller
                                                        .incrementQuality();
                                                  },
                                                      icon: const Icon(
                                                          Icons.add_outlined,
                                                          color: ColorResources
                                                              .PRIMARY)),
                                                ],
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                DeviceUtils.getScaledSize(context, 0.04)),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: controller.items[index].isChoose == true
                                ? [
                                    BoxShadow(
                                      blurRadius: 2,
                                      color: ColorResources.PRIMARY
                                          .withOpacity(0.3),
                                      spreadRadius: 2, // Shadow position
                                    )
                                  ]
                                : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            if (controller.items[index].isChoose == true)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.cancel(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          DeviceUtils.getScaledWidth(
                                              context, 0.01)),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorResources.GREY,
                                      ),
                                      child: Icon(
                                        Icons.close_outlined,
                                        size: DeviceUtils.getScaledHeight(
                                            context, 0.023),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              const SizedBox.shrink(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: DeviceUtils.getScaledSize(
                                      context, 0.038)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: DeviceUtils.getScaledSize(
                                        context, 0.343),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage(controller
                                              .items[index].url
                                              .toString()),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                      height: DeviceUtils.getScaledHeight(
                                          context, 0.01)),
                                  Text(
                                    controller.items[index].title.toString(),
                                    style: Dimensions.fontSizeStyle14w600(),
                                  ),
                                  Text(PriceConverter.convertPrice(
                                      context,
                                      controller.items[index].amount
                                          .toDouble())),
                                  if (controller.items[index].isChoose == true)
                                    Text(
                                      "Số lượng: ${controller.items[index].quality}",
                                      style: Dimensions.fontSizeStyle14()
                                          .copyWith(
                                              color: ColorResources.PRIMARY),
                                    )
                                  else
                                    const SizedBox.shrink(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}

// ignore: unused_element
Widget _normalInputWidget(String? label, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: const Color(0xFFEBEDEF), // set border color
        width: 3.0,
      ), // set border width
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ), // set rounded corner radius
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: label,
        border: InputBorder.none,
      ),
      controller: controller,
    ),
  );
}

class Item {
  String url;
  String title;
  int amount;
  bool isChoose;
  int quality;

  Item(
      {required this.url,
      required this.title,
      required this.amount,
      required this.isChoose,
      required this.quality});
}
