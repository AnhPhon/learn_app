import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/row_text.dart';
import 'package:template/view/screen/v3-agent/bill_detail_is_buy/bill_detail_is_buy_controller.dart';
import 'package:template/view/screen/v3-agent/component_agent/btn_component.dart';

class V3BillDetailIsBuyPage extends GetView<V3BillDetailIsBuyController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3BillDetailIsBuyController>(
        init: V3BillDetailIsBuyController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Container(
              height: DeviceUtils.getScaledHeight(context, .5),
              margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.MARGIN_SIZE_SMALL,
                vertical: Dimensions.MARGIN_SIZE_DEFAULT,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL,
              ),
              decoration: BoxDecoration(
                color: ColorResources.WHITE,
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.25),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  //title
                  _title(),

                  //content
                  _content(),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //note
                  _note(),
                ],
              ),
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
      children: const [
        RowText(
          text1: "Giá trị đơn hàng",
          text2: "100.000 VNĐ",
          notFontWeight: true,
          notFontSize: true,
        ),
        RowText(
          text1: "Phí vận chuyển, giao hàng",
          text2: "7.500 VNĐ",
          notFontWeight: true,
          notFontSize: true,
        ),
        RowText(
          text1: "Phí dịch vụ app",
          text2: "7.500 VNĐ",
          notFontWeight: true,
          notFontSize: true,
        ),
        RowText(
          text1: "Khuyến mãi của app",
          text2: "7.500 VNĐ",
          notFontWeight: true,
          notFontSize: true,
        ),
        RowText(
          text1: "Tổng tiền đơn hàng",
          text2: "117.500 VNĐ",
          colorRed: true,
        ),
      ],
    );
  }

  ///
  ///note
  ///
  Widget _note() {
    return Text(
      "Lưu thanh toán\nBạn sẽ thanh toán sau nếu còn hiệu lực",
      textAlign: TextAlign.center,
      style: Dimensions.fontSizeStyle18().copyWith(
        color: ColorResources.RED,
      ),
    );
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(
      BuildContext context, V3BillDetailIsBuyController controller) {
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
