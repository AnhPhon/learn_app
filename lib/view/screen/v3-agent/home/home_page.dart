import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/news/kho_san_pham.dart';
import 'package:template/view/basewidget/news/news.dart';

import 'home_controller.dart';

class V3HomePage extends GetView<V3HomeController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<V3HomeController>(
        init: V3HomeController(),
        builder: (V3HomeController controller) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: ColorResources.THEME_DEFAULT,
                ),
                child: Stack(children: [
                  Positioned(
                    top: -20,
                    left: -50,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                            ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -80,
                    right: -20,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                            ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 25,
                    // left: 15,
                    width: size.width,
                    child: Container(
                      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            margin: const EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                              child:
                                  const Icon(Icons.menu, color: Colors.white),
                            ),
                          ),
                          Text(
                            controller.fullname,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: const Icon(
                              CupertinoIcons.bell_fill,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: Dimensions.MARGIN_SIZE_SMALL)
                        ],
                      ),
                    ),
                  ),
                ]),
              ),

              // white
              Positioned(
                top: 100,
                child: Container(
                  height: size.height - 180,
                  width: size.width,
                  margin: const EdgeInsets.only(),
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_SMALL,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffF6F6F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                      topRight: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                          // need update widget
                          _needUpdateWidget(),
                          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                          // feature widget
                          _featuresWidget(),

                          // news widget
                          _fieldWidget(
                            "Tin tức",
                            () {},
                            Container(
                              height: 220,
                              padding: const EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              child: ListView.builder(
                                itemCount: 2,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (
                                  BuildContext ctx,
                                  index,
                                ) {
                                  return const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NewsBox(
                                      title: "Tin nóng tóm tắt tổng hợp",
                                      describe:
                                          "Việt Nam sắp có vắc xin điều trị Covid 20/09/2021",
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          // news widget
                          _fieldWidget(
                            "Kho sản phẩm",
                            () {},
                            Container(
                              height: 220,
                              padding: const EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              child: ListView.builder(
                                itemCount: 2,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (
                                  BuildContext ctx,
                                  index,
                                ) {
                                  return Padding(
                                    padding: const EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                    child: KhoSanPham(
                                      tenSanPham: "Kệ son nồi",
                                      maSanPham: "BN001",
                                      giaSanPham: "${PriceConverter.convertPrice(context, 500000)} đ",
                                      quyCach: "Kim đỉnh",
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  ///
  /// need update widget
  ///
  Widget _needUpdateWidget() {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_LARGE)),
          boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x1f000000))]),
      child: Row(
        children: [
          const Text('Bạn cần hoàn thiện hồ sơ',
              style: TextStyle(
                  color: Color(0xff4D4D4D),
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_LARGE)),
          const Icon(CupertinoIcons.bell, color: Color(0xff4D4D4D)),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              decoration: const BoxDecoration(
                  color: Color(0xff2196F3),
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT))),
              child: const Text(
                "Cập nhật",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// feature widget
  ///
  Widget _featuresWidget() {
    return SizedBox(
      height: 150,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.threeFeatures!.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: controller.threeFeatures![index]["onTap"] as Function(),
            child: BtnCategory(
              label: controller.threeFeatures![index]["label"] as String,
              gradient: controller.threeFeatures![index]["gradient"]
                  as RadialGradient,
              icon: controller.threeFeatures![index]["icon"] as IconData,
            ),
          );
        },
      ),
    );
  }

  ///
  /// field widget
  ///
  Widget _fieldWidget(String title, Function() onTap, Widget widget) {
    const double _fontSize = 16;
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _fontSize,
                  color: Color(0xff040404),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: const [
                    Text(
                      "Xem thêm",
                      style: TextStyle(
                        color: Color(0xff2196f3),
                        fontSize: _fontSize,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff2196f3),
                      size: _fontSize,
                    ),
                  ],
                ),
              )
            ],
          ),
          widget
        ],
      ),
    );
  }
}
