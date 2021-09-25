import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/product_detail/product_detail_controller.dart';

import 'cart_controller.dart';

class CartPage extends GetView<CartController> {
  final productDetailController = Get.find<ProductDetailController>();

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
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 2,
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2, // Shadow position
        ),
      ], color: ColorResources.WHITE, borderRadius: BorderRadius.circular(10)),
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
            Text(
              text2,
              style: Dimensions.fontSizeStyle16w600(),
              overflow: TextOverflow.ellipsis,
            ),
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
  Widget _shipping(BuildContext context, CartController cartController) {
    return _containerBox(
      context,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 9,
                child: _shippingWidget(context,
                    icon: const Icon(
                      Icons.location_on_outlined,
                      color: ColorResources.PRIMARY,
                    ),
                    text1: "Địa chỉ ship",
                    text2: cartController.userModel!.address!,
                    text3: "Liên hệ: 0334125142"),
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      controller.onAddressClick();
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorResources.PRIMARY,
                    )),
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
  ///list sản phẩm đã chọn
  ///
  Widget _otherProductDetail(BuildContext context) {
    return _containerBox(context,
        child: GetBuilder<CartController>(
            init: CartController(),
            builder: (cartController) {
              if (cartController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartController.selectedProductList.length,
                    itemBuilder: (BuildContext context, i) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.network(
                                          cartController.selectedProductList[i]
                                              .idProduct!.images!,
                                          height: DeviceUtils.getScaledSize(
                                              context, 0.178),
                                          width: DeviceUtils.getScaledSize(
                                              context, 0.178),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            cartController
                                                .selectedProductList[i]
                                                .idProduct!
                                                .name!,
                                            maxLines: 2,
                                            style: titilliumSemiBold.copyWith(
                                                fontSize: 16),
                                          ),
                                          Text(
                                            PriceConverter.convertPrice(
                                                context,
                                                double.parse(cartController
                                                    .selectedProductList[i]
                                                    .idProduct!
                                                    .prices!)),
                                            style: titilliumSemiBold.copyWith(
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                              height: DeviceUtils.getScaledSize(
                                                  context, 0.02)),
                                          Text(
                                            "x${cartController.selectedProductList[i].quantity!}",
                                            style: titilliumSemiBold.copyWith(
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                              height: DeviceUtils.getScaledSize(
                                                  context, 0.02)),
                                        ],
                                      ),
                                    ),

                                    ///
                                    /// xoá khỏi giỏ hàng
                                    ///
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.deleteItem(i);
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
                _paymentDetail(context, cartController),
              ]);
            }));
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
  Widget _paymentDetail(BuildContext context, CartController cartController) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.015)),
      child: Column(
        children: [
          rowText(
              text1: "Giá tiền",
              text2: PriceConverter.convertPrice(
                      context, cartController.price.toDouble())
                  .toString()),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.015)),
          rowText(text1: "Phí ship", text2: "0 đ"),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.015)),
          rowText(
              text1: "Tổng tiền",
              text2: PriceConverter.convertPrice(
                      context, cartController.price.toDouble())
                  .toString()),
        ],
      ),
    );
  }

  ///
  ///bottom payment button
  ///
  Widget _bottomContainer(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (cartController) {
          return cartController.selectedProductList.isEmpty
              ? Container()
              : Container(
                  padding:
                      EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.02)),
                  height: DeviceUtils.getScaledSize(context, 0.2),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: ColorResources.PRIMARY.withOpacity(0.3),
                        spreadRadius: 2, // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///
                      /// button checkout
                      ///
                      GestureDetector(
                        onTap: () {
                          cartController.onCheckoutClick();
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: ColorResources.PRIMARY,
                              borderRadius: BorderRadius.circular(20)),
                          child: Align(
                              child: Text(
                                  "Thanh toán ${PriceConverter.convertPrice(context, cartController.price.toDouble())}",
                                  style: Dimensions.fontSizeStyle16()
                                      .copyWith(color: ColorResources.WHITE))),
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    const String title = "Giỏ hàng";

    return Scaffold(
      appBar: CustomAppBar().customAppBar(title: "Giỏ hàng"),
      body: GetBuilder<CartController>(
          init: CartController(),
          builder: (cartController) {
            if (cartController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return cartController.selectedProductList.isEmpty
                ? const Center(child: Text("Giỏ hàng trống"))
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.038)),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: DeviceUtils.getScaledSize(context, 0.03)),

                          ///
                          ///shipping detail
                          ///
                          Text(
                            "Chi tiết về shipping",
                            style: Dimensions.fontSizeStyle18w600(),
                          ),
                          _shipping(context, cartController),

                          SizedBox(
                              height: DeviceUtils.getScaledSize(context, 0.02)),

                          ///
                          /// other product detail
                          ///
                          Text(
                            "Chi tiết đơn hàng",
                            style: Dimensions.fontSizeStyle18w600(),
                          ),
                          _otherProductDetail(context),

                          SizedBox(
                              height: DeviceUtils.getScaledSize(context, 0.03)),
                        ],
                      ),
                    ),
                  );
          }),

      ///
      ///bottomSheet payment button
      ///
      bottomNavigationBar: _bottomContainer(context),
    );
  }
}
