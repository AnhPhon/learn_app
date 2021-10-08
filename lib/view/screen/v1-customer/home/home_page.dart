import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/field_widget.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
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
          return HomeWidget(
            fullname: controller.fullname,
            content: Column(
              children: [
                // _categoryBoxWidget
                _categoryBoxWidget(),

                // _threeFeatureWidget
                _threeFeatureWidget(),

                // product
                _productWidget(),

                _newsWidget()
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  /// category box widget
  ///
  Widget _categoryBoxWidget() {
    return SizedBox(
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
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
  /// product
  ///
  Widget _product() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: _fieldWidget(
        "Sản phẩm",
        () {},
        Container(
          height: 400,
          padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomRight:
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
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
                  fontSize: 18,
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

  Widget _productWidget() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: FieldWidget(
        title: "Sản phẩm",
        onTap: () {},
        widget: Container(
          height: 400,
          padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }

  ///
  /// news widget
  ///
  Widget _newsWidget() {
    return FieldWidget(
      title: "Tin tức",
      onTap: () {},
      widget: Container(
        height: 230,
        padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (
            BuildContext ctx,
            index,
          ) {
            return const Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: NewsBox(
                title: "Tin nóng tóm tắt tổng hợp",
                describe: "Việt Nam sắp có vắc xin điều trị Covid 20/09/2021",
              ),
            );
          },
        ),
      ),
    );
  }
}
