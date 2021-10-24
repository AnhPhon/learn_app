import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
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
                color: ColorResources.WHITE,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_SMALL,
                    ),

                    //search bar
                    _searchBar(context),

                    //category
                    DropDownButton1<DanhMucSanPhamResponse>(
                      hint: "Hạng mục",
                      value: controller.danhMucSanPhamResponse,
                      onChanged: controller.onCategoryChange,
                      data: controller.danhMucList,
                      width: double.infinity,
                      isBorder: false,
                    ),
                  ],
                ),
              ),

              //product list
              Expanded(
                child: Scrollbar(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    enablePullUp: true,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    footer: const ClassicFooter(
                      loadingText: "Đang tải...",
                      noDataText: "Không có dữ liệu",
                      canLoadingText: "Kéo lên để tải thêm dữ liệu",
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_DEFAULT,
                          ),
                          _productList(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  ///search bar
  ///
  Widget _searchBar(BuildContext context) {
    return GetBuilder<V1ProductController>(builder: (controller) {
      return InputWidget(
        hintText: "Tìm kiếm",
        suffixIcon: const Icon(Icons.search,
          size: Dimensions.ICON_SIZE_DEFAULT,
        ),
        suffixIconTap: () => controller.searchProduct(),
        textEditingController: controller.searchController,
        width: double.infinity,
      );
    });
  }

  ///
  ///product list
  ///
  Widget _productList(BuildContext context) {
    return GetBuilder<V1ProductController>(builder: (controller) {
      if (controller.isSPLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return controller.sanPhamList.isEmpty
          ? const SizedBox.shrink()
          : Container(
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
                          .onProductDetailClick(controller.sanPhamList[index]),
                      child: ProductWidget(
                        imgUrl: controller.sanPhamList[index].hinhAnhDaiDien
                            .toString(),
                        name: controller.sanPhamList[index].ten!,
                        price: "${PriceConverter.convertPrice(
                          context,
                          double.parse(controller.sanPhamList[index].gia!),
                        )} vnđ",
                      ),
                    );
                  }),
            );
    });
  }
}
