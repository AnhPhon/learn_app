import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/news/news_detail/news_detail_controller.dart';

class NewsDetailPage extends GetView<NewsDetailController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "Chi tiết tin tức",
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
      ),
      body: GetBuilder(
        init: NewsDetailController(),
        builder: (NewsDetailController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              children: [
                image(),
                interactive(),
                content(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget image() {
    return Container(
      width: IZIDimensions.iziSize.width,
      height: IZIDimensions.ONE_UNIT_SIZE * 250,
      child: IZIImage(
        'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
      ),
    );
  }

  Widget interactive() {
    return Container(
      margin: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.favorite_border,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: IZIDimensions.SPACE_SIZE_1X * 0.5,
                ),
                child: IZIText(
                  text: "1,200k",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: IZIDimensions.ONE_UNIT_SIZE * 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: IZIDimensions.SPACE_SIZE_1X * 0.5,
                ),
                child: IZIText(
                  text: "Thứ ba, 12-12-2021",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        IZIText(
          text: controller.title,
          maxLine: 2,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H2,
            color: ColorResources.CIRCLE_COLOR_BG3,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_5X,
        ),
        Text(
          IZIOther.htmlUnescape(
            controller.content,
          ),
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H5,
          ),
        )
      ],
    );
  }
}
