import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/row_text.dart';
import 'package:template/view/screen/v1-customer/payment%20account/payment_account_controller.dart';

class V1PaymentAccountPage extends GetView<V1PaymentAccountController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1PaymentAccountController>(
        init: V1PaymentAccountController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Container(
              margin: const EdgeInsets.symmetric(
                vertical: Dimensions.MARGIN_SIZE_DEFAULT,
                horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                horizontal: Dimensions.PADDING_SIZE_LARGE,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //title
                    _textTitle(
                      context,
                      title: "Quản lý tài khoản",
                    ),

                    //detail
                    const RowText(
                      text1: "Số dư của bạn",
                      text2: "0đ",
                      notFontWeight: true,
                      notFontSize: true,
                      colorRed: true,
                    ),
                    const RowText(
                      text1: "Số tiền cần thanh toán",
                      text2: "7.500đ",
                      notFontWeight: true,
                      notFontSize: true,
                      colorRed: true,
                    ),
                    const RowText(
                      text1: "Còn dư/còn thiếu",
                      text2: "7.500đ",
                      notFontWeight: true,
                      notFontSize: true,
                      colorRed: true,
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, .019),
                    ),

                    //btn checkout
                    BtnCustom(
                      onTap: () => controller.onCheckoutClick(),
                      color: ColorResources.PRIMARY,
                      text: "Đồng ý thanh toán",
                      width: DeviceUtils.getScaledWidth(context, .7),
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, .019),
                    ),

                    //note
                    const Text(
                      "(Nếu số dư lớn hơn hoặc bằng số tiền thanh toán thì bạn chọn đồng ý thanh toán, lúc này tài khoản sẽ tự trừ qua app)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorResources.RED),
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, .019),
                    ),

                    //btn put money into an account
                    BtnCustom(
                      onTap: () => controller.onRechargeClick(),
                      color: ColorResources.PRIMARY,
                      text: "Nạp tiền",
                      width: DeviceUtils.getScaledWidth(context, .7),
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, .019),
                    ),

                    //note
                    const Text(
                      "Nếu bạn nộp dư thì số dư sẽ được tích lũy",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorResources.RED),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_SMALL,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
