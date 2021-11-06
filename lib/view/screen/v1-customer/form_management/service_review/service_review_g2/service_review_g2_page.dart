import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
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
            body: SingleChildScrollView(
              child: Column(
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

                  //hinh anh hien trang
                  hinhAnhHienTrang(controller: controller),

                  //hinh anh san pham mau
                  hinhAnhSanPhamMau(controller: controller),

                  //mo ta khoi luong cong viec
                  moTaCongViec(controller: controller),

                  //hinh anh bang khoi luong cong viec
                  imageMaterial(controller: controller),

                  //file
                  attchFile(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///tieu de cong viec
  ///
  Widget tieuDeCongViec({required V1ServiceReviewG2Controller controller}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextHighlight(
          title: "Tiêu đề công việc: ",
          content: controller.donDichVuResponse.tieuDe.toString(),
        ),
      ),
    );
  }

  ///
  /// Nội dung tiêu đề công việc
  ///
  Widget workContent({required V1ServiceReviewG2Controller controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu tề nhóm công việc
          const GroupTitle(title: "Dịch vụ thường xuyên khảo sát chờ báo giá"),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Tiêu đề công việc: ",
              content: controller.donDichVuResponse.tieuDe.toString(),
            ),
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
        const Label(
          label: "Thời gian làm trong ngày",
          obligatory: false,
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
  ///hinhAnhHienTrang
  ///
  Widget hinhAnhHienTrang({required V1ServiceReviewG2Controller controller}) {
    return controller.donDichVuResponse.hinhAnhChiTiets == null ||
            controller.donDichVuResponse.hinhAnhChiTiets!.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(
                label: "Hình ảnh hiện trạng",
                obligatory: false,
                paddingTitle: 0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  "(Những công viêc mang tính chất cải tạo cần nhiều hình ảnh chi tiết, cụ thể, rõ ràng để báo giá sát nhất,...)",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: ImageListHorizontal(
                  imageList: controller.donDichVuResponse.hinhAnhChiTiets!,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          );
  }

  ///
  ///hinhAnhSanPhamMau
  ///
  Widget hinhAnhSanPhamMau({required V1ServiceReviewG2Controller controller}) {
    return controller.donDichVuResponse.hinhAnhBanVes == null ||
            controller.donDichVuResponse.hinhAnhBanVes!.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(
                label: "Hình ảnh sản phẩm mẫu",
                obligatory: false,
                paddingTitle: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: ImageListHorizontal(
                  imageList: controller.donDichVuResponse.hinhAnhBanVes!,
                  padding: EdgeInsets.zero,
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
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextHighlight(
              title: "Thời gian bắt đầu dự kiến: ",
              content: controller.donDichVuResponse.ngayBatDau == null
                  ? ""
                  : DateConverter.formatDateTime(
                      controller.donDichVuResponse.ngayBatDau.toString(),
                    ),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            TextHighlight(
              title: "Thời gian kết thúc dự kiến: ",
              content: controller.donDichVuResponse.ngayKetThuc == null
                  ? ""
                  : DateConverter.formatDateTime(
                      controller.donDichVuResponse.ngayKetThuc.toString(),
                    ),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            TextHighlight(
              title: "Mô tả yêu cầu công việc: ",
              content: controller.donDichVuResponse.moTa!,
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///mo ta khoi luong cong viec
  ///
  Widget moTaCongViec({required V1ServiceReviewG2Controller controller}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Label(
            label: "Mô tả khối lượng công việc: ",
            obligatory: false,
            topPadding: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Text(
              controller.donDichVuResponse.moTaChiTiet.toString(),
              style: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///hinh anh bang khoi luong cong viec
  ///
  Widget imageMaterial({required V1ServiceReviewG2Controller controller}) {
    return controller.donDichVuResponse.hinhAnhBanKhoiLuongs == null
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(
                label: "Hình ảnh bảng khối lượng",
                obligatory: false,
                paddingTitle: 0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text("(Bảng in hoặc viết bằng tay nếu có)"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
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
        ? Column(
            children: [
              const Label(
                label: "File đính kèm",
                obligatory: false,
                paddingTitle: 0,
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
              ),
              AttachButton(
                title: "File báo giá khổi lượng",
                color: ColorResources.WHITE,
                onPressed: () => controller.downloadFile(
                  url: controller.donDichVuResponse.file.toString(),
                ),
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
            ],
          )
        : Container();
  }
}
