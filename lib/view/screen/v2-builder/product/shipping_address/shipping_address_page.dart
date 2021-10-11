import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/v2-builder/component_builder/btn_component.dart';
import 'package:template/view/screen/v2-builder/component_builder/input_widget.dart';
import 'package:template/view/screen/v2-builder/product/shipping_address/shipping_address_controller.dart';

class V2ShippingAddressPage extends GetView<V2ShippingAddressController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShippingAddressController>(
        init: V2ShippingAddressController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            backgroundColor: ColorResources.WHITE,
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                children: [
                  //province
                  _rowTitle(context, title: "Tỉnh thành phố"),
                  DropDownButton1(
<<<<<<< HEAD
                    width: DeviceUtils.getScaledWidth(context, 1),
=======
                    width: DeviceUtils.getScaledWidth(context,1),
>>>>>>> origin/develop
                    hint: "Nhập tỉnh/thành phố",
                    value: controller.province,
                    onChanged: controller.setSelectedProvince,
                    data: controller.provinceList,
                  ),

                  //district
                  _rowTitle(context, title: "Quận huyện"),
                  DropDownButton1(
<<<<<<< HEAD
                    width: DeviceUtils.getScaledWidth(context, 1),
=======
                    width: DeviceUtils.getScaledWidth(context,1),

>>>>>>> origin/develop
                    hint: "Nhập quận/huyện",
                    value: controller.district,
                    onChanged: controller.setSelectedDistrict,
                    data: controller.districtList,
                  ),

                  //ward
                  _rowTitle(context, title: "Phường xã"),
                  DropDownButton1(
<<<<<<< HEAD
                    width: DeviceUtils.getScaledWidth(context, 1),
=======
                    width: DeviceUtils.getScaledWidth(context,1),

>>>>>>> origin/develop
                    hint: "Nhập phường/xã",
                    value: controller.ward,
                    onChanged: controller.setSelectedWard,
                    data: controller.wardList,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_SMALL,
                  ),

                  //address
                  _rowTitle(
                    context,
                    title: "Địa chỉ cụ thể nhận hàng",
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_SMALL,
                  ),

                  InputWidget(
                    textEditingController: controller.addressController,
                    hintText: "Nhập địa chỉ cụ thể",
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE * 2,
                  ),

                  //btn
                  BtnCustom(
                    onTap: () {},
                    color: ColorResources.PRIMARY,
                    text: "Cập nhật",
                    width: DeviceUtils.getScaledWidth(context, .5),
                  )
                ],
              ),
            )),
          );
        });
  }

  ///
  ///row title
  ///
  Widget _rowTitle(BuildContext context, {required String title}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_SMALL,
        ),
        child: RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: ColorResources.BLACK),
            children: const [
              TextSpan(
                text: "*",
                style: TextStyle(color: ColorResources.RED),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
