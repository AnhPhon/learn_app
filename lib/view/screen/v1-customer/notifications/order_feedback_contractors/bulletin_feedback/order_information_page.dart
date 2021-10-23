import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/bulletin_feedback/order_information_controller.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/order_content.dart';

class OrderFeedbackInformationPage extends GetView<OrderFeedbackInformationController> {
  final OrderFeedbackInformationController _controller  = Get.find<OrderFeedbackInformationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Thông tin đơn hàng"),
      body: GetBuilder(
        builder: (OrderFeedbackInformationController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: const EdgeInsets.all(
              Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Thông tin đơn hàng
                  BillWidget(orderContents: [
                      OrderContent(title:"Giá trị đơn hàng" , value: controller.soTien, boldValue: true,),
                      OrderContent(title:"Khuyến mãi của App" , value: controller.khuyenMai, boldValue: true,),
                      OrderContent(title:"Phí dịch vụ app" , value:controller.phiDichVu, boldValue: true,),
                      OrderContent(title:"Tổng tiền đơn hàng" , value: controller.tongTien, boldValue: true,)
                  ],
                  deposit: controller.tienCoc > 0 ? controller.tienCoc : null,
                  isHasDeposit: controller.tienCoc > 0 ? true : false,
                  ),//double.parse(controller.donPhanHoi!.idDonDichVu!.tongDon!, (onError)=> 10000000000) * 10/100,),
                  
                  // Khoảng cách bottom sheet
                  const SizedBox(
                    height: BOTTOMSHEET,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: OrderBottomSheet(
        itemValue: _controller.tongTien,
        child: Center(child: LongButton(title: "Đồng ý đơn giá",onPressed: (){
          _controller.onNextPage();
        },color: ColorResources.PRIMARYCOLOR,)),
      ),
    );
  }
}