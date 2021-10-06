import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/product/cart/cart_controller.dart';

class V1CartPage extends GetView<V1CartController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<V1CartController>(
        init: V1CartController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      20 / height,
                    ),
                  ),

                  //title shipping detail
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          DeviceUtils.getScaledHeight(context, 15 / height),
                    ),
                    child: Text(
                      "Chi tiết về shipping",
                      style: Dimensions.fontSizeStyle18w600(),
                    ),
                  ),

                  //shipping detail
                  _shipping(context, controller, height, width),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 10 / height),
                  ),

                  //title order product detail
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: DeviceUtils.getScaledWidth(
                        context,
                        15 / width,
                      ),
                    ),
                    child: Text(
                      "Chi tiết đơn hàng",
                      style: Dimensions.fontSizeStyle18w600(),
                    ),
                  ),

                  //order product detail
                  _orderProductDetail(context, controller, height, width),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      20 / height,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar:
                _bottomPaymentBtn(context, controller, height, width),
          );
        });
  }

  ///
  ///shipping widget
  ///
  Row _shippingWidget(BuildContext context, double height, double width,
      {Image? image,
      Icon? icon,
      required String text1,
      required String text2,
      String? text3}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          Container(
              height: DeviceUtils.getScaledHeight(context, 25 / height),
              width: DeviceUtils.getScaledWidth(context, 25 / width),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: image)
        else
          icon!,
        SizedBox(width: DeviceUtils.getScaledWidth(context, 10 / width)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
              ),
              Text(
                text2,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              if (text3 == null)
                const SizedBox.shrink()
              else
                Text(text3.toString(),
                    style: Dimensions.fontSizeStyle16()
                        .copyWith(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///shipping
  ///
  Widget _shipping(
    BuildContext context,
    V1CartController controller,
    double height,
    double width,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 15 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 15 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 20 / width),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
          ),
        ],
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // shipping address
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: _shippingWidget(
                    context,
                    height,
                    width,
                    icon: const Icon(
                      Icons.location_on_outlined,
                      color: ColorResources.PRIMARY,
                    ),
                    text1: "Địa chỉ ship",
                    text2: "183 Quách Thị Trang",
                  ),
                ),
                const Expanded(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorResources.PRIMARY,
                  ),
                ),
              ],
            ),
          ),

          Dimensions().paddingDivider(context),

          //partner shipping
          _shippingWidget(
            context,
            height,
            width,
            image: Image.asset("assets/images/logo.png"),
            text1: "Dịch vụ shipping",
            text2: "Tên dịch vụ",
            text3: "Cùng ngày 2h - 3h",
          ),
        ],
      ),
    );
  }

  ///
  ///icons quality
  ///
  Widget _iconQuality(BuildContext context,
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

  ///
  ///edit quality
  ///
  Widget _editQuanlity(BuildContext context) {
    return Row(
      children: [
        //decrementQuality
        _iconQuality(context, onTap: () {
          controller.decreQuality();
        },
            icon: Icon(Icons.remove,
                color: controller.qualityProduct > 1
                    ? ColorResources.PRIMARY
                    : ColorResources.GREY),
            color: controller.qualityProduct > 1
                ? ColorResources.PRIMARY
                : ColorResources.GREY),

        //quanlity
        _iconQuality(context, text: controller.qualityProduct.toString()),

        //incrementQuality
        _iconQuality(context, onTap: () {
          controller.increQuality();
        }, icon: const Icon(Icons.add_outlined, color: ColorResources.PRIMARY)),
      ],
    );
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
  Widget _paymentDetail(
    BuildContext context,
    V1CartController controller,
    double height,
    double width,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 10 / height),
      ),
      child: Column(
        children: [
          rowText(
            text1: "Giá trị",
            text2: "260.000 VND",
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 10 / height),
          ),
          rowText(
            text1: "Phí vận chuyển",
            text2: "Miễn phí",
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 10 / height),
          ),
          rowText(
            text1: "Tổng",
            text2: "260.000 VND",
          ),
        ],
      ),
    );
  }

  ///
  ///order poduct detail
  ///
  Widget _orderProductDetail(
    BuildContext context,
    V1CartController controller,
    double height,
    double width,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 15 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 15 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 20 / width),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 2,
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
        ),
      ], color: ColorResources.WHITE, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //img order product
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.asset(
                                  controller.imgProduct,
                                  fit: BoxFit.fill,
                                  width: DeviceUtils.getScaledWidth(
                                      context, 60 / width),
                                  height: DeviceUtils.getScaledHeight(
                                      context, 70 / height),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: DeviceUtils.getScaledWidth(
                                  context, 10 / width),
                            ),

                            // name, price, quality
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //name
                                  Text(
                                    "Sản phẩm ${index + 1}",
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 5 / height),
                                  ),

                                  //price
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "${Random().nextInt(500000) + 100000} VND",
                                          style: const TextStyle(
                                            color: ColorResources.RED,
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 5 / height),
                                  ),

                                  // edit quality
                                  _editQuanlity(context),

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 5 / height),
                                  ),
                                ],
                              ),
                            ),

                            /// delete btn
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.deleteProduct(
                                    context, height, width),
                                child: Container(
                                  padding: EdgeInsets.all(
                                    DeviceUtils.getScaledSize(
                                        context, 5 / width),
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorResources.GREY.withOpacity(.2),
                                  ),
                                  child: Icon(
                                    Icons.close_outlined,
                                    size: DeviceUtils.getScaledHeight(
                                        context, 14 / height),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //divider
                  Dimensions().paddingDivider(context),
                ],
              );
            }),

        //payment detail
        _paymentDetail(context, controller, height, width),
      ]),
    );
  }

  ///
  ///bottom payment button
  ///
  Widget _bottomPaymentBtn(
    BuildContext context,
    V1CartController controller,
    double height,
    double width,
  ) {
    return Container(
      padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 10 / width)),
      height: DeviceUtils.getScaledHeight(context, 80 / height),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: ColorResources.GREY.withOpacity(0.3),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// button checkout
          GestureDetector(
            onTap: () {},
            child: Container(
              height: DeviceUtils.getScaledHeight(context, 40 / height),
              decoration: BoxDecoration(
                  color: ColorResources.PRIMARY,
                  borderRadius: BorderRadius.circular(20)),
              child: Align(
                  child: Text("Thanh toán 260.000 VND",
                      style: Dimensions.fontSizeStyle16()
                          .copyWith(color: ColorResources.WHITE))),
            ),
          ),
        ],
      ),
    );
  }
}
