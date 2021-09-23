import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/basewidget/my_dialog.dart';
import 'package:template/view/screen/register/register_controller.dart';

class RegisterPage4 extends GetView<RegisterController> {
  ///
  ///row text
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
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (RegisterController value) {
          return Scaffold(
            appBar: CustomAppBar().customAppBar(title: "Thanh toán"),
            backgroundColor: ColorResources.WHITE,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: DeviceUtils.getScaledSize(context, 0.05)),
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
                                      Flexible(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                child: Image.asset(
                                                  controller
                                                      .items[controller
                                                          .orderList[index]]
                                                      .url,
                                                  height: 70,
                                                  width: 70,
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
                                                  Text(
                                                    controller
                                                        .items[controller
                                                            .orderList[index]]
                                                        .title,
                                                    maxLines: 3,
                                                    style: titilliumSemiBold
                                                        .copyWith(fontSize: 14),
                                                  ),
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
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                _rowText(context,
                                    text1: "Số tài khoản:",
                                    text2: "XXXX XXXX XXXX"),
                                _rowText(context,
                                    text1: "Tên chủ tài khoản",
                                    text2: "Nguyễn Văn A"),
                                _rowText(context,
                                    text1: "Tên ngân hàng",
                                    text2: "Ngân hàng Sacombank"),
                                _rowText(context,
                                    text1: "Chi nhánh", text2: "Gia Lai"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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

                            // if (controller.image != null)
                            //   Image.file(
                            //     controller.image!,
                            //     height: DeviceUtils.getScaledSize(context, 0.127),
                            //     width: DeviceUtils.getScaledSize(context, 0.178),
                            //   )
                            // else
                            //   Icon(
                            //     Icons.image_outlined,
                            //     size: DeviceUtils.getScaledSize(context, 0.08),
                            //   ),
                          ],
                        ),
                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.025)),
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
                  GestureDetector(
                    onTap: () {
                      if (controller.image != null) {
                        Get.offNamed(AppRoutes.LOGIN);

                        showAnimatedDialog(
                            context,
                            const MyDialog(
                              icon: Icons.check,
                              title: "Hoàn tất",
                              description: "Đợi admin active",
                            ),
                            dismissible: false,
                            isFlip: true);
                      } else {
                        Get.snackbar(
                          "Thất bại",
                          "Vui lòng tải lên hình ảnh thanh toán",
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
