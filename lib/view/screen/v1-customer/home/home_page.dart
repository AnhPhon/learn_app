import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/field_widget.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';

import 'home_controller.dart';

class V1HomePage extends GetView<V1HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: GetBuilder<V1HomeController>(
        init: V1HomeController(),
        builder: (V1HomeController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return HomeWidget(
            fullname: "KH, ${controller.fullname}",
            content: Column(
              children: [
                // _categoryBoxWidget
                _categoryBoxWidget(),

                // _threeFeatureWidget
                _threeFeatureWidget(),

                // product
                _productWidget(controller),

                _newsWidget(controller: controller)
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
      height: 220,
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
              label: controller.contentGrid![index]["label"] as List<String>,
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
      height: 120,
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
              label: controller.threeFeatures![index]["label"] as List<String>,
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
    const double _fontSize = Dimensions.FONT_SIZE_LARGE;
    return Padding(
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
                  image: NetworkImage(url),
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
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
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

  ///
  /// product widget
  ///
  Widget _productWidget(V1HomeController controller) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: FieldWidget(
        title: "Danh mục sản phẩm",
        onTap: () => controller.onMoreProductList(),
        widget: SizedBox(
          height: 380,
          child: GridView.builder(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 120,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.danhMucList.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  controller
                      .onMoreCategoryProduct(controller.danhMucList[index].id!);
                },
                child: _imageWidget(
                  controller.danhMucList[index].ten!,
                  Images.location_example,
                  // controller.danhMucList[index].hinhAnhSanPham!,
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
  Widget _newsWidget({required V1HomeController controller}) {
    final int size =
        controller.tinTucList.length <= 2 ? controller.tinTucList.length : 2;
    return FieldWidget(
      title: "Tin tức",
      onTap: () {
        controller.onClickHotNews();
      },
      widget: SizedBox(
        height: 135 * size * 1.0 + 10,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.tinTucList.length <= 2
              ? controller.tinTucList.length
              : 2,
          padding: const EdgeInsets.all(0),
          itemBuilder: (
            BuildContext ctx,
            index,
          ) {
            return ItemListWidget(
              urlImage: controller.tinTucList[index].hinhAnh.toString(),
              onTap: () {
                controller.goToNewPageClick(controller.tinTucList[index].id!);
              },
              title: controller.tinTucList[index].tieuDe.toString(),
              colorRowText2: ColorResources.GREY,
              icon1: const Icon(Icons.remove_red_eye_sharp),
              rowText1: controller.tinTucList[index].luotXem,
              icon2: const Icon(Icons.calendar_today),
              rowText2: DateConverter.readMongoToString(
                controller.tinTucList[index].createdAt!,
              ),
              isSpaceBetween: true,
            );
          },
        ),
      ),
    );
  }
}
