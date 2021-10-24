import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v2-builder/product/shipping_address/shipping_address_controller.dart';

class V2ShippingAddressPage extends GetView<V2ShippingAddressController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShippingAddressController>(
        init: V2ShippingAddressController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(
              title: controller.title
            ),
            backgroundColor: ColorResources.WHITE,
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //province
                  DropDownButton1<TinhTpResponse>(
                    label: "Tỉnh thành phố",
                    hint: "Nhập tỉnh/thành phố",
                    obligatory: true,
                    labelBold: true,
                    value: controller.tinhTpResponse,
                    onChanged: controller.setSelectedTinhTp,
                    data: controller.tinhTpList,
                    width: double.infinity,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //district
                  DropDownButton1<QuanHuyenResponse>(
                    label: "Quận huyện",
                    hint: "Nhập quận/huyện",
                    obligatory: true,
                    labelBold: true,
                    value: controller.quanHuyenResponse,
                    onChanged: controller.setSelectedQuanHuyen,
                    data: controller.quanHuyenList,
                    width: double.infinity,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //ward
                  DropDownButton1<PhuongXaResponse>(
                    label: "Phường xã",
                    hint: "Nhập phường/xã",
                    obligatory: true,
                    labelBold: true,
                    value: controller.phuongXaResponse,
                    onChanged: controller.setSelectedPhuongXa,
                    data: controller.phuongXaList,
                    width: double.infinity,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //address
                  InputWidget(
                    width: double.infinity,
                    label: "Địa chỉ cụ thể",
                    obligatory: true,
                    labelBold: true,
                    textEditingController: controller.addressController,
                    hintText: "Nhập địa chỉ cụ thể",
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE * 2,
                  ),

                  //btn
                  BtnCustom(
                    onTap: () => controller.updateAddress(context),
                    color: ColorResources.PRIMARY,
                    text: "Cập nhật",
                    width: DeviceUtils.getScaledWidth(context, .95),
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
  Widget rowTitle(BuildContext context, {required String title}) {
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
