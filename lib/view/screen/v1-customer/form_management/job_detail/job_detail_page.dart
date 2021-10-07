import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/form_management/job_detail/job_detail_controller.dart';

class V1JobDetailPage extends GetView<V1JobDetailController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1JobDetailController>(
        init: V1JobDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  _textTitle(
                    context,
                    title: "Dịch vụ xây dựng toàn diện",
                  ),

                  //title list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _richText(
                        context,
                        text1: "Công việc: ",
                        text2: "Thợ ốp lát công trình 5 sao",
                      ),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      _richText(
                        context,
                        text1: "Mô tả công việc: ",
                        text2: "Thợ ốp công trình 5 sao của công trình",
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      _richText(
                        context,
                        text1: "Thời gian: ",
                        text2: "12-09-2021 đến 10-11-2021",
                      ),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      // title job container
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Text(
                          "Bảng khối lượng công việc cần báo giá",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //job container
                      _jobContainer(context,
                          name: "Xi măng",
                          specifications: "Kim đỉnh",
                          quanlity: "5",
                          unit: "Tấn"),

                      _jobContainer(context,
                          name: "Xi măng",
                          specifications: "Kim đỉnh",
                          quanlity: "5",
                          unit: "Tấn"),

                      //file picker
                      _filePicker(context),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      // title image container
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Text(
                          "Hình ảnh bảng khối lượng\n(Bảng in hoặc viết bằng tay nếu có)",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //image list
                      _imageList(context),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      // title image container
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Text(
                          "Hình ảnh bản vẽ (nếu có)",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //image list
                      _imageList(context),

                      //title note
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Text(
                          "Ghi chú",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //note
                      _note(context, controller),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_LARGE,
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
  Widget _textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
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
  Widget _richText(BuildContext context,
      {required String text1, required String text2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
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
    BuildContext context, {
    required String name,
    required String unit,
    required String quanlity,
    required String specifications,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_SMALL,
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 10),
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
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
            Text("Quy cách: $specifications"),
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
            Text("Số lượng: $quanlity"),
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
            Text("Đơn vị: $unit"),
            const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          ],
        ),
      ),
    );
  }

  ///
  ///file picker
  ///
  Widget _filePicker(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
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
  Widget _imageList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.025)),
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
          vertical: Dimensions.MARGIN_SIZE_DEFAULT),
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.PRIMARY),
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
      ),
      height: DeviceUtils.getScaledHeight(context, .14),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  Images.newsTemplate,
                  fit: BoxFit.fill,
                  height: DeviceUtils.getScaledHeight(context, .122),
                  width: DeviceUtils.getScaledWidth(context, .254),
                ),
              ),
            );
          }),
    );
  }

  ///
  ///note
  ///
  Widget _note(BuildContext context, V1JobDetailController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_SMALL,
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 10),
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
