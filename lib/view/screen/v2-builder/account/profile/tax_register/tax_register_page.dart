import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v2-builder/account/profile/tax_register/tax_register_controller.dart';

class V2TaxRegisterPage extends GetView<V2TaxRegisterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2TaxRegisterController>(
      init: V2TaxRegisterController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
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
          bottomNavigationBar: bottom(context),
        );
      },
    );
  }

  ///
  /// selected tab
  ///
  Widget _onSelectedTab(
      BuildContext context, V2TaxRegisterController controller,
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
      required V2TaxRegisterController controller}) {
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
    return GetBuilder<V2TaxRegisterController>(
      builder: (controller) {
        return (controller.currentIndex == 0)
            ? const SizedBox.shrink()
            : Container(
                height: DeviceUtils.getScaledHeight(
                    context, (controller.currentIndex == 2) ? .3 : .4),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                    topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  ),
                  color: ColorResources.WHITE,
                  boxShadow: boxShadowMedium,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      //input
                      if (controller.currentIndex == 2)
                        const SizedBox.shrink()
                      else
                        InputWidget(
                          label: "Cập nhập mã số thuế (nếu đã đăng ký)",
                          labelBold: true,
                          width: .9,
                          height: .06,
                          isShadow: true,
                          textEditingController: controller.taxController,
                          hintText: "Nhập mã số thuế",
                          allowEdit: controller
                                  .dangKyThueResponse[
                                      controller.currentIndex - 1]
                                  .id ==
                              null,
                          fillColor: ColorResources.WHITE,
                        ),

                      Label(
                        label: "Tải hình ảnh bản cứng (nếu có)",
                        obligatory: false,
                        horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
                        topPadding: (controller.currentIndex == 2)
                            ? 0
                            : Dimensions.PADDING_SIZE_SMALL,
                      ),

                      //upload image
                      ImageListHorizontalAdd(
                        pickImage: () => controller.pickImages(),
                        labelBold: true,
                        imageFileList:
                            controller.hinhAnhs[controller.currentIndex - 1],
                        height: .15,
                        isAddImage: controller
                                .dangKyThueResponse[controller.currentIndex - 1]
                                .id ==
                            null,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE * 3,
                        ),
                      ),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      if (controller
                              .dangKyThueResponse[controller.currentIndex - 1]
                              .id ==
                          null)
                        BtnCustom(
                          onTap: () => controller.onBtnDoneClick(),
                          color: ColorResources.PRIMARY,
                          text: "Hoàn thành",
                          width: DeviceUtils.getScaledWidth(context, .9),
                        ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
