import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

import 'package:template/view/basewidget/component/btn_component.dart';
import 'recharge_controller.dart';

class RechargePage extends GetView<RechargeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeController>(
        init: RechargeController(),
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
                      height: Dimensions.MARGIN_SIZE_SMALL,
                    ),

                    //title account management
                    _textTitle(
                      context,
                      title: "Quản lý tài khoản",
                    ),

                    Column(
                      children: [
                        ListView.builder(
                          itemCount: controller.thongTinNganHangResponse.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Card(
                            elevation: 2,
                            margin: const EdgeInsets.all(
                                Dimensions.MARGIN_SIZE_SMALL),
                            child: ListTile(
                                leading: Radio(
                                  value: index,
                                  groupValue: controller.selected,
                                  activeColor: ColorResources.PRIMARYCOLOR,
                                  onChanged: (int? value) {
                                    controller.onChangeRadio(value!);
                                  },
                                ),
                                title: Text(controller
                                    .thongTinNganHangResponse[index].soTaiKhoan
                                    .toString()),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller
                                        .thongTinNganHangResponse[index]
                                        .tenNganHang
                                        .toString()),
                                    Text(controller
                                        .thongTinNganHangResponse[index]
                                        .tenChuTaiKhoan
                                        .toString())
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () => {
                                          controller.onChangeRadio(index),
                                          controller.onBtnCopyClick(
                                              content: controller
                                                  .thongTinNganHangResponse[
                                                      index]
                                                  .soTaiKhoan
                                                  .toString())
                                        },
                                    icon: const Icon(Icons.copy,
                                        color: ColorResources.GREEN))),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: ColorResources.BLACK),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Số tiền tối thiểu',
                                textAlign: TextAlign.center),
                            const SizedBox(
                              height: Dimensions.MARGIN_SIZE_SMALL,
                            ),
                            Text(
                                "${PriceConverter.convertPrice(
                                  context,
                                  controller.soTienToiThieu,
                                )} đ",
                                textAlign: TextAlign.center,
                                style:
                                    const TextStyle(color: ColorResources.RED)),
                          ],
                        ),
                      ),
                    ), //bank info

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //content
                    _content(context, controller: controller),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //title upload
                    _textTitle(context,
                        title: "Tải hình ảnh hoá đơn giao dịch"),

                    //upload image
                    _uploadImage(context, controller),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
                    ),

                    //btn
                    _btnAccept(controller: controller),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),
                  ],
                ),
              ),
            ),
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
                  width: Dimensions.MARGIN_SIZE_SMALL,
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
  Widget _content(BuildContext context,
      {required RechargeController controller}) {
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
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
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
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),

          //content
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "FSS-${controller.taiKhoanResponse.soDienThoai}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
              const SizedBox(
                width: Dimensions.MARGIN_SIZE_SMALL,
              ),
              GestureDetector(
                onTap: () => controller.onBtnCopyClick(
                    content: "FSS-${controller.taiKhoanResponse.soDienThoai}"),
                child: const Icon(
                  Icons.copy_outlined,
                  color: ColorResources.GREY,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
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
  Widget _uploadImage(BuildContext context, RechargeController controller) {
    return GestureDetector(
      onTap: () => controller.pickHinhHoaDon(),
      child: Container(
        child: controller.image != null
            ? Image.network(
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
  ///btn accept
  ///
  Widget _btnAccept({required RechargeController controller}) {
    return BtnCustom(
      onTap: () => controller.onCheckoutClick(),
      color: ColorResources.PRIMARY,
      text: "Xác nhận",
      width: double.infinity,
    );
  }
}
