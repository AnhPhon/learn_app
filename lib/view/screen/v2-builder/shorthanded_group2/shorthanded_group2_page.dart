import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_string.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
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
                if (Validate.nullOrEmpty(
                            controller.donDichVuResponse.idNhomDichVu) ==
                        false &&
                    Validate.nullOrEmpty(controller
                            .donDichVuResponse.idNhomDichVu!.tenDichVu) ==
                        false)
                  ContentWidget(
                    maxLineLabel: 2,
                    label: controller.donDichVuResponse.idNhomDichVu!.tenDichVu!
                        .toString(),
                    center: true,
                    centerLabel: true,
                  )
                else
                  const SizedBox(),

                //job title
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.tieuDe) ==
                    false)
                  ContentWidget(
                    label: "Tiêu đề công việc: ",
                    content: controller.donDichVuResponse.tieuDe.toString(),
                  )
                else
                  const SizedBox(),

                //working time in day
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.idThoiGianLamViecs) ==
                    false)
                  ContentWidget(
                    label: "Thời gian làm trong ngày: ",
                    content: controller.donDichVuResponse.idThoiGianLamViecs!
                        .map((e) => e.toString())
                        .join('\n')
                        .toString(),
                  )
                else
                  const SizedBox(),

                //start
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.ngayBatDau) ==
                    false)
                  ContentWidget(
                    label: "Thời gian bắt đầu dự kiến: ",
                    content: controller.getDateOutput(
                        controller.donDichVuResponse.ngayBatDau.toString()),
                  )
                else
                  const SizedBox(),

                //end
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.ngayKetThuc) ==
                    false)
                  ContentWidget(
                    label: "Thời gian kết thúc dự kiến: ",
                    content: controller.getDateOutput(
                        controller.donDichVuResponse.ngayKetThuc.toString()),
                  )
                else
                  const SizedBox(),

                //working address
                if (Validate.nullOrEmpty(
                            controller.donDichVuResponse.idTinhTp) ==
                        false ||
                    Validate.nullOrEmpty(
                            controller.donDichVuResponse.idQuanHuyen) ==
                        false)
                  ContentWidget(
                    label: "Địa điểm làm việc: ",
                    content: ((Validate.nullOrEmpty(controller
                                        .donDichVuResponse.idQuanHuyen) ==
                                    false
                                ? '${controller.donDichVuResponse.idQuanHuyen}, '
                                : '') +
                            (Validate.nullOrEmpty(controller
                                        .donDichVuResponse.idTinhTp) ==
                                    false
                                ? controller.donDichVuResponse.idTinhTp
                                    .toString()
                                : ''))
                        .toString(),
                  )
                else
                  const SizedBox(),

                //job description
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.moTa) ==
                    false)
                  ContentWidget(
                    label: "Mô tả, yêu cầu công việc ",
                    content: controller.donDichVuResponse.moTa.toString(),
                  )
                else
                  const SizedBox(),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //image
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.hinhAnhThucTes) ==
                    false)
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse.hinhAnhThucTes ==
                                null ||
                            controller.donDichVuResponse.hinhAnhThucTes!.isEmpty
                        ? []
                        : controller.donDichVuResponse.hinhAnhThucTes!,
                    label: "Hình ảnh chi tiết nếu có (hình ảnh thực tế)",
                    labelBold: true,
                  )
                else
                  const SizedBox(),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //image
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.hinhAnhBanVes) ==
                    false)
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse.hinhAnhBanVes ==
                                null ||
                            controller.donDichVuResponse.hinhAnhBanVes!.isEmpty
                        ? []
                        : controller.donDichVuResponse.hinhAnhBanVes!,
                    label: "Hình ảnh sản phẩm mẫu (nếu có)",
                    labelBold: true,
                  )
                else
                  const SizedBox(),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //image
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.hinhAnhChiTiets) ==
                    false)
                  ImageListHorizontal(
                    imageList:
                        controller.donDichVuResponse.hinhAnhChiTiets == null ||
                                controller
                                    .donDichVuResponse.hinhAnhChiTiets!.isEmpty
                            ? []
                            : controller.donDichVuResponse.hinhAnhChiTiets!,
                    label: "Hình ảnh tham khảo (nếu có)",
                    labelBold: true,
                  )
                else
                  const SizedBox(),

                //job value description
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.moTaChiTiet) ==
                    false)
                  ContentWidget(
                    label:
                        "Mô tả khối lượng công việc thực hiện (sơ bộ tham khảo) ",
                    content: Validate.nullOrEmpty(
                                controller.donDichVuResponse.moTaChiTiet) ==
                            true
                        ? ''
                        : controller.donDichVuResponse.moTaChiTiet.toString(),
                  )
                else
                  const SizedBox(),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //image
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.hinhAnhBanKhoiLuongs) ==
                    false)
                  ImageListHorizontal(
                    imageList: controller
                                    .donDichVuResponse.hinhAnhBanKhoiLuongs ==
                                null ||
                            controller
                                .donDichVuResponse.hinhAnhBanKhoiLuongs!.isEmpty
                        ? []
                        : controller.donDichVuResponse.hinhAnhBanKhoiLuongs!,
                    label:
                        "Hình ảnh bảng khối lượng hoặc mô tả công việc (nếu có)",
                    labelBold: true,
                  )
                else
                  const SizedBox(),

                //file
                //table label
                if (Validate.nullOrEmpty(
                        controller.donDichVuResponse.files) ==
                    false)
                  Column(
                    children: [
                      const ContentWidget(
                        label: "File đính kèm",
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          bottom: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.donDichVuResponse.files!.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return GestureDetector(
                            onTap: () {
                              CommonHelper.openLink(
                                  url: controller
                                      .donDichVuResponse.files![index]
                                      .toString());
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                StringCut.getFileNameBaoGia(controller
                                    .donDichVuResponse.files![index]
                                    .toString()),
                                style: Dimensions.fontSizeStyle16().copyWith(
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                else
                  const SizedBox(),

                //btn tiep tuc bao gia
                if (controller.coTheBaoGia == true)
                  BtnCustom(
                    onTap: () => controller.onQuotationG2PageClick(),
                    margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                      vertical: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),
                    color: ColorResources.PRIMARY,
                    text: "Tiếp tục và báo giá",
                    width: double.infinity,
                  )
                else
                  const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
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
