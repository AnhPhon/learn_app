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
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/product_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v2-builder/product/product_controller.dart';

class V2ProductPage extends GetView<V2ProductController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ProductController>(
      init: V2ProductController(),
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
                    //category
                    DropDownButton1<DanhMucSanPhamResponse>(
                      hint: "Hạng mục",
                      value: controller.danhMucSanPhamResponse,
                      onChanged: controller.onCategoryChange,
                      data: controller.danhMucList,
                      width: double.infinity,
                      isBorder: false,
                      fillColor: ColorResources.WHITE,
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
                        (controller.isSearched)
                            ? controller.clearSearch(context)
                            : controller.btnSearch(context);
                      },
                      textEditingController: controller.searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) => controller.btnSearch(context),
                      // onChanged: (value) => controller.onChangeSearch(value.toString()),
                      width: double.infinity,
                      isBorder: false,
                      fillColor: ColorResources.WHITE,
                    ),
                  ],
                ),
              ),

              //product list
              Expanded(
                // flex: 7,
                child: Container(
                  height: double.infinity,
                  color: ColorResources.WHITE,
                  child: Scrollbar(
                    child: SmartRefresher(
                      controller: controller.refreshController,
                      enablePullUp: true,
                      onRefresh: () => controller.onRefresh(context),
                      onLoading: () => controller.onLoading(context),
                      footer: const ClassicFooter(
                        loadingText: "Đang tải...",
                        noDataText: "Không có dữ liệu",
                        canLoadingText: "Kéo lên để tải thêm dữ liệu",
                      ),
                      child: SingleChildScrollView(
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
  ///product list
  ///
  Widget _productList(BuildContext context) {
    return GetBuilder<V2ProductController>(
      builder: (controller) {
        if (controller.isSPLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return controller.sanPhamList.isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  //label
                  const Label(
                    label: "Danh sách sản phẩm",
                    obligatory: false,
                    paddingTitle: 0,
                    topPadding: Dimensions.PADDING_SIZE_DEFAULT,
                  ),

                  //divider
                  Dimensions().paddingDivider(context),

                  //product list
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .8,
                        crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
                        crossAxisCount: 2,
                      ),
                      itemCount: controller.sanPhamList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          child: GestureDetector(
                            onTap: () => controller.onProductDetailClick(
                                controller.sanPhamList[index]),
                            child: ProductWidget(
                              imgUrl: controller
                                  .sanPhamList[index].hinhAnhDaiDien
                                  .toString(),
                              name: controller.sanPhamList[index].ten!,
                              price: "${PriceConverter.convertPrice(
                                context,
                                double.parse(
                                    controller.sanPhamList[index].gia!),
                              )} vnđ",
                            ),
                          ),
                        );
                      }),
                ],
              );
      },
    );
  }
}
