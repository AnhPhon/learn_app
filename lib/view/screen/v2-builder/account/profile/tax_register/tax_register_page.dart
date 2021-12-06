import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
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
        return UnFocusTextField(
          widget: Scaffold(
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

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //tab view
                          _tabView(),

                          //tax form
                          _taxForm(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        //title
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
    return Specification(
      specification: (controller.currentIndex == 0)
          ? controller.thongTinThueResponse.gioiThieu.toString()
          : (controller.currentIndex == 1)
              ? controller.thongTinThueResponse.dangKyThue.toString()
              : controller.thongTinThueResponse.camKetThue.toString(),
    );
  }

  ///
  ///tax form
  ///
  Widget _taxForm(BuildContext context) {
    return GetBuilder<V2TaxRegisterController>(
      builder: (controller) {
        return (controller.currentIndex == 0)
            ? const SizedBox.shrink()
            : Column(
                children: [
                  //input
                  if (controller.currentIndex == 1)
                    InputWidget(
                      label: "Cập nhập mã số thuế (nếu đã đăng ký)",
                      labelBold: true,
                      width: .9,
                      height: .06,
                      isShadow: true,
                      textEditingController: controller.taxController,
                      hintText: "Nhập mã số thuế",
                      allowEdit: controller.isUpdateDangKy ||
                          controller.dangKyThueResponse[0].id == null,
                      fillColor: ColorResources.WHITE,
                    ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_SMALL,
                  ),

                  //upload image
                  ImageListHorizontalAdd(
                    label: "Tải hình ảnh bản cứng (nếu có)",
                    pickImage: () => controller.pickImages(),
                    labelBold: true,
                    imageFileList:
                        controller.hinhAnhs[controller.currentIndex - 1],
                    height: .15,
                    isAddImage: controller.currentIndex == 1
                        ? controller.isUpdateDangKy ||
                            controller.dangKyThueResponse[0].id == null
                        : controller.isUpdateCamKet ||
                            controller.dangKyThueResponse[1].id == null,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                    ),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //btn
                  if (controller.currentIndex == 1)
                    BtnCustom(
                      onTap: (controller.isUpdateDangKy == false &&
                              controller.dangKyThueResponse[0].id == null)
                          ? () => controller.onBtnDoneClick()
                          : () => controller.onBtnUpdate(),
                      color: ColorResources.PRIMARY,
                      text: controller.isUpdateDangKy ||
                              controller.dangKyThueResponse[0].id == null
                          ? "Hoàn thành"
                          : "Chỉnh sửa",
                      width: DeviceUtils.getScaledWidth(context, .9),
                    )
                  else
                    BtnCustom(
                      onTap: (controller.isUpdateCamKet == false &&
                              controller.dangKyThueResponse[1].id == null)
                          ? () => controller.onBtnDoneClick()
                          : () => controller.onBtnUpdate(),
                      color: ColorResources.PRIMARY,
                      text: controller.isUpdateCamKet ||
                              controller.dangKyThueResponse[1].id == null
                          ? "Hoàn thành"
                          : "Chỉnh sửa",
                      width: DeviceUtils.getScaledWidth(context, .9),
                    ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                ],
              );
      },
    );
  }
}
