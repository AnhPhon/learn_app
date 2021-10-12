import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/field_widget.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
import 'package:template/view/basewidget/news/kho_san_pham.dart';
import 'package:template/view/basewidget/news/news.dart';

import 'home_controller.dart';

class V3HomePage extends GetView<V3HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: GetBuilder<V3HomeController>(
        init: V3HomeController(),
        builder: (V3HomeController controller) {
          return HomeWidget(
            fullname: "ĐL, ${controller.fullname}!",
            content: Column(
              children: [
                const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                // need update widget
                _needUpdateWidget(),
                const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                // feature widget
                _featuresWidget(),

                // news widget
                _newsWidget(),

                // product widget
                _productWidget()
              ],
            ),
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
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_LARGE)),
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
            onTap: controller.onNeedUpdateClick,
            child: Container(
              width: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              decoration: const BoxDecoration(
                  color: Color(0xff2196F3),
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT))),
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
  /// features widget
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
  /// news widget
  ///
  Widget _newsWidget() {
    return FieldWidget(
      title: "Tin tức",
      onTap: () {
        controller.onClickNews();
      },
      widget: Container(
        height: 220,
        padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: ListView.builder(
          itemCount: controller.tinTucList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (
            BuildContext ctx,
            index,
          ) {
            return Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: NewsBox(
                title: controller.tinTucList[index].tieuDe!,
                describe: controller.tinTucList[index].tomTat!,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _productWidget() {
    return FieldWidget(
      title: "Kho sản phẩm",
      onTap: () {
        controller.onClickWareHouse();
      },
      widget: Container(
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
              padding:
                  const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: KhoSanPham(
                tenSanPham: "Kệ son nồi",
                maSanPham: "BN001",
                giaSanPham: "${PriceConverter.convertPrice(ctx, 500000)} đ",
                quyCach: "Kim đỉnh",
              ),
            );
          },
        ),
      ),
    );
  }
}
