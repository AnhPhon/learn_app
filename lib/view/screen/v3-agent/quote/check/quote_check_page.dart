import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/basewidget/widgets/file_upload.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v3-agent/quote/check/quote_check_controller.dart';

class V3QuoteCheckPage extends GetView<V3QuoteCheckController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Kiểm tra báo giá"),
      body: GetBuilder<V3QuoteCheckController>(
        init: V3QuoteCheckController(),
        builder: (V3QuoteCheckController controller) {
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

                  // bảng báo giá
                  _bangBaoGia(context, controller.infoCard),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // thời gian giao hàng
                  _thoiGianGiaoHang(context, controller.timeStart,
                      controller.timeEnd, controller.from, controller.to),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // tien do giao hang
                  _tienDoGiaoHang(context, controller.loaiHinh,
                      "${PriceConverter.convertPrice(context, controller.phiVanChuyen)} VNĐ"),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // file upload
                  _fileUpload(context, controller.filepath),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // Hinh Anh Khoi Luong
                  ImageListHorizontal(
                    padding: EdgeInsets.zero,
                    label: "Hình ảnh báo giá",
                    labelBold: true,
                    imageList: controller.images,
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // feature
                  _giatriDonHang(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
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
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
        ),
        Container(
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
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(.4),
                    )
                  ],
                ),
                child: Column(
                  children: infoCard.isEmpty
                      ? []
                      : List.generate(
                          infoCard[index].length,
                          (jndex) {
                            return SizedBox(
                              height: 30,
                              width: DeviceUtils.getScaledWidth(context, 1),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 7,
                                    child: SizedBox(
                                      width: DeviceUtils.getScaledWidth(
                                          context, .3),
                                      child: Text(
                                        "${infoCard[index][jndex]['label']}:",
                                        style: const TextStyle(
                                          fontSize: Dimensions.FONT_SIZE_LARGE,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left:
                                        DeviceUtils.getScaledWidth(context, .3),
                                    child: SizedBox(
                                      width: DeviceUtils.getScaledWidth(
                                          context, .7),
                                      child: Text(
                                        (infoCard[index][jndex]['controller'] !=
                                                null)
                                            ? "${PriceConverter.convertPrice(
                                                context,
                                                double.parse((infoCard[index]
                                                                [jndex]
                                                            ['controller']
                                                        as TextEditingController)
                                                    .text
                                                    .replaceAll(".", "")
                                                    .replaceAll("VND", "")
                                                    .trim()),
                                              )} VND"
                                            : infoCard[index][jndex]['value']
                                                .toString(),
                                        style: const TextStyle(
                                          fontSize: Dimensions.FONT_SIZE_LARGE,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_SMALL,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// fileWidget
  ///
  Widget fileWidget() {
    return LabelContent(
      title: "File excel hoặc khác",
      isRequired: false,
      content: Container(
        height: 115,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorResources.THEME_DEFAULT),
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 90,
            crossAxisSpacing: 10,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.example,
                  image: Images.location_example,
                  height: 90,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  /// thoi gian giao hang
  ///
  Widget _thoiGianGiaoHang(BuildContext context, String from, String to,
      String dateStart, String dateEnd) {
    const double width = 170;
    return LabelContent(
      title: "Thời gian giao hàng",
      isRequired: false,
      content: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: width,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Từ",
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                  Container(
                    width: width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      from,
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                    ),
                  ),
                ],
              ),
              // const Spacer(),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width,
                    child: const Text(
                      "Đến",
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width,
                    child: Text(
                      to,
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Ngày",
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  dateStart,
                  style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Báo cáo có hiệu lực đến hết ngày",
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  dateEnd,
                  style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
        ],
      ),
    );
  }

  ///
  /// conHieuLuc
  ///
  Widget _tienDoGiaoHang(BuildContext context, String status, String cost) {
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
              height: 30,
              child: Row(
                children: [
                  const Text(
                    "Loại hình",
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: DeviceUtils.getScaledWidth(context, .35),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      status,
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        color: ColorResources.RED,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  const Text(
                    "Phí",
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: DeviceUtils.getScaledWidth(context, .35),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      cost,
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
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
  /// feature
  ///
  Widget _giatriDonHang(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimensions.BORDER_RADIUS_LARGE)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 5,
            )
          ]),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Column(
        children: [
          Row(
            children: [
              Text("Tổng tiền thanh toán",
                  style: Dimensions.textTitleStyleCard()),
              const Spacer(),
              Text(
                "${PriceConverter.convertPrice(context, controller.giaTriDonHang)} VND",
                style: const TextStyle(
                  color: ColorResources.RED,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          SizedBox(
            height: 80,
            child: GridView.builder(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 60,
                crossAxisSpacing: 30,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.features.length,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                  onTap: controller.features[index]["onTap"] as Function(),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.features[index]['color'] as Color,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimensions.BORDER_RADIUS_SMALL)),
                    ),
                    child: Text(
                      controller.features[index]['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  ///
  /// file upload
  ///
  Widget _fileUpload(BuildContext context, String? filepath) {
    return GestureDetector(
      onTap: () {
        controller.onBtnDownload(url: filepath.toString());
      },
      child: LabelContent(
        title: "File báo giá:",
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
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
