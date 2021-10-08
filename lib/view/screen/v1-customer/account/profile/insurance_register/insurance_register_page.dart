import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/insurance_register/insurance_register_controller.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/tab_bar_widget.dart';

class V1InsuranceRegisterPage extends GetView<V1InsuranceRegisterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1InsuranceRegisterController>(
        init: V1InsuranceRegisterController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //tab bar
                  _tabBarWidget(context: context, controller: controller),

                  //title
                  _textTitle(context,
                      title: "Bạn vui lòng chọn mức phí phù hợp"),

                  //red fee list
                  _radFeeList(controller),
                ],
              ),
            ),
            bottomNavigationBar: _btnBottom(controller),
          );
        });
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V1InsuranceRegisterController controller}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .07),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.titleTabBar.length,
          itemBuilder: (BuildContext context, int index) {
            return TabBarWidget(
                onTap: () => controller.onChangeTab(index),
                index: index,
                currentIndex: controller.currentIndex,
                title: controller.titleTabBar[index].toString());
          }),
    );
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
        style: Dimensions.fontSizeStyle20w600(),
      ),
    );
  }

  ///
  ///fee List
  ///
  Widget _radFeeList(V1InsuranceRegisterController controller) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.feeList.length,
        itemBuilder: (BuildContext ctx, int index) {
          return RadioListTile(
            title: Text(
              controller.feeList[index].toString(),
            ),
            value: index,
            activeColor: ColorResources.PRIMARY,
            groupValue: controller.indexFee,
            onChanged: controller.setSelectedIndexFee,
          );
        });
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(V1InsuranceRegisterController controller) {
    return BtnCustom(
      onTap: () => controller.onCheckoutClick(),
      color: ColorResources.PRIMARY,
      text: "Thanh toán",
      width: double.infinity,
    );
  }
}
