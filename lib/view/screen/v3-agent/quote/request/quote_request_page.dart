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
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // Chọn loại công trình
                  _textWidget("Chọn loại công trình", controller.loaiCongTrinh),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // địa điểm nhận
                  _diaDiemNhan(),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // dia chi cu the
                  _diaChiCuThe(
                      context,
                      (controller.isCheck == true)
                          ? controller.diaChiCuThe
                          : "***"),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // thời gian dự kiến
                  _thoiGianDuKien(context, controller.infoCard),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // noi dung yeu cau
                  _noiDungYeuCau(context, controller.noiDungYeuCau!),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // Hinh Anh Khoi Luong
                  _hinhAnhKhoiLuong(),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // file upload
                  _fileUpload(context),
                  SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context, Dimensions.SCALE_DEFAULT)),

                  // feature
                  _featureWidget(),
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
            child: Text(
              "Tỉnh/TP: ",
              style: Dimensions.textNormalStyle(),
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
                    child: Text(controller.tinhThanh,
                        style: Dimensions.textNormalStyle()),
                  ),

                // quan, phuong
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                if (controller.quan.isNotEmpty || controller.phuong.isNotEmpty)
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(controller.quan,
                            style: Dimensions.textNormalStyle()),
                        const Spacer(),
                        Text(controller.phuong,
                            style: Dimensions.textNormalStyle()),
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
      isRequired: false,
      content: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          value,
          style: Dimensions.textNormalGreyStyleCard(),
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
    return LabelContent(
      title: "Thời gian nhận dự kiến",
      isRequired: false,
      content: Column(
        children: [
          Row(
            children: [
              Text("Từ ${controller.from}"),
              const Spacer(),
              Text("Đến ${controller.to}"),
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          Column(
            children: List.generate(
              infoCard.length,
              (index) => Column(
                children: [
                  ContentWhiteBox(infoCard: infoCard[index]),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                ],
              ),
            ),
          )
        ],
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
    return LabelContent(
      title: "Nội dung yêu cầu",
      isRequired: false,
      content: Container(
        alignment: Alignment.centerLeft,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: List.generate(
              noiDungYeuCau.length,
              (index) => Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "+ ${noiDungYeuCau[index]}",
                  style: Dimensions.textNormalStyle(),
                ),
              ),
            ),
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
      title: "Hình ảnh khối lượng",
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
        content: FileUploadWidget(
          label: controller.filepath.split("/").last.toString(),
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
                  boxShadow: const [
                    BoxShadow(blurRadius: 3, offset: Offset(0, 2))
                  ]),
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
