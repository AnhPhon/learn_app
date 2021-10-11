import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/v2-builder/project/project_detail/project_detail_controller.dart';

class V2ProjectDetailPage extends GetView<V2ProjectDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ProjectDetailController>(
        init: V2ProjectDetailController(),
        builder: (controller) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                controller.title,
                style: const TextStyle(
                  shadows: [
                    Shadow(
                        // bottomLeft
                        offset: Offset(-1.5, -1.5),
                        color: ColorResources.PRIMARY),
                    Shadow(
                        // bottomRight
                        offset: Offset(1.5, -1.5),
                        color: ColorResources.PRIMARY),
                    Shadow(
                        // topRight
                        offset: Offset(1.5, 1.5),
                        color: ColorResources.PRIMARY),
                    Shadow(
                        // topLeft
                        offset: Offset(-1.5, 1.5),
                        color: ColorResources.PRIMARY),
                  ],
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
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
        });
  }

  ///
  ///img product
  ///
  Widget _imgProject(
      BuildContext context, V2ProjectDetailController controller) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: controller.urlImage,
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Text(
        title,
        style: Dimensions.fontSizeStyle22w600(),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Địa điểm:",
            style: Dimensions.fontSizeStyle20w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          Text(
            controller.place,
            textAlign: TextAlign.justify,
            style: Dimensions.fontSizeStyle18().copyWith(height: 1.5),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          Text(
            "Giới thiệu:",
            style: Dimensions.fontSizeStyle20w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          Text(
            controller.introduce,
            textAlign: TextAlign.justify,
            style: Dimensions.fontSizeStyle18().copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
