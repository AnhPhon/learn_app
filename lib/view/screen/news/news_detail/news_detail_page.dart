import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/news/news_controller.dart';
import 'package:template/view/screen/news/news_detail/news_detail_controller.dart';
import 'package:template/view/screen/news/news_detail/news_specification.dart';

class NewsDetailPage extends GetView<NewsDetailController> {
  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsDetailController>(
        init: NewsDetailController(),
        builder: (NewsDetailController value) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: CustomAppBar().customAppBar(title: "Tiêu đề"),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: DeviceUtils.getScaledSize(context, 0.04),
                    horizontal: DeviceUtils.getScaledSize(context, 0.04)),
                child: DefaultTextStyle(
                  style: TextStyle(height: 1.3, color: Colors.grey[600]),
                  child: Column(
                    children: [
                      Container(
                        height: DeviceUtils.getScaledSize(context, 0.6),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          newsController.newsModel!.image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.05),
                              vertical:
                                  DeviceUtils.getScaledSize(context, 0.04)),
                          child: Text(
                            newsController.newsModel!.name!,
                            style: Dimensions.fontSizeStyle20w600()
                                .copyWith(color: ColorResources.BLACK),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                DeviceUtils.getScaledSize(context, 0.1)),
                        child: Row(children: [
                          Text(newsController.newsModel!.tags!),
                          const Spacer(),
                          Text(newsController.newsModel!.createdAt!),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DeviceUtils.getScaledSize(context, 0.2),
                            vertical: DeviceUtils.getScaledSize(context, 0.03)),
                        child: const Divider(color: ColorResources.GREY),
                      ),

                      ///
                      ///body
                      ///
                      NewsSpecification(
                          newsSpecification: newsController.newsModel!.body!),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
