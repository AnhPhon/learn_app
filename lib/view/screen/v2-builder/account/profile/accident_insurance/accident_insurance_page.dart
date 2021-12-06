import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/screen/v2-builder/account/profile/accident_insurance/accident_insurance_controller.dart';

class V2AccidentInsurancePage extends GetView<V2AccidentInsuranceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2AccidentInsuranceController>(
        init: V2AccidentInsuranceController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL,
              ),
              child: Column(
                children: [
                  //tab bar
                  _tabBarWidget(context: context, controller: controller),

                  //tab view
                  _tabView(),
                ],
              ),
            ),
            bottomNavigationBar: _btnBottom(context, controller: controller),
          );
        });
  }

  ///
  /// selected tab
  ///
  Widget _onSelectedTab(
      BuildContext context, V2AccidentInsuranceController controller,
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
      required V2AccidentInsuranceController controller}) {
    return Container(
      alignment: Alignment.center,
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, .07),
      child: Row(
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
    );
  }

  ///
  ///tab view
  ///
  Widget _tabView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Specification(
          specification: (controller.currentIndex == 1)
              ? controller.baoHiemResponse.quyenLoi.toString()
              : (controller.currentIndex == 2)
                  ? controller.baoHiemResponse.boiThuong.toString()
                  : controller.baoHiemResponse.gioiThieu.toString(),
        ),
      ),
    );
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(BuildContext context,
      {required V2AccidentInsuranceController controller}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BtnCustomBorder(
            onTap: () => controller.onBtnClick(currentIndex: 0),
            text: "Bảo hiểm của bạn",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () => controller.onBtnClick(currentIndex: 1),
            color: ColorResources.PRIMARY,
            text: "Đăng ký mua",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }
}
