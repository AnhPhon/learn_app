import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/services/components/material_card.dart';
import 'package:template/view/screen/v1-customer/services/vat_lieu_xay_dung/preview_vat_tu/preview_vat_tu_controller.dart';

class V1PreviewVatTuPage extends GetView<V1PreviewVatTuController> {
  const V1PreviewVatTuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Kiểm tra lại đơn hàng"),
      body: GetBuilder(
        init: V1PreviewVatTuController(),
        builder: (V1PreviewVatTuController controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu tề nhóm công việc
                    workContent(controller: controller),
                    
                    // Danh sách vật liệu
                    materialList(context,controller: controller),

                    // Hình ảnh bảng vật liệu
                    imageMaterial(controller: controller),

                    //Thêm file
                    attchFile(context,controller: controller),
                    
                    // Tiến độ hàng
                    deliveryProgress(controller: controller),
                    
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
  
  Widget workContent({required V1PreviewVatTuController controller}){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHighlight(title: "Tiêu đề báo giá: ", content: controller.previewServiceRequest!.tieuDe!),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Công trình: ", content: controller.previewServiceRequest!.idLoaiCongTrinh!.tenCongTrinh!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Địa điểm nhận: ", content: controller.previewServiceRequest!.diaDiemNhan!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Địa chỉ cụ thể: ", content: controller.previewServiceRequest!.diaChiCuThe!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Thời gian: ", content: "Từ ${controller.previewServiceRequest!.ngayBatDau} ${controller.previewServiceRequest!.ngayKetThuc == null ? '' : "đến ${controller.previewServiceRequest!.ngayKetThuc}"} "),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Nội dung yêu cầu: ", content: controller.previewServiceRequest!.moTa!),
          ),
        ],
      ),
    );
  }

  
  ///
  /// Danh sách vật liệu được thêm 
  ///
  Widget materialList(BuildContext context,{required V1PreviewVatTuController controller}){
    return controller.previewServiceRequest!.chiTietVatTus!.isEmpty ? Container() : Column(
      children:  [
        const Label(
          label: "Bảng khối lượng",
          obligatory: false,
          topPadding: 0,
        ),
        ...controller.previewServiceRequest!.chiTietVatTus!.map((e) => 
        SizedBox(
        width: DeviceUtils.getScaledWidth(context, 1),
        child: MaterialCard(mass: e))).toList()
      ],
    );
  }

  Widget attchFile(BuildContext context,{required V1PreviewVatTuController controller}){
    return controller.previewServiceRequest!.files!.isNotEmpty ? 
    Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_LARGE
      ),
      child: Column(
        children: [
          const Label(
            label: "Tập tin đính kèm",
            obligatory: false,
            paddingTitle: 0
          ),
          AttachButton(
            title: controller.previewServiceRequest!.files.toString(), 
            color: ColorResources.WHITE, 
            onPressed: (){},
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
        ],
      ),
    ) : Container();
  }

  Widget imageMaterial({required V1PreviewVatTuController controller}){
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
          child: BoxImage(images: controller.previewServiceRequest!.hinhAnhBanKhoiLuongs),
        ),
      ],
    );
  }

  Widget deliveryProgress({required V1PreviewVatTuController controller}){
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Tiến độ giao hàng",
          style:TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE, 
              fontWeight: FontWeight.bold
            )
          ),
          Text(controller.previewServiceRequest!.tienDoGiaoHang! == 1 ? "Giao gấp" : "Không gấp, giao kết hợp", 
          style: const TextStyle(
              color: ColorResources.RED
            ),
          ),
        ],
      ),
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

  Widget button({required V1PreviewVatTuController controller}){
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