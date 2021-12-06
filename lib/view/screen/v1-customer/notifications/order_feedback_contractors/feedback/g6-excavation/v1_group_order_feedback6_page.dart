
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g6-excavation/v1_group_order_feedback6_controller.dart';

class V1GroupOrderFeedBack6Page extends GetView<V1GroupOrderFeedBack6Controller> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const AppBarWidget(title: "Phản hồi đơn hàng"),
        body: GetBuilder(
          builder: (V1GroupOrderFeedBack6Controller controller) {
            if(controller.isLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
    
                  header(),
    
                  // Text Field Nội dung báo cáo
                  textField(context),
    
                  // Khoản cách bottomSheet
                  const SizedBox(height: BOTTOMSHEET + Dimensions.PADDING_SIZE_LARGE,)
                ],
              ),
            );
          },
        ),
        bottomSheet: GetBuilder(
          builder: (V1GroupOrderFeedBack6Controller controller) {
            if(controller.isLoading){
              return const SizedBox.shrink();
            }
            return OrderBottomSheet(
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
              : 
              [
                SmallButton(title: "Từ chối", color: ColorResources.GREY, onPressed: (){
                  controller.showDialog();
                }),
                SmallButton(title: "Đồng ý", color: ColorResources.PRIMARYCOLOR, onPressed: (){
                  controller.onClickAgreeButton();
                })
              ],
            );
          },
        )
      ),
    );
  }


  Widget header(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề nhóm
        const GroupTitle(title: "Dịch vụ xe đào,cầu nặng, máy khác"),
        //GroupTitle(title: controller.donDichVu!.tieuDe!),
  
        //Công việc: Thuê xe tải thùng 1,5 tấn
         Padding(
         padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: TextHighlight(
            title: "Công việc: ",
            content: controller.donDichVu!.tieuDe!,//" Thuê xe đào móng nhà gầu 0,3m",
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
      ],
    );
  }

  Widget textField(BuildContext context){
    return // Text field
    InputField(
      allowEdit: true,
      allowMultiline: true,
      controller: controller.desController,
      fontSize: Dimensions.FONT_SIZE_LARGE,
      holdplacer: "Khách hàng nêu nội dung chi tiết giá",
      hidden: false,
      label: "Nội dung chi tiết giá",
      obligatory: false,
      textInputAction: TextInputAction.newline,
      typeInput: TextInputType.multiline,
      width: DeviceUtils.getScaledWidth(context,1),
    );
  }

}