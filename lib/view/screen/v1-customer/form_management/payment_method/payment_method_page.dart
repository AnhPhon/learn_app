import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/row_text.dart';
import 'package:template/view/screen/v1-customer/form_management/payment_method/payment_method_controller.dart';

class V1PaymentMethodPage extends GetView<V1PaymentMethodController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1PaymentMethodController>(
        init: V1PaymentMethodController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //rad payment method
                  _radPaymentMethodList(controller),
                ],
              ),
            ),
            //bottom sheet
            bottomNavigationBar: _bottomSheet(context, controller),
          );
        });
  }

  ///
  ///radio list
  ///
  Widget _radPaymentMethodList(V1PaymentMethodController controller) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: DeviceUtils.getScaledWidth(context, 0.025),
                vertical: DeviceUtils.getScaledHeight(context, 0.026)),
            padding: EdgeInsets.symmetric(
                vertical: DeviceUtils.getScaledHeight(context, 0.026),
                horizontal: DeviceUtils.getScaledWidth(context, 0.051)),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.25),
                    blurRadius: 4,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //rad btn
                Expanded(
                  child: Radio(
                    value: index,
                    groupValue: controller.paymentMethodIndex,
                    activeColor: ColorResources.PRIMARY,
                    onChanged: controller.setSelectedPaymentMethod,
                  ),
                ),

                //title and subtitle
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      Text(
                        controller.paymentMethodTitle[index],
                        style: const TextStyle(
                          height: 1.5,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //subtitle
                      ...controller.paymentMethodSubTitle[index]
                          .map((element) => Padding(
                                padding: EdgeInsets.only(
                                  left: DeviceUtils.getScaledWidth(
                                      context, 0.051),
                                  top: DeviceUtils.getScaledHeight(
                                      context, 0.006),
                                  bottom: DeviceUtils.getScaledHeight(
                                      context, 0.006),
                                ),
                                child: Text(
                                  element,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    height: 1.5,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  ///
  ///bottom sheet
  ///
  Widget _bottomSheet(
      BuildContext context, V1PaymentMethodController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.19),
      padding: EdgeInsets.only(
          left: DeviceUtils.getScaledWidth(context, 0.038),
          right: DeviceUtils.getScaledWidth(context, 0.038),
          top: DeviceUtils.getScaledHeight(context, 0.035),
          bottom: DeviceUtils.getScaledHeight(context, 0.026)),
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, -2))
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
            color: ColorResources.BLACK,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            fontWeight: FontWeight.bold),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const RowText(
              text1: "Cần thanh toán",
              text2: "11.050.000 VND",
              colorRed: true,
            ),
            BtnCustom(
              color: ColorResources.PRIMARY,
              text: "Tiếp tục",
              onTap: () {},
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
