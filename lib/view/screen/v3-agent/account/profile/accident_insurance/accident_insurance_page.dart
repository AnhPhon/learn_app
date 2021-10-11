import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/profile/accident_insurance/accident_insurance_controller.dart';
import 'package:template/view/screen/v3-agent/component_customer/btn_component.dart';

class V3AccidentInsurancePage extends GetView<V3AccidentInsuranceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3AccidentInsuranceController>(
        init: V3AccidentInsuranceController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_LARGE,
              ),
              child: Column(
                children: [
                  //tab bar
                  _tabBarWidget(context: context, controller: controller),

                  const Spacer(),

                  //btn bottom
                  _btnBottom(context, controller),
                ],
              ),
            ),
          );
        });
  }

  ///
  /// selected tab
  ///
  Widget _onSelectedTab(
      BuildContext context, V3AccidentInsuranceController controller,
      {required String title, required int index}) {
    return GestureDetector(
      onTap: () {
        controller.onChangeTab(index);
      },
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: DeviceUtils.getScaledWidth(context, .999).roundToDouble() / 3,
        decoration: BoxDecoration(
          color: controller.currentIndex == index
              ? ColorResources.PRIMARY
              : ColorResources.WHITE,
          border: controller.currentIndex == index
              ? null
              : Border.all(color: ColorResources.PRIMARY),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: controller.currentIndex == index
                ? ColorResources.WHITE
                : ColorResources.BLACK,
          ),
        ),
      ),
    );
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V3AccidentInsuranceController controller}) {
    return Container(
      alignment: Alignment.center,
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, .1),
      child: Container(
        alignment: Alignment.center,
        width: DeviceUtils.getScaledWidth(context, 1),
        height: DeviceUtils.getScaledHeight(context, .07),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _onSelectedTab(
              context,
              controller,
              title: controller.titleTabBar['GT']!,
              index: 0,
            ),
            _onSelectedTab(
              context,
              controller,
              title: controller.titleTabBar['QL']!,
              index: 1,
            ),
            _onSelectedTab(
              context,
              controller,
              title: controller.titleTabBar['BT']!,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(
      BuildContext context, V3AccidentInsuranceController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BtnCustom(
          onTap: () => controller.onYourInsurancePageClick(),
          color: ColorResources.GREY,
          text: "Bảo hiểm của bạn",
          width: DeviceUtils.getScaledWidth(context, .4),
          isPadding: true,
        ),
        const SizedBox(
          width: Dimensions.MARGIN_SIZE_SMALL,
        ),
        BtnCustom(
          onTap: () => controller.onRegisterClick(),
          color: ColorResources.PRIMARY,
          text: "Đăng ký mua bảo hiểm",
          width: DeviceUtils.getScaledWidth(context, .4),
          isPadding: true,
        ),
      ],
    );
  }
}
