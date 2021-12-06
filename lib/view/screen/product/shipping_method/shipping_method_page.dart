import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/screen/product/shipping_method/shipping_method_controller.dart';

class ShippingMethodPage extends GetView<ShippingMethodController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShippingMethodController>(
        init: ShippingMethodController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //shipping method
                _shippingMethod(context, controller),

                //btn
                _btnBottomSheet(context, controller: controller),
              ],
            ),
          );
        });
  }

  ///
  ///shipping widget
  ///
  Row _shippingWidget(BuildContext context,
      {String? image,
      Icon? icon,
      required String text1,
      String? text2,
      String? text3}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          Container(
              height: DeviceUtils.getScaledHeight(context, .05),
              width: DeviceUtils.getScaledWidth(context, .13),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              child: Image.asset(
                image,
                color: ColorResources.PRIMARY,
                fit: BoxFit.contain,
              ))
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
              if (text2 == null)
                const SizedBox.shrink()
              else
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
    ShippingMethodController controller, {
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
    ShippingMethodController controller,
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
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
      child: Column(
        children: [
          //partner shipping
          ListView.builder(
              shrinkWrap: true,
              itemCount: LOAI_VAN_CHUYEN.values.toList().length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    _rowShipping(
                      context,
                      controller,
                      indexRad: index,
                      shippingWidget: _shippingWidget(
                        context,
                        image: controller.imageShipping[index],
                        text1: "Loại vận chuyển",
                        text2: LOAI_VAN_CHUYEN.values.toList()[index],
                      ),
                    ),
                    if (index != LOAI_VAN_CHUYEN.values.toList().length - 1)
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
  Widget _btnBottomSheet(BuildContext context,
      {required ShippingMethodController controller}) {
    return Column(
      children: [
        BtnCustom(
          onTap: () => controller.onBtnDoneClick(),
          color: ColorResources.PRIMARY,
          text: "Hoàn tất",
          width: DeviceUtils.getScaledWidth(context, .9),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
        ),
      ],
    );
  }
}
