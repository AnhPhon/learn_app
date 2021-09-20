
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_point_tab_bar/pointTabBar.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
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

    final itemList = [
      'Việt Nam',
      'Công nghệ',
      'Thế giới',
    ];

    final data = [
      [
        ["YouTube's new features, let's take a look", '45 phút', 'Việt Nam', Images.newsTemplate],
        ["YouTube's new features, let's take a look", '45 phút', 'Việt Nam', Images.newsTemplate],
        ["YouTube's new features, let's take a look", '45 phút', 'Việt Nam', Images.newsTemplate],
      ],
      [
        ["YouTube's new features, let's take a look", '45 phút', 'Công nghệ', Images.newsTemplate],
        ["YouTube's new features, let's take a look", '45 phút', 'Công nghệ', Images.newsTemplate],
      ],
      [
        ["YouTube's new features, let's take a look", '45 phút', 'Thế Giới', Images.newsTemplate],
      ]
    ];

    final searchWidget = _searchWidget(_searchController);
    final tabbarWidget = _tabbarWidget(itemList, controller);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
            Container(
              height: 1,
              color: const Color(0xffBDBDBD)
            ),

            // content
            Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              height: MediaQuery.of(context).size.height - 300,
              child: TabBarView(
                controller: controller.tabController,
                children: data.map((List<List<String>> item) {

                  final List<Widget> _rows = [];
                  for (final element in item) {
                    _rows.add(
                      Row(
                          children: [
                            //  text
                            Container(
                              width: MediaQuery.of(context).size.width * .6,
                              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                              child: Column(
                                children: [

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Text(
                                        element[0],
                                        style: const TextStyle(
                                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                          fontWeight: FontWeight.bold,
                                        )
                                    )
                                  ),

                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                            element[1],
                                            style: const TextStyle(
                                                color: Color(0xFF898989)
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                          child: Text(
                                              element[2],
                                              style: const TextStyle(
                                                color: Color(0xFF898989),
                                              ),
                                          )
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .25,
                              child: Image.asset(
                                element[3],
                                width: MediaQuery.of(context).size.width * .25,
                                // height: 265,
                              ),
                            ),
                          ]
                      )
                    );

                    _rows.add(const SizedBox(height: 20));
                  }

                  return SingleChildScrollView(
                    child: Column(
                      // alignment: Alignment.topLeft,
                      // padding: const EdgeInsets.all(10),
                      children: _rows
                    )
                  );
                }).toList(),
              ),
            )
          ],
        )
      )
    );
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
      )
  );
}

//tabbar widget
Container _tabbarWidget(List<String> itemList, NewsController controller) {
  final GlobalKey stickyKey = GlobalKey();
  return Container(
    key: stickyKey,
    child: TabBar(
      controller: controller.tabController,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ColorResources.DEFAULT,
          width: 5.0,
        ),
      ),
      tabs: itemList.map((item) {
        return Tab(child: Text(item, style: const TextStyle(color: Colors.black)));
      }).toList(),
    ),
  );
}