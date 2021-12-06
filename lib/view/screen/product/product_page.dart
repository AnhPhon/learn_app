import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/product_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/product/product_controller.dart';

class ProductPage extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //header
                Container(
                  color: ColorResources.WHITE,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //category
                      SearchDropDownButton<DanhMucSanPhamResponse>(
                        hint: "Chọn hạng mục",
                        data: controller.danhMucList,
                        width: double.infinity,
                        value: controller.danhMucSanPhamResponse,
                        obligatory: false,
                        isHideLineButton: true,
                        fillColor: ColorResources.WHITE,
                        isEnable: controller.danhMucList.isNotEmpty,
                        onChanged: controller.danhMucList.isNotEmpty ? controller.onCategoryChange : null,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Divider(
                          color: ColorResources.GREY,
                          height: 0,
                        ),
                      ),

                      //search bar
                      InputWidget(
                        hintText: "Tìm kiếm",
                        suffixIcon: Icon(
                          (controller.isSearched) ? Icons.close : Icons.search,
                          size: Dimensions.ICON_SIZE_DEFAULT,
                        ),
                        suffixIconTap: () {
                          (controller.isSearched) ? controller.clearSearch(context) : controller.btnSearch(context);
                        },
                        textEditingController: controller.searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) => controller.btnSearch(context),
                        width: double.infinity,
                        isBorder: false,
                        fillColor: ColorResources.WHITE,
                      ),
                    ],
                  ),
                ),

                //product list
                Expanded(
                  child: Container(
                    color: ColorResources.WHITE,
                    child: Column(
                      children: [
                        Container(
                          color: ColorResources.GREY.withOpacity(.15),
                          height: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),
                        _productList(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ///product list
  ///
  Widget _productList(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return Expanded(
          child: Column(
            children: [
              //label
              const Label(
                label: "Danh sách sản phẩm",
                obligatory: false,
                paddingTitle: 0,
                topPadding: Dimensions.PADDING_SIZE_DEFAULT,
              ),

              //divider
              const Padding(
                padding: EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Divider(
                  thickness: 2,
                  height: 0,
                ),
              ),

              //product list
              if (controller.isSPLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (controller.sanPhamList.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text("Chưa có sản phẩm"),
                  ),
                )
              else
                Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    enablePullUp: controller.sanPhamList.isNotEmpty,
                    onRefresh: () => controller.onRefresh(context),
                    onLoading: () => controller.onLoading(context),
                    footer: const ClassicFooter(
                      loadingText: "Đang tải...",
                      noDataText: "Không có dữ liệu",
                      canLoadingText: "Kéo lên để tải thêm dữ liệu",
                    ),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .85,
                          mainAxisSpacing: 15,
                          crossAxisCount: 2,
                        ),
                        itemCount: controller.sanPhamList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            child: GestureDetector(
                              onTap: () => controller.onProductDetailClick(controller.sanPhamList[index]),
                              child: ProductWidget(
                                imgUrl: controller.sanPhamList[index].hinhAnhDaiDien.toString(),
                                name: controller.sanPhamList[index].ten!,
                                price: "${PriceConverter.convertPrice(
                                  context,
                                  double.parse(controller.sanPhamList[index].gia!),
                                )} vnđ",
                              ),
                            ),
                          );
                        }),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
