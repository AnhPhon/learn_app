import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/Product/Product_controller.dart';
import 'package:template/view/screen/product/components/filter_product.dart';

class ProductPage extends GetView<ProductController> {
  final _controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "",
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Icon(
                  Icons.filter_alt_outlined,
                  color: ColorResources.WHITE,
                ),
              );
            },
          )
        ],
      ),
      body: GetBuilder(
        init: ProductController(),
        builder: (ProductController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              children: [],
            ),
          );
        },
      ),
      drawer: FilterProduct(),
    );
  }
}
