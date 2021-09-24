import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_point_tab_bar/pointTabBar.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/category_news_model.dart';
import 'package:template/localization/language_constrants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
// template
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';

import 'news_controller.dart';

class NewsPage extends GetView<NewsController> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(NewsController());
    const String title = "Tin Tức";

    final searchWidget = _searchWidget(_searchController);
    final tabbarWidget = _tabbarWidget(controller.categoryNewsList, controller);

    return GetBuilder<NewsController>(
        init: NewsController(),
        builder: (NewsController value) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 1,
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
              ),
              body: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // search widget
                  searchWidget,

                  // tabbar
                  tabbarWidget,

                  // underline
                  Container(height: 1, color: const Color(0xffBDBDBD)),

                  // content
                  Container(
                    padding: const EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    height: MediaQuery.of(context).size.height - 300,
                    child: TabBarView(
                      controller: controller.tabController,
                      children: List.generate(
                          controller.categoryNewsList.length,
                          (index) => controller.newsList.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : SingleChildScrollView(
                                  child: controller.isLoading
                                      ? const CircularProgressIndicator()
                                      : Column(children: [
                                          ...controller.newsList
                                              .map(
                                                (news) => Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .onNewsClick();
                                                      },
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .25,
                                                              height: DeviceUtils
                                                                  .getScaledSize(
                                                                      context,
                                                                      0.25),
                                                              child:
                                                                  Image.network(
                                                                news.image!,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .25,
                                                                // height: 265,
                                                              ),
                                                            ),
                                                            const Spacer(),

                                                            //  text
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .6,
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      Dimensions
                                                                          .PADDING_SIZE_DEFAULT),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              7),
                                                                      child: Text(
                                                                          news
                                                                              .name!,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                Dimensions.FONT_SIZE_EXTRA_LARGE,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ))),
                                                                ],
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          DeviceUtils
                                                              .getScaledSize(
                                                                  context,
                                                                  0.025)),
                                                      child: const Divider(
                                                        color:
                                                            ColorResources.GREY,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ]))).toList(),
                    ),
                  )
                ],
              )));
        });
  }
}

// Search Widget
Container _searchWidget(TextEditingController controller) {
  final GlobalKey stickyKey = GlobalKey();
  return Container(
      key: stickyKey,
      margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
      // color: const Color(0xFFCDCDCD),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0x1FCDCDCD),
      ),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          labelText: 'Tìm kiếm',
        ),
        controller: controller,
      ));
}

//tabbar widget
Container _tabbarWidget(
    List<CategoryNewsModel> itemList, NewsController controller) {
  final GlobalKey stickyKey = GlobalKey();
  return Container(
    key: stickyKey,
    child: TabBar(
      isScrollable: true,
      controller: controller.tabController,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ColorResources.DEFAULT,
          width: 5.0,
        ),
      ),
      tabs: itemList.map((item) {
        return Tab(
            child:
                Text(item.name!, style: const TextStyle(color: Colors.black)));
      }).toList(),
    ),
  );
}
