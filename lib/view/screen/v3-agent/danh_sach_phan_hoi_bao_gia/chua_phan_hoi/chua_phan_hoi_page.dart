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
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/chua_phan_hoi/chua_phan_hoi_controller.dart';

class V3ChuaPhanHoiPage extends GetView<V3ChuaPhanHoiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3ChuaPhanHoiController>(
        init: V3ChuaPhanHoiController(),
        builder: (V3ChuaPhanHoiController controller) {
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
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // bảng báo giá
                  if (controller.infoCard.isNotEmpty)
                    _bangBaoGia(context, controller.infoCard),
                  if (controller.infoCard.isNotEmpty)
                    const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // thời gian giao hàng
                  _thoiGianGiaoHang(
                    context,
                    controller.timeStartGiaoHang,
                    controller.timeEndGiaoHang,
                    controller.ngayStartGiaoHang,
                    controller.ngayEndGiaoHang,
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // tien do giao hang
                  _tienDoGiaoHang(context, controller.loaiHinh,
                      "${PriceConverter.convertPrice(context, controller.phiGiaoHang)} VNĐ"),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                  // file upload

                  _fileUpload(context, controller.filepath.toString()),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                  // Hinh Anh báo giá
                  ImageListHorizontal(
                    padding: EdgeInsets.zero,
                    label: "Hình ảnh báo giá",
                    labelBold: true,
                    imageList: controller.images,
                  ),
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
                            final String label =
                                infoCard[index][jndex]['label'].toString();
                            TextEditingController? controller;
                            if (infoCard[index][jndex]['controller'] != null) {
                              controller = infoCard[index][jndex]['controller']
                                  as TextEditingController;
                            }

                            final String value =
                                infoCard[index][jndex]['value'].toString();

                            print(value);
                            final bool input =
                                infoCard[index][jndex]['input'] as bool;
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
                                        "$label:",
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
                                        (input == true)
                                            ? controller!.text
                                            : (label.toString().toLowerCase() !=
                                                    "đơn giá")
                                                ? value
                                                : "${PriceConverter.convertPrice(
                                                    context,
                                                    double.parse(value == "null"
                                                        ? "0"
                                                        : value),
                                                  )} VND",
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
  Widget _thoiGianGiaoHang(
    BuildContext context,
    String from,
    String to,
    String dateStart,
    String dateEnd,
  ) {
    const double width = 170;
    return LabelContent(
      title: "Thời gian giao hàng",
      isRequired: false,
      height: 0,
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
          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          if (dateEnd.trim().isNotEmpty)
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
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
          Column(children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  const Text(
                    "Loại hình",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  const Text("Phí",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                      )),
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
  /// file upload
  ///
  Widget _fileUpload(BuildContext context, String filepath) {
    return GestureDetector(
      onTap: () {
        controller.onBtnDownload();
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
