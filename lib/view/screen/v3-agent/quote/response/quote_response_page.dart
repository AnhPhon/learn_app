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
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v3-agent/quote/response/quote_response_controller.dart';

class V3QuoteResponsePage extends GetView<V3QuoteResponseController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarWidget(title: "Danh sách báo giá đơn hàng"),
      body: GetBuilder<V3QuoteResponseController>(
        init: V3QuoteResponseController(),
        builder: (V3QuoteResponseController controller) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  // tiêu đề báo giá
                  _textWidget("Tiêu đề báo giá", controller.tieuDeBaoGia),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),

                  // bảng báo giá
                  _bangBaoGia(context, controller.infoCard),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),

                  // thời gian giao hàng
                  _thoiGianGiaoHang(context, "09h30", "10h30", "12-09-2021"),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),

                  // Thời gian hiệu cực
                  _baoGiaCoHieuLuc(context),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),

                  // tien do giao hang
                  _tienDoGiaoHang(context, "Giao cấp",
                      "${PriceConverter.convertPrice(context, 50000)} VNĐ"),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),

                  // Hinh Anh Khoi Luong
                  _hinhAnhKhoiLuong(),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),

                  // feature
                  _giatriDonHang(context),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),
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
          child: Text(title, style: Dimensions.textTitleStyleCard()),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(label, style: Dimensions.textNormalStyleCard()),
        ),
      ],
    );
  }

  ///
  /// thoi gian du kien
  ///
  Widget _bangBaoGia(
    BuildContext context,
    List<Map<String, dynamic>> infoCard,
  ) {
    return LabelContent(
      title: "Bảng báo giá",
      content: ContentWhiteBox(infoCard: infoCard),
    );
  }

  ///
  /// hinh anh khoi luong
  ///
  Widget _hinhAnhKhoiLuong() {
    return LabelContent(
      title: "Hình ảnh báo giá",
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
  /// fileWidget
  ///
  Widget _fileWidget() {
    return LabelContent(
      title: "File excel hoặc khác",
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
      BuildContext context, String from, String to, String date) {
    const double width = 170;
    return LabelContent(
      title: "Thời gian giao hàng",
      content: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Từ",
                      style: Dimensions.textTitleStyleCard(),
                    ),
                  ),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, .01)),
                  Container(
                    width: width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      from,
                      style: Dimensions.textNormalGreyStyleCard(),
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
                    child: Text(
                      "Đến",
                      style: Dimensions.textTitleStyleCard(),
                    ),
                  ),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, .01)),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width,
                    child: Text(
                      to,
                      style: Dimensions.textNormalGreyStyleCard(),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ngày",
                  style: Dimensions.textTitleStyleCard(),
                ),
              ),
              SizedBox(height: DeviceUtils.getScaledHeight(context, .01)),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  date,
                  style: Dimensions.textNormalGreyStyleCard(),
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
      content: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: controller.datetimeController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: '12/09/2021',
        ),
        onTap: () {
          controller.datePicker(
            context,
            DateTime(2021),
            DateTime(2021, 12, 31),
          );
        },
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
          Text(
            "Tiến độ giao hàng",
            style: Dimensions.textTitleStyleCard(),
          ),
          Column(children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text("Loại hình", style: Dimensions.textNormalStyle()),
                  const Spacer(),
                  Container(
                    width: DeviceUtils.getScaledWidth(context, .35),
                    alignment: Alignment.centerLeft,
                    child: Text(status, style: Dimensions.textNormalStyle()),
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
                      child: Text("Phí", style: Dimensions.textNormalStyle()),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: DeviceUtils.getScaledWidth(context, .5),
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .5),
                      child: TextField(
                          controller: controller.costController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Phí',
                          )),
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
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_LARGE)),
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
              Text("Giá trị đơn hàng", style: Dimensions.textTitleStyleCard()),
              const Spacer(),
              const Text(
                "350.000vnđ",
                style: TextStyle(
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
