import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/screen/v2-builder/account/profile/contract/contract_controller.dart';

class V2ContractPage extends GetView<V2ContractController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ContractController>(
      init: V2ContractController(),
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
                //title
                _textTitle(context, title: "Hợp đồng nguyên tắc"),

                //content
                _content(controller: controller),
              ],
            ),
          ),
          bottomNavigationBar: (controller.dangKyHopDongSBSResponse == null)
              ? _bottomContract(context, controller: controller)
              : null,
        );
      },
    );
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        title,
        style: Dimensions.fontSizeStyle22w600(),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content({required V2ContractController controller}) {
    return Specification(
      specification:
          controller.thongTinDangKyHopDongResponse!.noiDung.toString(),
    );
  }

  ///
  ///bottom contract
  ///
  Widget _bottomContract(BuildContext context,
      {required V2ContractController controller}) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, .3),
      color: ColorResources.WHITE,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //rules 1
          CheckboxListTile(
            checkColor: ColorResources.WHITE,
            activeColor: ColorResources.PRIMARY,
            title: const Text(
                "Tôi đồng ý và hiểu rõ nội dung hợp đồng nguyên tắc số 0989539292"),
            value: controller.isChecked1,
            onChanged: (val) => controller.setSeletedCheckBox1(value: val),
            controlAffinity: ListTileControlAffinity.leading,
          ),

          //rule2
          CheckboxListTile(
            checkColor: ColorResources.WHITE,
            activeColor: ColorResources.PRIMARY,
            title:
                const Text("Tôi đồng ý giao kết hợp đồng thông qua appweb này"),
            value: controller.isChecked2,
            onChanged: (val) => controller.setSeletedCheckBox2(value: val),
            controlAffinity: ListTileControlAffinity.leading,
          ),

          const Spacer(),

          //btn accept
          BtnCustom(
            onTap: () => controller.onBtnAceptClick(context),
            color: ColorResources.PRIMARY,
            text: "Tôi đồng ý",
            width: DeviceUtils.getScaledWidth(context, .9),
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
        ],
      ),
    );
  }
}
