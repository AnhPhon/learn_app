import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/payment/payment_success/payment_success_controller.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';

class PaymentSuccessPage extends GetView<PaymentSuccessController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentSuccessController>(
        init: PaymentSuccessController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(
              title: controller.title,
              isNotBack: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                  //image
                  _image(),

                  //note
                  _note(context, controller)
                ],
              ),
            ),
            bottomNavigationBar: _btnBottomSheet(controller),
          );
        });
  }

  ///
  ///image
  ///
  Widget _image() {
    return Image.asset(Images.payment_success);
  }

  ///
  ///note
  ///
  Widget _note(BuildContext context, PaymentSuccessController controller) {
    return DefaultTextStyle(
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: ColorResources.BLACK,
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
            ),
            Text(
              controller.isPayment
                  ? "Bạn đã thanh toán thành công!"
                  : "Bạn đã gửi yêu cầu nạp tiền thành công",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            Text(controller.isPayment
                ? 'Chúng tôi sẽ bố trí người để thực hiện đơn hàng sớm nhất!'
                : "Chúng tôi sẽ kiểm tra yêu cầu sớm nhất!"),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            const Text("Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!"),
          ],
        ),
      ),
    );
  }

  ///
  ///btn bottomsheet
  ///
  Widget _btnBottomSheet(PaymentSuccessController controller) {
    return BtnCustom(
      onTap: () => controller.onCompleteClick(),
      color: ColorResources.PRIMARY,
      text: "Xác nhận",
      width: double.infinity,
    );
  }
}