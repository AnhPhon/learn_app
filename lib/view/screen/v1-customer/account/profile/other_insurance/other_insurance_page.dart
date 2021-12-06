import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/screen/v1-customer/account/profile/other_insurance/other_insurance_controller.dart';

class V1OtherInsurancePage extends GetView<V1OtherInsuranceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1OtherInsuranceController>(
        init: V1OtherInsuranceController(),
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
                  //image
                  _image(context),

                  //option insurance
                  _optionInsurance(controller: controller),

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
            bottomNavigationBar: _btnBottom(context, controller: controller),
          );
        });
  }

  ///
  ///image
  ///
  Widget _image(BuildContext context) {
    return Image.asset(
      Images.insurance,
      fit: BoxFit.fill,
      height: DeviceUtils.getScaledHeight(context, .3),
      width: double.infinity,
    );
  }

  ///
  ///option insurance List
  ///
  Widget _optionInsurance({required V1OtherInsuranceController controller}) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.baoHiemResponse.length,
        itemBuilder: (BuildContext ctx, int index) {
          return CheckboxListTile(
            checkColor: ColorResources.WHITE,
            activeColor: ColorResources.PRIMARY,
            value: controller.isChecked![index],
            title: Text(controller.baoHiemResponse[index].ten.toString()),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) =>
                controller.setChecked(index: index, value: value),
          );
        });
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(BuildContext context,
      {required V1OtherInsuranceController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BtnCustom(
            onTap: () {
              Get.dialog(
                dialogRegister(
                  context,
                  note: "Bạn có chắc chắn muốn đăng ký tư vấn bảo hiểm",
                  onTap: () => controller.dangKyTuVanBtn(context),
                  controller: controller,
                ),
              );
            },
            color: ColorResources.PRIMARY,
            text: "Đăng ký tư vấn",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () {
              Get.dialog(
                dialogRegister(
                  context,
                  note: "Bạn có chắc chắn muốn đăng ký mua bảo hiểm",
                  onTap: () => controller.dangKyMuaBtn(context),
                  controller: controller,
                ),
              );
            },
            color: ColorResources.PRIMARY,
            text: "Đăng ký mua",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }

  ///
  ///dialog register
  ///
  Widget dialogRegister(
    BuildContext context, {
    required String note,
    required VoidCallback onTap,
    required V1OtherInsuranceController controller,
  }) {
    return Center(
      child: Container(
        height: DeviceUtils.getScaledHeight(context, .35),
        margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
        ),
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_DEFAULT,
        ),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //title
            const Text(
              "Xác nhận",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(
              color: ColorResources.GREY,
              height: 0,
            ),

            //note
            Flexible(
              child: Text(
                note,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                ),
              ),
            ),

            const SizedBox(
              height: Dimensions.MARGIN_SIZE_LARGE,
            ),

            //btn
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //accept
                BtnCustomBorder(
                  onTap: onTap,
                  text: "Đồng ý",
                  width: DeviceUtils.getScaledWidth(context, 0.35),
                ),

                const SizedBox(
                  width: Dimensions.MARGIN_SIZE_SMALL,
                ),

                //cancel
                BtnCustom(
                  onTap: () => Get.back(),
                  color: ColorResources.PRIMARY,
                  text: "Huỷ",
                  width: DeviceUtils.getScaledWidth(context, 0.35),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
