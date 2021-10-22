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
            children: [
              // Thông tin đơn hàng
              BillWidget(orderContents: [
                  OrderContent(title:"Giá trị đơn hàng" , value: double.parse(controller.donPhanHoi!.idDonDichVu!.soTien!, (onError)=> 10000000000), boldValue: true,),
                  const OrderContent(title:"Khuyến mãi của App" , value:0, boldValue: true,),
                  const OrderContent(title:"Phí dịch vụ app" , value:50000, boldValue: true,),
                  OrderContent(title:"Tổng tiền đơn hàng" , value: double.parse(controller.donPhanHoi!.idDonDichVu!.tongDon!, (onError)=> 10000000000), boldValue: true,)
              ],deposit: double.parse(controller.donPhanHoi!.idDonDichVu!.tongDon!, (onError)=> 10000000000) * 10/100,),
              // Khoảng cách bottom sheet
              const SizedBox(
                height: BOTTOMSHEET,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: OrderBottomSheet(
        itemValue: double.parse(controller.donPhanHoi!.idDonDichVu!.tongDon!, (onError)=> 10000000000),
        child: Center(child: LongButton(title: "Đồng ý đơn giá",onPressed: (){
          _controller.onNextPage();
        },color: ColorResources.PRIMARYCOLOR,)),
      ),
    );
  }
}