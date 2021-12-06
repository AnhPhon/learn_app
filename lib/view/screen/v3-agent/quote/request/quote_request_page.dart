import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/widgets/content_whitebox.dart';
import 'package:template/view/basewidget/widgets/file_upload.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v3-agent/quote/request/quote_request_controller.dart';

class V3QuoteRequestPage extends GetView<V3QuoteRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3QuoteRequestController>(
        init: V3QuoteRequestController(),
        builder: (V3QuoteRequestController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  // tiêu đề báo giá
                  _textWidget("Tiêu đề báo giá", controller.tieuDeBaoGia),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // Chọn loại công trình
                  _textWidget("Chọn loại công trình", controller.loaiCongTrinh),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // địa điểm nhận
                  if (controller.tinhThanh.toString() != "null" &&
                      controller.tinhThanh.toString().isNotEmpty)
                    _diaDiemNhan(),

                  if (controller.tinhThanh.toString() != "null" &&
                      controller.tinhThanh.toString().isNotEmpty)
                    const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // dia chi cu the
                  if (controller.diaChiCuThe.toString() != "null" &&
                      controller.diaChiCuThe.toString().isNotEmpty)
                    _diaChiCuThe(
                        context,
                        (controller.isCheck == true)
                            ? controller.diaChiCuThe
                            : "***"),
                  if (controller.tinhThanh.toString() != "null" &&
                      controller.tinhThanh.toString().isNotEmpty)
                    const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // thời gian dự kiến
                  _thoiGianDuKien(context, controller.infoCard),

                  if (controller.infoCard.isNotEmpty)
                    _bangBaoGia(context, controller.infoCard),
                  if (controller.infoCard.isNotEmpty)
                    const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // noi dung yeu cau
                  _noiDungYeuCau(context, controller.noiDungYeuCau!),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // hinh anh khoi luong
                  ImageListHorizontal(
                    labelBold: true,
                    label: "Hình ảnh bảng khối lượng",
                    imageList: controller.images,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // file upload
                  _fileUpload(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // feature
                  if (controller.isHidden) _featureWidget(),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// text widget
  ///
  Widget _textWidget(String title, String label) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL),
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// dia diem nhan
  ///
  Widget _diaDiemNhan() {
    return LabelContent(
      title: "Địa điểm nhận",
      isRequired: false,
      content: Column(
        children: [
          // Tỉnh/TP:
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Tỉnh/TP: ",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // info
          Container(
            margin: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                // Tinh / Thanh pho
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                if (controller.tinhThanh.isNotEmpty)
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.tinhThanh,
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                    ),
                  ),

                // quan, phuong
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                if (controller.quan.isNotEmpty || controller.phuong.isNotEmpty)
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Quận ${controller.quan}",
                          style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          controller.phuong,
                          style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// dia chi cu the
  ///
  Widget _diaChiCuThe(BuildContext context, String value) {
    return LabelContent(
      title: "Địa chỉ cụ thể (số nhà, tên đường)",
      height: 0,
      isRequired: false,
      content: Container(
        margin: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL),
        alignment: Alignment.centerLeft,
        child: Text(
          value,
          style: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
        ),
      ),
    );
  }

  ///
  /// thoi gian du kien
  ///
  Widget _thoiGianDuKien(
    BuildContext context,
    List<List<Map<String, dynamic>>> infoCard,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Thời gian nhận dự kiến",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Từ ${controller.from}",
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Đến ${controller.to}",
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
            ],
          ),
        )
      ],
    );
  }

  ///
  /// thoi gian du kien
  ///
  Widget _bangBaoGia(
    BuildContext context,
    List<List<Map<String, dynamic>>> infoCard,
  ) {
    return LabelContent(
      title: "Bảng báo giá",
      isRequired: false,
      content: Column(
        children: List.generate(
          infoCard.length,
          (index) => Column(
            children: [
              ContentWhiteBox(
                infoCard: infoCard[index],
                onChanged: (val) {},
              ),
              const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// noi dung yeu cau
  ///
  Widget _noiDungYeuCau(
    BuildContext context,
    List<String> noiDungYeuCau,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nội dung yêu cầu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL),
          alignment: Alignment.centerLeft,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: List.generate(
                noiDungYeuCau.length,
                (index) => Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    noiDungYeuCau[index],
                    style:
                        const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  ///
  /// file upload
  ///
  Widget _fileUpload(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onBtnDownload();
      },
      child: LabelContent(
        title: "Đính kèm file excel hoặc khác:",
        isRequired: false,
        content: (controller.filepath != null &&
                controller.filepath.toString() != "null")
            ? const FileUploadWidget(label: "Tải file")
            : Container(
                alignment: Alignment.center,
                child: const Text("Không có file"),
              ),
      ),
    );
  }

  ///
  /// features widget
  ///
  Widget _featureWidget() {
    return SizedBox(
      height: 80,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 60,
          crossAxisSpacing: 30,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.features!.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: controller.features![index]["onTap"] as Function(),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.features![index]['color'] as Color,
                borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_SMALL)),
              ),
              child: Text(
                controller.features![index]['title'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
