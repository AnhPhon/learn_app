import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/news/news.dart';

import 'home_controller.dart';

class V1HomePage extends GetView<V1HomeController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<V1HomeController>(
        init: V1HomeController(),
        builder: (V1HomeController controller) {
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
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                            ),
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                              child: Image.asset(
                                Images.V4AvatarHome,
                                width: 40,
                                height: 40,
                              ),
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
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.V1NOTIFICATION);
                              },
                              child: const Icon(
                                CupertinoIcons.bell_fill,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10)
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
                  alignment: Alignment.topLeft,
                  height: size.height - 180,
                  width: size.width,
                  margin: const EdgeInsets.only(),
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffF6F6F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                      topRight: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: size.width,
                      child: Column(
                        children: [
                          // _categoryBoxWidget
                          _categoryBoxWidget(),

                          // _threeFeatureWidget
                          _threeFeatureWidget(),

                          // product
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: _fieldWidget(
                              "Sản phẩm",
                              () {},
                              Container(
                                height: 400,
                                padding: const EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_DEFAULT,
                                ),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 120,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 9,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: _imageWidget(
                                        controller.productList![index]["title"].toString(),
                                        controller.productList![index]["image"].toString(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          _fieldWidget(
                            "Tin tức",
                            () {},
                            Container(
                              height: 180,
                              padding: const EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (
                                  BuildContext ctx,
                                  index,
                                ) {
                                  return const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NewsBox(
                                      title: "Tin nóng tóm tắt tổng hợp",
                                      describe: "Việt Nam sắp có vắc xin điều trị Covid 20/09/2021",
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
  /// category box widget
  ///
  Widget _categoryBoxWidget() {
    return Container(
      height: 240,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: controller.contentGrid![index]["onTap"] as Function(),
            child: BtnCategory(
              label: controller.contentGrid![index]["label"].toString(),
              gradient:
                  controller.contentGrid![index]["gradient"] as RadialGradient,
              icon: controller.contentGrid![index]["icon"] as IconData,
            ),
          );
        },
      ),
    );
  }

  ///
  /// three feature widget
  ///
  Widget _threeFeatureWidget() {
    return SizedBox(
      height: 140,
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
    return Padding(
      padding: EdgeInsets.all(5),
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

  ///
  /// image widget
  ///
  Widget _imageWidget(String title, String url) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                  bottomLeft: Radius.circular(11),
                  bottomRight: Radius.circular(11),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.20000000298023224),
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  )
                ],
                image: DecorationImage(
                  image: AssetImage(url),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 110 / 2 - 18 / 2,
            child: Container(
              width: 110,
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromRGBO(42, 53, 71, 1),
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  letterSpacing: -0.30000001192092896,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      offset: Offset(2, 0),
                    ),
                    Shadow(
                      color: Colors.white,
                      offset: Offset(0, 2),
                    ),
                    Shadow(
                      color: Colors.white,
                      offset: Offset(0, -2),
                    ),
                    Shadow(
                      color: Colors.white,
                      offset: Offset(-2, 0),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
