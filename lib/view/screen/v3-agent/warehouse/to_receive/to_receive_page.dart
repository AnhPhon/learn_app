import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/screen/v3-agent/warehouse/to_receive/to_receive_controller.dart';

class V3ToReceivePage extends GetView<V3ToReceiveController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ToReceiveController>(
      init: V3ToReceiveController(),
      builder: (controller) {
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Column(
                  children: [
                    //dropdown product
                    DropDownButton1<SanPhamResponse>(
                      hint: "Chọn sản phẩm",
                      label: "Sản phẩm",
                      labelBold: true,
                      obligatory: true,
                      value: controller.sanPhamResponse,
                      onChanged: controller.onchangedSanPham,
                      data: controller.sanPhamList,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      fillColor: ColorResources.WHITE,
                    ),

                    //dropdown warehouse
                    DropDownButton1<KhoHangDaiLyResponse>(
                      hint: "Chọn kho hàng",
                      label: "Kho hàng",
                      labelBold: true,
                      obligatory: true,
                      value: controller.khoHangDaiLyResponse,
                      onChanged: controller.onchangedKhoHangDaiLy,
                      data: controller.khoHangDaiLyList,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      fillColor: ColorResources.WHITE,
                    ),

                    //stock
                    InputWidget(
                      hintText: "Số lượng",
                      label: "Số lượng",
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.stockController,
                      fillColor: ColorResources.WHITE,
                      textInputType: TextInputType.number,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //btn
                    BtnCustom(
                      onTap: () => controller.onUpdateClick(),
                      color: ColorResources.PRIMARY,
                      text: "Cập nhật",
                      width: DeviceUtils.getScaledWidth(context, .95),
                      margin: const EdgeInsets.only(
                        top: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
