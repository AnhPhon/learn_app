import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/row_text.dart';
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
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
                        controller.paymentMethodTitle![index],
                        style: const TextStyle(
                          height: 1.5,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //subtitle
                      ...controller.paymentMethodSubTitle![index]
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
            RowText(
              text1: "Cần thanh toán",
              text2:
                  "${PriceConverter.convertPrice(context, controller.contentMoney)} VND",
              colorRed: true,
            ),
            BtnCustom(
              color: ColorResources.PRIMARY,
              text: "Tiếp tục",
              onTap: () {
                controller.toTaiKhoan();
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
