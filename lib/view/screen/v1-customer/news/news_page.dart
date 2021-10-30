import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/component/app_bar_with_tabbar.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
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
                      return itemList(
                        indextab: index,
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
  Widget itemList({required int indextab}) {
    return GetBuilder<V1NewsController>(
      builder: (controller) {
        if (controller.isLoadingNews) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return (controller.tinTucList.isNotEmpty)
            ? SmartRefresher(
                enablePullUp: true,
                onRefresh: controller.onRefresh,
                onLoading: controller.onLoading,
                controller: controller.refreshControllerList[indextab],
                footer: const ClassicFooter(
                  loadingText: "Đang tải...",
                  noDataText: "Không có dữ liệu",
                  canLoadingText: "Kéo lên để tải thêm dữ liệu",
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_LARGE,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.tinTucList.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            child: ItemListWidget(
                              onTap: () {},
                              // controller.onNewsDetailClick(index: index),
                              urlImage: controller.tinTucList[index].hinhAnh
                                  .toString(),
                              title: controller.tinTucList[index].tieuDe
                                  .toString(),
                              rowText1: DateConverter.formatDateTime(
                                controller.tinTucList[index].createdAt
                                    .toString(),
                              ),
                              icon1: const Icon(
                                Icons.calendar_today_outlined,
                                color: ColorResources.GREY,
                              ),
                              colorRowText1: ColorResources.GREY,
                              rowText2: controller.tinTucList[index].luotXem
                                  .toString(),
                              icon2: const Icon(
                                Icons.remove_red_eye,
                                color: ColorResources.GREY,
                              ),
                              colorRowText2: ColorResources.GREY,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
