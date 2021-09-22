import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/news/news_detail/news_detail_controller.dart';

class NewsDetailPage extends GetView<NewsDetailController> {
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
                            image: const DecorationImage(
                                image: AssetImage(Images.news),
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.13),
                              vertical:
                                  DeviceUtils.getScaledSize(context, 0.04)),
                          child: Text(
                            controller.title.first.toString(),
                            style: Dimensions.fontSizeStyle20w600()
                                .copyWith(color: ColorResources.BLACK),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                DeviceUtils.getScaledSize(context, 0.25)),
                        child: Row(children: [
                          Text(controller.categories.first.toString()),
                          const Spacer(),
                          Text(controller.time.first.toString()),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DeviceUtils.getScaledSize(context, 0.2),
                            vertical: DeviceUtils.getScaledSize(context, 0.03)),
                        child: const Divider(color: ColorResources.GREY),
                      ),
                      Text(
                        controller.subtitle.first.toString(),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
