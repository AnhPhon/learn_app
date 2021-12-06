import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/chi_tiet_cong_viec_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/form_management/service_review/service_review_g1/service_review_g1_controller.dart';
import 'package:template/view/screen/v1-customer/services/components/order_content_string_value.dart';

class V1ServiceReviewG1Page extends GetView<V1ServiceReviewG1Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ServiceReviewG1Controller>(
        init: V1ServiceReviewG1Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: const AppBarWidget(title: "Xem đơn công việc"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu tề nhóm công việc
                  const GroupTitle(title: "Dịch vụ xây dựng toàn diện"),
                  workContent(controller: controller),

                  // Danh sách vật liệu
                  materialList(context, controller: controller),

                  //Thêm file
                  attchFile(context, controller: controller),

                  // Hình ảnh bảng vật liệu
                  imageMaterial(controller: controller),

                  // Bản vẽ
                  drawing(controller: controller),
                ],
              ),
            ),
          );
        });
  }

  ///
  /// Nội dung tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget workContent({required V1ServiceReviewG1Controller controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHighlight(title: "Công việc: ", content: controller.donDichVuResponse.tieuDe!),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Mô tả công việc: ", content: controller.donDichVuResponse.moTa!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(title: "Thời gian: ", content: "${DateConverter.formatDateTimeGlobal(controller.donDichVuResponse.ngayBatDau!)} ${controller.donDichVuResponse.ngayKetThuc == null ? '' : "đến ${DateConverter.formatDateTimeGlobal(controller.donDichVuResponse.ngayKetThuc!)}"} "),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  Widget item({required ChiTietCongViecResponse mass}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
        top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      child: BoxShadowWidget(
        child: Container(
          padding: const EdgeInsets.all(
            Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderContentStringValue(
                title: "Tên công việc: ",
                value: mass.tenCongViec.toString(),
                boldTitle: true,
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_SMALL,
                  right: Dimensions.PADDING_SIZE_SMALL,
                  top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
              ),
              OrderContentStringValue(
                title: "Quy cách: ",
                value: mass.quyCach.toString(),
                boldTitle: true,
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_SMALL,
                  right: Dimensions.PADDING_SIZE_SMALL,
                  top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
              ),
              OrderContentStringValue(
                title: "Khối lượng: ",
                value: mass.soLuong.toString(),
                boldTitle: true,
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_SMALL,
                  right: Dimensions.PADDING_SIZE_SMALL,
                  top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
              ),
              OrderContentStringValue(
                title: "Đơn vị: ",
                value: mass.donVi.toString(),
                boldTitle: true,
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_SMALL,
                  right: Dimensions.PADDING_SIZE_SMALL,
                  top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Danh sách vật liệu được thêm
  ///
  Widget materialList(BuildContext context, {required V1ServiceReviewG1Controller controller}) {
    return controller.chiTietCongViecList.isEmpty
        ? Container()
        : Column(
            children: [
              const Label(
                label: "Bảng khối lượng công việc(nếu có)",
                obligatory: false,
                topPadding: 0,
              ),
              ...controller.chiTietCongViecList
                  .map((e) => SizedBox(
                      width: DeviceUtils.getScaledWidth(context, 1),
                      child: Column(
                        children: [
                          item(mass: e),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),
                        ],
                      )))
                  .toList()
            ],
          );
  }

  Widget attchFile(BuildContext context, {required V1ServiceReviewG1Controller controller}) {
    return controller.donDichVuResponse.files == null || controller.donDichVuResponse.files!.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
            child: AttachButton(
              title: controller.donDichVuResponse.files!.first.toString(),
              color: ColorResources.WHITE,
              onPressed: () => controller.downloadFile(
                url: controller.donDichVuResponse.files!.first.toString(),
              ),
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
          );
  }

  ///
  ///imageMaterial
  ///
  Widget imageMaterial({required V1ServiceReviewG1Controller controller}) {
    return controller.donDichVuResponse.hinhAnhBanKhoiLuongs == null || controller.donDichVuResponse.hinhAnhBanKhoiLuongs!.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(label: "Hình ảnh bảng khối lượng", obligatory: false, paddingTitle: 0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text("(Bảng in hoặc viết bằng tay nếu có)"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: ImageListHorizontal(
                  imageList: controller.donDichVuResponse.hinhAnhBanKhoiLuongs!,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          );
  }

  ///
  ///drawing
  ///
  Widget drawing({required V1ServiceReviewG1Controller controller}) {
    return controller.donDichVuResponse.hinhAnhBanVes == null || controller.donDichVuResponse.hinhAnhBanVes!.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(label: "Hình ảnh bản vẽ (nếu có)", obligatory: false, paddingTitle: 0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: ImageListHorizontal(
                  imageList: controller.donDichVuResponse.hinhAnhBanVes!,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          );
  }
}
