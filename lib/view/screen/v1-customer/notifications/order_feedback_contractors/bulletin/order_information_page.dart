import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/bulletin/order_information_controller.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/order_content.dart';

class V1OrderInformationPage extends GetView<V1OrderInformationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: V1OrderInformationController(),
        builder: (V1OrderInformationController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: const AppBarWidget(title: "Thông tin đơn hàng"),
            body: Container(
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Thông tin đơn hàng
                    BillWidget(
                      orderContents: [
                        OrderContent(
                          title: 'Phí đăng tin',
                          value: controller.soTien,
                          boldValue: true,
                        ),
                        OrderContent(
                          title: "Khuyến mãi của App",
                          value: controller.khuyenMai,
                          boldValue: true,
                        ),
                        OrderContent(
                          title: "Phí dịch vụ app",
                          value: controller.phiDichVu,
                          boldValue: true,
                        ),
                        OrderContent(
                          title: "Tổng tiền đơn hàng",
                          value: controller.tongTien,
                          boldValue: true,
                        )
                      ],
                      deposit:
                          controller.tienCoc > 0 ? controller.tienCoc : null,
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      isHasDeposit: controller.tienCoc > 0 ? true : false,
                    ),
                    // Khoảng cách bottom sheet
                    const SizedBox(
                      height: BOTTOMSHEET,
                    ),
                  ],
                ),
              ),
            ),
            bottomSheet: OrderBottomSheet(
              itemValue: controller.tongTien,
              child: Center(
                  child: LongButton(
                title: "Đồng ý đơn giá",
                onPressed: () {
                  controller.showDialogAccept();
                },
                color: ColorResources.PRIMARYCOLOR,
              )),
            ),
          );
        });
  }
}
