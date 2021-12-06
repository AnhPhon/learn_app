import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/widgets/content_whitebox.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v3-agent/quote/response/quote_response_controller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class V3QuoteResponsePage extends GetView<V3QuoteResponseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Danh sách báo giá đơn hàng"),
      body: GetBuilder<V3QuoteResponseController>(
        init: V3QuoteResponseController(),
        builder: (V3QuoteResponseController controller) {
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

                  // bảng báo giá
                  if (controller.infoCard.isNotEmpty)
                    _bangBaoGia(context, controller.infoCard),
                  if (controller.infoCard.isNotEmpty)
                    const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // thời gian giao hàng
                  _thoiGianGiaoHang(context, "09h30", "10h30", "12-09-2021"),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // Thời gian hiệu cực
                  _baoGiaCoHieuLuc(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // tien do giao hang
                  _tienDoGiaoHang(context, controller.loaiHinh),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // file widget
                  attchFile(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // Hinh Anh Khoi Luong
                  ImageListHorizontalAdd(
                    padding: EdgeInsets.zero,
                    label: "Hình ảnh báo giá",
                    labelBold: true,
                    imageFileList: controller.images,
                    pickImage: () {
                      controller.pickImages();
                    },
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                  // feature
                  _giatriDonHang(context),
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
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
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
              ContentWhiteBox(
                infoCard: infoCard[index],
                onChanged: (val) {
                  controller.onMoneyChange(val);
                },
              ),
              const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// attchFile
  ///
  Widget attchFile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "File báo giá",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
        ),
        AttachButton(
          title:
              controller.filepath.isEmpty ? "Upload file" : controller.filepath,
          color: ColorResources.WHITE,
          onPressed: controller.pickFiles,
        )
      ],
    );
  }

  ///
  /// thoi gian giao hang
  ///
  Widget _thoiGianGiaoHang(
      BuildContext context, String from, String to, String date) {
    final double width = DeviceUtils.getScaledWidth(context, .45);
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
                  SizedBox(height: DeviceUtils.getScaledHeight(context, .01)),
                  Container(
                    width: width,
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      focusNode: AlwaysDisabledFocusNode(),
                      controller: controller.fromController,
                      decoration: InputDecoration(
                        fillColor: ColorResources.WHITE,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorResources.LIGHT_SKY_BLUE_HEIGHT),
                        ),
                        hintText: controller.fromController.text,
                        contentPadding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_SMALL,
                        ),
                      ),
                      onTap: () {
                        controller.fromSelectTime(context);
                      },
                    ),
                  ),
                ],
              ),
              // const SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
              const Spacer(),
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
                  SizedBox(height: DeviceUtils.getScaledHeight(context, .01)),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width,
                    child: TextField(
                      focusNode: AlwaysDisabledFocusNode(),
                      controller: controller.toController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: BorderSide(
                              color: ColorResources.LIGHT_SKY_BLUE_HEIGHT),
                        ),
                        hintText: controller.toController.text,
                        contentPadding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_SMALL,
                        ),
                      ),
                      onTap: () {
                        controller.toSelectTime(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: DeviceUtils.getScaledWidth(context, 1),
                child: const Text(
                  "Ngày",
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
              Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: controller.dateStartController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(
                          color: ColorResources.LIGHT_SKY_BLUE_HEIGHT),
                    ),
                    hintText: '12/09/2021',
                    contentPadding: EdgeInsets.all(
                      Dimensions.PADDING_SIZE_SMALL,
                    ),
                    fillColor: ColorResources.WHITE,
                    suffixIcon: Icon(Icons.date_range_outlined),
                  ),
                  onTap: () {
                    controller.dateStartPicker(
                      context,
                      DateTime.now(),
                      DateTime(2100, 12, 31),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  ///
  /// conHieuLuc
  ///
  Widget _baoGiaCoHieuLuc(BuildContext context) {
    return LabelContent(
      title: "Báo giá có hiệu thực đến hết ngày",
      isRequired: false,
      content: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: controller.dateEndController,
        decoration: const InputDecoration(
          fillColor: ColorResources.WHITE,
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: ColorResources.LIGHT_SKY_BLUE_HEIGHT),
          ),
          hintText: '12/09/2021',
          contentPadding: EdgeInsets.all(
            Dimensions.PADDING_SIZE_SMALL,
          ),
          suffixIcon: Icon(Icons.date_range_outlined),
        ),
        onTap: () {
          controller.dateEndPicker(
            context,
            DateTime.now(),
            DateTime(2100, 12, 31),
          );
        },
      ),
    );
  }

  ///
  /// conHieuLuc
  ///
  Widget _tienDoGiaoHang(BuildContext context, String status) {
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
          Text(
            "Tiến độ giao hàng",
            style: Dimensions.textTitleStyleCard(),
          ),
          Column(children: [
            SizedBox(
              height: 50,
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
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 0,
                    left: DeviceUtils.getScaledWidth(context, .5),
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .5),
                      child: Text(
                        controller.loaiHinh,
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: DeviceUtils.getScaledWidth(context, 1),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 20,
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .5),
                      child: const Text(
                        "Phí",
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: DeviceUtils.getScaledWidth(context, .5),
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .5),
                      child: TextField(
                        inputFormatters: [
                          CurrencyTextInputFormatter(locale: "vi")
                        ],
                        onChanged: (val) {
                          controller.onMoneyChange(null);
                        },
                        controller: controller.costController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          fillColor: ColorResources.WHITE,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorResources.LIGHT_SKY_BLUE_HEIGHT),
                          ),
                          hintText: 'Phí',
                          contentPadding: EdgeInsets.all(
                            Dimensions.PADDING_SIZE_SMALL,
                          ),
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
                "${PriceConverter.convertPrice(context, controller.giaTriDonHang)} vnđ",
                style: const TextStyle(
                  color: ColorResources.RED,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceUtils.getScaledHeight(context, .04)),
          GestureDetector(
            onTap: () {
              controller.onContinueClick();
            },
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              width: DeviceUtils.getScaledWidth(context, 1),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: ColorResources.THEME_DEFAULT,
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_LARGE)),
              ),
              child: const Text(
                "Tiếp tục",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
