import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/product/cart/cart_controller.dart';

class V1CartPage extends GetView<V1CartController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1CartController>(
        init: V1CartController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //title shipping detail
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Text(
                      "Chi tiết về shipping",
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //shipping detail
                  _shipping(context, controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_SMALL,
                  ),

                  //title order product detail
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Text(
                      "Chi tiết đơn hàng",
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //order product detail
                  _orderProductDetail(context, controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _bottomPaymentBtn(context, controller),
          );
        });
  }

  ///
  ///shipping widget
  ///
  Row _shippingWidget(
    BuildContext context, {
    Image? image,
    Icon? icon,
    required String text1,
    required String text2,
    String? text3,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          Container(
              height: DeviceUtils.getScaledHeight(context, .032),
              width: DeviceUtils.getScaledWidth(context, .063),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              child: image)
        else
          icon!,
        const SizedBox(
          width: Dimensions.MARGIN_SIZE_SMALL,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
              Text(
                text2,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (text3 == null)
                const SizedBox.shrink()
              else
                Text(
                  text3.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///row shipping component
  ///
  Widget _rowShipping(
    BuildContext context, {
    required VoidCallback onTap,
    required Widget shippingWidget,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: shippingWidget,
          ),
          const Expanded(
            child: Icon(
              Icons.arrow_forward_ios,
              color: ColorResources.PRIMARY,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///shipping
  ///
  Widget _shipping(
    BuildContext context,
    V1CartController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_DEFAULT,
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(.3),
            spreadRadius: 2,
          ),
        ],
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
      child: Column(
        children: [
          // shipping address
          _rowShipping(
            context,
            onTap: () => controller.onSelectShippingAddress(),
            shippingWidget: _shippingWidget(
              context,
              icon: const Icon(
                Icons.location_on_outlined,
                color: ColorResources.PRIMARY,
              ),
              text1: "Địa chỉ ship",
              text2: "183 Quách Thị Trang",
            ),
          ),

          Dimensions().paddingDivider(context),

          //partner shipping
          _rowShipping(
            context,
            onTap: () => controller.onSelectShippingMethod(),
            shippingWidget: _shippingWidget(
              context,
              image: Image.asset("assets/images/logo.png"),
              text1: "Dịch vụ shipping",
              text2: "Tên dịch vụ",
              text3: "Cùng ngày 2h - 3h",
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///icons quality
  ///
  Widget _iconQuality(
    BuildContext context, {
    VoidCallback? onTap,
    Icon? icon,
    String? text,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
        height: DeviceUtils.getScaledSize(context, .064),
        width: DeviceUtils.getScaledSize(context, .064),
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
  Row rowText({
    required String text1,
    required String text2,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: color ?? ColorResources.BLACK,
          ),
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
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Column(
        children: [
          rowText(
            text1: "Giá trị",
            text2: "260.000 VND",
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          rowText(
            text1: "Phí vận chuyển",
            text2: "Miễn phí",
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
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
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_DEFAULT,
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(.3),
            spreadRadius: 2,
          ),
        ],
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
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
                                borderRadius: BorderRadius.circular(
                                    Dimensions.BORDER_RADIUS_SMALL),
                                child: Image.asset(
                                  controller.imgProduct,
                                  fit: BoxFit.fill,
                                  width:
                                      DeviceUtils.getScaledWidth(context, .152),
                                  height: DeviceUtils.getScaledHeight(
                                      context, .092),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: Dimensions.MARGIN_SIZE_SMALL,
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

                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
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

                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),

                                  // edit quality
                                  _editQuanlity(context),

                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                ],
                              ),
                            ),

                            /// delete btn
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.deleteProduct(context),
                                child: Container(
                                  padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorResources.GREY.withOpacity(.2),
                                  ),
                                  child: const Icon(
                                    Icons.close_outlined,
                                    size: Dimensions.ICON_SIZE_EXTRA_SMALL,
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
        _paymentDetail(context, controller),
      ]),
    );
  }

  ///
  ///bottom payment button
  ///
  Widget _bottomPaymentBtn(
    BuildContext context,
    V1CartController controller,
  ) {
    return BtnCustom(
        onTap: () => controller.onCheckoutClick(),
        color: ColorResources.PRIMARY,
        text: "Thanh toán 260.000 VND",
        width: double.infinity);
  }
}
