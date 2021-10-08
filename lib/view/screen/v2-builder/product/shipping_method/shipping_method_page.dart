import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/component_builder/btn_component.dart';
import 'package:template/view/screen/v2-builder/product/shipping_method/shipping_method_controller.dart';

class V2ShippingMethodPage extends GetView<V2ShippingMethodController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShippingMethodController>(
        init: V2ShippingMethodController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //shipping method
                _shippingMethod(context, controller),

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
  Row _shippingWidget(BuildContext context,
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
              height: DeviceUtils.getScaledHeight(context, .032),
              width: DeviceUtils.getScaledWidth(context, .063),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              child: image)
        else
          icon!,
        const SizedBox(
          width: Dimensions.MARGIN_SIZE_SMALL,
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

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_SMALL,
              ),

              //subtile
              Text(
                text2,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_SMALL,
              ),

              //price
              if (text3 == null)
                const SizedBox.shrink()
              else
                Text(
                  text3.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///row shipping component
  ///
  Widget _rowShipping(
    BuildContext context,
    V2ShippingMethodController controller, {
    required Widget shippingWidget,
    required int indexRad,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 9,
          child: shippingWidget,
        ),
        const SizedBox(
          width: Dimensions.MARGIN_SIZE_SMALL,
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
    V2ShippingMethodController controller,
  ) {
    return Container(
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
                      controller,
                      indexRad: index,
                      shippingWidget: _shippingWidget(
                        context,
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
