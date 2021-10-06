import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/row_text.dart';
import 'package:template/view/screen/v1-customer/recharge/recharge_controller.dart';

class V1RechargePage extends GetView<V1RechargeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1RechargeController>(
        init: V1RechargeController(),
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
                    _textTitle(
                      context,
                      title: "Hướng dẫn thực hiện thanh toán",
                    ),

                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),

                    //title account management
                    _textTitle(
                      context,
                      title: "Quản lý tài khoản",
                    ),

                    //bank info
                    const RowText(
                      text1: "Ngân hàng nhận",
                      text2: "MB",
                      notFontWeight: true,
                      notFontSize: true,
                    ),
                    _row3Widget(
                      context,
                      text1: "Số tài khoản",
                      text2: "8000.111.68.68.68",
                      onTap: () {},
                      icon: const Icon(
                        Icons.copy_outlined,
                        color: ColorResources.GREY,
                      ),
                    ),
                    const RowText(
                      text1: "Người nhận",
                      text2: "Công ty FIve Star System",
                      notFontWeight: true,
                      notFontSize: true,
                    ),
                    const RowText(
                      text1: "Số tiền tối thiểu",
                      text2: "20.000đ",
                      notFontWeight: true,
                      notFontSize: true,
                    ),

                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT,
                    ),

                    //content
                    _content(context),

                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT,
                    ),

                    //title upload
                    _textTitle(context,
                        title: "Tải hình ảnh hoá đơn giao dịch"),

                    //upload image
                    _uploadImage(context, controller),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _btnBottomSheet(controller),
          );
        });
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_SMALL,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  ///
  ///row 3 widget
  ///
  Widget _row3Widget(BuildContext context,
      {required String text1,
      required String text2,
      required Icon icon,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_LARGE,
          color: ColorResources.BLACK,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Text(
                  text2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: Dimensions.PADDING_SIZE_SMALL,
                ),
                GestureDetector(onTap: onTap, child: icon),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_DEFAULT,
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.GREY),
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          //title
          const Text(
            "Nội dung chuyển khoản (bắt buộc)",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),

          const SizedBox(
            height: Dimensions.PADDING_SIZE_SMALL,
          ),

          //content
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "FSS686868",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
              const SizedBox(
                width: Dimensions.PADDING_SIZE_SMALL,
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.copy_outlined,
                  color: ColorResources.GREY,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: Dimensions.PADDING_SIZE_SMALL,
          ),

          //note
          const Text(
            "Chụp màn hình giao dịch để cập nhật thông tin nhanh hơn",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorResources.RED,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(BuildContext context, V1RechargeController controller) {
    return GestureDetector(
      onTap: () => controller.pickImage(),
      child: Container(
        child: controller.image != null
            ? Image.file(
                controller.image!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                Images.add_image,
                height: DeviceUtils.getScaledHeight(context, .092),
                width: DeviceUtils.getScaledWidth(context, .25),
                fit: BoxFit.fill,
                color: ColorResources.PRIMARY,
              ),
      ),
    );
  }

  ///
  ///btn bottomsheet
  ///
  Widget _btnBottomSheet(V1RechargeController controller) {
    return BtnCustom(
      onTap: () => controller.onCheckoutClick(),
      color: ColorResources.PRIMARY,
      text: "Xác nhận",
      width: double.infinity,
    );
  }
}
