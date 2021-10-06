import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v1-customer/product/shipping_address/shipping_address_controller.dart';

class V1ShippingAddressPage extends GetView<V1ShippingAddressController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ShippingAddressController>(
        init: V1ShippingAddressController(),
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
                    hint: "Nhập tỉnh/thành phố",
                    value: controller.province,
                    onChanged: controller.setSelectedProvince,
                    data: controller.provinceList,
                  ),

                  //district
                  _rowTitle(context, title: "Quận huyện"),
                  DropDownButton1(
                    hint: "Nhập quận/huyện",
                    value: controller.district,
                    onChanged: controller.setSelectedDistrict,
                    data: controller.districtList,
                  ),

                  //ward
                  _rowTitle(context, title: "Phường xã"),
                  DropDownButton1(
                    hint: "Nhập phường/xã",
                    value: controller.ward,
                    onChanged: controller.setSelectedWard,
                    data: controller.wardList,
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.013),
                  ),

                  //address
                  _rowTitle(
                    context,
                    title: "Địa chỉ cụ thể nhận hàng",
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.013),
                  ),

                  InputWidget(
                    textEditingController: controller.addressController,
                    hintText: "Nhập địa chỉ cụ thể",
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.052),
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
