import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/components/order_content.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/bulletin/order_information_controller.dart';

class OrderInformationPage extends GetView<OrderInformationController> {
  final OrderInformationController _controller  = Get.find<OrderInformationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Thông tin đơn hàng"),
      body: Container(
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              // Thông tin đơn hàng
              BillWidget(orderContents: [
                OrderContent(title:"Giá trị đơn hàng" , value:"100.000.000 VNĐ", boldValue: true,),
                  OrderContent(title:"Khuyến mãi của App" , value:"50.000 VNĐ", boldValue: true,),
                  OrderContent(title:"Phí dịch vụ app" , value:"0 VNĐ", boldValue: true,),
                  OrderContent(title:"Tổng tiền đơn hàng" , value:"11.050.000 VNĐ", boldValue: true,)
              ],deposit: "1.000.000",),
              // Khoảng cách bottom sheet
              SizedBox(
                height: BOTTOMSHEET,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: OrderBottomSheet(
        itemValue: "100.000.000",
        child: Center(child: LongButton(title: "Đồng ý đơn giá",onPressed: (){
          _controller.onNextPage();
        },color: ColorResources.PRIMARYCOLOR,)),
      ),
    );
  }
}