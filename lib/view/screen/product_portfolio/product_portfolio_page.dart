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
import 'package:template/view/screen/product/components/filter_product.dart';
import 'package:template/view/screen/product_portfolio/product_portfolio_controller.dart';

class ProductPortfolioPage extends GetView<ProductPortfolioController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      drawer: const FilterProduct(),
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
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Icon(
                  Icons.filter_alt_outlined,
                  color: ColorResources.WHITE,
                  size: 30,
                ),
              );
            },
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
                Container(
                  width: double.infinity,
                  height: IZIDimensions.ONE_UNIT_SIZE * 60,
                  decoration: const BoxDecoration(
                    color: ColorResources.WHITE,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(
                        4,
                        (index) => GestureDetector(
                          onTap: () {
                            controller.onChangeTab(index: index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.ONE_UNIT_SIZE * 10,
                              vertical: IZIDimensions.ONE_UNIT_SIZE * 5,
                            ),
                            height: double.infinity,
                            width: IZIDimensions.ONE_UNIT_SIZE * 580.roundToDouble() / 4.5,
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              border: Border(
                                bottom: controller.currentIndex == index
                                    ? BorderSide(
                                        width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                        color: ColorResources.CIRCLE_COLOR_BG,
                                      )
                                    : BorderSide.none,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.tieuDe[index].toString(),
                                    style: TextStyle(
                                      color: controller.currentIndex == index ? ColorResources.CIRCLE_COLOR_BG : ColorResources.GREY,
                                      fontWeight: controller.currentIndex == index ? FontWeight.w600 : FontWeight.normal,
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (index == 3)
                                    GestureDetector(
                                      onTap: controller.currentIndex == 3
                                          ? () {
                                              controller.isDecrease == true ? controller.filterIncrease() : controller.filterDecrease();
                                            }
                                          : null,
                                      child: Icon(
                                        controller.iconFilter,
                                        color: controller.currentIndex == index ? ColorResources.CIRCLE_COLOR_BG : ColorResources.GREY,
                                      ),
                                    )
                                  else
                                    const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: ColorResources.BACKGROUND,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          IZIDimensions.SPACE_SIZE_1X,
                          IZIDimensions.SPACE_SIZE_2X,
                          0,
                          IZIDimensions.SPACE_SIZE_1X,
                        ),
                        child: Text(
                          "Khám phá danh mục Sâm",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IZIListView(
                        itemCount: controller.dataMenu.length,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        margin: const EdgeInsets.all(0),
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
                    ],
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
                              marginCard: EdgeInsets.fromLTRB(
                                IZIDimensions.SPACE_SIZE_1X,
                                index == 0
                                    ? IZIDimensions.SPACE_SIZE_4X
                                    : index == 1
                                        ? IZIDimensions.SPACE_SIZE_4X
                                        : IZIDimensions.SPACE_SIZE_1X,
                                IZIDimensions.SPACE_SIZE_1X,
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
