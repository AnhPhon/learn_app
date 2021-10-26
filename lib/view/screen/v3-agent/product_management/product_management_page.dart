import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/component/app_bar_with_tabbar.dart';
import 'package:template/view/screen/v3-agent/product_management/product_management_controller.dart';

class V3ProductManagementPage extends GetView<V3ProductManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ProductManagementController>(
        init: V3ProductManagementController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWithTabBar(
              title: controller.title,
              bottom: TabBar(
                controller: controller.tabController,
                isScrollable: true,
                indicatorColor: ColorResources.PRIMARY,
                labelColor: ColorResources.PRIMARY,
                unselectedLabelColor: Colors.grey,
                tabs: controller.danhMucSanPhamResponse.map(
                  (categories) {
                    return Tab(text: categories.ten.toString());
                  },
                ).toList(),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(controller.danhMucSanPhamResponse.length,
                  (index) {
                return _item(context, indexRefreshController: index);
              }),
            ),
          );
        });
  }

  ///
  ///item
  ///
  Widget _item(BuildContext context, {required int indexRefreshController}) {
    return GetBuilder<V3ProductManagementController>(
      builder: (controller) {
        if (controller.isLoadingProduct) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scrollbar(
          child: SmartRefresher(
            controller:
                controller.refreshControllerList![indexRefreshController],
            enablePullUp: true,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            footer: const ClassicFooter(
              loadingText: "Đang tải...",
              noDataText: "Không có dữ liệu",
              canLoadingText: "Kéo lên để tải thêm dữ liệu",
            ),
            child: (controller.sanPhamResponse.isEmpty)
                ? const Center(
                    child: Text("Không có sản phẩm"),
                  )
                : ListView.builder(
                    itemCount: controller.sanPhamResponse.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return GestureDetector(
                        onTap: () =>
                            controller.onProductDetailClick(index: index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: Dimensions.MARGIN_SIZE_SMALL,
                              horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: Images.placeholder,
                                      image: controller
                                          .sanPhamResponse[index].hinhAnhDaiDien
                                          .toString(),
                                      height: DeviceUtils.getScaledHeight(
                                          context, .08),
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      imageErrorBuilder: (c, o, s) =>
                                          Image.asset(
                                        Images.placeholder,
                                        height: DeviceUtils.getScaledHeight(
                                            context, .08),
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.MARGIN_SIZE_SMALL,
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.sanPhamResponse[index].ten
                                              .toString(),
                                          maxLines: 2,
                                          style:
                                              Dimensions.fontSizeStyle16w600(),
                                        ),
                                        const SizedBox(
                                          height: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL,
                                        ),
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Text(controller
                                                  .sanPhamResponse[index].donVi
                                                  .toString()),
                                              VerticalDivider(
                                                color: ColorResources.BLACK
                                                    .withOpacity(.7),
                                              ),
                                              Text(
                                                "${PriceConverter.convertPrice(
                                                  context,
                                                  double.parse(
                                                    controller
                                                        .sanPhamResponse[index]
                                                        .gia
                                                        .toString(),
                                                  ),
                                                )} vnđ",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                height: 20,
                                color: ColorResources.BLACK.withOpacity(.7),
                              ),

                              //product code
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller
                                      .sanPhamResponse[index].maSanPham
                                      .toString()),
                                  Text(
                                      "Quy cách: ${controller.sanPhamResponse[index].quyCach}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ),
        );
      },
    );
  }
}
