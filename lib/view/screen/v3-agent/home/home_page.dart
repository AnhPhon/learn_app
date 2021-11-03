import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
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
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SmartRefresher(
            controller: controller.refreshController!,
            onLoading: controller.onLoading,
            onRefresh: controller.onRefresh,
            child: HomeWidget(
              fullname: "DL, ${controller.fullname}",
              soThongBao: controller.thongBaoList.length,
              content: Column(
                children: [
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                  // need update widget
                  _needUpdateWidget(),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                  // feature widget
                  _featuresWidget(),

                  // news widget
                  _newsWidget(),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                  // product widget
                  _productWidget()
                ],
              ),
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
          boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x3f000000))]),
      child: Row(
        children: [
          Row(
            children: const [
              Text(
                "Bạn cần hoàn thiện hồ sơ",
                style: TextStyle(
                  color: Color(0xff4D4D4D),
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              const Icon(CupertinoIcons.bell_fill,
                  color: ColorResources.PRIMARY),
              Positioned(
                right: 8,
                top: 5,
                child: Text(
                  controller.number.toString(),
                  style: const TextStyle(
                    color: ColorResources.WHITE,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  ),
                ),
              )
            ],
          ),
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
      height: 120,
      child: GridView.builder(
        padding: EdgeInsets.zero,
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
              iconColor: ColorResources.BLACK,
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
    return FieldWidget(
      title: "Tin tức",
      onTap: () {
        controller.onClickHotNews();
      },
      widget: SizedBox(
        height: (len > 0) ? 130 * len : 0,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: length,
          itemBuilder: (
            BuildContext ctx,
            index,
          ) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              child: ItemListWidget(
                onTap: () {
                  // call detail
                  controller.onClickHotNewsDetail(
                      controller.tinTucList[index].id.toString());
                },
                title: controller.tinTucList[index].tieuDe!,
                icon1: const Icon(Icons.remove_red_eye),
                rowText1: controller.tinTucList[index].luotXem,
                colorRowText1: ColorResources.BLACKGREY,
                icon2: const Icon(Icons.date_range_outlined),
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
    );
  }

  ///
  /// product widget
  ///
  Widget _productWidget() {
    int size = 2;
    if (controller.sanPhamList.length < 2) {
      size = controller.sanPhamList.length;
    }

    // return notificaiotn widget 0 case
    if (size == 0) {
      return Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          "Kho sản phẩm rỗng",
          style: TextStyle(
            color: ColorResources.RED,
          ),
        ),
      );
    }

    // backup
    return FieldWidget(
      title: "Kho sản phẩm",
      onTap: () {
        controller.onClickWareHouse();
      },
      widget: SizedBox(
        height: 110 * size + 20,
        child: ListView.builder(
          itemCount: size,
          padding: EdgeInsets.zero,
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
                  hinhAnh: (controller
                          .sanPhamList[index].hinhAnhSanPhams!.isNotEmpty)
                      ? controller.sanPhamList[index].hinhAnhSanPhams![0]
                          .toString()
                      : "",
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
