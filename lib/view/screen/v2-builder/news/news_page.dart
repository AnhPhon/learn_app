import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/component_customer/app_bar_with_tabbar.dart';
import 'package:template/view/screen/v2-builder/news/news_controller.dart';

import 'categories/news_categories_page.dart';

class V2NewsPage extends GetView<V2NewsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2NewsController>(
      init: V2NewsController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return controller.danhMucTinTucList.isEmpty
            ? const Center(child: Text("Tin tức trống!"))
            : Scaffold(
                appBar: AppBarWithTabBar(
                  title: controller.title,
                  bottom: TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    indicatorColor: ColorResources.PRIMARY,
                    labelColor: ColorResources.PRIMARY,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      ...List.generate(
                        controller.danhMucTinTucList.length,
                        (index) => Tab(
                            text: controller.danhMucTinTucList[index].tieuDe),
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: controller.tabController,
                  children: List.generate(
                    controller.danhMucTinTucList.length,
                    (index) {
                      return V2NewsCategoriesPage(
                        key: UniqueKey(),
                        danhMucTinTucList: controller.danhMucTinTucList[index],
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
