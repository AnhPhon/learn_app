import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/product_widget.dart';
import 'package:template/view/screen/v1-customer/product/product_controller.dart';

class V1ProductPage extends GetView<V1ProductController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<V1ProductController>(
        init: V1ProductController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //header
                Expanded(
                  child: Container(
                    color: ColorResources.WHITE,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //search bar
                        _searchBar(context, controller, height, width),

                        //category
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                DeviceUtils.getScaledWidth(context, 15 / width),
                            vertical: DeviceUtils.getScaledHeight(
                                context, 15 / height),
                          ),
                          child: const Text(
                            "Hạng mục",
                            style: TextStyle(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, 15 / height),
                ),

                //product list
                Expanded(
                  flex: 5,
                  child: _productList(context, controller, width),
                ),
              ],
            ),
          );
        });
  }

  ///
  ///search bar
  ///
  Widget _searchBar(BuildContext context, V1ProductController controller,
      double height, double width) {
    return TextField(
      textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      controller: controller.searchController,
      cursorColor: ColorResources.PRIMARY,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: const Icon(
          Icons.search,
          size: Dimensions.ICON_SIZE_LARGE,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 10 / width),
          vertical: DeviceUtils.getScaledHeight(context, 15 / height),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorResources.PRIMARY, width: 2)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorResources.GREY, width: 2)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorResources.GREY, width: 2)),
        hintText: "Tìm kiếm",
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }

  ///
  ///product list
  ///
  Widget _productList(
      BuildContext context, V1ProductController controller, double width) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 15 / width)),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .7,
            crossAxisSpacing: 20,
            crossAxisCount: 2,
          ),
          itemCount: 17,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => controller.onProductDetailClick(),
              child: ProductWidget(
                  imgUrl: "assets/images/news_template.png",
                  name: "Sản phẩm ${index + 1}",
                  price: "230.000 VND"),
            );
          }),
    );
  }
}
