import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v3-agent/account/profile/tax_register/tax_register_controller.dart';

class V3TaxRegisterPage extends GetView<V3TaxRegisterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3TaxRegisterController>(
      init: V3TaxRegisterController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBarWidget(title: controller.title),
          body: Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Column(
              children: [
                //tab bar
                _tabBarWidget(context: context, controller: controller),

                _tabView(),
              ],
            ),
          ),
          bottomNavigationBar: bottom(context),
        );
      },
    );
  }

  ///
  /// selected tab
  ///
  Widget _onSelectedTab(
      BuildContext context, V3TaxRegisterController controller,
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
      required V3TaxRegisterController controller}) {
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
            title: controller.titleTabBar['DK']!,
            index: 1,
          ),
          _onSelectedTab(
            context,
            controller,
            title: controller.titleTabBar['CK']!,
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
          specification: (controller.currentIndex == 0)
              ? controller.thongTinThueResponse.gioiThieu.toString()
              : (controller.currentIndex == 1)
                  ? controller.thongTinThueResponse.dangKyThue.toString()
                  : controller.thongTinThueResponse.camKetThue.toString(),
        ),
      ),
    );
  }

  ///
  ///btn bottom
  ///
  Widget bottom(BuildContext context) {
    return GetBuilder<V3TaxRegisterController>(
      builder: (controller) {
        return (controller.currentIndex == 2)
            ? Container(
                height: DeviceUtils.getScaledHeight(context,
                    (controller.dangKyThueResponse == null) ? .3 : .25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                    topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  ),
                  color: ColorResources.WHITE,
                  boxShadow: boxShadowMedium,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_SMALL,
                    ),

                    Label(
                      label: "Tải hình ảnh bản cứng (nếu có)",
                      obligatory: false,
                      horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
                      topPadding: (controller.currentIndex == 2)
                          ? 0
                          : Dimensions.PADDING_SIZE_DEFAULT,
                    ),

                    //upload image
                    ImageListHorizontalAdd(
                      pickImage: () => controller.pickImages(),
                      labelBold: true,
                      imageFileList:
                          controller.dangKyThueRequest.hinhAnhs ?? [],
                      height: .15,
                      isAddImage: controller.dangKyThueResponse == null,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_LARGE,
                      ),
                    ),

                    const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    if (controller.dangKyThueResponse == null)
                      BtnCustom(
                        onTap: () => controller.onBtnDoneClick(),
                        color: ColorResources.PRIMARY,
                        text: "Hoàn thành",
                        width: DeviceUtils.getScaledWidth(context, .9),
                      ),
                  ],
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
