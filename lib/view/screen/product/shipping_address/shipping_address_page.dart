import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/screen/product/shipping_address/shipping_address_controller.dart';

class ShippingAddressPage extends GetView<ShippingAddressController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShippingAddressController>(
      init: ShippingAddressController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
                SearchDropDownButton<TinhTpResponse>(
                  label: "Tỉnh thành phố",
                  hint: "Nhập tỉnh/thành phố",
                  obligatory: true,
                  data: controller.tinhTpList,
                  width: double.infinity,
                  value: controller.tinhTpResponse,
                  fillColor: ColorResources.WHITE,
                  isEnable: controller.tinhTpList.isNotEmpty,
                  onChanged: controller.tinhTpList.isNotEmpty
                      ? controller.setSelectedTinhTp
                      : null,
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                ),

                //district
                SearchDropDownButton<QuanHuyenResponse>(
                  label: "Quận huyện",
                  hint: "Nhập quận/huyện",
                  obligatory: true,
                  data: controller.quanHuyenList,
                  width: double.infinity,
                  value: controller.quanHuyenResponse,
                  fillColor: ColorResources.WHITE,
                  isEnable: controller.quanHuyenList.isNotEmpty,
                  onChanged: controller.quanHuyenList.isNotEmpty
                      ? controller.setSelectedQuanHuyen
                      : null,
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                ),

                //ward
                SearchDropDownButton<PhuongXaResponse>(
                  label: "Phường xã",
                  hint: "Nhập phường/xã",
                  obligatory: true,
                  data: controller.phuongXaList,
                  width: double.infinity,
                  value: controller.phuongXaResponse,
                  fillColor: ColorResources.WHITE,
                  isEnable: controller.phuongXaList.isNotEmpty,
                  onChanged: controller.phuongXaList.isNotEmpty
                      ? controller.setSelectedPhuongXa
                      : null,
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                ),

                //address
                InputWidget(
                  width: double.infinity,
                  label: "Địa chỉ cụ thể",
                  obligatory: true,
                  labelBold: true,
                  textEditingController: controller.addressController,
                  hintText: "Nhập địa chỉ cụ thể",
                  fillColor: ColorResources.WHITE,
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
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
      },
    );
  }
}
