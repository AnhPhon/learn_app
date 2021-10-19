import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/price_converter.dart';
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
    return SmartRefresher(
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      controller: controller.refreshController,
      child: GetBuilder<V1ProductController>(
        init: V1ProductController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //header
                Container(
                  height: DeviceUtils.getScaledHeight(context, 0.14),
                  color: ColorResources.WHITE,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //search bar
                      _searchBar(context, controller),

                      //category
                      GestureDetector(
                        onTap: () {},
                        child: hangMucDropdown(
                          "Hạng mục",
                          controller.selectIndex,
                          controller.danhMucList
                              .map((e) => [e.id!, e.ten!])
                              .toList(),
                          controller.onCategoryChange,
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
                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),
                        if (controller.isSPLoading)
                          const Center(child: CircularProgressIndicator())
                        else
                          _productList(context, controller),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
      decoration: const InputDecoration(
        isDense: true,
        prefixIcon: Icon(
          Icons.search,
          size: Dimensions.ICON_SIZE_LARGE,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.PRIMARY, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.GREY, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.GREY, width: 2),
        ),
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
    if (controller.sanPhamList.isNotEmpty) {
      return Container(
        color: ColorResources.WHITE,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .7,
              crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
              crossAxisCount: 2,
            ),
            itemCount: controller.sanPhamList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => controller
                    .onProductDetailClick(controller.sanPhamList[index].id!),
                child: ProductWidget(
                  imgUrl: controller.sanPhamList[index].hinhAnhSanPham!,
                  name: controller.sanPhamList[index].ten!,
                  price: "${PriceConverter.convertPrice(
                    context,
                    double.parse(controller.sanPhamList[index].gia!),
                  )} VND",
                ),
              );
            }),
      );
    } else {
      return const Center(
        child: Text("Không có dữ liệu"),
      );
    }
  }

  ///
  /// dropdown hạng mục
  ///
  Widget hangMucDropdown(
    String labelText,
    String selectValue,
    List<List<String>> values,
    Function(String?) onChanged,
  ) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              labelStyle: Dimensions.textNormalStyleCard(),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
              hintText: labelText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: selectValue == 'hạng mục',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectValue,
              isDense: true,
              onChanged: onChanged,
              items: values.map((List<String> value) {
                return DropdownMenuItem<String>(
                  value: value[0],
                  child: Text(value[1]),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
