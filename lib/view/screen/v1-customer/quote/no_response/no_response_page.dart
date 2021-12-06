import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/widgets/content_whitebox.dart';
import 'package:template/view/basewidget/widgets/file_upload.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v1-customer/quote/no_response/no_response_controller.dart';

class V1NoResponsePage extends GetView<V1NoResponseController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1NoResponseController>(
      init: V1NoResponseController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                children: [
                  _textField(
                      context, "Tiêu đề báo giá", controller.tenDonDichVu),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // công trình
                  _textField(context, "Công trình", controller.congTrinh),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  //text
                  _textField(
                    context,
                    "Địa điểm nhận",
                    controller.diaChi,
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  //text
                  _textField(
                    context,
                    "Thời gian nhận dự kiến",
                    "         Từ ${controller.ngayBatDau}           Đến ${controller.ngayKetThuc}",
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // ngày
                  _textField(context, "Nội dung yêu cầu", controller.yeuCau),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // bảng khối lượng
                  if (controller.infoCard.isNotEmpty) bangKhoiLuong(),
                  if (controller.infoCard.isNotEmpty)
                    const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // hinh anh khoi luong
                  ImageListHorizontal(
                    labelBold: true,
                    label: "Hình ảnh bảng khối lượng",
                    imageList: controller.images,
                    padding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // file upload
                  _fileUpload(context),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // bottom
                  Row(
                    children: [
                      const Text(
                        "Tiến độ giao hàng",
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        controller.loaiHinh == "1"
                            ? "Giao gấp"
                            : "Không giao gấp",
                        style: const TextStyle(
                          color: ColorResources.RED,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  /// text field
  ///
  Widget _textField(BuildContext context, String label, String content) {
    return SizedBox(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Wrap(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Bảng khối lượng
  ///
  Widget bangKhoiLuong() {
    // Đơn giá phản hồi
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bảng khối lượng",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
        ),
        Column(
          children: List.generate(controller.infoCard.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: ContentWhiteBox(
                infoCard: controller.infoCard[index],
              ),
            );
          }),
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
        content: (controller.fileURL != null &&
                controller.fileURL.toString() != "null")
            ? const FileUploadWidget(label: "Tải file")
            : Container(
                alignment: Alignment.center,
                child: const Text("Không có file"),
              ),
      ),
    );
  }

  ///
  /// line split
  ///
  // Widget _lineSplit(BuildContext context, double height) {
  //   return Container(
  //     height: height,
  //     width: DeviceUtils.getScaledWidth(context, 1),
  //     decoration: const BoxDecoration(
  //       color: ColorResources.GREY,
  //     ),
  //   );
  // }
}
