

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/components/custom_file_button.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/text_typing_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V2TextTypingPage extends GetView<V2TextTypingController>{
  final _controller = Get.find<V2TextTypingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Đăng ký việc mới"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            form(context, _controller),
            button(),
            const SizedBox(
              height: Dimensions.SIZE_LARGE,
            )
          ],
        ),
      ),
    );
  }

  Widget text({required String title,required String content}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: TextHighlight(title: title, content: content,
      style: const TextStyle(
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      ),),
    );
  }

  Widget contentPrivew({required String title,required String content}){
    return Padding(
      padding: const EdgeInsets.only(top:Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: TextHighlight(title: title, content: content),
    );
  }
  ///
  /// form tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget form(BuildContext context,V2TextTypingController controller ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Tiêu đề cần tuyển
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.titleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Tiêu đề công việc",
          hidden: false,
          label: "Tiêu đề",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(title: "Tên ứng viên: ",content: "Nguyễn Văn A"),
              text(title: "Giới tính: ",content: "Nam"),
              text(title: "Ngày sinh: ",content: "20/10/1992"),
              text(title: "Điện thoại: ",content: "0932132132"),
              text(title: "Email: ",content: "Exmaple@gmail.com"),
            ],
          ),
        ),

        //Chỗ ở hiện tại
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "123B/22 Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Chỗ ở hiện tại",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),


        // hôn nhân
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Độc thân", 
          obligatory: true,
          label: "Hôn nhân",
          hint: "Độc thân",
        ),

        // Hình thức làm việc
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Bán thời gian", 
          obligatory: true,
          label: "Hình thức làm việc",
          hint: "Hình thức làm việc",
        ),

        const Label(label: "Mục tiêu nghê nghiệp", obligatory: true),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT
            ),
          child: BoxShadowWidget(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Được làm việc trong môi trường chuyên nghiệp, có chế độ tốt.Nâng cao được trình độ, kỹ năng chuyên môn Cống hiến năng lực bản thân và mong có cơ hội thăng tiến",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            )
            ),
          ),
        ),

        aualificationsAndQualifications(context),

        const Label(label: "Chọn chức vụ, kinh nghiệm, mức lương", obligatory: false),
        // Chức vụ hiện tại *
        DropDownButton<String>(
          paddingTop: 0,
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Chức vụ hiện tại", 
          obligatory: true,
          label: "Chức vụ hiện tại",
          hint: "Chức vụ hiện tại *",
        ),

        // Chức vụ mong muốn *
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Chức vụ mong muốn", 
          obligatory: true,
          label: "Chức vụ mong muốn",
          hint: "Chức vụ mong muốn",
        ),

        // Năm kinh nghiệm *
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Năm kinh nghiệm", 
          obligatory: true,
          label: "Năm kinh nghiệm",
          hint: "Năm kinh nghiệm",
        ),

       // Mức lương đề xuất *
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Mức lương đề xuất", 
          obligatory: true,
          label: "Mức lương đề xuất",
          hint: "Mức lương đề xuất",
        ),

        // Nơi làm việc *
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Nơi làm việc", 
          obligatory: true,
          label: "Nơi làm việc",
          hint: "Chọn tỉnh/TP",
        ),

        // Ngành nghề mong muốn ứng tuyển *
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Ngành nghề mong muốn ứng tuyển", 
          obligatory: true,
          label: "Ngành nghề mong muốn ứng tuyển",
          hint: "Chọn ngành nghề",
        ),

        experience(context),

        // Cum ngoại ngữ
        language(context)
      ],
    );
  }


  Widget aualificationsAndQualifications(BuildContext context){
    return Column(
      children: [
        const Label(label: "Bằng cấp và trình độ", obligatory: false),

        // Trình độ
        DropDownButton<String>(
          paddingTop: 0,
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Mới học", 
          obligatory: true,
          label: "Trình độ",
          hint: "Cùi",
        ),

        // Chuyên môn *
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Chuyên môn", 
          obligatory: true,
          label: "Chuyên môn",
          hint: "Chuyên môn",
        ),

        // Tốt nghiệp lọai *
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Tốt nghiệp lọai", 
          obligatory: true,
          label: "Tốt nghiệp lọai",
          hint: "Tốt nghiệp lọai",
        ),

         // Năm tốt nghiệp *
        TextFieldDate(
          allowEdit: true,
          controller: controller.endTimeController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-12-2021",
          label: "Năm tốt nghiệp",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
        ),

        //Đơn vị đào tạo *
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Đơn vị đào tạo",
          hidden: false,
          label: "Đơn vị đào tạo",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        const Label(label: "Ảnh bằng cấp (nếu có)", obligatory: false),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT
          ),
          child: BoxImage(images: [], isAddImage: true,),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: Dimensions.PADDING_SIZE_SMALL
          ),
          child: LongButton(title: "Thêm bằng cấp mới", color: ColorResources.PRIMARYCOLOR, onPressed: (){}),
        ),

        // List thêm
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: Dimensions.PADDING_SIZE_SMALL
          ),
          child: BoxShadowWidget(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: SizedBox(
              width: DeviceUtils.getScaledWidth(context,1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const TextHighlight(title: "Trình độ: ", content: "Đại học",),
                  contentPrivew(title:"Chuyên môn: ",content: "chuyên môn in trên bằng cấp"),
                  contentPrivew(title:"Tốt nghiệp loại: ",content: "giỏi"),
                  contentPrivew(title:"Năm tốt nghiệp: ",content: "2021"),
                  contentPrivew(title:"Đơn vị đào tạo: ",content: "trường đại học"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget experience(BuildContext context){
    return Column(
      children: [
        //Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)
        const Label(label: "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)", obligatory: false),
        // từ
        TextFieldDate(
          paddingTop: 0,
          allowEdit: true,
          controller: controller.endTimeController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-12-2021",
          label: "Từ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
        ),

        // đến
        TextFieldDate(
          allowEdit: true,
          controller: controller.endTimeController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-12-2021",
          label: "Đến",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
        ),


        //Đơn vị  *
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Đơn vị",
          hidden: false,
          label: "Đơn vị",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Chức vụ *
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Chức vụ",
          hidden: false,
          label: "Chức vụ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Mức lương *
        Row(
          children: [
            InputField(
              allowEdit: false,
              allowMultiline: false,
              controller: controller.addressController,
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              holdplacer: "Mức lương",
              hidden: false,
              label: "Mức lương",
              obligatory: true,
              typeInput: TextInputType.text,
              width: DeviceUtils.getScaledWidth(context,0.5),
            ),
            // Đơn vị
            DropDownButton<String>(
              onChanged: (val){}, 
              data: [], 
              width: DeviceUtils.getScaledWidth(context,0.5),
              value: "US", 
              obligatory: false,
              label: "",
              hint: "USD",
            ),
          ],
        ),

        //Công việc phụ trách *
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Công việc phụ trách",
          hidden: false,
          label: "Công việc phụ trách",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //thành tích đạt được *
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Thành tích đạt được",
          hidden: false,
          label: "Thành tích đạt được",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // List thêm
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: Dimensions.PADDING_SIZE_SMALL
          ),
          child: BoxShadowWidget(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: SizedBox(
              width: DeviceUtils.getScaledWidth(context,1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const TextHighlight(title: "Chức vụ hiện tại: ", content: "Giám đốc",),
                  contentPrivew(title:"Chức vụ mong muốn: ",content: "Chủ tịch"),
                  contentPrivew(title:"Năm kinh nghiệm: ",content: "100 năm"),
                  contentPrivew(title:"Mức lương đề xuất: ",content: "200000 USD"),
                  contentPrivew(title:"Nơi làm việc: ",content: "Nhà"),
                  contentPrivew(title:"Ngành nghề mong muốn ứng tuyển: ",content: "Phụ hồ"),
                  contentPrivew(title:"Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",content: "",),
                  contentPrivew(title:"Thời gian: ",content: "12-12-1991 - 12-12-2-2021"),
                  contentPrivew(title:"Đơn vị: ",content: "Không biết"),
                  contentPrivew(title:"Chức vụ: ",content: "Chủ tịch"),
                  contentPrivew(title:"Mức lương: ",content: "1000 USD"),
                  contentPrivew(title:"Công việc phụ trách: ",content: "Không biết"),
                  contentPrivew(title:"Kết quả / thành tích đạt được: ",content: "VIP PRO"),
                ],
              ),
            ),
          ),
        ),

        const Label(label: "Ảnh hồ sơ xin việc (nếu có)", obligatory: false),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT
          ),
          child: BoxImage(images: [],isAddImage: true,),
        ),

        //File hồ sơ xin việc (nếu có)
        CustomFileButton(title: "Cv.pdf",onTap: (){},verticalPadding: Dimensions.PADDING_SIZE_DEFAULT,),

        //Kỹ năng và sở trường làm việc
        const Label(label: "Kỹ năng và sở trường làm việc", obligatory: false),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT
            ),
          child: BoxShadowWidget(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Kỹ năng giao tiếp tốt, sáng tạo trong công việc, làm việc độc lập, làm việc theo nhóm, giải quyết vấn đề linh hoạt, kỹ năng làm việc văn phòng, công trường, công nghệ,...",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            )
            ),
          ),
        ),
      ],
    );
  }


  Widget language(BuildContext context){
    return Column(
      children: [
        //Ngoại ngữ *
        const Label(label: "Ngoại ngữ", obligatory: false),
        // Chọn ngoại ngữ
        DropDownButton<String>(
          paddingTop: 0,
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Chọn ngoại ngữ", 
          obligatory: true,
          label: "Chọn ngoại ngữ",
          hint: "Chọn ngoại ngữ",
        ),

        // Trình độ
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Trình độ", 
          obligatory: true,
          label: "Trình độ",
          hint: "Trình độ",
        ),

        Table(
          defaultColumnWidth: FixedColumnWidth(DeviceUtils.getScaledWidth(context, 1)/5),
          children: [
            chooseAbility(context,title: "",ability:[
              "Giỏi","Khá","Trung",'Yếu'
            ]),
            chooseAbility(context,title: "Nghe",ability:[
              RadioButton(title: "", onChanged: (val){}, value: 1, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 2, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 3, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 4, groupValue: 1)
            ]),
            chooseAbility(context,title: "Nói",ability:[
              RadioButton(title: "", onChanged: (val){}, value: 1, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 2, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 3, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 4, groupValue: 1)
            ]),
            chooseAbility(context,title: "Đọc",ability:[
              RadioButton(title: "", onChanged: (val){}, value: 1, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 2, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 3, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 4, groupValue: 1)
            ]),
            chooseAbility(context,title: "Viết",ability:[
              RadioButton(title: "", onChanged: (val){}, value: 1, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 2, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 3, groupValue: 1),
              RadioButton(title: "", onChanged: (val){}, value: 4, groupValue: 1)
            ]),
          ],
        )
      ],
    );
  }

  TableRow chooseAbility(BuildContext context,{required String title,required List<Object> ability}){
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textAlign: TextAlign.center,style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  ),),
                ],
              ),
            ),
          ),
          ...ability.map((e) => Align(
            child: e is Widget ? e : Padding(
              padding: const EdgeInsets.only(
                right: Dimensions.FONT_SIZE_EXTRA_LARGE * 2,
                top: Dimensions.FONT_SIZE_EXTRA_SMALL
              ),
              child: Text(e as String, textAlign: TextAlign.left, style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),),
            ),
          ),)
        ]
      );
    }

  

  ///
    /// Button
    ///
    Widget button(){
      return Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallButton(title: "Lưu", color: ColorResources.PRIMARYCOLOR, onPressed: (){}),
            SmallButton(title: "Ứng tuyển", color: ColorResources.RED, onPressed: (){
            }),
          ],
        ),
      );
    }
}