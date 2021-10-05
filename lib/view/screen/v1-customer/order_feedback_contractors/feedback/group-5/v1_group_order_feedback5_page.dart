


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/bill_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/order_content.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/group-5/v1_group_order_feedback5_controller.dart';

class V1GroupOrderFeedBack5Page extends GetView<V1GroupOrderFeedBack5Controller> {
  const V1GroupOrderFeedBack5Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Phản hồi đơn hàng"),
      body: Container(
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Tiêu đề nhóm
              GroupTitle(title: "Dịch vụ xe tải, xe ben, cầu thùng"),
        
              //Công việc: Thuê xe tải thùng 1,5 tấn
              Padding(
                padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighligt(
                  title: "Công việc: ",
                  content: "Thuê xe tải thùng 1,5 tấn",
                ),
              ),
              // Bảng thông tin đơn hàng
              Padding(
                padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                child: BillWidget(
                  orderContents: [
                  OrderContent(title:"Giá trị đơn hàng" , value:"100.000.000 VNĐ"),
                  OrderContent(title:"Tiền phí qua trạm(nếu có)" , value:"8.000 VNĐ"),
                  OrderContent(title:"Phí dịch vụ app" , value:"0 VNĐ"),
                  OrderContent(title:"Khuyến mãi của App" , value:"50.000 VNĐ"),
                  OrderContent(title:"Tổng tiền đơn hàng" , value:"11.050.000 VNĐ")
                ], deposit: "100.000.000"),
              ),
              // Khoản cách bottomSheet
              SizedBox(height: 150,)
            ],
          ),
        ),
      ),
      bottomSheet: OrderBottomSheet(
        itemValue: "100.000.000",
        children: [
          SmallButton(title: "Huỷ", color: ColorResources.GREY, onPressed: (){}),
          SmallButton(title: "Đồng ý", color: ColorResources.PRIMARYCOLOR, onPressed: (){})
        ],
      )
    );
  }
}