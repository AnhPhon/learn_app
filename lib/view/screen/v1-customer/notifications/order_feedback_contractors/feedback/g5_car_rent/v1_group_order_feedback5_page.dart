
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g5_car_rent/v1_group_order_feedback5_controller.dart';

class V1GroupOrderFeedBack5Page extends GetView<V1GroupOrderFeedBack5Controller> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (V1GroupOrderFeedBack5Controller controller) {
        if(controller.isLoading && controller.donPhanHoi == null){
          return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
        }
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
                    top: Dimensions.PADDING_SIZE_SMALL,
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: TextHighlight(
                    title: "Công việc: ",
                    content: controller.donDichVu!.tieuDe!,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_SMALL,
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: TextHighlight(
                    title: "Nội dung đính kèm theo báo giá: ",
                    content: controller.donPhanHoi!.ghiChu!,
                  ),
                ),

                // Khoản cách bottomSheet
                const SizedBox(height: BOTTOMSHEET + Dimensions.PADDING_SIZE_LARGE,)
              ],
            ),
          ),
          bottomSheet: OrderBottomSheet(
            itemValue: controller.soTien,
            children: 
            controller.donDichVu!.idTrangThaiDonDichVu!.id!  == THAT_BAI ? 
            [
              const Flexible(
                child: Text(
                  "Bạn đã không đồng ý giá đơn dịch vụ. Rất vui hợp tác với bạn lần sau !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorResources.RED
                  ),
                )
              )
            ] :
            controller.donDichVu!.idTrangThaiThanhToan!.id! == DA_THANH_TOAN || controller.donDichVu!.idTrangThaiThanhToan!.id == DAT_COT? 
            [
              const Flexible(
              child: Text("Bạn đã thanh toán đơn dịch vụ. Cám ơn bạn đã tin dùng dịch vụ chúng tôi", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorResources.RED
                  ),
                ),
              )
            ] 
            :[
              SmallButton(title: "Từ chối", color: ColorResources.GREY, onPressed: (){
                controller.showDialog();
              }),
              SmallButton(title: "Đồng ý", color: ColorResources.PRIMARYCOLOR, onPressed: (){
                controller.onClickAgreeButton();
              })
            ],
          )
        );
      },
    );
  }
}