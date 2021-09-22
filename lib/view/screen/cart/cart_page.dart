import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:template/data/model/home_page/info.dart';
// template
import 'package:template/data/template/categories.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';

import 'cart_controller.dart';

class CartPage extends GetView<CartController> {
  ///
  ///container box
  ///
  Container _containerBox(BuildContext context, {required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.017)),
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.04),
          horizontal: DeviceUtils.getScaledSize(context, 0.05)),
      decoration: BoxDecoration(
          color: ColorResources.WHITE, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  ///
  ///shipping widget
  ///
  Row _shippingWidget(BuildContext context,
      {Image? image,
      Icon? icon,
      required String text1,
      required String text2,
      required String text3}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          Container(
              height: DeviceUtils.getScaledSize(context, 0.063),
              width: DeviceUtils.getScaledSize(context, 0.063),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: image)
        else
          icon!,
        SizedBox(width: DeviceUtils.getScaledSize(context, 0.02)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: Dimensions.fontSizeStyle16(),
            ),
            Text(text2, style: Dimensions.fontSizeStyle16w600()),
            Text(text3,
                style:
                    Dimensions.fontSizeStyle16().copyWith(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  ///
  ///shipping
  ///
  Widget _shipping(BuildContext context) {
    return _containerBox(
      context,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 9,
                child: _shippingWidget(context,
                    icon: const Icon(Icons.location_on_outlined),
                    text1: "Địa chỉ shop",
                    text2: "183 Quách Thị Trang",
                    text3: "Liên hệ: 0334125142"),
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {}, child: const Icon(Icons.arrow_forward_ios)),
              ),
            ],
          ),
          Dimensions().paddingDivider(context),
          _shippingWidget(context,
              image: Image.asset("assets/images/logo.png"),
              text1: "Dịch vụ shipping",
              text2: "Tên dịch vụ",
              text3: "Trong ngày 2h - 3h"),
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
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            border: Border.all(color: color ?? ColorResources.PRIMARY),
            borderRadius: BorderRadius.circular(5)),
        child: text != null ? Align(child: Text(text)) : icon,
      ),
    );
  }

  ///
  ///other product detail
  ///
  Widget _otherProductDetail(BuildContext context) {
    return _containerBox(context,
        child: Column(children: [
          ...List.generate(
              3,
              (index) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 9,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Image.asset(
                                        "assets/images/Untitled.png",
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sản phẩm",
                                          style: titilliumSemiBold.copyWith(
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "200.000đ",
                                          style: titilliumSemiBold.copyWith(
                                              color: Colors.grey),
                                        ),

                                        SizedBox(
                                            height: DeviceUtils.getScaledSize(
                                                context, 0.02)),

                                        //button quanlity
                                        Row(
                                          children: [
                                            _iconsquality(context, onTap: () {
                                              controller.decrementQuality();
                                            },
                                                icon: Icon(Icons.remove,
                                                    color: controller
                                                                .qualityProduct ==
                                                            1
                                                        ? Colors.grey
                                                        : ColorResources
                                                            .PRIMARY),
                                                color:
                                                    controller.qualityProduct ==
                                                            1
                                                        ? Colors.grey
                                                        : null),
                                            _iconsquality(context,
                                                text: controller.qualityProduct
                                                    .toString()),
                                            _iconsquality(context, onTap: () {
                                              controller.incrementQuality();
                                            },
                                                icon: const Icon(
                                                    Icons.add_outlined,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(
                                    DeviceUtils.getScaledWidth(context, 0.01)),
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
                          ),
                        ],
                      ),

                      //devider
                      Dimensions().paddingDivider(context),
                    ],
                  )),

          //payment detail
          _paymentDetail(context),
        ]));
  }

  ///
  ///row text info
  ///
  Row rowText({required String text1, required String text2, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: Dimensions.fontSizeStyle16(),
        ),
        Text(
          text2,
          style: Dimensions.fontSizeStyle16w600()
              .copyWith(color: color ?? ColorResources.BLACK),
        ),
      ],
    );
  }

  ///
  ///payment detail
  ///
  Widget _paymentDetail(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            controller.payment.length,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: DeviceUtils.getScaledSize(context, 0.015)),
                  child: rowText(
                      text1: controller.payment[index].toString(),
                      text2: controller.price[index].toString(),
                      color: index == 2 ? ColorResources.PRIMARY : null),
                )).toList()
      ],
    );
  }

  ///
  ///bottom payment button
  ///
  Widget _bottomContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.02)),
      height: DeviceUtils.getScaledSize(context, 0.2),
      color: ColorResources.WHITE,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //button checkout
          GestureDetector(
            onTap: () {
              controller.onCheckoutClick();
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: ColorResources.PRIMARY,
                  borderRadius: BorderRadius.circular(20)),
              child: Align(
                  child: Text("Thanh toán 275.000đ",
                      style: Dimensions.fontSizeStyle16()
                          .copyWith(color: ColorResources.WHITE))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    const String title = "Giỏ hàng";

    return GetBuilder<CartController>(
        init: CartController(),
        builder: (CartController value) {
          return Scaffold(
            appBar: CustomAppBar().customAppBar(title: "Giỏ hàng"),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledSize(context, 0.038)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.03)),

                    //shipping detail
                    Text(
                      "Chi tiết về shipping",
                      style: Dimensions.fontSizeStyle18w600(),
                    ),
                    _shipping(context),

                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.02)),

                    //other product detail
                    Text(
                      "Chi tiết sản phẩm khác",
                      style: Dimensions.fontSizeStyle18w600(),
                    ),
                    _otherProductDetail(context),

                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.03)),
                  ],
                ),
              ),
            ),
            //bottomSheet payment button
            bottomNavigationBar: _bottomContainer(context),
          );
        });
  }
}
