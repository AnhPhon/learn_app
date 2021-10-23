import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/content_whitebox.dart';
import 'package:template/view/basewidget/widgets/file_upload.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/basewidget/widgets/three_image_box.dart';
import 'package:template/view/screen/v1-customer/quote/response/response_controller.dart';

class V1ResponsePage extends GetView<V1ResponseController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ResponseController>(
      init: V1ResponseController(),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Công việc: ${controller.tenDonDichVu}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // Đơn giá phản hồi
                  LabelContent(
                    title: "Đơn giá phản hồi",
                    content: // vat lieu đã được thêm
                        Column(
                      children: List.generate(controller.infoCard.keys.length,
                          (index) {
                        final keys = controller.infoCard.keys;
                        String key = keys.toList()[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          child: ContentWhiteBox(
                            infoCard: controller.infoCard[key]!,
                          ),
                        );
                      }),
                    ),
                    isRequired: false,
                  ),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  //text
                  _textField(
                    context,
                    "Thời gian nhận dự kiến:",
                    "Từ 7h30\tĐến 11h30",
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // ngày
                  _textField(
                    context,
                    "Ngày",
                    controller.ngayBatDau,
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // báo cáo có hiệu lực đến hết ngày
                  _textField(
                    context,
                    "Báo cáo có hiệu lực đến hết ngày",
                    controller.ngayKetThuc,
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  _lineSplit(context, 2),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // tien do giao hang
                  _tienDoGiaoHang(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // file upload
                  _fileUpload(context),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // hinh anh khoi luong
                  _hinhAnhKhoiLuong(),

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

                  Container(
                    decoration: const BoxDecoration(
                      color: ColorResources.WHITE,
                    ),
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Giá trị đơn hàng",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${PriceConverter.convertPrice(context, controller.tongTien)} VND",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: ColorResources.RED,
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                        // button update and accept
                        _buttonUpdateAndAccept(context)
                      ],
                    ),
                  )
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
  /// tiện độ giao hàng
  ///
  Widget _tienDoGiaoHang(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(
            color: ColorResources.LIGHT_GREY.withOpacity(.5),
            blurRadius: 4,
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
        ),
      ),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        children: [
          const Text(
            "Tiến độ giao hàng",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Loại hình",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.centerRight,
                child: const Text(
                  "Giao gấp",
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_LARGE,
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Phí",
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_LARGE,
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  "${PriceConverter.convertPrice(context, 50000)} VND",
                  style: const TextStyle(
                    color: ColorResources.RED,
                  ),
                ),
              ),
            ],
          )
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
      content: ThreeImageBox(
        images: controller.images,
        allowPicker: false,
      ),
    );
  }

  ///
  /// file upload
  ///
  Widget _fileUpload(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const LabelContent(
        title: "Đính kèm file excel hoặc khác:",
        isRequired: false,
        content: FileUploadWidget(label: "Thêm file"),
      ),
    );
  }

  ///
  /// two feature
  ///
  Widget _buttonUpdateAndAccept(BuildContext context) {
    final List<String> labels = ["Không đồng ý", "Đồng ý"];
    final List<Function()> onTapList = [
      controller.khongDongY,
      controller.onxacNhanClick,
    ];
    final List<Color> colors = [
      const Color(0xFFB0BAC1),
      ColorResources.THEME_DEFAULT
    ];
    return SizedBox(
      height: 70,
      child: GridView.builder(
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

  ///
  /// line split
  ///
  Widget _lineSplit(BuildContext context, double height) {
    return Container(
      height: height,
      width: DeviceUtils.getScaledWidth(context, 1),
      decoration: const BoxDecoration(
        color: ColorResources.GREY,
      ),
    );
  }
}
