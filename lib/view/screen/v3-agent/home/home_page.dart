import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/field_widget.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
import 'package:template/view/basewidget/news/kho_san_pham.dart';

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
  /// news widget
  ///
  Widget _newsWidget() {
    return FieldWidget(
      title: "Tin tức",
      onTap: () {
        controller.onClickNews();
      },
      widget: Container(
        height: 320,
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
            return _itemList(ctx, index);
          },
        ),
      ),
    );
  }

  ///
  /// item list
  ///
  Widget _itemList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_SMALL,
            vertical: Dimensions.MARGIN_SIZE_SMALL),
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.MARGIN_SIZE_SMALL,
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          color: ColorResources.WHITE,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.logo,
                    image: controller.tinTucList[index].hinhAnh!,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    child: Text(
                      controller.tinTucList[index].tieuDe!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    child: Text(
                      controller.tinTucList[index].tomTat!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "7:00 20/09/2021",
                        style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL),
                      ),
                      SizedBox(
                        width: Dimensions.MARGIN_SIZE_SMALL,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                  ),
                ],
              ),
            ),
          ],
        ),
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
          itemCount: controller.sanPhamList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (
            BuildContext ctx,
            index,
          ) {
            return Padding(
              padding:
                  const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: KhoSanPham(
                tenSanPham: controller.sanPhamList[index].ten!,
                maSanPham: controller.sanPhamList[index].maSanPham!,
                giaSanPham:
                    "${PriceConverter.convertPrice(ctx, double.parse(controller.sanPhamList[index].gia!))} đ",
                quyCach: "Kim đỉnh",
              ),
            );
          },
        ),
      ),
    );
  }
}
