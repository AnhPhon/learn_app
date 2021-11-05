import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // bảng báo giá
                  _bangBaoGia(context, controller.infoCard),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // thời gian giao hàng
                  _thoiGianGiaoHang(context, "09h30", "10h30", "12-09-2021"),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // tien do giao hang
                  _tienDoGiaoHang(context, controller.loaiHinh,
                      "${PriceConverter.convertPrice(context, controller.phiGiaoHang)} VNĐ"),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // file upload
                  _fileUpload(context, controller.filepath),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // Hinh Anh Khoi Luong
                  _hinhAnhKhoiLuong(),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // feature
                  _giatriDonHang(context),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),
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
                          infoCard.length,
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
                                          style: Dimensions.textNormalStyle()),
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
                                        "${(infoCard[index][jndex]['controller'] != null) ? (infoCard[index][jndex]['controller'] as TextEditingController).text : infoCard[index][jndex]['value']}",
                                        style: Dimensions.textNormalStyle(),
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
  /// hinh anh khoi luong
  ///
  Widget _hinhAnhKhoiLuong() {
    return LabelContent(
      title: "Hình ảnh báo giá",
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
          itemCount: controller.images.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.example,
                  image: controller.images[index],
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
      BuildContext context, String from, String to, String date) {
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
          SizedBox(
              height: DeviceUtils.getScaledHeight(
                  context, Dimensions.SCALE_DEFAULT)),
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
          ),
          SizedBox(
              height: DeviceUtils.getScaledHeight(
                  context, Dimensions.SCALE_DEFAULT)),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Báo cáo có hiệu lực đến hết ngày",
                  style: Dimensions.textTitleStyleCard(),
                ),
              ),
              SizedBox(height: DeviceUtils.getScaledHeight(context, .01)),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.datetimeController.text,
                  style: Dimensions.textNormalGreyStyleCard(),
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
              height: 50,
              child: Row(
                children: [
                  Text("Phí", style: Dimensions.textNormalStyle()),
                  const Spacer(),
                  Container(
                    width: DeviceUtils.getScaledWidth(context, .35),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      cost,
                      style: Dimensions.textNormalStyle(),
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
              Text("Giá trị đơn hàng", style: Dimensions.textTitleStyleCard()),
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
          SizedBox(height: DeviceUtils.getScaledHeight(context, .04)),
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
                        boxShadow: const [
                          BoxShadow(blurRadius: 3, offset: Offset(0, 2))
                        ]),
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
  Widget _fileUpload(BuildContext context, String filepath) {
    return GestureDetector(
      onTap: () {
        controller.onBtnDownload(url: filepath.toString());
      },
      child: LabelContent(
        title: "File báo giá:",
        isRequired: false,
        content: FileUploadWidget(label: controller.getFilename(filepath)),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
