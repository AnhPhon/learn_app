


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/components/bill_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/components/order_content.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/group-6/v1_group_order_feedback6_controller.dart';

class V1GroupOrderFeedBack6Page extends GetView<V1GroupOrderFeedBack6Controller> {
  const V1GroupOrderFeedBack6Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Phản hồi đơn hàng"),
      body: GetBuilder(
        builder: (V1GroupOrderFeedBack6Controller controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [

                header(),

                // Bảng thông tin đơn hàng
                const Padding(
                  padding: EdgeInsets.all(
                    Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: BillWidget(
                    orderContents: [
                    OrderContent(title:"Giá trị đơn hàng" , value:"100.000.000 VNĐ"),
                    OrderContent(title:"Tiền phí qua trạm(nếu có)" , value:"8.000 VNĐ"),
                    OrderContent(title:"Phí dịch vụ app" , value:"0 VNĐ"),
                    OrderContent(title:"Khuyến mãi của App" , value:"50.000 VNĐ"),
                    OrderContent(title:"Tổng tiền đơn hàng" , value:"11.050.000 VNĐ")
                  ], deposit: "50.000"),
                ),
                
                // Text Field Nội dung báo cáo
                textField(context),

                // Khoản cách bottomSheet
                const SizedBox(height: 150,)
              ],
            ),
          );
        },
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


  Widget header(){
    return Container(
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: const [
          // Tiêu đề nhóm
          GroupTitle(title: "Dịch vụ xe đào,cầu nặng, máy khá"),
  
          //Công việc: Thuê xe tải thùng 1,5 tấn
          Padding(
            padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
            child: TextHighligt(
              title: "Công việc: ",
              content: " Thuê xe đào móng nhà gầu 0,3m",
            ),
          ),
        ],
      ),
    );
  }

  Widget textField(BuildContext context){
    return // Text field
    Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: InputField(
        allowEdit: true,
        allowMultiline: true,
        controller: controller.desController,
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
        holdplacer: "Khách hàng nêu nội dung chi tiết báo gía",
        hidden: false,
        label: "Nội dung chi tiết báo giá",
        obligatory: false,
        typeInput: TextInputType.text,
        width: DeviceUtils.getScaledWidth(context,1),
      ),
    );
  }

}