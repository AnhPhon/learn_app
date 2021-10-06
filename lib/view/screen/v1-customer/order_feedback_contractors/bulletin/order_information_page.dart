

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/components/order_content.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/bulletin/order_information_controller.dart';

class OrderInformationPage extends GetView<OrderInformationController> {
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
              bill(context),
              // Khoảng cách bottom sheet
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: OrderBottomSheet(
        itemValue: "100.000.000",
        children: [
          SmallButton(title: "Huỷ ", color: ColorResources.GREY,onPressed: (){}),
          SmallButton(title: "Đồng ý đơn giá",color: ColorResources.PRIMARYCOLOR, onPressed: (){
            
          }),
        ],
      ),
    );
  }



  Widget bill(BuildContext context){
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.6),
      width:  DeviceUtils.getScaledHeight(context,1),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8
          )
        ]
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Thông tin đơn hàng", style:TextStyle(
              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              fontWeight: FontWeight.bold
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK
              ),
              child: Column(
                children: const [
                  OrderContent(title:"Giá trị đơn hàng" , value:"100.000.000 VNĐ"),
                  OrderContent(title:"Khuyến mãi của App" , value:"50.000 VNĐ"),
                  OrderContent(title:"Phí dịch vụ app" , value:"0 VNĐ"),
                  OrderContent(title:"Tổng tiền đơn hàng" , value:"11.050.000 VNĐ")
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          const Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("Đặt cọc đơn hàng (Chỉ đặt cọc nếu chưa thanh toán đơn hàng. "
            "Tiền này sẽ được khấu trừ khi thanh toán đơn hàng. Trường hợp thợ đã di "
            "chuyển đến nơi làm việc mà Khách hủy đơn  thì Khách sẽ bị mất tiền cọc):",
            textAlign: TextAlign.center,style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE
            ),),
          ),
          const Text("1.000.000 VNĐ", style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: ColorResources.RED,
            fontWeight: FontWeight.bold,
          )),
        ],
      )
    );
  }

}