import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/services/components/material_card.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/components/work_card.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/reviews/g1_review_controller.dart';

class V1G1ReviewPage extends GetView<V1G1ReviewController> {
  const V1G1ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Xem đơn công việc"),
      body: GetBuilder(
        builder: (V1G1ReviewController controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu tề nhóm công việc
                    const GroupTitle(title: "Dịch vụ xây dựng toàn diện"),
                    workContent(controller: controller),
                    
                    // Danh sách vật liệu
                    materialList(context,controller: controller),
                    //Thêm file
                    attchFile(context,controller: controller),
                    // Hình ảnh bảng vật liệu
                    imageMaterial(controller: controller),
                    // Bản vẽ
                    drawing(controller: controller),
                    // Ghi chú
                    note(),
                    // Button
                    button(controller: controller)
              ],
            ),
          );
        },
      ),
    );
  }


  ///
  /// Nội dung tiêu đề công việc và mô tả công việc , Thời gian
  ///
  
  Widget workContent({required V1G1ReviewController controller}){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHighlight(title: "Công việc: ", content: controller.previewServiceRequest!.tieuDe!),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Mô tả công việc: ", content: controller.previewServiceRequest!.moTa!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Thời gian: ", content: "${controller.previewServiceRequest!.ngayBatDau} ${controller.previewServiceRequest!.ngayKetThuc == null ? '' : "- ${controller.previewServiceRequest!.ngayKetThuc}"} "),
          ),
        ],
      ),
    );
  }

  
  ///
  /// Danh sách vật liệu được thêm 
  ///
  Widget materialList(BuildContext context,{required V1G1ReviewController controller}){
    return controller.previewServiceRequest!.bangKhoiLuongCongViec!.isEmpty ? Container() : Column(
      children:  [
        const Label(
          label: "Bảng khối lượng công việc(nếu có)",
          obligatory: false,
          topPadding: 0,
        ),
        ...controller.previewServiceRequest!.bangKhoiLuongCongViec!.map((e) => 
        SizedBox(
        width: DeviceUtils.getScaledWidth(context, 1),
        child: WorkCard(work: e))).toList()
      ],
    );
  }

  Widget attchFile(BuildContext context,{required V1G1ReviewController controller}){
    return controller.previewServiceRequest!.files!= null ? 
    Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_LARGE
      ),
      child: AttachButton(
        title: controller.previewServiceRequest!.files.toString(), 
        color: ColorResources.WHITE, 
        onPressed: (){},
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    ) : Container();
  }

  Widget imageMaterial({required V1G1ReviewController controller}){
    return controller.previewServiceRequest!.hinhAnhBanKhoiLuongs!.isEmpty ?  Container(): Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
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
          child: BoxImage(images: controller.previewServiceRequest!.hinhAnhBanKhoiLuongs!),
        ),
      ],
    );
  }

  Widget drawing({required V1G1ReviewController controller}){
    return controller.previewServiceRequest!.hinhAnhBanVes!.isEmpty ?  Container() : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Label(
          label: "Hình ảnh bản vẽ (nếu có)",
          obligatory: false,
          paddingTitle: 0
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(images: controller.previewServiceRequest!.hinhAnhBanVes!,),
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
          padding: EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: BoxShadowWidget(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text('Đối với dự án có khối lượng lớn, gửi bản vẽ qua email baogia5sao@gmail.com; chúng tôi sẽ có đội ngũ đến khảo sát và báo giá.Hoặc khách hàng yêu cầu chúng tôi sẽ đến khảo sát báo giá trực tiếp', 
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE
            ),),
          ),
        )
      ],
    );
  }

  Widget button({required V1G1ReviewController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: ()=> controller.onClickButton(),
        title: "Hoàn thành tạo đơn công việc",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }

}