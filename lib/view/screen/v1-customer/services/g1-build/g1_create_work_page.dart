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

                  // Nhóm công việc
                  workGroup(context),
          
          
                  // Nhập địa chỉ cụ thể
                  form(context, controller),
                  
                  // Button
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                    child: LongButton(
                      color: ColorResources.PRIMARYCOLOR,
                      onPressed: (){},
                      title: "Tiếp tục",
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// Nhóm công việc
  ///
  Widget workGroup(BuildContext context){
    return Column(
      children: [
         DropDownButton<String>(
            data: const ["Xây nhà","Lót gạch men"],
            obligatory: true,
            onChanged: (value){},
            value: "Xây nhà",
            width: DeviceUtils.getScaledSize(context,1),
            label: "Chọn nhóm công việc phù hợp",
          ),
          DropDownButton<String>(
            data: const ["Xây nhà","Lót gạch men"],
            obligatory: true,
            onChanged: (value){},
            value: "Xây nhà",
            width: DeviceUtils.getScaledSize(context,1),
            label: "Chọn công việc phù hợp",
          ),
      ],
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
          controller: controller.worKTitleController,
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
          controller: controller.worKTitleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "123 Hoàng Thị Loan",
          label: "Thời gian bắt đầu",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        TextFieldDate(
          allowEdit: true,
          controller: controller.worKTitleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "123 Hoàng Thị Loan",
          label: "Thời gian kết thúc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
        ),
      ],
    );
  }
}