import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/widgets/content_whitebox.dart';
import 'package:template/view/basewidget/widgets/file_upload.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
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
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // Đơn giá phản hồi
                  _donGiaPhanHoi(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  //text
                  _textField(
                    context,
                    "Thời gian nhận dự kiến",
                    "Từ ${controller.timeStart}\tĐến ${controller.timeEnd}",
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

                  // tien do giao hang
                  _tienDoGiaoHang(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // file upload
                  fileDownload(context),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // hinh anh khoi luong
                  _hinhAnhKhoiLuong(),

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
                        controller.loaiHinh,
                        style: const TextStyle(
                          color: ColorResources.RED,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  if (controller.idDonDichVu!.idTrangThaiDonDichVu!.id! !=
                      THAT_BAI)
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
                                  "Tổng tiền thanh toán",
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
                          if (controller.isHidden == false)
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
  /// don gia phan hoi
  ///
  Widget _donGiaPhanHoi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Đơn giá phản hồi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
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
                onChanged: (val) {},
              ),
            );
          }),
        )
      ],
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
            child: Text(
              "$label: ",
              style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              content,
              style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// conHieuLuc
  ///
  Widget _tienDoGiaoHang(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(.5),
          )
        ],
      ),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        children: [
          const Text(
            "Tiến độ giao hàng",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(children: [
            SizedBox(
              height: 40,
              width: DeviceUtils.getScaledWidth(context, 1),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 20,
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .5),
                      child: const Text(
                        "Loại hình",
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 0,
                    left: DeviceUtils.getScaledWidth(context, .5),
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .5),
                      child: Text(
                        controller.loaiHinh,
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              width: DeviceUtils.getScaledWidth(context, 1),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 30,
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .5),
                      child: const Text(
                        "Phí",
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 0,
                    left: DeviceUtils.getScaledWidth(context, .5),
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .5),
                      child: Text(
                        "${PriceConverter.convertPrice(context, controller.phiVanChuyen)} VNĐ",
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: ColorResources.RED,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }

  ///
  /// hinh anh khoi luong
  ///
  Widget _hinhAnhKhoiLuong() {
    return ImageListHorizontal(
      imageList: controller.images,
      padding: EdgeInsets.zero,
      label: "Hình ảnh báo giá",
      labelBold: true,
    );
  }

  ///
  /// file upload
  ///
  Widget fileDownload(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onBtnDownload();
      },
      child: LabelContent(
        title: "File báo giá",
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
}
