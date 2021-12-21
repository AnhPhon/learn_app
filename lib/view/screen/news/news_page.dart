import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_tabbar.dart';
import 'package:template/base_widget/izi_tabview.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/news/news_controller.dart';
import 'package:template/view/widgets/getx_smart_refresh/getx_smart_refresh_page.dart';

class NewsPage extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundHome(),
      body: GetBuilder(
        init: NewsController(),
        builder: (NewsController controller) {
          return Container(
            // padding: EdgeInsets.symmetric(
            //   horizontal: IZIDimensions.SPACE_SIZE_4X,
            // ),
            child: Column(
              children: [
                tabBar(controller: controller),
                news(controller: controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget tabBar({required NewsController controller}) {
    return IZITabBar(
      items: controller.tabBarName,
      onTapChangedTabbar: (index) {
        controller.onChangeTabBar(
          index: index,
        );
      },
      currentIndex: controller.currentIndexTabBar,
    );
  }

  Widget news({required NewsController controller}) {
    List<Map<String, String>> data = getData(controller: controller);
    Map<String, Function> smartFunction = getFunction(controller: controller);
    return Expanded(
      child: GetXSmartRefreshPage(
        onLoading: () async {
          final loading = smartFunction['loading'] as Function;
          loading();
        },
        onRefresh: () async {
          final onRefresh = smartFunction['refresh'] as Function;
          onRefresh();
        },
        refreshController: controller.refreshController,
        enablePullDown: true,
        enablePullUp: true,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(
              top: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: IZIListView(
              itemCount: data.length,
              builder: (index) {
                return Container(
                  margin: EdgeInsets.only(
                    left: IZIDimensions.SPACE_SIZE_4X,
                    right: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  child: IZICard(
                    cardType: IZICardType.CARD_NEWS,
                    urlImage: data[index]['image'].toString(),
                    row1Left: data[index]['row1Left'].toString(),
                    row1Right: data[index]['row1Right'].toString(),
                    row2Left: data[index]['row2Left'].toString(),
                    onTap: () {
                      controller.onTapNewCard();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> getData({required NewsController controller}) {
    List<Map<String, String>> data = [];
    if (controller.currentIndexTabBar == 0) {
      // Phổ biến
      data = controller.data;
    } else if (controller.currentIndexTabBar == 1) {
      // Hot nhất
      data = controller.hot;
    } else {
      // Khuyến mãi
      data = controller.data;
    }
    return data;
  }

  Map<String, Function> getFunction({required NewsController controller}) {
    Map<String, Function> smartFunction = {
      'loading': () {},
      'refresh': () {},
    };
    if (controller.currentIndexTabBar == 0) {
      // Phổ biến
      smartFunction['loading'] = controller.onLoadMore;
      smartFunction['refresh'] = controller.onRefresh;
    } else if (controller.currentIndexTabBar == 1) {
      // Hot nhất
      smartFunction['loading'] = controller.onLoadMore;
      smartFunction['refresh'] = controller.onRefresh;
    } else {
      // Khuyến mãi
      smartFunction['loading'] = controller.onLoadMore;
      smartFunction['refresh'] = controller.onRefresh;
    }
    return smartFunction;
  }
}
