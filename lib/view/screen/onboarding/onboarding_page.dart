import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
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
      background: GetBuilder(
        builder: (OnBoardingController controller) {
          return background(controller.currentIndex);
        },
      ),
      body: GetBuilder(
        builder: (OnBoardingController controller) {
          return Column(
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
                          height: IZIDimensions.iziSize.height * 0.1,
                        ),
                      // Page
                      pageViewWidget(context),
                      // Indicator
                      getWidgetGoToPageEnd(controller),
                      // Space bottom
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_2X,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget background(int currentIndex) {
    if (currentIndex == 0) {
      return const BackgroundSplash1();
    } else if (currentIndex == 1) {
      return const backgroundSplash2();
    } else {
      return const BackgroundSplash3();
    }
  }

  ///
  /// get widget when go to page end
  ///
  Widget getWidgetGoToPageEnd(OnBoardingController controller) {
    if (controller.currentIndex != 2) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _buildIndicator(),
        ),
      );
    }
    return Expanded(
      child: buttonComplete(controller),
    );
  }

  Widget lableWidget() {
    return Container(
      height: IZIDimensions.iziSize.height * 0.1,
      margin: EdgeInsets.only(
        top: IZIDimensions.ONE_UNIT_SIZE * 50,
        left: IZIDimensions.ONE_UNIT_SIZE * 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IZIText(
            text: "Chào mừng đến với",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H5,
              color: ColorResources.WHITE,
            ),
          ),
          IZIText(
            text: "Hà Nội Safe Food",
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
    return SizedBox(
      height: IZIDimensions.iziSize.height * 0.65,
      child: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.onChangeIndex(index);
        },
        children: [
          pageViewDetailWidget(
            context,
            image: ImagesPath.nature,
            description: "Mua sắm thỏa thích với ưu đãi Miễn Phí Vận Chuyển",
          ),
          pageViewDetailWidget(
            context,
            image: ImagesPath.shop,
            description: "Mua sắm an toàn với Hà Nội Safe Food",
          ),
          pageViewDetailWidget(
            context,
            image: ImagesPath.sale,
            description: "Bật thông báo để không bỏ sót ưu đãi",
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
            child: IZIImage(
              image,
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
    return Center(
      child: IZIButton(
        margin: EdgeInsets.symmetric(
          horizontal: IZIDimensions.ONE_UNIT_SIZE * 30,
        ),
        padding: EdgeInsets.all(
          IZIDimensions.ONE_UNIT_SIZE * 25,
        ),
        onTap: () {
          controller.onSaveSplash();
          controller.onComplete();
        },
        label: "Khám phá ngay",
      ),
    );
  }
}
