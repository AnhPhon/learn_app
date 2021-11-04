
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/sharedpref/constants/enum_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/create/g4_create_service_controller.dart';

class V1G4CreateServicePage extends GetView<V1G4CreateServiceController> {

  final V1G4CreateServiceController _controller = Get.find<V1G4CreateServiceController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Tạo đơn dịch vụ",
        leading: IconButton(onPressed: (){
          _controller.onBack();
        }, icon: const Icon(
          Icons.arrow_back_ios,
          color: ColorResources.WHITE,
        )),
      ),
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
          fontSize: Dimensions.FONT_SIZE_LARGE,
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
          child: GetBuilder(
            builder: (V1G4CreateServiceController controller) {
              return Row(
                children: [
                  RadioButton<GENDER>(title: "Nam", onChanged: (val)=>controller.onChangedGender(val!), value: GENDER.Nam, groupValue: controller.gender),
                  RadioButton<GENDER>(title: "Nữ", onChanged: (val)=>controller.onChangedGender(val!), value: GENDER.Nu, groupValue: controller.gender),
                  RadioButton<GENDER>(title: "Không yêu cầu", onChanged: (val)=>controller.onChangedGender(val!), value: GENDER.Khac, groupValue: controller.gender),
                ],
              );
            },
          )
        ),


        // Thời gian làm việc
        const Label(label: "Thời gian làm trong ngày", obligatory: true, paddingTitle: 0,),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE * 2),
          child: GetBuilder(
            builder: (V1G4CreateServiceController controller) {
              return Column(
                children: [
                  CheckBoxCustom(title: "Sáng: từ 7h30 - 11h30", onChanged: (bool? val) { 
                        controller.onSelectedTommorow(val: val!);
                      },status: controller.tommorow,),
                      CheckBoxCustom(title: "Chiều: từ 1h30 - 5h30", onChanged: (bool? val) { 
                        controller.onSelectedAfternoon(val: val!);
                      },status: controller.afternoon,),
                      CheckBoxCustom(title: "Tối: từ 18h30 - 22h30", onChanged: (bool? val) {  
                        controller.onSelectedTonight(val: val!);
                      },status: controller.tonight,),
                ],
              );
            },
          )
        ),

        TextFieldDate(
          paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          isDate: true,
          allowEdit: true,
          controller: controller.startTime,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "12-11-2021",
          label: "Ngày bắt đầu",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),

        TextFieldDate(
          allowEdit: true,
          controller: controller.endTime,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "22-11-2021",
          label: "Ngày kết thúc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),

      ],
    );
  }

  

  ///
  /// Nút tiếp tục
  ///

  Widget nextButton({required V1G4CreateServiceController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
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