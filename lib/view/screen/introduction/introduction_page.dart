import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/screen/introduction/introduction_controller.dart';

class IntroductionPage extends GetView<IntroductionController> {
  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset("assets/images/$assetName", width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT + 1,
        0.0,
        Dimensions.PADDING_SIZE_DEFAULT + 1,
        Dimensions.PADDING_SIZE_DEFAULT + 1,
      ),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return GetBuilder<IntroductionController>(
        init: IntroductionController(),
        builder: (IntroductionController value) {
          return IntroductionScreen(
            key: controller.introKey,
            globalBackgroundColor: Colors.white,

            pages: [
              PageViewModel(
                title: "Kinh nghiệm thi công",
                body:
                    "Kinh nghiệm với hàng trăm công trình xây nhà trọn gói, sửa chữa nhà trọn gói quy mô lớn nhỏ trên khắp mọi tỉnh, thành.",
                image: _buildImage("img1.jpg"),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Thủ tục pháp lý",
                body:
                    "Tư vấn chi tiết các thủ tục pháp lý, song hành cùng chủ đầu tư giải quyết các vấn đề có liên quan.",
                image: _buildImage("img2.jpg"),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Chi phí và quy trình",
                body:
                    "Tiên lượng tất cả các chi phí có thể phát sinh trong quá trình xây dựng. Quy trình quản lý kỹ thuật chặt chẽ, Đảm bảo tiến độ công trình.",
                decoration: pageDecoration.copyWith(
                  bodyFlex: 2,
                  imageFlex: 4,
                  bodyAlignment: Alignment.bottomCenter,
                  imageAlignment: Alignment.topCenter,
                ),
                image: _buildImage("img3.jpg"),
                reverse: true,
              ),
            ],
            onDone: () => controller.onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            //rtl: true, // Display as right-to-left
            skip: const Text('Bỏ qua',
                style: TextStyle(color: ColorResources.PRIMARY)),
            next:
                const Icon(Icons.arrow_forward, color: ColorResources.PRIMARY),
            done: const Text('Tiếp tục',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.PRIMARY)),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin:
                const EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT + 1),
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT - 3)
                : const EdgeInsets.fromLTRB(
                    Dimensions.PADDING_SIZE_EXTRA_SMALL + 3.0,
                    Dimensions.PADDING_SIZE_EXTRA_SMALL - 1.0,
                    Dimensions.PADDING_SIZE_EXTRA_SMALL + 3.0,
                    Dimensions.PADDING_SIZE_EXTRA_SMALL - 1.0,
                  ),
            dotsDecorator: const DotsDecorator(
              size: Size(
                  Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
              color: ColorResources.PRIMARY,
              activeSize: Size(Dimensions.PADDING_SIZE_LARGE + 2,
                  Dimensions.PADDING_SIZE_SMALL),
              activeColor: ColorResources.PRIMARY,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),
              ),
            ),
          );
        });
  }
}
