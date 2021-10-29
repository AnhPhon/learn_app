import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/form_management/service_review/service_review_g6/service_review_g6_controller.dart';

class V1ServiceReviewG6Page extends GetView<V1ServiceReviewG6Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ServiceReviewG6Controller>(
        init: V1ServiceReviewG6Controller(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: const AppBarWidget(title: "Xem đơn công việc"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu tề nhóm công việc
                  const GroupTitle(title: "Dịch vụ xe đào, cầu nặng, máy khác"),
                  //tieu de cong viec
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: TextHighlight(
                        title: "Tiêu đề công việc: ",
                        content: controller.donDichVuResponse.tieuDe!),
                  ),

                  //thong so ky thuat
                  thongSoKyThuat(controller: controller),

                  //so luong yeu cau
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: TextHighlight(
                      title: "Số lượng yêu cầu: ",
                      content:
                          controller.donDichVuResponse.soLuongYeuCau.toString(),
                    ),
                  ),

                  //thoigian lam viec
                  thoiGianLamViec(controller: controller),

                  //work content
                  workContent(controller: controller),

                  //hinh anh ban ve
                  hinhAnhBanVe(controller: controller),
                ],
              ),
            ),
          );
        });
  }

  ///
  /// Thông số kỹ thuật
  ///
  Widget thongSoKyThuat({required V1ServiceReviewG6Controller controller}) {
    return Column(
      children: [
        const Label(label: "Thông số kỹ thuật", obligatory: true),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE * 2,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.thongSoKyThuatList.length,
            itemBuilder: (BuildContext ctx, int index) {
              return CheckBoxCustom(
                title: controller.thongSoKyThuatList[index].tieuDe.toString(),
                onChanged: (val) {},
                status: controller.thongSoKyThuatListBool[index],
              );
            },
          ),
        ),
      ],
    );
  }

  ///
  ///Thời gian làm việc trong ngày
  ///
  Widget thoiGianLamViec({required V1ServiceReviewG6Controller controller}) {
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
  /// Nội dung tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget workContent({required V1ServiceReviewG6Controller controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Ngày làm việc: ",
              content: DateConverter.formatDateTime(
                controller.donDichVuResponse.ngayBatDau.toString(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Ngày kết thúc dự kiến: ",
              content: DateConverter.formatDateTime(
                controller.donDichVuResponse.ngayKetThuc.toString(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Bề rộng mặt đường làm việc: ",
              content: "khôngtimf thấy",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Miêu tả yêu cầu công việc cụ thể: ",
              content: controller.donDichVuResponse.moTaChiTiet.toString(),
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///hinhAnhBanVe
  ///
  Widget hinhAnhBanVe({required V1ServiceReviewG6Controller controller}) {
    return controller.donDichVuResponse.hinhAnhBanVe!.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(
                  label: "Hình ảnh bản vẽ (nếu có)",
                  obligatory: false,
                  paddingTitle: 0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: ImageListHorizontal(
                  imageList: controller.hinhAnhBanVe,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          );
  }
}
