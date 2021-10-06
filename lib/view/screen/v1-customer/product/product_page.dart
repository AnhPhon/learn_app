import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/product_widget.dart';
import 'package:template/view/screen/v1-customer/product/product_controller.dart';

class V1ProductPage extends GetView<V1ProductController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProductController>(
        init: V1ProductController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //header
                Container(
                  height: DeviceUtils.getScaledHeight(context, 0.13),
                  color: ColorResources.WHITE,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //search bar
                      _searchBar(context, controller),

                      //category
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //title
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    DeviceUtils.getScaledWidth(context, 0.038),
                                vertical:
                                    DeviceUtils.getScaledHeight(context, 0.019),
                              ),
                              child: const Text(
                                "Hạng mục",
                                style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            //icon
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    DeviceUtils.getScaledWidth(context, 0.038),
                              ),
                              child: Icon(
                                Icons.arrow_drop_down,
                                size:
                                    DeviceUtils.getScaledHeight(context, 0.05),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //product list
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context, 0.019),
                        ),
                        _productList(context, controller),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  ///
  ///search bar
  ///
  Widget _searchBar(BuildContext context, V1ProductController controller) {
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
          horizontal: DeviceUtils.getScaledWidth(context, 0.025),
          vertical: DeviceUtils.getScaledHeight(context, 0.019),
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
  Widget _productList(BuildContext context, V1ProductController controller) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceUtils.getScaledWidth(context, 0.038),
      ),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
                  imgUrl: Images.newsTemplate,
                  name: "Sản phẩm ${index + 1}",
                  price: "230.000 VND"),
            );
          }),
    );
  }
}
