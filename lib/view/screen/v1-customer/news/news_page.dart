import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/v1-customer/component_customer/app_bar_with_tabbar.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';
import 'package:template/view/screen/v1-customer/keep_alive_wrapper.dart';
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
            : Scaffold(
                appBar: AppBarWithTabBar(
                  title: controller.title,
                  bottom: TabBar(
                    controller: controller.tabController,
                    onTap: (val) => controller.getNewsByIdCategory(index: val),
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
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: List.generate(
                    controller.danhMucTinTucList.length,
                    (index) {
                      if (controller.isLoadingNews && controller.refreshController[index] == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                      return new SmartRefresher(
                              key: UniqueKey(),
                              controller: controller.refreshController[index],
                              enablePullUp: true,
                              onLoading: controller.onLoading,
                              onRefresh: controller.onRefresh,
                              child: _itemList(
                                context,
                                controller: controller,
                              ),
                            );
                         
                    },
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
    BuildContext context, {
    required V1NewsController controller,
  }) {
    return (controller.tinTucModelList.isNotEmpty)
        ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.tinTucModelList.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: ItemListWidget(
                          urlImage: controller.tinTucModelList[index].hinhAnh
                              .toString(),
                          onTap: () {},
                          title: controller.tinTucModelList[index].tieuDe
                              .toString(),
                          rowText1: controller.formatDateTime(
                            dateTime: controller
                                .tinTucModelList[index].createdAt
                                .toString(),
                          ),
                          icon1: const Icon(
                            Icons.calendar_today_outlined,
                            color: ColorResources.GREY,
                          ),
                          colorRowText1: ColorResources.GREY,
                          rowText2: controller.tinTucModelList[index].luotXem
                              .toString(),
                          icon2: const Icon(
                            Icons.remove_red_eye,
                            color: ColorResources.GREY,
                          ),
                          colorRowText2: ColorResources.GREY,
                          isSpaceBetween: true,
                        ),
                      );
                    },
                  ),
                ],
              ),
            
          )
        : Container();
  }
}
