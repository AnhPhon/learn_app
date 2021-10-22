
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/order_content.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g5_car_rent/v1_group_order_feedback5_controller.dart';

class V1GroupOrderFeedBack5Page extends GetView<V1GroupOrderFeedBack5Controller> {
  final V1GroupOrderFeedBack5Controller _controller = Get.find<V1GroupOrderFeedBack5Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Phản hồi đơn hàng"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề nhóm
            const GroupTitle(title: "Dịch vụ xe tải, xe ben, cầu thùng"),
      
            //Công việc: Thuê xe tải thùng 1,5 tấn
            Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.PADDING_SIZE_DEFAULT,
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: TextHighlight(
                title: "Công việc: ",
                content: _controller.donPhanHoi!.idDonDichVu!.tieuDe!,
              ),
            ),

            // Bảng thông tin đơn hàng
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: BillWidget(
                orderContents: [
                OrderContent(title:"Giá trị đơn hàng" , value: double.parse(_controller.donPhanHoi!.idDonDichVu!.soTien!, (e)=> 1000000000), boldValue: true,),
                const OrderContent(title:"Tiền phí qua trạm(nếu có)" , value:0, boldValue: true,),
                const OrderContent(title:"Phí dịch vụ app" , value: 0, boldValue: true,),
                const OrderContent(title:"Khuyến mãi của App" , value: 0, boldValue: true,),
                OrderContent(title:"Tổng tiền đơn hàng" , value: double.parse(_controller.donPhanHoi!.idDonDichVu!.tongDon!,(e)=> 1000000000), boldValue: true,)
              ], deposit: double.parse(_controller.donPhanHoi!.idDonDichVu!.tongDon!,(e)=> 1000000000)* 10 /1000) ,
            ),
            // Khoản cách bottomSheet
            const SizedBox(height: BOTTOMSHEET + Dimensions.PADDING_SIZE_LARGE,)
          ],
        ),
      ),
      bottomSheet: OrderBottomSheet(
        itemValue: double.parse(_controller.donPhanHoi!.idDonDichVu!.tongDon!,(e)=> 1000000000),
        children: [
          SmallButton(title: "Huỷ", color: ColorResources.GREY, onPressed: (){}),
          SmallButton(title: "Đồng ý", color: ColorResources.PRIMARYCOLOR, onPressed: (){
            _controller.onClickAgreeButton();
          })
        ],
      )
    );
  }
}