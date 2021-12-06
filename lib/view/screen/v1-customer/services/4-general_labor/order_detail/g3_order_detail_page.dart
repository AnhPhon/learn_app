import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/services/components/order_content_string_value.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_detail/g3_order_detail_controller.dart';

class V1G3OrderDetailPage extends GetView<V1G3OrderDetailController> {
  V1G3OrderDetailPage({Key? key}) : super(key: key);
  final V1G3OrderDetailController _controller =
      Get.find<V1G3OrderDetailController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Chi tiết đơn hàng"),
      body: Column(
        children: [
          const GroupTitle(title: "Dịch vụ thường xuyên đã có giá"),

          // Bảng thông tin đơn hàng
          Padding(
            padding: const EdgeInsets.all(
              Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: BillWidget(
                isHasDeposit: false,
                title: "Chi tiết đơn hàng",
                orderContents: [
                  OrderContentStringValue(
                    title: "Gội đầu tại nhà",
                    value:
                        "${CurrencyConverter.currencyConverterVND(300000)} VNĐ/công",
                    boldValue: true,
                  ),
                  OrderContentStringValue(
                    title: "Số giờ làm việc/ngày",
                    value:
                        "${CurrencyConverter.currencyConverterVND(8000)} VNĐ",
                    boldValue: true,
                  ),
                  const OrderContentStringValue(
                    title: "Số lượng",
                    value: "8 người",
                    boldValue: true,
                  ),
                  const OrderContentStringValue(
                    title: "Số ngày làm việc dự kiến",
                    value: "10 giờ",
                    boldValue: true,
                  ),
                  OrderContentStringValue(
                    title: "Giá trị đơn hàng",
                    value:
                        "${CurrencyConverter.currencyConverterVND(300000)} VNĐ",
                    boldValue: true,
                  ),
                  OrderContentStringValue(
                    title: "Phí dịch vụ App",
                    value:
                        "${CurrencyConverter.currencyConverterVND(8000)} VNĐ",
                    boldValue: true,
                  ),
                  OrderContentStringValue(
                    title: "Khuyến mãi của App",
                    value:
                        "${CurrencyConverter.currencyConverterVND(5000)} VNĐ",
                    boldValue: true,
                  ),
                  OrderContentStringValue(
                    title: "Tổng tiền đơn hàng",
                    value:
                        "${CurrencyConverter.currencyConverterVND(455000)} VNĐ",
                    boldValue: true,
                  ),
                ]),
          ),

          // Khoản cách bottomSheet
          const SizedBox(
            height: BOTTOMSHEET,
          )
        ],
      ),
      bottomSheet: OrderBottomSheet(
        mainAxisAlignment: MainAxisAlignment.center,
        itemValue: 337500,
        child: Center(
          child: LongButton(
            color: ColorResources.PRIMARYCOLOR,
            onPressed: () => _controller.onNextPage(),
            title: "Tiếp tục",
          ),
        ),
      ),
    );
  }
}
