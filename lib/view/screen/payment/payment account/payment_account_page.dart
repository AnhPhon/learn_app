import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'payment_account_controller.dart';

class PaymentAccountPage extends GetView<PaymentAccountController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PaymentAccountController(),
        builder: (PaymentAccountController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tài khoản của bạn'),
              centerTitle: true,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      controller.showDialogBack();
                    },
                  );
                },
              ),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(
                vertical: Dimensions.MARGIN_SIZE_DEFAULT,
                horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                horizontal: Dimensions.PADDING_SIZE_LARGE,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                  ),
                ],
                color: ColorResources.WHITE,
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //title
                    _textTitle(
                      context,
                      title: "Quản lý tài khoản",
                    ),

                    //detail
                    RowText(
                      text1: "Số dư của bạn",
                      text2: "${PriceConverter.convertPrice(
                        context,
                        controller.soDuTaiKhoan,
                      )} đ",
                      notFontWeight: true,
                      notFontSize: true,
                      colorRed: true,
                    ),
                    RowText(
                      text1: "Số tiền cần thanh toán",
                      text2: "${PriceConverter.convertPrice(
                        context,
                        controller.tongTienThanhToan,
                      )} đ",
                      notFontWeight: true,
                      notFontSize: true,
                      colorRed: true,
                    ),
                    RowText(
                      text1: "Số dư còn lại",
                      text2: controller.isShowSoDu
                          ? "Tài khoản không đủ"
                          : "${PriceConverter.convertPrice(
                              context,
                              controller.soDuConLai,
                            )} đ",
                      notFontWeight: true,
                      notFontSize: true,
                      colorRed: true,
                    ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //btn checkout
                    BtnCustom(
                      onTap: () => controller.isShowSoDu
                          ? null
                          : controller.showDialogAccept(),
                      color: controller.isShowSoDu
                          ? ColorResources.GREY
                          : ColorResources.PRIMARY,
                      text: "Đồng ý thanh toán",
                      width: DeviceUtils.getScaledWidth(context, .7),
                    ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //note
                    const Text(
                      "(Nếu số dư lớn hơn hoặc bằng số tiền thanh toán thì bạn chọn đồng ý thanh toán, lúc này tài khoản sẽ tự trừ qua app)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorResources.RED),
                    ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //btn put money into an account
                    BtnCustom(
                      onTap: () => controller.isShowSoDu
                          ? controller.onRechargeClick()
                          : null,
                      color: controller.isShowSoDu
                          ? ColorResources.PRIMARY
                          : ColorResources.GREY,
                      text: "Nạp tiền",
                      width: DeviceUtils.getScaledWidth(context, .7),
                    ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //note
                    const Text(
                      "Nếu bạn nộp dư thì số dư sẽ được tích lũy",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorResources.RED),
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
            fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
