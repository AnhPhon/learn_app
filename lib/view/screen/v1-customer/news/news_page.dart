import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/v1-customer/component_customer/app_bar_with_tabbar.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';
import 'package:template/view/screen/v1-customer/news/news_controller.dart';

class V1NewsPage extends GetView<V1NewsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1NewsController>(
      init: V1NewsController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return controller.danhMucTinTucList.isEmpty
            ? const Center(child: Text("Tin tức trống!"))
            : DefaultTabController(
                length: controller.danhMucTinTucList.length,
                child: Scaffold(
                  appBar: AppBarWithTabBar(
                    title: controller.title,
                    bottom: TabBar(
                      // controller: controller.tabController,
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
                    // controller: controller.tabController,
                    children: List.generate(
                      controller.danhMucTinTucList.length,
                      (index) => _itemList(
                        controller: controller,
                        indexA: index,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  ///
  ///item list
  ///
  Widget _itemList(
      {required V1NewsController controller, required int indexA}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.tinTucModelList[indexA].length,
            itemBuilder: (BuildContext ctx, int index) {
              return ItemListWidget(
                urlImage: controller.tinTucModelList[indexA][index].hinhAnh
                    .toString(),
                onTap: () => controller.onNewsDetailClick(indexA: indexA, indexB: index),
                title:
                    controller.tinTucModelList[indexA][index].tieuDe.toString(),
                subTitle: controller.tinTucModelList[indexA][index].tomTat,
                rowText2: controller.formatDateTime(
                  dateTime: controller.tinTucModelList[indexA][index].createdAt
                      .toString(),
                ),
                colorRowText2: ColorResources.GREY,
              );
            },
          ),
        ],
      ),
    );
  }
}
