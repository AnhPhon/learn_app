import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group2/shorthanded_group2_conroller.dart';

class V2ShorthandedGroup2Page extends GetView<V2ShorthandedGroup2Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedGroup2Controller>(
        init: V2ShorthandedGroup2Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  const ContentWidget(
                    label: "Dịch vụ thường xuyên khảo sát chờ báo giá ",
                    center: true,
                  ),

                  //job title
                  ContentWidget(
                    label: "Tiêu đề công việc: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.tieuDe.toString(),
                  ),

                  //working time in day
                  ContentWidget(
                    label: "Thời gian làm trong ngày: ",
                    content: controller.donDichVuResponse == null
                        ? '' : '' + controller.donDichVuResponse!.idThoiGianLamViecs!.map((e) => e.toString()).join('\n').toString(),
                  ),

                  //start
                  ContentWidget(
                    label: "Thời gian bắt đầu dự kiến: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.getDateOutput(controller
                        .donDichVuResponse!.ngayBatDau
                        .toString()),
                  ),

                  //end
                  ContentWidget(
                    label: "Thời gian kết thúc dự kiến: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.getDateOutput(controller
                        .donDichVuResponse!.ngayKetThuc
                        .toString()),
                  ),

                  //value of customer idea
                  ContentWidget(
                    label: "Giá trị khách hàng đề xuất ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.giaTriKhachDeXuat.toString(),
                  ),

                  //working address
                  ContentWidget(
                    label: "Địa điểm làm việc: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.diaDiemLamViec
                        .toString(),
                  ),

                  //job description
                  ContentWidget(
                    label: "Mô tả, yêu cầu công việc ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.moTa
                        .toString(),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse == null || controller.donDichVuResponse!.hinhAnhThucTes == null || controller.donDichVuResponse!.hinhAnhThucTes!.isEmpty
                        ? []
                        : controller.donDichVuResponse!.hinhAnhThucTes!,
                    label: "Hình ảnh chi tiết nếu có (hình ảnh thực tế)",
                    labelBold: true,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse == null || controller.donDichVuResponse!.hinhAnhChiTiets == null || controller.donDichVuResponse!.hinhAnhChiTiets!.isEmpty
                        ? []
                        : controller.donDichVuResponse!.hinhAnhChiTiets!,
                    label: "Hình ảnh sản phẩm mẫu (nếu có)",
                    labelBold: true,
                  ),

                  //job value description
                  ContentWidget(
                    label:
                        "Mô tả khối lượng công việc thực hiện (sơ bộ tham khảo) ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.moTaChiTiet
                        .toString(),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse == null || controller.donDichVuResponse!.hinhAnhBanKhoiLuongs == null || controller.donDichVuResponse!.hinhAnhBanKhoiLuongs!.isEmpty
                        ? []
                        : controller.donDichVuResponse!.hinhAnhBanKhoiLuongs!,
                    label:
                        "Hình ảnh bảng khối lượng hoặc mô tả công việc (nếu có)",
                    labelBold: true,
                  ),

                  //file
                  RowText(
                    text1: "File đính kèm",
                    text2: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.file
                        .toString(),
                  ),

                  //btn
                  BtnCustom(
                    onTap: () => controller.onQuotationG2PageClick(),
                    margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                      vertical: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),
                    color: ColorResources.PRIMARY,
                    text: "Tiếp tục và báo giá",
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///label and content
  ///
  Widget content({
    required String label,
    String? content,
    required bool center,
    bool? centerLabel = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Align(
        alignment: center == false ? Alignment.centerLeft : Alignment.center,
        child: Wrap(
          children: [
            Text(
              label,
              textAlign:
                  centerLabel == true ? TextAlign.center : TextAlign.left,
              style: Dimensions.fontSizeStyle16w600().copyWith(height: 1.5),
            ),
            if (content != null)
              Text(
                content,
                textAlign: TextAlign.justify,
                style: Dimensions.fontSizeStyle16().copyWith(height: 1.5),
              ),
          ],
        ),
      ),
    );
  }
}
