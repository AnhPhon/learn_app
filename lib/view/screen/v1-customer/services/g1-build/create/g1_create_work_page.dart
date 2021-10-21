import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/components/material_card.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/create/g1_create_work_controller.dart';

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
                  form(context, controller:controller),
                  
                  material(context, controller:controller),
                  // Danh sách vật liệu
                  materialList(context,controller:controller),
                  //Thêm file
                  attchFile(context,controller:controller),
                  // Hình ảnh bảng vật liệu
                  imageMaterial(controller: controller),
                  // Bản vẽ
                  drawing(controller: controller),
                  // Ghi chú
                  note(),
                  // Button tiếp tục
                  nextButton(controller: controller)
                ],
              ),
            ),
          );
        },
      ),
    );
  }



  ///
  /// form tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget form(BuildContext context,{required V1G1CreateWorkController controller} ){
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
          holdplacer: "Miêu tả",
          hidden: false,
          label: "Mô tả công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        TextFieldDate(
          isDate: true,
          allowEdit: false,
          controller: controller.startTimeController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-11-2021",
          label: "Thời gian bắt đầu",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        TextFieldDate(
          allowEdit: false,
          controller: controller.endTimeController,
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
  /// Thêm vật liệu
  ///
  Widget material(BuildContext context, {required V1G1CreateWorkController controller} ){
    return Column(
      children: [
        const Label(
          label: "Bảng khối lượng công việc(nếu có)",
          obligatory: false,
        ),
        InputField(
          paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.nameTitleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Lát gạch phòng ngủ 600*600",
          hidden: false,
          label: "Tên công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.specificationController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Dùng keo, gạch thạch bàn mã TB123",
          hidden: false,
          label: "Quy cách",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InputField(
              allowEdit: true,
              allowMultiline: false,
              controller: controller.massController,
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              holdplacer: "VD: 100",
              hidden: false,
              label: "Khối lượng",
              obligatory: true,
              typeInput: TextInputType.number,
              width: DeviceUtils.getScaledWidth(context,0.5),
            ),
          DropDownButton<String>(
            data: const ["m2","m3",'Tấn','Tạ','Kg'],
            obligatory: true,
            onChanged: (unit)=> controller.onChangedUnit(unit!),
            value: controller.unit,
            width: DeviceUtils.getScaledSize(context,0.5),
            label: "Đơn vị",
            hint: 'Chọn đơn vị',
          ),
          ],
         ),

        // Button
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
          child: LongButton(
             title: '+ Thêm công việc', 
             color: ColorResources.PRIMARYCOLOR, 
             onPressed: controller.onClickAddMass,
             horizontal: Dimensions.PADDING_SIZE_DEFAULT,
             vertical: Dimensions.PADDING_SIZE_SMALL,
          ),
        )
      ],
    );
  }

  ///
  /// Danh sách công việc được thêm 
  ///
  Widget materialList(BuildContext context,{required V1G1CreateWorkController controller}){
    return Column(
      children: controller.massList.map((e) => 
      SizedBox(
        width: DeviceUtils.getScaledWidth(context, 1),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Xoá',
              color: Colors.red,
              icon: Icons.delete,
              onTap: ()=> controller.deleteSupplies(e)
            ),
          ],
          child: MaterialCard(mass: e)))
      ).toList()
    );
  }

  Widget attchFile(BuildContext context,{required V1G1CreateWorkController controller}){
    return Column(
      children: [
        const Label(
          label: "Đính kèm file excel hoặc khác",
          obligatory: false,
        ),
        AttachButton(
          title: controller.file == null ? "Thêm tập tin" : controller.fileName!, 
          color: ColorResources.WHITE, 
          onPressed: controller.pickerFile,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        )
      ],
    );
  }

  Widget imageMaterial({required V1G1CreateWorkController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          label: "Hình ảnh bảng khối lượng",
          obligatory: false,
          paddingTitle: 0
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text("(Bảng in hoặc viết bằng tay nếu có)"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(images: controller.images,isAddImage: true,onPress:()=> controller.pickerMuilFile(files: controller.images) ,onDelete: (File? file, List<File> files)=>controller.onDeleteImage(file: file!,files: files),),
        ),
      ],
    );
  }

  Widget drawing({required V1G1CreateWorkController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Label(
          label: "Hình ảnh bản vẽ (nếu có)",
          obligatory: false,
          paddingTitle: 0
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(images: controller.drawingImages,isAddImage: true,onPress:()=> controller.pickerMuilFile(files: controller.drawingImages) ,onDelete: (File? file, List<File> files)=>controller.onDeleteImage(file: file!,files: files),),
        ),
      ],
    );
  }

  Widget note(){
    return Column(
      children: const [
        Label(
          label: "Ghi chú",
          obligatory: false,
          paddingTitle: 0
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: Dimensions.PADDING_SIZE_DEFAULT
          ),
          child: BoxShadowWidget(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text('Đối với dự án có khối lượng lớn, gửi bản vẽ qua email baogia5sao@gmail.com; chúng tôi sẽ có đội ngũ đến khảo sát và báo giá. Hoặc khách hàng yêu cầu chúng tôi sẽ đến khảo sát báo giá trực tiếp ',
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE
            ),),
          ),
        )
      ],
    );
  }

  Widget nextButton({required V1G1CreateWorkController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: controller.onClickContinueButton,
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }


}