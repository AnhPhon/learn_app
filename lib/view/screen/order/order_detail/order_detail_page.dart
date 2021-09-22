import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/order/component/custom_stepper.dart';
import 'package:template/view/screen/order/order_detail/order_detail_controller.dart';

class OrderDetailPage extends GetView<OrderDetailController> {
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
  ///thong tin chung
  ///
  Widget _thongTinChung(BuildContext context) {
    return _containerBox(
      context,
      child: Column(
        children: [
          rowText(text1: "Order Id", text2: "00000000"),
          Dimensions().paddingDivider(context),
          rowText(text1: "Ngày order", text2: "13:35 17/09/2021"),
          Dimensions().paddingDivider(context),
          rowText(text1: "Trạng thái", text2: "Đã giao hàng"),
        ],
      ),
    );
  }

  ///
  ///lich su
  ///
  Widget _lichSu(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Text(
                "Lịch sử",
                style: Dimensions.fontSizeStyle18w600(),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.onHistoryClick();
              },
              child: const Text("Chi tiết",
                  style: TextStyle(
                    color: ColorResources.LIGHT_SKY_BLUE,
                  )),
            ),
            SizedBox(width: DeviceUtils.getScaledSize(context, 0.01)),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorResources.LIGHT_SKY_BLUE,
              size: DeviceUtils.getScaledSize(context, 0.035),
            ),
          ],
        ),
        _containerBox(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Giao hàng nhanh"),
              Dimensions().paddingDivider(context),
              const CustomStepper(
                  title: "Đã giao hàng\n19:27 17/09/2021",
                  color: ColorResources.PRIMARY),
            ],
          ),
        ),
      ],
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
          _shippingWidget(context,
              icon: const Icon(Icons.location_on_outlined),
              text1: "Địa chỉ shop",
              text2: "183 Quách Thị Trang",
              text3: "Liên hệ: 0334125142"),
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
  ///product info
  ///
  Widget _productInfo(BuildContext context) {
    return _containerBox(context,
        child: Column(
          children: List.generate(
              3,
              (index) => Column(
                    children: [
                      Row(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sản phẩm",
                                style: titilliumSemiBold.copyWith(fontSize: 16),
                              ),
                              Text(
                                "200.000đ x1",
                                style: titilliumSemiBold.copyWith(
                                    color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      if (index == 2)
                        const SizedBox.shrink()
                      else
                        Dimensions().paddingDivider(context),
                    ],
                  )),
        ));
  }

  ///
  ///payment detail
  ///
  Widget _paymentDetail(BuildContext context) {
    return _containerBox(context,
        child: Column(
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
        init: OrderDetailController(),
        builder: (OrderDetailController value) {
          return Scaffold(
            appBar: CustomAppBar().customAppBar(title: "Order của tôi"),
            body: Padding(
              padding:
                  EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.038)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //thong tin chung
                    Text(
                      "Thông tin chung",
                      style: Dimensions.fontSizeStyle18w600(),
                    ),
                    _thongTinChung(context),

                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.02)),

                    //lich su
                    _lichSu(context),

                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.05)),

                    //shipping
                    _shipping(context),

                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.02)),

                    //product info
                    Text("Thông tin sản phẩm",
                        style: Dimensions.fontSizeStyle18w600()),
                    _productInfo(context),

                    //payment detail
                    Text(
                      "Chi tiết thanh toán",
                      style: Dimensions.fontSizeStyle18w600(),
                    ),
                    _paymentDetail(context),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
