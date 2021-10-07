import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/quote/request/quote_request_controller.dart';

class V3QuoteRequestPage extends GetView<V3QuoteRequestController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarWidget(title: "Danh sách báo giá đơn hàng"),
      body: GetBuilder<V3QuoteRequestController>(
        init: V3QuoteRequestController(),
        builder: (V3QuoteRequestController controller) {
          return Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                // tiêu đề báo giá
                _textWidget("Tiêu đề báo giá", "Cần báo giá xi măng"),
                SizedBox(height: DeviceUtils.getScaledHeight(context, .02)),

                // Chọn loại công trình
                _textWidget("Chọn loại công trình", "Nhà tư"),
                SizedBox(height: DeviceUtils.getScaledHeight(context, .02)),

                // địa điểm nhận
                _diaDiemNhan()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _textWidget(String title, String label) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(title, style: Dimensions.textTitleStyleCard()),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(label, style: Dimensions.textNormalStyleCard()),
        ),
      ],
    );
  }

  Widget _diaDiemNhan() {
    return Column(
      children: [
        // địa điểm nhận
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Địa điểm nhận",
            style: Dimensions.textTitleStyleCard(),
          ),
        ),

        // Tỉnh/TP:
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Tỉnh/TP: ",
            style: Dimensions.textNormalStyleCard(),
          ),
        ),

        // radio
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              
            ],
          ),
        ),
      ],
    );
  }
}
