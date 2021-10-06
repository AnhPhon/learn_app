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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<V1RechargeController>(
        init: V1RechargeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //title
                    _textTitle(
                      context,
                      height,
                      title: "Hướng dẫn thực hiện thanh toán",
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, 10 / height),
                    ),

                    //title account management
                    _textTitle(
                      context,
                      height,
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
                      height,
                      width,
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

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, 15 / height),
                    ),

                    //content
                    _content(context, height, width),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, 15 / height),
                    ),

                    //title upload
                    _textTitle(context, height,
                        title: "Tải hình ảnh hoá đơn giao dịch"),

                    //upload image
                    _uploadImage(controller),
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
  Widget _textTitle(BuildContext context, double height,
      {required String title}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledHeight(context, 10 / height),
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
  Widget _row3Widget(BuildContext context, double height, double width,
      {required String text1,
      required String text2,
      required Icon icon,
      required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 10 / width),
          vertical: DeviceUtils.getScaledHeight(context, 8 / height)),
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
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 0.025),
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
  Widget _content(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 15 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 25 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 20 / width),
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

          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 10 / height),
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
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, 10 / width),
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

          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 10 / height),
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
  Widget _uploadImage(V1RechargeController controller) {
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
                height: 70,
                width: 100,
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
