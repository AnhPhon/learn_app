import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/news/new_detail/news_detail_controller.dart';

class V1NewsDetailPage extends GetView<V1NewsDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1NewsDetailController>(
        init: V1NewsDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //image
                  _imageNews(context),

                  //view and like
                  _totalsView(context),

                  //title news
                  _titleNews(controller),

                  //authors and time
                  _authors(controller),

                  //content
                  _content(),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///image
  ///
  Widget _imageNews(BuildContext context) {
    return Image.asset(
      Images.newsTemplate,
      fit: BoxFit.fill,
      height: DeviceUtils.getScaledHeight(context, .25),
      width: double.infinity,
    );
  }

  ///
  ///view and like
  ///
  Widget _totalsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Row(
        children: const [
          Spacer(),
          //view
          Icon(
            Icons.remove_red_eye_sharp,
            color: ColorResources.PRIMARYCOLOR,
          ),
          Text("21.32k"),

          SizedBox(
            width: Dimensions.MARGIN_SIZE_SMALL,
          ),

          //reacion
          Icon(
            Icons.favorite_border_outlined,
            color: ColorResources.RED,
          ),
          Text("600"),
        ],
      ),
    );
  }

  ///
  ///title news
  ///
  Widget _titleNews(V1NewsDetailController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        controller.titleNews,
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle20w600(),
      ),
    );
  }

  ///
  ///authors and time
  ///
  Widget _authors(V1NewsDetailController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: controller.time,
                style: Dimensions.fontSizeStyle16w600()
                    .copyWith(color: ColorResources.PRIMARY),
                children: [
                  TextSpan(
                    text: controller.authors,
                    style: Dimensions.fontSizeStyle16w600()
                        .copyWith(color: ColorResources.BLACK),
                  ),
                ]),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        controller.content,
        textAlign: TextAlign.justify,
        style:
            Dimensions.fontSizeStyle18().copyWith(color: ColorResources.BLACK),
      ),
    );
  }
}
