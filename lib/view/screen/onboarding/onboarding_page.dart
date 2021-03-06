import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_splash3.dart';
import 'package:template/base_widget/background/background_splash1.dart';
import 'package:template/base_widget/background/background_splash2.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/onboarding/onboarding_controller.dart';

class OnBoardingPage extends GetView<OnBoardingController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: GetBuilder(
        builder: (OnBoardingController controller) {
          return background(controller.currentIndex);
        },
      ),
      body: GetBuilder(
        builder: (OnBoardingController controller) {
          return ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: IZIDimensions.iziSize.height,
                width: IZIDimensions.iziSize.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Lable
                      if (controller.currentIndex == 0)
                        lableWidget()
                      else
                        Container(
                          margin: EdgeInsets.only(
                            top: IZIDimensions.ONE_UNIT_SIZE * 50,
                            left: IZIDimensions.ONE_UNIT_SIZE * 20,
                          ),
                          height: IZIDimensions.ONE_UNIT_SIZE * 100,
                        ),
                      // Page
                      Expanded(
                        child: pageViewWidget(context),
                      ),
                      // Indicator

                      // Space bottom
                      // SizedBox(
                      //   height: IZIDimensions.SPACE_SIZE_2X,
                      // )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      widgetBottomSheet: GetBuilder(
        builder: (OnBoardingController controller) {
          return getWidgetGoToPageEnd(controller);
        },
      ),
    );
  }

  Widget background(int currentIndex) {
    if (currentIndex == 0) {
      return const BackgroundSplash1();
    } else if (currentIndex == 1) {
      return const BackgroundSplash2();
    } else {
      return const BackgroundSplash3();
    }
  }

  ///
  /// get widget when go to page end
  ///
  Widget getWidgetGoToPageEnd(OnBoardingController controller) {
    if (controller.currentIndex != 2) {
      return Container(
        margin: EdgeInsets.only(
          bottom: IZIDimensions.ONE_UNIT_SIZE * 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _buildIndicator(),
        ),
      );
    }
    return buttonComplete(controller);
  }

  Widget lableWidget() {
    return Container(
      height: IZIDimensions.ONE_UNIT_SIZE * 100,
      margin: EdgeInsets.only(
        top: IZIDimensions.ONE_UNIT_SIZE * 50,
        left: IZIDimensions.ONE_UNIT_SIZE * 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IZIText(
            text: "Ch??o m???ng ?????n v???i",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H5,
              color: ColorResources.WHITE,
            ),
          ),
          IZIText(
            text: "H?? N???i Safe Food",
            style: TextStyle(
              color: ColorResources.WHITE,
              fontSize: IZIDimensions.FONT_SIZE_H3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == controller.currentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      height: isActive ? IZIDimensions.ONE_UNIT_SIZE * 20 : IZIDimensions.ONE_UNIT_SIZE * 18,
      width: isActive ? IZIDimensions.ONE_UNIT_SIZE * 20 : IZIDimensions.ONE_UNIT_SIZE * 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isActive ? ColorResources.GREEN : ColorResources.CIRCLE_COLOR_BG2,
      ),
    );
  }

  ///
  /// Page view
  ///
  Widget pageViewWidget(BuildContext context) {
    return Container(
      // height: IZIDimensions.ONE_UNIT_SIZE * 570,
      alignment: Alignment.center,
      child: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.onChangeIndex(index);
        },
        children: [
          pageViewDetailWidget(
            context,
            image: ImagesPath.nature,
            description: "Mua s???m th???a th??ch v???i ??u ????i Mi???n Ph?? V???n Chuy???n",
          ),
          pageViewDetailWidget(
            context,
            image: ImagesPath.shop,
            description: "Mua s???m an to??n v???i H?? N???i Safe Food",
          ),
          pageViewDetailWidget(
            context,
            image: ImagesPath.sale,
            description: "B???t th??ng b??o ????? kh??ng b??? s??t ??u ????i",
          ),
        ],
      ),
    );
  }

  ///
  /// Page view widget
  ///
  Widget pageViewDetailWidget(
    BuildContext context, {
    required String image,
    required String description,
  }) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: IZIDimensions.ONE_UNIT_SIZE * 70,
            right: IZIDimensions.ONE_UNIT_SIZE * 70,
            top: IZIDimensions.ONE_UNIT_SIZE * 70,
            bottom: IZIDimensions.SPACE_SIZE_1X,
          ),
          width: IZIDimensions.iziSize.width,
          child: Center(
            child: Container(
              // height: IZIDimensions.ONE_UNIT_SIZE * 350,
              // width: IZIDimensions.ONE_UNIT_SIZE * 350,
              constraints: BoxConstraints(
                maxHeight: IZIDimensions.ONE_UNIT_SIZE * 750,
                maxWidth: IZIDimensions.ONE_UNIT_SIZE * 750,
              ),
              child: IZIImage(
                image,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: IZIDimensions.SPACE_SIZE_2X,
            right: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H4,
            ),
          ),
        )
      ],
    );
  }

  Widget buttonComplete(OnBoardingController controller) {
    return Container(
      // alignment: Alignment.bottomCenter,
      child: IZIButton(
        margin: EdgeInsets.only(
          left: IZIDimensions.ONE_UNIT_SIZE * 30,
          right: IZIDimensions.ONE_UNIT_SIZE * 30,
          bottom: IZIDimensions.ONE_UNIT_SIZE * 30,
        ),
        padding: EdgeInsets.all(
          IZIDimensions.ONE_UNIT_SIZE * 25,
        ),
        onTap: () {
          controller.onSaveSplash();
          controller.onComplete();
        },
        label: "Kh??m ph?? ngay",
      ),
    );
  }
}
