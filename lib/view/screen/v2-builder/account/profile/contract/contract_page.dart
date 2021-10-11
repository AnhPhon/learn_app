import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/account/profile/contract/contract_controller.dart';
import 'package:template/view/screen/v2-builder/component_customer/btn_component.dart';

class V2ContractPage extends GetView<V2ContractController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ContractController>(
        init: V2ContractController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //title
                    _textTitle(context, title: "Hợp đồng nguyên tắc"),

                    //content
                    _content(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _bottomContract(context, controller),
          );
        });
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE + 2,
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
  Widget _content() {
    return Text(
      controller.content,
      textAlign: TextAlign.justify,
      style: Dimensions.fontSizeStyle16(),
    );
  }

  ///
  ///bottom contract
  ///
  Widget _bottomContract(
      BuildContext context, V2ContractController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, .25),
      color: ColorResources.WHITE,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //rules 1
          CheckboxListTile(
            checkColor: ColorResources.WHITE,
            activeColor: ColorResources.PRIMARY,
            title: const Text(
                "Tôi đồng ý và hiểu rõ nội dung hợp đồng nguyên tắc số 0989539292"),
            value: controller.isChecked1,
            onChanged: controller.setSeletedCheckBox1,
            controlAffinity: ListTileControlAffinity.leading,
          ),

          //rule2
          CheckboxListTile(
            checkColor: ColorResources.WHITE,
            activeColor: ColorResources.PRIMARY,
            title:
                const Text("Tôi đồng ý giao kết hợp đồng thông qua appweb này"),
            value: controller.isChecked2,
            onChanged: controller.setSeletedCheckBox2,
            controlAffinity: ListTileControlAffinity.leading,
          ),

          //btn accept
          BtnCustom(
            onTap: () {},
            color: ColorResources.PRIMARY,
            text: "Tôi đồng ý",
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
