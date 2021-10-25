import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/v1-customer/project/project_detail/project_detail_controller.dart';

class V1ProjectDetailPage extends GetView<V1ProjectDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProjectDetailController>(
      init: V1ProjectDetailController(),
      builder: (controller) {
        return controller.duAnKhachHangResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    controller.title.toString(),
                    style: const TextStyle(
                      shadows: [
                        Shadow(
                            // bottomLeft
                            offset: Offset(-1.5, -1.5),
                            color: ColorResources.BLACK),
                        Shadow(
                            // bottomRight
                            offset: Offset(1.5, -1.5),
                            color: ColorResources.BLACK),
                        Shadow(
                            // topRight
                            offset: Offset(1.5, 1.5),
                            color: ColorResources.BLACK),
                        Shadow(
                            // topLeft
                            offset: Offset(-1.5, 1.5),
                            color: ColorResources.BLACK),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image
                      _imgProject(context, controller),

                      //title
                      _textTitle(context, title: "Vinpearl Land Làng Vân"),

                      //content
                      _content(),
                    ],
                  ),
                ),
              );
      },
    );
  }

  ///
  ///img product
  ///
  Widget _imgProject(BuildContext context, V1ProjectDetailController controller) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: controller.duAnKhachHangResponse!.hinhAnhDaiDien.toString(),
            width: double.infinity,
            height: DeviceUtils.getScaledHeight(context, .3),
            fit: BoxFit.fill,
            imageErrorBuilder: (c, o, s) => Image.asset(
              Images.placeholder,
              width: double.infinity,
              height: DeviceUtils.getScaledHeight(context, .3),
            ),
          );
        },
        options: CarouselOptions(
          height: DeviceUtils.getScaledHeight(context, .355),
          autoPlay: true,
          viewportFraction: 1,
        ),
      ),
    );
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Text(
        controller.duAnKhachHangResponse!.ten.toString(),
        style: Dimensions.fontSizeStyle22w600(),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content() {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      // margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Địa điểm:",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          Text(
            controller.duAnKhachHangResponse!.diaDiem.toString(),
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Text(
            "Giới thiệu:",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          Text(
            controller.duAnKhachHangResponse!.gioiThieu.toString(),
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18(),
          ),
        ],
      ),
    );
  }
}
