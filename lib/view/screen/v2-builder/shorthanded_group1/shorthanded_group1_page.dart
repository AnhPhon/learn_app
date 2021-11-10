import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group1/shorthanded_group1_conroller.dart';

class V2ShorthandedGroup1Page extends GetView<V2ShorthandedGroup1Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedGroup1Controller>(
        init: V2ShorthandedGroup1Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  ContentWidget(
                      label: controller.donDichVuResponse == null
                          ? ''
                          : controller
                              .donDichVuResponse!.idNhomDichVu!.tenDichVu!
                              .toString(),
                      center: true),

                  //job label
                  ContentWidget(
                    label: "Tiêu đề công việc: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.tieuDe.toString(),
                  ),

                  //job detail
                  ContentWidget(
                    label: "Mô tả công việc: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.moTa.toString(),
                  ),

                  //working address
                  ContentWidget(
                    label: "Địa điểm làm việc: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.diaDiemLamViec
                            .toString(),
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

                  //table label
                  const ContentWidget(
                    label:
                        "Bảng khối lượng công việc cần báo giá\n(Chỉ báo giá phần nhân công) ",
                    center: true,
                    centerLabel: true,
                  ),

                  //table
                  if (controller.flagSeeMore == false)
                    Container(
                      margin: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT,
                        // right: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: BoxShadowWidget(
                        child: Column(
                          children: (controller.chiTietCongViecResponse ==
                                      null ||
                                  controller.chiTietCongViecResponse!.isEmpty)
                              ? []
                              : [
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                                  ),
                                  _rowtext(
                                    text1: "Tên công việc:",
                                    text2: controller
                                        .chiTietCongViecResponse![0].tenCongViec
                                        .toString(),
                                  ),
                                  _rowtext(
                                    text1: "Quy cách:",
                                    text2: controller
                                        .chiTietCongViecResponse![0].quyCach
                                        .toString(),
                                  ),
                                  _rowtext(
                                    text1: "Khối lượng:",
                                    text2: controller
                                        .chiTietCongViecResponse![0].soLuong
                                        .toString(),
                                  ),
                                  _rowtext(
                                    text1: "Đơn vị",
                                    text2: controller
                                        .chiTietCongViecResponse![0].donVi
                                        .toString(),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                                  ),
                                ],
                        ),
                      ),
                    )
                  else
                    buildListViewVatTu(controller),

                  //show more
                  if (controller.flagSeeMore == false)
                    _showMore()
                  else
                    SizedBox(),

                  //table label
                  const ContentWidget(
                    label: "File khối lượng",
                    center: false,
                    centerLabel: true,
                  ),
                  //file
                  //item list
                  // buildListViewVatTu(controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse == null ||
                            controller
                                    .donDichVuResponse!.hinhAnhBanKhoiLuongs ==
                                null
                        ? []
                        : controller.donDichVuResponse!.hinhAnhBanKhoiLuongs!,
                    label: "Hình ảnh bảng khối lượng",
                    labelBold: true,
                  ),

                  //image
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse == null ||
                            controller.donDichVuResponse!.hinhAnhBanVes == null
                        ? []
                        : controller.donDichVuResponse!.hinhAnhBanVes!,
                    label: "Hình ảnh bảng vẽ",
                    labelBold: true,
                  ),

                  //rights
                  _rights(),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //btn
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: BtnCustom(
                      onTap: () => controller.onQuotationG1PageClick(),
                      color: ColorResources.PRIMARY,
                      text: "Tiếp tục và báo giá",
                      width: double.infinity,
                    ),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ListView buildListViewVatTu(V2ShorthandedGroup1Controller controller) {
    return ListView.builder(
        padding: const EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT,
          bottom: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (controller.chiTietCongViecResponse == null ||
                controller.chiTietCongViecResponse!.isEmpty)
            ? 0
            : controller.chiTietCongViecResponse!.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Container(
            margin: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_DEFAULT,
              // right: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: BoxShadowWidget(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                  _rowtext(
                    text1: "Tên công việc:",
                    text2: controller
                        .chiTietCongViecResponse![index].tenCongViec
                        .toString(),
                  ),
                  _rowtext(
                    text1: "Quy cách:",
                    text2: controller
                        .chiTietCongViecResponse![index].quyCach
                        .toString(),
                  ),
                  _rowtext(
                    text1: "Khối lượng:",
                    text2: controller
                        .chiTietCongViecResponse![index].soLuong
                        .toString(),
                  ),
                  _rowtext(
                    text1: "Đơn vị",
                    text2: controller
                        .chiTietCongViecResponse![index].donVi
                        .toString(),
                  ),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///row text
  ///
  Widget _rowtext({
    required String text1,
    required String text2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: DefaultTextStyle(
        textAlign: TextAlign.left,
        style: Dimensions.fontSizeStyle18().copyWith(
          color: ColorResources.BLACK,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                text1,
              ),
            ),
            Expanded(
                flex: 5,
                child: Text(
                  text2,
                )),
          ],
        ),
      ),
    );
  }

  ///
  ///show more
  ///
  Widget _showMore() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: GestureDetector(
        onTap: () {
          controller.showMoreVatTu();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Xem thêm",
              style: Dimensions.fontSizeStyle16w600().copyWith(
                color: ColorResources.PRIMARY,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: ColorResources.PRIMARY,
              size: Dimensions.ICON_SIZE_SMALL,
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///rights
  ///
  Widget _rights() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Quyền lợi",
              style: Dimensions.fontSizeStyle16w600(),
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          BoxShadowWidget(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT,
              horizontal: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Text(
              "Bạn sẽ được bố trí công việc thường xuyên nếu làm tốt, được khách hàng đánh giá trong và sau khi kết thúc công việc + thời gian bảo hành",
              textAlign: TextAlign.justify,
              style: Dimensions.fontSizeStyle16(),
            ),
          )),
        ],
      ),
    );
  }
}
