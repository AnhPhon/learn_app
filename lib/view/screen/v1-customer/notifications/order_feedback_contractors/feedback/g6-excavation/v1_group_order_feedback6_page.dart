
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/order_content.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g6-excavation/v1_group_order_feedback6_controller.dart';

class V1GroupOrderFeedBack6Page extends GetView<V1GroupOrderFeedBack6Controller> {
  final V1GroupOrderFeedBack6Controller _controller = Get.find<V1GroupOrderFeedBack6Controller>();

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
                Padding(
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: BillWidget(
                    orderContents: [
                    OrderContent(title:"Giá trị đơn hàng" , value:double.parse(_controller.donPhanHoi!.idDonDichVu!.soTien!, (e)=> 1000000000), boldValue: true,),
                    // const OrderContent(title:"Tiền phí qua trạm(nếu có)" , value:0 ,boldValue: true),
                    const OrderContent(title:"Phí dịch vụ app" , value:50000 , boldValue: true,),
                    const OrderContent(title:"Khuyến mãi của App" , value:0, boldValue: true,),
                    OrderContent(title:"Tổng tiền đơn hàng" , value: double.parse(_controller.donPhanHoi!.idDonDichVu!.tongDon!,(e)=> 1000000000), boldValue: true,)
                  ], deposit: double.parse(_controller.donPhanHoi!.idDonDichVu!.tongDon!,(e)=> 1000000000) * 10 / 100,),
                ),
                
                // Text Field Nội dung báo cáo
                textField(context),

                // Khoản cách bottomSheet
                const SizedBox(height: BOTTOMSHEET + Dimensions.PADDING_SIZE_LARGE,)
              ],
            ),
          );
        },
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


  Widget header(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề nhóm
        const GroupTitle(title: "Dịch vụ xe đào,cầu nặng, máy khá"),
        //GroupTitle(title: _controller.donPhanHoi!.idDonDichVu!.tieuDe!),
  
        //Công việc: Thuê xe tải thùng 1,5 tấn
         Padding(
         padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: TextHighlight(
            title: "Công việc: ",
            content: _controller.donPhanHoi!.idDonDichVu!.tieuDe!,//" Thuê xe đào móng nhà gầu 0,3m",
          ),
        ),
      ],
    );
  }

  Widget textField(BuildContext context){
    return // Text field
    InputField(
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
    );
  }

}