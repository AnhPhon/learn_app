import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/content_whitebox.dart';
import 'package:template/view/basewidget/widgets/file_upload.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/basewidget/widgets/three_image_box.dart';
import 'package:template/view/screen/v1-customer/quote/check/check_controller.dart';

class V1CheckPage extends GetView<V1CheckController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1CheckController>(
      init: V1CheckController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                children: [
                  _textField(
                    context,
                    "Tiêu đề báo giá",
                    "Cần báo giá vật liệu, xi măng, cát, đá",
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  //text
                  _textField(
                    context,
                    "Công trình",
                    "Biệt thự",
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  //text
                  _textField(
                    context,
                    "Địa điểm nhận",
                    "Thanh Khê Tây - Đà Nẵng",
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  //text
                  _textField(
                    context,
                    "Thời gian nhận dự kiến:",
                    "Từ 10/09/2021\tĐến 10/12/2021",
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  //text
                  _textField(
                    context,
                    "Nội dung yêu cầu",
                    "Nội dung yêu cầu theo màng hình KH12",
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // bang khoi luong
                  LabelContent(
                    title: "Bảng khối lượng",
                    content: // vat lieu đã được thêm
                        Column(
                      children: List.generate(2, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          child: ContentWhiteBox(
                            infoCard: controller.infoCard!,
                          ),
                        );
                      }),
                    ),
                    isRequired: false,
                  ),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // hinh anh khoi luong
                  _hinhAnhKhoiLuong(),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // file upload
                  _fileUpload(context),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // bottom
                  Row(
                    children: [
                      Text("Tiến độ giao hàng",
                          style: Dimensions.textTitleStyleCard()),
                      const Spacer(),
                      const Text(
                        "Cần gấp",
                        style: TextStyle(
                          color: ColorResources.RED,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // button update and accept
                  _buttonUpdateAndAccept(context)
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
          Container(
            alignment: Alignment.centerLeft,
            child: Text("$label: ", style: Dimensions.textTitleStyleCard()),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(content, style: Dimensions.textNormalStyleCard()),
          ),
        ],
      ),
    );
  }

  ///
  /// hinh anh khoi luong
  ///
  Widget _hinhAnhKhoiLuong() {
    return LabelContent(
      title: "Hình ảnh bảng khối lượng",
      isRequired: false,
      content: const ThreeImageBox(
        images: [
          Images.location_example,
          Images.location_example,
          Images.location_example,
        ],
        allowPicker: false,
      ),
    );
  }

  ///
  /// file upload
  ///
  Widget _fileUpload(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onBtnDownloadCv(url: controller.fileURL.toString());
      },
      child: LabelContent(
        title: "Đính kèm file excel hoặc khác:",
        isRequired: false,
        content: (controller.fileURL != null &&
                controller.fileURL.toString() != "null")
            ? const FileUploadWidget(label: "Thêm file")
            : Container(
                alignment: Alignment.center,
                child: const Text("Không có file"),
              ),
      ),
    );
  }

  ///
  /// two feature
  ///
  Widget _buttonUpdateAndAccept(BuildContext context) {
    final List<String> labels = ["Chỉnh sửa", "Xác nhận"];
    final List<Function()> onTapList = [() {}, controller.onxacNhanClick];
    final List<Color> colors = [
      const Color(0xFFB0BAC1),
      ColorResources.THEME_DEFAULT
    ];
    return SizedBox(
      height: 100,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 50,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: onTapList[index],
            child: Container(
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors[index],
                borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_SMALL)),
              ),
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Text(
                labels[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
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
