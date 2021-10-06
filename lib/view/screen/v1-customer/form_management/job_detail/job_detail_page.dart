import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/form_management/job_detail/job_detail_controller.dart';

class V1JobDetailPage extends GetView<V1JobDetailController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<V1JobDetailController>(
        init: V1JobDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  _textTitle(context, height,
                      title: "Dịch vụ xây dựng toàn diện"),

                  //title list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _richText(
                        context,
                        width,
                        text1: "Công việc: ",
                        text2: "Thợ ốp lát công trình 5 sao",
                      ),

                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, 10 / height),
                      ),

                      _richText(
                        context,
                        width,
                        text1: "Mô tả công việc: ",
                        text2: "Thợ ốp công trình 5 sao của công trình",
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, 10 / height),
                      ),

                      _richText(
                        context,
                        width,
                        text1: "Thời gian: ",
                        text2: "12-09-2021 đến 10-11-2021",
                      ),

                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, 10 / height),
                      ),

                      // title job container
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, 15 / width),
                        ),
                        child: const Text(
                          "Bảng khối lượng công việc cần báo giá",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //job container
                      _jobContainer(context, height, width,
                          name: "Xi măng",
                          specifications: "Kim đỉnh",
                          quanlity: "5",
                          unit: "Tấn"),

                      _jobContainer(context, height, width,
                          name: "Xi măng",
                          specifications: "Kim đỉnh",
                          quanlity: "5",
                          unit: "Tấn"),

                      //file picker
                      _filePicker(context, height, width),

                      // title image container
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, 15 / width),
                        ),
                        child: const Text(
                          "Hình ảnh bảng khối lượng\n(Bảng in hoặc viết bằng tay nếu có)",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //image list
                      _imageList(context, height, width),

                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, 15 / height),
                      ),

                      // title image container
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, 15 / width),
                        ),
                        child: const Text(
                          "Hình ảnh bản vẽ (nếu có)",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //image list
                      _imageList(context, height, width),

                      //title note
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, 15 / width),
                        ),
                        child: const Text(
                          "Ghi chú",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //note
                      _note(context, controller, height, width),

                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, 20 / height),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, double height,
      {required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 20 / height),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ///
  ///rich text title
  ///
  Widget _richText(BuildContext context, double width,
      {required String text1, required String text2}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 15 / width)),
      child: RichText(
        text: TextSpan(
            text: text1,
            style: const TextStyle(
                color: ColorResources.BLACK,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: text2,
                  style: TextStyle(
                      height: 1.5,
                      color: ColorResources.BLACK.withOpacity(.75),
                      fontSize: Dimensions.FONT_SIZE_LARGE))
            ]),
      ),
    );
  }

  ///
  ///job container
  ///
  Widget _jobContainer(
    BuildContext context,
    double height,
    double width, {
    required String name,
    required String unit,
    required String quanlity,
    required String specifications,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 10 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 10 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 20 / width),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10),
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: ColorResources.BLACK),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tên vật liệu: $name"),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.013)),
            Text("Quy cách: $specifications"),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.013)),
            Text("Số lượng: $quanlity"),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.013)),
            Text("Đơn vị: $unit"),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.013)),
          ],
        ),
      ),
    );
  }

  ///
  ///file picker
  ///
  Widget _filePicker(BuildContext context, double height, double width) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 10 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 10 / height),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10),
        ],
      ),
      child: const Text(
        "File báo giá khối lượng.doc",
        style: TextStyle(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
      ),
    );
  }

  ///
  ///image list
  ///
  Widget _imageList(BuildContext context, double height, double width) {
    return Container(
      padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.025)),
      margin: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
          vertical: DeviceUtils.getScaledHeight(context, 15 / height)),
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.PRIMARY),
        borderRadius: BorderRadius.circular(5),
      ),
      height: DeviceUtils.getScaledHeight(context, 120 / height),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  "assets/images/news_template.png",
                  fit: BoxFit.fill,
                  height: DeviceUtils.getScaledHeight(context, 93 / height),
                  width: DeviceUtils.getScaledWidth(context, 100 / width),
                ),
              ),
            );
          }),
    );
  }

  ///
  ///note
  ///
  Widget _note(BuildContext context, V1JobDetailController controller,
      double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 10 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 30 / height),
        horizontal: DeviceUtils.getScaledWidth(context, 15 / width),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10),
        ],
      ),
      child: Text(
        controller.note,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            height: 1.3, fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
      ),
    );
  }
}
