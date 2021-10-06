import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/payment_success/payment_success_controller.dart';

class V1PaymentSuccessPage extends GetView<V1PaymentSuccessController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1PaymentSuccessController>(
        init: V1PaymentSuccessController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.026),
                  ),
                  //image
                  _image(),

                  //note
                  _note(context)
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
  Widget _note(BuildContext context) {
    return DefaultTextStyle(
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: ColorResources.BLACK,
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 0.038),
        ),
        child: Column(
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.032),
            ),
            const Text(
              "Bạn đã chuyển tiền cọc và tiền phí thành công!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.019),
            ),
            const Text(
                "Chúng tôi sẽ bố trí người để thực hiện đơn hàng sớm nhất!"),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.019),
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
  Widget _btnBottomSheet(V1PaymentSuccessController controller) {
    return BtnCustom(
      onTap: () => controller.onCompleteClick(),
      color: ColorResources.PRIMARY,
      text: "Xác nhận",
      width: double.infinity,
    );
  }
}
