import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v2-builder/payment_order/payment_order_controller.dart';

class V2PaymentOrderPage extends GetView<V2PaymentOrderController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2PaymentOrderController>(
        init: V2PaymentOrderController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: BoxShadowWidget(
                  child: Column(
                children: [
                  //title
                  _title(),

                  //content
                  _content(),

                  //note
                  _note(),

                  const Divider(
                    color: ColorResources.GREY,
                  ),
                ],
              )),
            ),
            bottomNavigationBar: _btnBottom(context, controller),
          );
        });
  }

  ///
  ///text title
  ///
  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Text(
        "Thông tin đơn hàng",
        style: Dimensions.fontSizeStyle20w600(),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content() {
    return Column(
      children: [
        RowText(
          text1: "Tiền cọc giữ việc",
          text2: "${CurrencyConverter.currencyConverterVND(controller.tienCoc * 1.0).toString()} VNĐ",
          notFontWeight: true,
          notFontSize: true,
        ),
        RowText(
          text1: "Phí dịch vụ",
          text2: "${CurrencyConverter.currencyConverterVND(controller.phiDichVu * 1.0)} VNĐ",
          notFontWeight: true,
          notFontSize: true,
        ),
        RowText(
          text1: "Khuyến mãi",
          text2: "${CurrencyConverter.currencyConverterVND(controller.khuyenMai * 1.0)} VNĐ",
          notFontWeight: true,
          notFontSize: true,
        ),
        RowText(
          text1: "Tổng tiền",
          text2: "${CurrencyConverter.currencyConverterVND(controller.tongTien * 1.0)} VNĐ",
          colorRed: true,
        ),
        const Divider(
          color: ColorResources.GREY,
        ),
      ],
    );
  }

  ///
  ///note
  ///
  Widget _note() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          Text(
            "Tiền cọc của bạn sẽ được cộng lại tài khoản khi bạn hoàn thành công việc. Nếu bạn bỏ việc đã nhận với 1 lý do không chính đáng thì tiền cọc sẽ bị mất",
            textAlign: TextAlign.center,
            style: Dimensions.fontSizeStyle18().copyWith(
              color: ColorResources.RED,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(BuildContext context, V2PaymentOrderController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BtnCustom(
            onTap: () => controller.onCancleClick(),
            color: ColorResources.RED,
            text: "Hủy",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () => controller.onCheckoutClick(),
            color: ColorResources.PRIMARY,
            text: "Đồng ý",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }
}
