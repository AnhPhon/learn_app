
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/create/g4_create_service_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V1G4CreateServicePage extends GetView<V1G4CreateServiceController> {

  final V1G4CreateServiceController _controller = Get.find<V1G4CreateServiceController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tạo đơn dịch vụ"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tiêu tề nhóm công việc
                const GroupTitle(title: "Dịch vụ lao động phổ thông"),
      
                // Nhập địa chỉ cụ thể
                form(context, controller),
                
                // Button tiếp tục
                nextButton(controller: _controller)
          ],
        ),
      ),
    );
  }

  ///
  /// form tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget form(BuildContext context,V1G4CreateServiceController controller ){
    return Column(
      children: [
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.workTitleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Xây nhà",
          hidden: false,
          label: "Tiêu đề công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Giới tính
        const Label(label: "Giới tính", obligatory: true, paddingTitle: 0,),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE * 2),
          child: Row(
            children: [
              RadioButton<int>(title: "Nam", onChanged: (val){}, value: 1, groupValue: 1),
              RadioButton<int>(title: "Nữ", onChanged: (val){}, value: 2, groupValue: 1),
              RadioButton<int>(title: "Khác", onChanged: (val){}, value: 0, groupValue: 1),
            ],
          ),
        ),

        // Số lượng yêu cầu
        InputField(
          paddingTop: 0,
          allowEdit: false,
          allowMultiline: false,
          controller: controller.amountController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "10",
          hidden: false,
          label: "Số lượng yêu cầu",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Thời gian làm việc
        const Label(label: "Thời gian làm trong ngày", obligatory: true, paddingTitle: 0,),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE * 2),
          child: Column(
            children: [
              CheckBoxCustom(title: "Sáng: từ 7h30 - 11h30", onChanged: (bool? val) {  },status: false,),
              CheckBoxCustom(title: "Sáng: từ 7h30 - 11h30", onChanged: (bool? val) {  },status: false,),
              CheckBoxCustom(title: "Sáng: từ 7h30 - 11h30", onChanged: (bool? val) {  },status: false,),
            ],
          ),
        ),

        TextFieldDate(
          paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          isDate: true,
          allowEdit: true,
          controller: controller.startTime,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-11-2021",
          label: "Ngày bắt đầu",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        TextFieldDate(
          allowEdit: true,
          controller: controller.endTime,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "22-11-2021",
          label: "Ngày kết thúc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
        ),

        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.valueController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "100.000.000",
          hidden: false,
          label: "Giá trị khách hàng đề xuất (nếu có) : VNĐ",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),


        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.descController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Khách nhập",
          hidden: false,
          label: "Mô tả yêu cầu công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

      ],
    );
  }

  

  ///
  /// Nút tiếp tục
  ///

  Widget nextButton({required V1G4CreateServiceController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: ()=> controller.onClickContinueButton(),
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }

}