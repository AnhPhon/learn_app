import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/helper/string_cut.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
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
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idNhomDichVu) == false && Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idNhomDichVu!.tenDichVu) == false)
                  ContentWidget(
                    label: controller.donDichVuResponse.idNhomDichVu!.tenDichVu!.toString(),
                    center: true,
                    centerLabel: true,
                  )
                else
                  const SizedBox(),

                //job label
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.tieuDe) == false)
                  ContentWidget(
                    label: "Tiêu đề công việc: ",
                    content: controller.donDichVuResponse.tieuDe.toString(),
                  )
                else
                  const SizedBox(),

                //job detail
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.moTa) == false)
                  ContentWidget(
                    label: "Mô tả công việc: ",
                    content: controller.donDichVuResponse.moTa.toString(),
                  )
                else
                  const SizedBox(),

                //working address
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idTinhTp) == false || Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idQuanHuyen) == false)
                  ContentWidget(
                    label: "Địa điểm làm việc: ",
                    content: ((Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idQuanHuyen) == false ? '${controller.donDichVuResponse.idQuanHuyen}, ' : '') + (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idTinhTp) == false ? controller.donDichVuResponse.idTinhTp.toString() : '')).toString(),
                  )
                else
                  const SizedBox(),

                //start
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.ngayBatDau) == false)
                  ContentWidget(
                    label: "Thời gian bắt đầu dự kiến: ",
                    content: controller.getDateOutput(controller.donDichVuResponse.ngayBatDau.toString()),
                  )
                else
                  const SizedBox(),

                //end
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.ngayKetThuc) == false)
                  ContentWidget(
                    label: "Thời gian kết thúc dự kiến: ",
                    content: controller.getDateOutput(controller.donDichVuResponse.ngayKetThuc.toString()),
                  )
                else
                  const SizedBox(),

                //table label
                if (Validate.checkValueIsNullEmpty(controller.chiTietCongViecResponse) == false)
                  const ContentWidget(
                    label: "Bảng khối lượng công việc cần báo giá\n(Chỉ báo giá phần nhân công): ",
                    center: true,
                    centerLabel: true,
                  )
                else
                  const SizedBox(),

                //table
                if (controller.flagSeeMore == false)
                  Container(
                    margin: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: BoxShadowWidget(
                      child: Column(
                        children: (controller.chiTietCongViecResponse == null || controller.chiTietCongViecResponse!.isEmpty)
                            ? []
                            : [
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                                ),
                                _rowtext(
                                  text1: "Tên công việc:",
                                  text2: controller.chiTietCongViecResponse![0].tenCongViec.toString(),
                                ),
                                _rowtext(
                                  text1: "Quy cách:",
                                  text2: controller.chiTietCongViecResponse![0].quyCach.toString(),
                                ),
                                _rowtext(
                                  text1: "Khối lượng:",
                                  text2: controller.chiTietCongViecResponse![0].soLuong.toString(),
                                ),
                                _rowtext(
                                  text1: "Đơn vị:",
                                  text2: controller.chiTietCongViecResponse![0].donVi.toString(),
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

                //btn show more
                if (Validate.checkValueIsNullEmpty(controller.chiTietCongViecResponse) == false && controller.flagSeeMore == false) _showMore() else const SizedBox(),

                // file khoi luong
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.files) == false)
                  Column(
                    children: [
                      const ContentWidget(
                        label: "File khối lượng",
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
                              CommonHelper.openLink(url: controller.donDichVuResponse.files![index].toString());
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                StringCut.getFileNameBaoGia(controller.donDichVuResponse.files![index].toString()),
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

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //image khoi luong
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.hinhAnhBanKhoiLuongs) == false)
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse.hinhAnhBanKhoiLuongs == null ? [] : controller.donDichVuResponse.hinhAnhBanKhoiLuongs!,
                    label: "Hình ảnh bảng khối lượng",
                    labelBold: true,
                  )
                else
                  const SizedBox(),

                //image bang ve
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.hinhAnhBanVes) == false)
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse.hinhAnhBanVes == null ? [] : controller.donDichVuResponse.hinhAnhBanVes!,
                    label: "Hình ảnh bảng vẽ",
                    labelBold: true,
                  )
                else
                  const SizedBox(),

                // quyen loi
                _rights(),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                ),

                //btn tiep tuc bbao gia
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  child: controller.coTheBaoGia == true
                      ? BtnCustom(
                          onTap: () => controller.onQuotationG1PageClick(),
                          color: ColorResources.PRIMARY,
                          text: "Tiếp tục và báo giá",
                          width: double.infinity,
                        )
                      : const SizedBox(),
                ),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                ),
              ],
            ),
          ),
        );
      },
    );
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
      itemCount: (controller.chiTietCongViecResponse == null || controller.chiTietCongViecResponse!.isEmpty) ? 0 : controller.chiTietCongViecResponse!.length,
      itemBuilder: (BuildContext ctx, int index) {
        return Container(
          margin: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: BoxShadowWidget(
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                _rowtext(
                  text1: "Tên công việc:",
                  text2: controller.chiTietCongViecResponse![index].tenCongViec.toString(),
                ),
                _rowtext(
                  text1: "Quy cách:",
                  text2: controller.chiTietCongViecResponse![index].quyCach.toString(),
                ),
                _rowtext(
                  text1: "Khối lượng:",
                  text2: controller.chiTietCongViecResponse![index].soLuong.toString(),
                ),
                _rowtext(
                  text1: "Đơn vị",
                  text2: controller.chiTietCongViecResponse![index].donVi.toString(),
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
              ],
            ),
          ),
        );
      },
    );
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
              ),
            ),
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
  /// quyen loi
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
