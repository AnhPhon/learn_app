import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/form_management/service_review/service_review_g5/service_review_g5_controller.dart';

class V1ServiceReviewG5Page extends GetView<V1ServiceReviewG5Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ServiceReviewG5Controller>(
        init: V1ServiceReviewG5Controller(),
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
                  const GroupTitle(title: "Dịch vụ xe tải, xe ben, cầu thùng"),
                  //tieu de cong viec
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: TextHighlight(
                      title: "Công việc: ",
                      content: controller.donDichVuResponse.tieuDe.toString(),
                    ),
                  ),

                  //thong so ky thuat
                  thongSoKyThuat(controller: controller),

                  //so luong yeu cau
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: TextHighlight(
                      title: "Số lượng yêu cầu: ",
                      content:
                          controller.donDichVuResponse.soLuongYeuCau.toString(),
                    ),
                  ),

                  //don vi
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: TextHighlight(
                      title: "Đơn vị: ",
                      content: controller.donDichVuResponse.donVi.toString(),
                    ),
                  ),

                  //thoigian lam viec
                  thoiGianLamViec(controller: controller),

                  //work content
                  workContent(controller: controller),
                ],
              ),
            ),
          );
        });
  }

  ///
  /// Thông số kỹ thuật
  ///
  Widget thongSoKyThuat({required V1ServiceReviewG5Controller controller}) {
    return Column(
      children: [
        const Label(
          label: "Thông số kỹ thuật",
          obligatory: false,
          topPadding: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE * 2,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.donDichVuResponse.idThongSoKyThuats!.length,
            itemBuilder: (BuildContext ctx, int index) {
              return CheckBoxCustom(
                title: controller.donDichVuResponse.idThongSoKyThuats![index].tieuDe.toString(),
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
  Widget thoiGianLamViec({required V1ServiceReviewG5Controller controller}) {
    return Column(
      children: [
        const Label(
          label: "Thời gian làm trong ngày",
          obligatory: false,
          topPadding: 0,
        ),
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
  Widget workContent({required V1ServiceReviewG5Controller controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Ngày làm việc: ",
              content: controller.donDichVuResponse.ngayBatDau == null
                  ? ""
                  : DateConverter.formatDateTimeGlobal(
                      controller.donDichVuResponse.ngayBatDau.toString(),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Địa điểm bốc hàng dự kiến: ",
              content: controller.donDichVuResponse.diaDiemBocHang.toString(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Địa điểm trả hàng dự kiến: ",
              content: controller.donDichVuResponse.diaDiemTraHang.toString(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Cự ly vận chuyển tương đối: ",
              content: "${controller.donDichVuResponse.cuLyVanChuyen}km",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Bề rộng mặt đường nhận hàng (m): ",
              content: "${controller.donDichVuResponse.beRongDiemNhan}m",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Bề rộng mặt đường trả hàng (m): ",
              content: "${controller.donDichVuResponse.beRongDiemTra}m",
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
}
