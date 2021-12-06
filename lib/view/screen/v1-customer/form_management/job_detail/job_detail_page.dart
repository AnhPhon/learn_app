import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/screen/v1-customer/form_management/job_detail/job_detail_controller.dart';

class V1JobDetailPage extends GetView<V1JobDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1JobDetailController>(
        init: V1JobDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  _textTitle(
                    context,
                    title: controller.donDichVuResponse.tieuDe.toString(),
                  ),

                  //title list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _richText(
                        context,
                        text1: "Công việc: ",
                        text2: controller.donDichVuResponse.moTa.toString(),
                      ),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      _richText(
                        context,
                        text1: "Mô tả công việc: ",
                        text2:
                            controller.donDichVuResponse.moTaChiTiet.toString(),
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      _richText(
                        context,
                        text1: "Thời gian: ",
                        listText2: controller
                            .donDichVuResponse.idThoiGianLamViecs!
                            .map((e) => e.tieuDe.toString())
                            .toList(),
                      ),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      // title job container
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Text(
                          "Bảng khối lượng công việc cần báo giá",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //job container
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.vatTuList.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return _jobContainer(context,
                              name: controller.vatTuList[index].tenVatTu
                                  .toString(),
                              specifications: controller
                                  .vatTuList[index].quyCach
                                  .toString(),
                              weight: "controller.vatTuList[index].",
                              unit:
                                  controller.vatTuList[index].donVi.toString(),
                              price:
                                  '' //controller.vatTuList[index].donGia.toString(),
                              );
                        },
                      ),

                      //file picker
                      _filePicker(context),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //hinh anh bang khoi luong
                      ImageListHorizontal(
                        label:
                            "Hình ảnh bảng khối lượng\n(Bảng in hoặc viết bằng tay nếu có)",
                        labelBold: true,
                        imageList:
                            controller.donDichVuResponse.hinhAnhBanKhoiLuongs!,
                      ),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      // title image container
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Text(
                          "Hình ảnh bản vẽ (nếu có)",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //hinh anh ban ve
                      ImageListHorizontal(
                        label: "Hình ảnh bản vẽ (nếu có)",
                        labelBold: true,
                        imageList: controller.hinhAnhBanVe,
                      ),

                      //title note
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Text(
                          "Ghi chú",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //note
                      _note(context, controller),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_LARGE,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ///
  ///rich text title
  ///
  Widget _richText(BuildContext context,
      {required String text1, String? text2, List<String>? listText2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: RichText(
        text: TextSpan(
            text: text1,
            style: const TextStyle(
                color: ColorResources.BLACK,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold),
            children: [
              if (listText2 != null)
                ...listText2
                    .map(
                      (e) => TextSpan(
                        text:
                            "$e${e != controller.donDichVuResponse.idThoiGianLamViecs!.last.tieuDe ? ', ' : ''}",
                        style: TextStyle(
                          height: 1.5,
                          color: ColorResources.BLACK.withOpacity(.75),
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),
                    )
                    .toList(),
              if (text2 != null)
                TextSpan(
                  text: text2,
                  style: TextStyle(
                    height: 1.5,
                    color: ColorResources.BLACK.withOpacity(.75),
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
            ]),
      ),
    );
  }

  ///
  ///job container
  ///
  Widget _jobContainer(
    BuildContext context, {
    required String name,
    required String unit,
    required String weight,
    required String specifications,
    required String price,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_SMALL,
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 10),
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: ColorResources.BLACK),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tên vật liệu: $name"),
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
            Text("Quy cách: $specifications"),
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
            Text("Khối lượng: $weight"),
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
            Text("Đơn vị: $unit"),
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
            Text(
                "Đơn giá: ${PriceConverter.convertPrice(context, double.parse(price))}"),
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          ],
        ),
      ),
    );
  }

  ///
  ///file picker
  ///
  Widget _filePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.downloadFile(
        url: (Validate.nullOrEmpty(
                    controller.donDichVuResponse.files) ==
                false)
            ? controller.donDichVuResponse.files![0].toString()
            : '',
      ),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_SMALL,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_SMALL,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          color: ColorResources.WHITE,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10),
          ],
        ),
        child: const Text(
          "File báo giá khối lượng",
          style: TextStyle(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
        ),
      ),
    );
  }

  ///
  ///image list
  ///
  // Widget _imageList(
  //   BuildContext context, {
  //   required List imageList,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.025)),
  //     margin: const EdgeInsets.symmetric(
  //         horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
  //         vertical: Dimensions.MARGIN_SIZE_DEFAULT),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: ColorResources.PRIMARY),
  //       borderRadius:
  //           BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
  //     ),
  //     height: DeviceUtils.getScaledHeight(context, .14),
  //     child: ListView.builder(
  //         shrinkWrap: true,
  //         scrollDirection: Axis.horizontal,
  //         itemCount: imageList.length,
  //         itemBuilder: (BuildContext context, index) {
  //           return Padding(
  //             padding: const EdgeInsets.only(
  //                 right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
  //             child: FadeInImageCustom(
  //                 urlImage: imageList[index].toString(),
  //                 height: .122,
  //                 width: .254),
  //           );
  //         }),
  //   );
  // }

  ///
  ///note
  ///
  Widget _note(BuildContext context, V1JobDetailController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_SMALL,
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 10),
        ],
      ),
      child: Text(
        controller.note,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            height: 1.3, fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
      ),
    );
  }
}
