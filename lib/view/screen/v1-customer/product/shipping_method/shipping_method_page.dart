import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/product/shipping_method/shipping_method_controller.dart';

class V1ShippingMethodPage extends GetView<V1ShippingMethodController> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<V1ShippingMethodController>(
        init: V1ShippingMethodController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //shipping method
                _shippingMethod(context, controller, height, width),

                const Spacer(),
              ],
            ),
            bottomNavigationBar: _btnBottomSheet(),
          );
        });
  }

  ///
  ///shipping widget
  ///
  Row _shippingWidget(BuildContext context, double height, double width,
      {Image? image,
      Icon? icon,
      required String text1,
      required String text2,
      String? text3}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          Container(
              height: DeviceUtils.getScaledHeight(context, 25 / height),
              width: DeviceUtils.getScaledWidth(context, 25 / width),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: image)
        else
          icon!,
        SizedBox(
          width: DeviceUtils.getScaledWidth(context, 10 / width),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name
              Text(
                text1,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: DeviceUtils.getScaledHeight(context, 10 / height),
              ),

              //subtile
              Text(
                text2,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
              ),

              SizedBox(
                height: DeviceUtils.getScaledHeight(context, 10 / height),
              ),

              //price
              if (text3 == null)
                const SizedBox.shrink()
              else
                Text(text3.toString(),
                    style: Dimensions.fontSizeStyle16()
                        .copyWith(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///row shipping component
  ///
  Widget _rowShipping(BuildContext context, double height, double width,
      V1ShippingMethodController controller,
      {required Widget shippingWidget, required int indexRad}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 9,
          child: shippingWidget,
        ),
        SizedBox(
          width: DeviceUtils.getScaledWidth(context, 10 / width),
        ),
        Expanded(
          child: Radio(
            value: indexRad,
            groupValue: controller.shippingMethodIndex,
            activeColor: ColorResources.PRIMARY,
            onChanged: controller.setSelectedShippingMethod,
          ),
        ),
      ],
    );
  }

  ///
  ///shipping
  ///
  Widget _shippingMethod(
    BuildContext context,
    V1ShippingMethodController controller,
    double height,
    double width,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 15 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 25 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 20 / width),
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
      child: Column(
        children: [
          //partner shipping
          ListView.builder(
              shrinkWrap: true,
              itemCount: controller.shippingMethodNameList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    _rowShipping(
                      context,
                      height,
                      width,
                      controller,
                      indexRad: index,
                      shippingWidget: _shippingWidget(
                        context,
                        height,
                        width,
                        image: Image.asset(Images.shipping_method),
                        text1: controller.shippingMethodNameList[index],
                        text2: controller.shippingMethodSubTileList[index],
                        text3: controller.shippingMethodIndex == index
                            ? controller.shippingMethodPrice
                            : null,
                      ),
                    ),
                    if (index != controller.shippingMethodNameList.length - 1)
                      Dimensions().paddingDivider(context),
                  ],
                );
              }),
        ],
      ),
    );
  }

  ///
  ///btn bottom sheet
  ///
  Widget _btnBottomSheet() {
    return BtnCustom(
        onTap: () {},
        color: ColorResources.PRIMARY,
        text: "Hoàn tất",
        width: double.infinity);
  }
}
