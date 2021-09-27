import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
// template
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'news_controller.dart';

class NewsPage extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    const String title = "Tin Tức";
    return GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) {
          if (controller.isLoading) {
            return Container(
                color: ColorResources.WHITE,
                child: const Center(child: CircularProgressIndicator()));
          }
          return controller.categoryNewsList.isEmpty
              ? const Center(child: Text("Tin tức trống!"))
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 2,
                    title: const Text(
                      title,
                      style: TextStyle(
                        color: Color(0xFF27272A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    shadowColor: const Color(0x3F000000),
                    bottom: TabBar(
                      controller: controller.tabController,
                      isScrollable: true,
                      indicatorColor: ColorResources.PRIMARY,
                      labelColor: ColorResources.PRIMARY,
                      unselectedLabelColor: Colors.grey,
                      tabs: controller.categoryNewsList
                          .map((item) => Tab(child: Text(item.name!)))
                          .toList(),
                    ),
                  ),
                  body: TabBarView(
                    controller: controller.tabController,
                    children: List.generate(
                        controller.categoryNewsList.length,
                        (index) => GetBuilder<NewsController>(
                            init: NewsController(),
                            builder: (controller) {
                              if (controller.isLoadingNews) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.newsList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.onClickNewsDetail(
                                                  index: index);
                                            },
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .25,
                                                    height: DeviceUtils
                                                        .getScaledSize(
                                                            context, 0.25),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          Images.placeholder,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .25,
                                                      image: controller
                                                          .newsList[index]
                                                          .image!,
                                                      fit: BoxFit.fill,
                                                      imageErrorBuilder:
                                                          (c, o, s) =>
                                                              Image.asset(
                                                        Images.placeholder,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .25,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),

                                                  //  text
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .6,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: Dimensions
                                                            .PADDING_SIZE_DEFAULT),
                                                    child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                controller
                                                                    .newsList[
                                                                        index]
                                                                    .name!,
                                                                maxLines: 3,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .FONT_SIZE_EXTRA_LARGE,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            SizedBox(
                                                                height: DeviceUtils
                                                                    .getScaledSize(
                                                                        context,
                                                                        0.04)),
                                                            Text(
                                                                controller.timeAgo(
                                                                    controller
                                                                        .newsList[
                                                                            index]
                                                                        .createdAt!),
                                                                maxLines: 1,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .FONT_SIZE_DEFAULT,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey)),
                                                          ],
                                                        )),
                                                  ),
                                                ]),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                DeviceUtils.getScaledSize(
                                                    context, 0.025)),
                                            child: const Divider(
                                              color: ColorResources.GREY,
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              );
                            })).toList(),
                  ),
                );
        });
  }
}
