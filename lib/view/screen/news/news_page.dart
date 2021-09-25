import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/category_news_model.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
// template
import 'package:template/utils/dimensions.dart';
import 'news_controller.dart';

class NewsPage extends GetView<NewsController> {
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
  Container _tabbarWidget(List<CategoryNewsModel> itemList) {
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
              child: Text(item.name!,
                  style: const TextStyle(color: Colors.black)));
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(NewsController());
    const String title = "Tin Tức";

    final searchWidget = _searchWidget(controller.searchController);
    final tabbarWidget = _tabbarWidget(controller.categoryNewsList);

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
                    child: controller.newsList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : TabBarView(
                            controller: controller.tabController,
                            children: List.generate(
                                controller.categoryNewsList.length,
                                (index) => controller.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.newsList.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller.getNewsFromId(
                                                      index: index);
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
                                                                context, 0.25),
                                                        child: Image.network(
                                                          controller
                                                              .newsList[index]
                                                              .image!,
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
                                                            horizontal: Dimensions
                                                                .PADDING_SIZE_DEFAULT),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            7),
                                                                child: Text(
                                                                    controller
                                                                        .newsList[
                                                                            index]
                                                                        .name!,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .FONT_SIZE_EXTRA_LARGE,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ))),
                                                          ],
                                                        ),
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
                                        })).toList(),
                          ),
                  )
                ],
              )));
        });
  }
}
