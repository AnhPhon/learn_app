import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/drop_down_button_hide_under_line_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/create_work_controller.dart';

class CreateWorkPage extends GetView<CreateWorkController>{
  final CreateWorkController _controller = Get.put(CreateWorkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tạo đơn công việc"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nhóm công việc
              workGroup(context),
      
              // Địa điểm làm việc
              workLocation(context),
      
              // Nhập địa chỉ cụ thể
              textField(context),
              
              // Button
              button(),
            ],
          ),
        ),
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
  /// Địa điểm làm việc
  ///
  Widget workLocation(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const Label(
            label: "Địa điểm làm việc",
            obligatory: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            child: Text("Tỉnh/Thành phố",style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w500
            ),),
          ),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: ColorResources.BLACK
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                onSelectedWorkLocation(
                  context,
                  ward: ["Hoà Khánh","Thanh Khê"],
                  city: "Hồ Chí Minh",
                  district: ["Quận 9","Quận 8"],
                  value: 0
                ),
                onSelectedWorkLocation(
                  context,
                  ward: ["Hoà Khánh","Thanh Khê"],
                  city: "Hà Nội",
                  district: ["Quận 9","Quận 8"],
                  value: 1
                ),
                onSelectedWorkLocation(
                  context,
                  ward: ["Hoà Khánh","Thanh Khê"],
                  city: "Đà Nẵng",
                  district: ["Quận 9","Quận 8"],
                  value: 2
                ),
              ],
            ),
          )
      ],
    );
  }

  ///
  /// Radio button chon đia điểm làm việc
  ///
  Widget onSelectedWorkLocation(BuildContext context, {
    required List<String> district,
    required String city,
    required List<String> ward,
    required int value,
    }){
    return Column(
      children: [
        RadioButton<int>(
          title: city,
          value: value,
          groupValue: 1,
          onChanged: (int? val){},
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_LARGE* 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropDownButtonHideUnderLineWidget<String>(
                data: district,
                onChanged: (val){},
                value: "Quận 9",
                hint: "Quận/Huyện",
                width: DeviceUtils.getScaledWidth(context, 0.3),
              ),
              DropDownButtonHideUnderLineWidget<String>(
                data: ward,
                onChanged: (val){},
                value: null,
                hint: "Phường/xa",
                width: DeviceUtils.getScaledWidth(context, 0.3),
              ),
            ],
          ),
        )
      ],
    );
  }

  ///
  /// text field nhập địa chỉ cụ thể
  ///
  Widget textField(BuildContext context){
    return // Text field
    InputField(
      allowEdit: true,
      allowMultiline: false,
      controller: controller.addressController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      holdplacer: "123 Hoàng Thị Loan",
      hidden: false,
      label: "Địa chỉ cụ thể (số nhà, tên đường)",
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context,1),
    );
  }

  Widget button(){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: (){
          _controller.onClickContinue(1);
        },
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }

}