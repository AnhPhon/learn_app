import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/register/payment/payment_controller.dart'; 

class PaymentPage extends GetView<PaymentController> {
  ///
  /// row text
  ///
  Widget _rowText(BuildContext context,
      {required String text1, required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1,
            textAlign: TextAlign.center,
            style:
                Dimensions.fontSizeStyle14w600().copyWith(color: Colors.grey)),
        Text(text2,
            textAlign: TextAlign.center,
            style: Dimensions.fontSizeStyle14w600()
                .copyWith(color: ColorResources.BLACK)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (PaymentController value) {
          return Scaffold(
            //app bar
            appBar: CustomAppBar().customAppBar(title: "Thanh toán"),

            backgroundColor: ColorResources.WHITE,

            //body
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: DeviceUtils.getScaledSize(context, 0.05)),

                  //chi tiết hoá đơn
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.03),
                        vertical: DeviceUtils.getScaledSize(context, 0.03)),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2, // Shadow position
                          ),
                        ],
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  DeviceUtils.getScaledSize(context, 0.025),
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.025)),
                          width: double.infinity,
                          height: DeviceUtils.getScaledSize(context, 0.125),
                          decoration: const BoxDecoration(
                              color: ColorResources.PRIMARY,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Chi tiết hoá đơn",
                              style: Dimensions.fontSizeStyle16w600()
                                  .copyWith(color: ColorResources.WHITE),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    DeviceUtils.getScaledSize(context, 0.05),
                                vertical:
                                    DeviceUtils.getScaledSize(context, 0.02)),

                            //list sản phẩm đã chọn
                            child: Column(
                                children: List.generate(
                              controller.orderList.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //hình ảnh sản phẩm
                                      Flexible(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                child: Image(
                                                  height: 70,
                                                  width: 70,
                                                  image: NetworkImage(
                                                    controller
                                                        .items[controller
                                                            .orderList[index]]
                                                        .url,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //tên sản phẩm
                                                  Text(
                                                    controller
                                                        .items[controller
                                                            .orderList[index]]
                                                        .title,
                                                    maxLines: 3,
                                                    style: titilliumSemiBold
                                                        .copyWith(fontSize: 14),
                                                  ),

                                                  //số lượng đã chọn
                                                  Text(
                                                    "x${controller.items[controller.orderList[index]].quality.toString()}",
                                                    style: titilliumSemiBold
                                                        .copyWith(
                                                            color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //giá tiền
                                      Flexible(
                                        flex: 3,
                                        child: Text(
                                          PriceConverter.convertPrice(
                                              context,
                                              controller
                                                  .items[controller
                                                      .orderList[index]]
                                                  .amount
                                                  .toDouble()),
                                          style: titilliumSemiBold.copyWith(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: DeviceUtils.getScaledSize(
                                            context, 0.01)),
                                    child: const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ))),

                        //tổng tiền
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.05)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tổng tiền phải trả: ",
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                              Text(
                                PriceConverter.convertPrice(
                                    context, controller.sum * .75),
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.027))
                      ],
                    ),
                  ),

                  //thông tin tài khoản
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.03),
                        vertical: DeviceUtils.getScaledSize(context, 0.03)),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2, // Shadow position
                          ),
                        ],
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    DeviceUtils.getScaledSize(context, 0.025),
                                horizontal:
                                    DeviceUtils.getScaledSize(context, 0.025)),
                            width: double.infinity,
                            height: DeviceUtils.getScaledSize(context, 0.125),
                            decoration: const BoxDecoration(
                                color: ColorResources.PRIMARY,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Thông tin tài khoản",
                                style: Dimensions.fontSizeStyle16w600()
                                    .copyWith(color: ColorResources.WHITE),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.04),
                              vertical:
                                  DeviceUtils.getScaledSize(context, 0.03)),
                          child: DefaultTextStyle(
                            style: Dimensions.fontSizeStyle16().copyWith(
                                decoration: TextDecoration.none,
                                color: ColorResources.BLACK),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _rowText(context,
                                    text1: "Số tài khoản:",
                                    text2: "1234 5678 9012"),
                                _rowText(context,
                                    text1: "Tên chủ tài khoản",
                                    text2: "Nguyễn Thị Thảo"),
                                _rowText(context,
                                    text1: "Tên ngân hàng",
                                    text2: "Ngân hàng Sacombank"),
                                _rowText(context,
                                    text1: "Chi nhánh", text2: "Hà Nội"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //tải lên hình ảnh thanh toán
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.05),
                        vertical: DeviceUtils.getScaledSize(context, 0.03)),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Tải lên hình ảnh thanh toán",
                              style: Dimensions.fontSizeStyle16w600()
                                  .copyWith(color: ColorResources.BLACK),
                            ),
                            Text(
                              "*",
                              style: Dimensions.fontSizeStyle16w600()
                                  .copyWith(color: ColorResources.RED),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.025)),

                        //hình ảnh thanh toán
                        GestureDetector(
                          onTap: () {
                            controller.pickImage();
                          },
                          child: Container(
                            height: DeviceUtils.getScaledSize(context, 0.382),
                            width: DeviceUtils.getScaledSize(context, 0.509),
                            padding: EdgeInsets.symmetric(
                                horizontal: DeviceUtils.getScaledSize(context,
                                    controller.image != null ? 0 : 0.101)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: controller.image != null
                                  ? null
                                  : Border.all(width: 2, color: Colors.grey),
                            ),
                            child: controller.image != null
                                ? Image.file(
                                    controller.image!,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/bill.png",
                                        height: 50,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "Bấm vào đây để tải lên hoá đơn",
                                        textAlign: TextAlign.center,
                                        style: Dimensions.fontSizeStyle14w600()
                                            .copyWith(color: Colors.grey),
                                      )
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //done button
                  GestureDetector(
                    onTap: () {
                      controller.uploadImage();

                      // if (controller.image != null) {
                      //   controller.uploadImage();
                      //   controller.sl
                      //       .get<SharedPreferenceHelper>()
                      //       .removeOrderId();

                      //   Get.offNamed(AppRoutes.LOGIN);
                      //   showAnimatedDialog(
                      //       context,
                      //       const MyDialog(
                      //         icon: Icons.check,
                      //         title: "Hoàn tất",
                      //         description: "Đợi admin active",
                      //       ),
                      //       dismissible: false,
                      //       isFlip: true);
                      // } else {
                      //   controller.hoanTatFaild();
                      // }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(context, 0.1),
                          vertical: DeviceUtils.getScaledSize(context, 0.07)),
                      alignment: Alignment.center,
                      height: DeviceUtils.getScaledSize(context, 0.12),
                      decoration: BoxDecoration(
                          color: ColorResources.PRIMARY,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Hoàn tất",
                        style: Dimensions.fontSizeStyle16w600()
                            .copyWith(color: ColorResources.WHITE),
                      ),
                    ),
                  ),
                  SizedBox(height: DeviceUtils.getScaledSize(context, 0.15)),
                ],
              ),
            ),
          );
        });
  }
}
