import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/checkout/checkout_controller.dart';

class CheckoutPage extends GetView<CheckoutController> {
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
    return Scaffold(
      appBar: CustomAppBar().customAppBar(title: "Thanh toán"),
      backgroundColor: ColorResources.WHITE,
      body: GetBuilder<CheckoutController>(
          init: CheckoutController(),
          builder: (checkoutController) {
            return SingleChildScrollView(
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

                    ///
                    ///
                    ///
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

                          ///
                          ///bill detail
                          ///
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
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkoutController
                                    .selectedProductList.length,
                                itemBuilder: (BuildContext context, i) {
                                  return Column(
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
                                                        BorderRadius.circular(
                                                            7),
                                                    child: Image.network(
                                                      checkoutController
                                                          .selectedProductList[
                                                              i]
                                                          .idProduct!
                                                          .images!,
                                                      height: 70,
                                                      width: 70,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        checkoutController
                                                            .selectedProductList[
                                                                i]
                                                            .idProduct!
                                                            .name!,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 3,
                                                        style: titilliumSemiBold
                                                            .copyWith(
                                                                fontSize: 14),
                                                      ),
                                                      Text(
                                                        "x${checkoutController.selectedProductList[i].quantity.toString()}",
                                                        style: titilliumSemiBold
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
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
                                                  double.parse(
                                                      checkoutController
                                                          .selectedProductList[
                                                              i]
                                                          .idProduct!
                                                          .prices!)),
                                              style: titilliumSemiBold.copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 16),
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
                                  );
                                })),
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
                                PriceConverter.convertPrice(context,
                                        checkoutController.price.toDouble())
                                    .toString(),
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

                  ///
                  ///done btn
                  ///
                  GestureDetector(
                    onTap: () {
                      checkoutController.onClickDoneBtn(context);
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
            );
          }),
    );
  }
}