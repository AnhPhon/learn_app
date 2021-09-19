import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/order/order_controller.dart';

class OrderPage extends GetView<OrderController> {
  ///
  ///order widget
  ///
  Widget orderWidget(BuildContext context,
      {required String orderStatus,
      required String imgUrl,
      required int price,
      required int quantity,
      required String paymentMethod}) {
    return GestureDetector(
      onTap: () {
        controller.onOrderWidgetClick();
      },
      child: Container(
        margin: EdgeInsets.only(
            left: DeviceUtils.getScaledSize(context, 0.03),
            right: DeviceUtils.getScaledSize(context, 0.03),
            bottom: DeviceUtils.getScaledSize(context, 0.02),
            top: DeviceUtils.getScaledSize(context, 0.03)),
        padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.04)),
        decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //status order
            Container(
              padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.02)),
              decoration: BoxDecoration(
                  color: orderStatus == "Đã giao hàng"
                      ? const Color(0xffD7FAE0)
                      : orderStatus == "Shipping"
                          ? const Color(0xffDBEEFF)
                          : orderStatus == "Xử lý"
                              ? const Color(0xffFFF5C7)
                              : orderStatus == "Chờ thanh toán"
                                  ? const Color(0xffFFDBDE)
                                  : orderStatus == "Huỷ bỏ"
                                      ? const Color(0xffF5F5FA)
                                      : Colors.white,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                orderStatus,
                style: TextStyle(
                  color: orderStatus == "Đã giao hàng"
                      ? const Color(0xff007D3A)
                      : orderStatus == "Shipping"
                          ? const Color(0xff0D5BB5)
                          : orderStatus == "Xử lý"
                              ? const Color(0xffCC8100)
                              : orderStatus == "Chờ thanh toán"
                                  ? const Color(0xffBF1D28)
                                  : orderStatus == "Huỷ bỏ"
                                      ? const Color(0xffA6A6B0)
                                      : Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            //product info
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    imgUrl,
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
                      "$quantity sản phẩm | $price đ",
                      style: titilliumSemiBold.copyWith(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            Dimensions().paddingDivider(context),

            //payment method
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text("Phương thức thanh toán"),
                  Text(paymentMethod,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  ///tab all
  ///
  Widget _tabAll(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // tab all
          orderWidget(context,
              imgUrl: "assets/images/Untitled.png",
              orderStatus: "Đã giao hàng",
              paymentMethod: "Momo",
              price: 380000,
              quantity: 2),
          orderWidget(context,
              imgUrl: "assets/images/Untitled.png",
              orderStatus: "Shipping",
              paymentMethod: "ZaloPay",
              price: 380000,
              quantity: 2),
          orderWidget(context,
              imgUrl: "assets/images/Untitled.png",
              orderStatus: "Xử lý",
              paymentMethod: "COD",
              price: 380000,
              quantity: 2),
          orderWidget(context,
              imgUrl: "assets/images/Untitled.png",
              orderStatus: "Chờ thanh toán",
              paymentMethod: "Credit Card",
              price: 380000,
              quantity: 2),
          orderWidget(context,
              imgUrl: "assets/images/Untitled.png",
              orderStatus: "Huỷ bỏ",
              paymentMethod: "ATM",
              price: 380000,
              quantity: 2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return GetBuilder<OrderController>(
        init: OrderController(),
        builder: (OrderController value) {
          return DefaultTabController(
            length: 5,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: ColorResources.WHITE,
                iconTheme: const IconThemeData(color: Colors.black),
                title: const Text(
                  "Order của tôi",
                  style: TextStyle(color: ColorResources.BLACK),
                ),
                bottom: const TabBar(
                  isScrollable: true,
                  indicatorColor: ColorResources.PRIMARY,
                  labelColor: ColorResources.PRIMARY,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Tất cả"),
                    Tab(text: "Chờ thanh toán"),
                    Tab(text: "Xử lý"),
                    Tab(text: "Shipping"),
                    Tab(text: "Huỷ bỏ"),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  // tab all
                  _tabAll(context),

                  //tab pending
                  Container(),

                  //tab processing
                  Container(),

                  //tab shipping
                  Container(),

                  //tab cancle
                  Container(),
                ],
              ),
            ),
          );
        });
  }
}
