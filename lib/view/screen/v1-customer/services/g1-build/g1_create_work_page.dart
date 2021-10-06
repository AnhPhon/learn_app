import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/g1_create_work_controller.dart';

class V1G1CreateWorkPage extends GetView<V1G1CreateWorkController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tạo đơn công việc"),
      body: GetBuilder(
        builder: (V1G1CreateWorkController controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Tiêu tề nhóm công việc
                  const GroupTitle(title: "Dịch vụ xây dựng toàn diện"),

                  // Nhập địa chỉ cụ thể
                  form(context, controller),
                  
                  material(context),

                  // Button
                  button()
                ],
              ),
            ),
          );
        },
      ),
    );
  }



  ///
  /// text field nhập địa chỉ cụ thể
  ///
  Widget form(BuildContext context,V1G1CreateWorkController controller ){
    return Column(
      children: [
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.worKTitleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Xây nhà",
          hidden: false,
          label: "Tiêu đề công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        

        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.descController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Xây nhà lầu",
          hidden: false,
          label: "Mô tả công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        TextFieldDate(
          isDate: true,
          allowEdit: true,
          controller: controller.startTime,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-11-2021",
          label: "Thời gian bắt đầu",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        TextFieldDate(
          allowEdit: true,
          controller: controller.endTime,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "22-11-2021",
          label: "Thời gian kết thúc",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
        ),
      ],
    );
  }

  ///
  /// Nhóm công việc
  ///
  Widget material(BuildContext context){
    return Column(
      children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             DropDownButton<String>(
                data: const ["Xây nhà","Lót gạch men"],
                obligatory: true,
                onChanged: (value){},
                value: "Xây nhà",
                width: DeviceUtils.getScaledSize(context,0.5),
                label: "Vật liệu",
              ),
            DropDownButton<String>(
              data: const ["Xây nhà","Lót gạch men"],
              obligatory: true,
              onChanged: (value){},
              value: "Xây nhà",
              width: DeviceUtils.getScaledSize(context,0.5),
              label: "Quy cách",
            ),
           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             DropDownButton<String>(
                data: const ["Xây nhà","Lót gạch men"],
                obligatory: true,
                onChanged: (value){},
                value: "Xây nhà",
                width: DeviceUtils.getScaledSize(context,0.5),
                label: "Vật liệu",
                paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
            DropDownButton<String>(
              data: const ["Xây nhà","Lót gạch men"],
              obligatory: true,
              onChanged: (value){},
              value: "Xây nhà",
              width: DeviceUtils.getScaledSize(context,0.5),
              label: "Quy cách",
              paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
           ],
         ),

        LongButton(
           title: 'Thêm vật liệu', 
           color: ColorResources.PRIMARYCOLOR, 
           onPressed: (){},
           horizontal: Dimensions.PADDING_SIZE_DEFAULT,
           vertical: Dimensions.PADDING_SIZE_DEFAULT,
        )
      ],
    );
  }

  Widget button(){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: (){},
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }


}