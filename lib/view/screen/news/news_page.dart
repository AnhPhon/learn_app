
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_point_tab_bar/pointTabBar.dart';
import 'package:get/get.dart';
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

    final tabList = <Tab>[
      const Tab(child: Text('Tab 1')),
      const Tab(child: Text('Tab 2')),
      const Tab(child: Text('Tab 3')),
    ];

    final itemList = [
      'Tab 1',
      'Tab 2',
      'Tab 3',
    ];

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
        child: Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: const Color(0x1FCDCDCD),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Tìm kiếm',
                  ),
                  controller: _searchController,
                )
              ),

              //  tabs
              Container(
                  child: Column(
                      children: [
                        TabBar(
                          controller: controller.tabController,
                          indicator: const PointTabIndicator(
                            position: PointTabIndicatorPosition.bottom,
                            color: Colors.white,
                            insets: EdgeInsets.only(bottom: 6),
                          ),
                          tabs: itemList.map((item) {
                            return Tab(text: item);
                          }).toList(),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                            controller: controller.tabController,
                            children: itemList.map((String item) {
                              final String label = item.toLowerCase();
                              return Center(
                                child: Text(
                                  'This is the $label tab',
                                  style: const TextStyle(fontSize: 36),
                                ),
                              );
                            }).toList(),
                        ),
                      )
                      ]
                  )
              ),

            ],
          ),
        )
      )
    );
  }
}