import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/component_builder/btn_component.dart';
import 'package:template/view/screen/v2-builder/component_builder/row_text.dart';
import 'package:template/view/screen/v2-builder/payment_method/payment_method_controller.dart';

class V2PaymentMethodPage extends GetView<V2PaymentMethodController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2PaymentMethodController>(
        init: V2PaymentMethodController(),
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
  Widget _radPaymentMethodList(V2PaymentMethodController controller) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.MARGIN_SIZE_SMALL,
                vertical: Dimensions.MARGIN_SIZE_SMALL),
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL,
                horizontal: Dimensions.PADDING_SIZE_LARGE),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
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
                      if (controller.isBuy == true)
                        ...controller.paymentMethodSubTitleIsBuy[index]
                            .map((element) => Padding(
                                  padding: const EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_LARGE,
                                    top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
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
                      else
                        ...controller.paymentMethodSubTitle[index]
                            .map((element) => Padding(
                                  padding: const EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_LARGE,
                                    top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                  ),
                                  child: Text(
                                    element,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      height: 1.5,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                )),
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
      BuildContext context, V2PaymentMethodController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, .19),
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
        top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        bottom: Dimensions.PADDING_SIZE_SMALL,
      ),
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.BORDER_RADIUS_LARGE - 5),
          topRight: Radius.circular(Dimensions.BORDER_RADIUS_LARGE - 5),
        ),
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
              onTap: () => controller.onContinueClick(),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}