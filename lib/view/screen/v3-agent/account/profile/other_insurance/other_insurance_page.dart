import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/profile/other_insurance/other_insurance_controller.dart';
import 'package:template/view/screen/v3-agent/component_customer/btn_component.dart';

class V3OtherInsurancePage extends GetView<V3OtherInsuranceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3OtherInsuranceController>(
        init: V3OtherInsuranceController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //image
                  _image(context),

                  //option insurance
                  _optionInsurance(controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //detail
                  GestureDetector(
                    onTap: () => controller.onInsuranceDetailClick(),
                    child: Text(
                      "Xem chi tiết các loại bảo hiểm",
                      style: Dimensions.fontSizeStyle16w600().copyWith(
                        color: ColorResources.PRIMARY,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _btnBottom(context, controller),
          );
        });
  }

  ///
  ///image
  ///
  Widget _image(BuildContext context) {
    return Image.asset(
      Images.newsTemplate,
      fit: BoxFit.fill,
      height: DeviceUtils.getScaledHeight(context, .3),
      width: double.infinity,
    );
  }

  ///
  ///option insurance List
  ///
  Widget _optionInsurance(V3OtherInsuranceController controller) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.optionInsuranceList.length,
        itemBuilder: (BuildContext ctx, int index) {
          return CheckboxListTile(
            checkColor: ColorResources.WHITE,
            activeColor: ColorResources.PRIMARY,
            value: controller.isChecked![index],
            title: Text(controller.optionInsuranceList[index].toString()),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) => controller.setChecked(index, value),
          );
        });
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(
      BuildContext context, V3OtherInsuranceController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BtnCustom(
            onTap: () {},
            color: ColorResources.PRIMARY,
            text: "Đăng ký tư vấn",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () {},
            color: ColorResources.PRIMARY,
            text: "Đăng ký mua",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }
}
