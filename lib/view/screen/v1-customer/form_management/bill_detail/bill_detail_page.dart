import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/screen/v1-customer/form_management/bill_detail/bill_detail_controller.dart';

class V1BillDetailPage extends GetView<V1BillDetailController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1BillDetailController>(
      init: V1BillDetailController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Column(
            children: [
              //bill detail
              _containerBill(context, controller),
            ],
          ),
          bottomNavigationBar: _bottomSheet(context, controller),
        );
      },
    );
  }

  ///
  ///note
  ///
  Widget _note(BuildContext context, V1BillDetailController controller) {
    return Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                text: controller.note,
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    color: ColorResources.BLACK.withOpacity(.7),
                    height: 1.5),
                children: [
                  TextSpan(
                      text:
                          "${PriceConverter.convertPrice(context, controller.depositMoney)} VND",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorResources.RED,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                ])));
  }

  ///
  /// container bill
  ///
  Widget _containerBill(
      BuildContext context, V1BillDetailController controller) {
    return Container(
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
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
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
          //price
          RowText(
            text1: "Giá trị đơn hàng",
            text2:
                "${PriceConverter.convertPrice(context, controller.giaTriDonHangMoney)} VND",
          ),
          RowText(
            text1: "Phí dịch vụ App",
            text2:
                "${PriceConverter.convertPrice(context, controller.phiDichVu)} VND",
          ),
          RowText(
            text1: "Khuyến mãi của App",
            text2:
                "${PriceConverter.convertPrice(context, controller.khuyenMaiCuaApp)} VND",
          ),
          RowText(
            text1: "Tổng tiền đơn hàng",
            text2:
                "${PriceConverter.convertPrice(context, controller.getTongDonHang())} VND",
            colorRed: true,
          ),

          //divider
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Divider(color: Colors.grey),
          ),

          //note
          _note(context, controller),
        ],
      ),
    );
  }

  ///
  ///bottom sheet
  ///
  Widget _bottomSheet(BuildContext context, V1BillDetailController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, .19),
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
        top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        bottom: Dimensions.PADDING_SIZE_LARGE,
      ),
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.BORDER_RADIUS_LARGE - 5),
          topRight: Radius.circular(Dimensions.BORDER_RADIUS_LARGE - 5),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
            color: ColorResources.BLACK,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            fontWeight: FontWeight.bold),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RowText(
                text1: "Cần thanh toán",
                text2:
                    "${PriceConverter.convertPrice(context, controller.getTongDonHang())} VND",
                colorRed: true),
            BtnCustom(
              color: ColorResources.PRIMARY,
              text: "Tiếp tục",
              onTap: () => controller.onContinueClick(controller.idDonDichVu),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
