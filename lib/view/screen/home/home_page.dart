import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_Home.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_slider.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/widgets/getx_smart_refresh/getx_smart_refresh_page.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundHome(),
      body: GetBuilder(
        init: HomeController(),
        builder: (HomeController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              children: [
                headerUser(),
                IZISlider(
                  data: controller.data,
                  margin: EdgeInsets.only(
                    top: IZIDimensions.SPACE_SIZE_4X,
                  ),
                ),
                wallet(controller),
                Expanded(
                  child: GetXSmartRefreshPage(
                    onLoading: () async {
                      IZIAlert.info(message: 'loading more');
                    },
                    onRefresh: () async {
                      IZIAlert.info(message: 'refresh');
                    },
                    refreshController: controller.refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          listViewMenu(),
                          listViewCategory(
                            controller: controller,
                          ),
                          listViewProduct(),
                        ],
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

  Widget headerUser() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IZIText(
                text: "Xin ch??o,",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H5,
                ),
              ),
              IZIText(
                text: "Tr??m Nguy???n",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  controller.gotToNotification();
                },
                child: Icon(
                  Icons.notifications,
                  size: IZIDimensions.ONE_UNIT_SIZE * 50,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BLUR_RADIUS_3X,
                  ),
                ),
                child: IZIText(
                  text: "9+",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorResources.RED,
                    fontSize: IZIDimensions.ONE_UNIT_SIZE * 20,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget wallet(HomeController controller) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_H5,
        color: ColorResources.BLACK,
      ),
      child: Container(
        // color: ColorResources.WHITE,
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.ONE_UNIT_SIZE * 70,
        margin: EdgeInsets.only(
          top: IZIDimensions.SPACE_SIZE_3X,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IZIText(
                          text: "V?? c???a t??i",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H5,
                            color: ColorResources.BLACK,
                          ),
                        ),
                        SizedBox(
                          width: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.onVisibleWallet();
                          },
                          child: Icon(
                            controller.isVisibleWallet ? Icons.visibility : Icons.visibility_off,
                            size: IZIDimensions.ONE_UNIT_SIZE * 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IZIText(
                    text: controller.isVisibleWallet ? '999.999.999.999 VN??' : "************",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H5,
                      color: ColorResources.BLACK,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IZIText(
                  text: "Qu???n l?? t??i kho???n",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: IZIDimensions.ONE_UNIT_SIZE * 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget listViewMenu() {
    return IZIListView(
      itemCount: controller.dataMenu.length,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
      ),
      builder: (index) {
        return IZICard(
            marginCard: EdgeInsets.only(
              top: IZIDimensions.SPACE_SIZE_4X,
            ),
            icon: controller.dataMenu[index]['icon'] as IconData,
            colorBG: ColorResources.CIRCLE_COLOR_BG3,
            cardType: IZICardType.CARD_CIRCLE,
            row1Left: controller.dataMenu[index]['lable'].toString(),
            onTap: () {
              controller.dataMenu[index]['function']();
            });
      },
    );
  }

  Widget listViewCategory({required HomeController controller}) {
    return IZIListView(
      label: "Danh m???c",
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      action: GestureDetector(
        onTap: () {
          controller.goToProductPortfolio();
        },
        child: Row(
          children: [
            IZIText(
              text: "Xem th??m",
              style: TextStyle(
                color: ColorResources.CIRCLE_COLOR_BG3,
                fontSize: IZIDimensions.FONT_SIZE_H5,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: IZIDimensions.ONE_UNIT_SIZE * 25,
              color: ColorResources.CIRCLE_COLOR_BG3,
            )
          ],
        ),
      ),
      mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 370,
      itemCount: controller.dataMenu.length,
      type: IZIListViewType.GRIDVIEW,
      builder: (index) {
        return IZICard(
          marginCard: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_2X,
          ),
          urlImage: controller.dataMenu[index]['image'].toString(),
          colorBG: ColorResources.CIRCLE_COLOR_BG3,
          cardType: IZICardType.CARD_OUTLINE,
          row1Left: controller.dataMenu[index]['lable'].toString(),
        );
      },
    );
  }

  Widget listViewProduct() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: IZIListView(
        label: "S???n ph???m",
        margin: EdgeInsets.only(
          bottom: IZIDimensions.SPACE_SIZE_2X,
        ),
        action: GestureDetector(
          onTap: () {
            controller.goToProductPortfolio();
          },
          child: Row(
            children: [
              IZIText(
                text: "Xem th??m",
                style: TextStyle(
                  color: ColorResources.CIRCLE_COLOR_BG3,
                  fontSize: IZIDimensions.FONT_SIZE_H5,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: IZIDimensions.ONE_UNIT_SIZE * 25,
                color: ColorResources.CIRCLE_COLOR_BG3,
              )
            ],
          ),
        ),
        mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 450,
        itemCount: controller.dataMenu.length,
        type: IZIListViewType.GRIDVIEW,
        builder: (index) {
          return IZICard(
            marginCard: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            urlImage: controller.dataMenu[index]['image'].toString(),
            colorBG: ColorResources.CIRCLE_COLOR_BG3,
            row1Left: 'S??m D??y Ng???c Linh T????i/Kh??',
            row2Left: '?? 50.000',
            row3Left: "??100.000",
            row3Right: '???? b??n 100',
          );
        },
      ),
    );
  }
}
