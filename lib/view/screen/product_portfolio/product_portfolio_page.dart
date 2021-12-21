import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/base_widget/izi_tabbar.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/product_portfolio/product_portfolio_controller.dart';

class ProductPortfolioPage extends GetView<ProductPortfolioController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAccount(),
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        callbackSearch: (val) {},
        title: '',
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.filter_alt_outlined,
              color: ColorResources.WHITE,
              size: 30,
            ),
          ),
        ],
      ),
      body: GetBuilder(
        init: ProductPortfolioController(),
        builder: (ProductPortfolioController controller) {
          return Container(
            constraints: BoxConstraints(
              minHeight: IZIDimensions.iziSize.height,
              minWidth: IZIDimensions.iziSize.width,
            ),
            decoration: const BoxDecoration(
              color: ColorResources.WHITE,
            ),
            child: Column(
              children: [
                IZITabBar(
                  colorUnderLine: ColorResources.CIRCLE_COLOR_BG,
                  colorTabBar: ColorResources.WHITE,
                  colorText: ColorResources.CIRCLE_COLOR_BG,
                  items: controller.tieuDe,
                  onTapChangedTabbar: (index) => controller.onChangeTab(index: index),
                  currentIndex: controller.currentIndex,
                ),
                Container(
                  color: ColorResources.BACKGROUND,
                  child: IZIListView(
                    itemCount: controller.dataMenu.length,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    builder: (index) {
                      return IZICard(
                        imageUrlType: IZIImageUrlType.IMAGE_CIRCLE,
                        urlImage: controller.dataMenu[index]['image'].toString(),
                        marginCard: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        colorBG: ColorResources.CIRCLE_COLOR_BG3,
                        cardType: IZICardType.CARD_CIRCLE,
                        row1Left: controller.dataMenu[index]['lable'].toString(),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    color: ColorResources.BACKGROUND,
                    child: IZISmartRefresher(
                      onLoading: controller.onLoading,
                      onRefresh: controller.onRefresh,
                      isLoading: false,
                      refreshController: controller.refreshController,
                      enablePullDown: true,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: IZIDimensions.SPACE_SIZE_1X * .5,
                          mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 430,
                          crossAxisSpacing: IZIDimensions.SPACE_SIZE_1X * .5,
                        ),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.gotoDetailedProductInformation();
                            },
                            child: IZICard(
                              marginCard: EdgeInsets.all(
                                IZIDimensions.SPACE_SIZE_1X,
                              ),
                              urlImage: controller.dataMenu[index]['image'].toString(),
                              colorBG: ColorResources.CIRCLE_COLOR_BG3,
                              row1Left: 'Sâm Dây Ngọc Linh Tươi/Khô',
                              row2Left: 'đ 50.000',
                              row3Left: "đ100.000",
                              row3Right: 'Đã bán 100',
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
