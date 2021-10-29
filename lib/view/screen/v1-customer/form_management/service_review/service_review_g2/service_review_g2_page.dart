import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/form_management/service_review/service_review_g2/service_review_g2_controller.dart';

class V1ServiceReviewG2Page extends GetView<V1ServiceReviewG2Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ServiceReviewG2Controller>(
        init: V1ServiceReviewG2Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: const AppBarWidget(title: "Xem đơn công việc"),
            body: Column(
              children: [
                // Tiêu đề nhóm công việc
                const GroupTitle(
                    title: "Dịch vụ thường xuyên khảo sát chờ báo giá"),

                //tieu de cong viec
                tieuDeCongViec(controller: controller),

                //thoigian lam viec
                thoiGianLamViec(controller: controller),

                //moTa yeu cau
                moTaYeuCau(controller: controller),

                //hinh anh bang khoi luong cong viec
                imageMaterial(controller: controller),

                //thieu hinh anh hien trang, hinh anh san pham mau, mo ta khoi luong cong viec

                //file
                attchFile(context, controller: controller),
              ],
            ),
          );
        });
  }

  ///
  ///tieu de cong viec
  ///
  Widget tieuDeCongViec({required V1ServiceReviewG2Controller controller}) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: TextHighlight(
          title: "Tiêu đề công việc: ",
          content: controller.donDichVuResponse.tieuDe!),
    );
  }

  ///
  /// Nội dung tiêu đề công việc
  ///
  Widget workContent({required V1ServiceReviewG2Controller controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu tề nhóm công việc
          const GroupTitle(title: "Dịch vụ thường xuyên khảo sát chờ báo giá"),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
                title: "Tiêu đề công việc: ",
                content: controller.donDichVuResponse.tieuDe!),
          ),
        ],
      ),
    );
  }

  ///
  ///Thời gian làm việc trong ngày
  ///
  Widget thoiGianLamViec({required V1ServiceReviewG2Controller controller}) {
    return Column(
      children: [
        const Label(label: "Thời gian làm trong ngày", obligatory: true),
        Padding(
          padding:
              const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE * 2),
          child: Column(
            children: [
              CheckBoxCustom(
                title: "Sáng: từ 7h30 - 11h30",
                onChanged: (val) {},
                status: controller.tommorow,
              ),
              CheckBoxCustom(
                title: "Chiều: từ 13h30 - 17h30",
                onChanged: (val) {},
                status: controller.afternoon,
              ),
              CheckBoxCustom(
                title: "Tối: từ 18h30 - 22h30",
                onChanged: (val) {},
                status: controller.tonight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///mo ta cong viec
  ///
  Widget moTaYeuCau({required V1ServiceReviewG2Controller controller}) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: TextHighlight(
          title: "Mô tả yêu cầu công việc: ",
          content: controller.donDichVuResponse.moTa!,),
    );
  }

  ///
  ///hinh anh bang khoi luong cong viec
  ///
  Widget imageMaterial({required V1ServiceReviewG2Controller controller}) {
    return controller.donDichVuResponse.hinhAnhBanKhoiLuongs!.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(
                  label: "Hình ảnh bảng khối lượng",
                  obligatory: false,
                  paddingTitle: 0),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,),
                child: Text("(Bảng in hoặc viết bằng tay nếu có)"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,),
                child: ImageListHorizontal(
                  imageList: controller.donDichVuResponse.hinhAnhBanKhoiLuongs!,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          );
  }

  ///
  ///file
  ///
  Widget attchFile(BuildContext context,
      {required V1ServiceReviewG2Controller controller}) {
    return controller.donDichVuResponse.file != null
        ? Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
            child: AttachButton(
              title: "File báo giá khổi lượng",
              color: ColorResources.WHITE,
              onPressed: () => controller.downloadFile(
                url: controller.donDichVuResponse.file.toString(),
              ),
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
          )
        : Container();
  }
}
