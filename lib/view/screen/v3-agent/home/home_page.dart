import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/card/product_card.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/field_widget.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
import 'package:template/view/basewidget/news/kho_san_pham.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';

import 'home_controller.dart';

class V3HomePage extends GetView<V3HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: GetBuilder<V3HomeController>(
        init: V3HomeController(),
        builder: (V3HomeController controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return HomeWidget(
            fullname: "DL, ${controller.fullname}",
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
                _productWidget(controller: controller)
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
          Row(
            children: [
              const Text(
                "Bạn cần hoàn thiện ",
                style: TextStyle(
                  color: Color(0xff4D4D4D),
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
              Text(
                controller.number.toString(),
                style: const TextStyle(
                  color: ColorResources.RED,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
              const Text(
                " hồ sơ",
                style: TextStyle(
                  color: Color(0xff4D4D4D),
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
            ],
          ),
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
  /// item list
  ///
  Widget _itemList(BuildContext context, int index) {
    return ItemListWidget(
      urlImage: controller.tinTucList[index].hinhAnh.toString(),
      onTap: () {},
      title: controller.tinTucList[index].tieuDe.toString(),
      colorRowText2: ColorResources.GREY,
      icon1: const Icon(Icons.remove_red_eye_sharp),
      rowText1: "10",
      icon2: const Icon(Icons.calendar_today),
      rowText2: "20/09/2021",
      isSpaceBetween: true,
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
  /// news widget
  ///
  Widget _newsWidget() {
    final int length =
        controller.tinTucList.length > 2 ? 2 : controller.tinTucList.length;
    final double len = length * 1.0;
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: FieldWidget(
        title: "Tin tức",
        onTap: () {
          controller.onClickHotNews();
        },
        widget: SizedBox(
          height: (len > 0) ? 140 * len : 0,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: (
              BuildContext ctx,
              index,
            ) {
              return Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: ItemListWidget(
                  onTap: () {
                    // call detail
                    controller
                        .onClickHotNewsDetail(controller.tinTucList[index].id!);
                  },
                  title: "Biệt thự 170 Nguyễn Đình Thi",
                  icon1: const Icon(Icons.remove_red_eye),
                  rowText1: controller.tinTucList[index].luotXem,
                  colorRowText1: ColorResources.BLACKGREY,
                  icon2: const Icon(Icons.monetization_on_outlined),
                  rowText2: controller.tinTucList[index].createdAt
                      .toString()
                      .substring(0, 10),
                  colorRowText2: ColorResources.BLACKGREY,
                  isStart: true,
                  urlImage: controller.tinTucList[index].hinhAnh!,
                  isSpaceBetween: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ///
  /// product widget
  ///
  Widget _productWidget({required V3HomeController controller}) {
    final int size =
        controller.sanPhamList.length <= 2 ? controller.sanPhamList.length : 2;

    return FieldWidget(
      title: "Kho sản phẩm",
      onTap: () {
        controller.onClickWareHouse();
      },
      widget: Container(
        height: 110 * size + 50,
        padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_SMALL,
        ),
        child: ListView.builder(
          itemCount: size,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (
            BuildContext ctx,
            index,
          ) {
            return Padding(
              padding:
                  const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: GestureDetector(
                onTap: () {
                  controller.onClickHotProductDetail(
                    controller.sanPhamList[index].id!,
                  );
                },
                child: KhoSanPham(
                  tenSanPham: controller.sanPhamList[index].ten!,
                  maSanPham: "${controller.sanPhamList[index].maSanPham}",
                  giaSanPham: "${PriceConverter.convertPrice(
                    ctx,
                    double.parse(controller.sanPhamList[index].gia!),
                  )} đ",
                  quyCach: controller.sanPhamList[index].quyCach!,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
