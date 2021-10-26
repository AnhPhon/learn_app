import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/product_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v3-agent/product_management/product_detail/product_detail_controller.dart';
import 'package:template/view/screen/v3-agent/product_management/product_detail/product_specification.dart';

class V3ProductDetailPage extends GetView<V3ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ProductDetailController>(
        init: V3ProductDetailController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Scrollbar(
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
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //img product
                      _imgProduct(context, controller),

                      //header product detail
                      _headerProductDetail(
                        context,
                        name: controller.sanPhamResponse.ten.toString(),
                        price:
                            "${PriceConverter.convertPrice(context, double.parse(controller.sanPhamResponse.gia.toString()))} vnđ",
                        discount:
                            "${PriceConverter.convertPrice(context, double.parse(controller.sanPhamResponse.gia.toString()))} vnđ",
                      ),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      //ProductSpecification
                      _productSpecification(context, controller),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      //more product
                      _moreProduct(context, controller),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  ///
  ///img product
  ///
  Widget _imgProduct(
      BuildContext context, V3ProductDetailController controller) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: controller.sanPhamResponse.hinhAnhSanPhams!.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return FadeInImageCustom(
            urlImage: controller.sanPhamResponse.hinhAnhSanPhams![itemIndex],
            height: double.infinity,
            width: double.infinity,
          );
        },
        options: CarouselOptions(
          height: DeviceUtils.getScaledHeight(context, .355),
          autoPlay: true,
          viewportFraction: 1,
        ),
      ),
    );
  }

  ///
  /// header product detail
  ///
  Widget _headerProductDetail(BuildContext context,
      {required String name, required String price, required String discount}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      color: ColorResources.WHITE,
      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: ColorResources.BLACK,
            fontWeight: FontWeight.w600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Text(price,
                style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    color: ColorResources.RED,
                    fontWeight: FontWeight.w600)),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Text(
              discount,
              style: TextStyle(
                color: Theme.of(context).hintColor,
                decoration: TextDecoration.lineThrough,
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  ///Product Specification
  ///
  Widget _productSpecification(
      BuildContext context, V3ProductDetailController controller) {
    return Container(
      height: controller.isLoadingMore
          ? null
          : DeviceUtils.getScaledHeight(context, .263),
      color: ColorResources.WHITE,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Label(
            label: "Thông tin sản phẩm",
            obligatory: false,
            horizontalPadding: 0,
            paddingTitle: 0,
            topPadding: Dimensions.PADDING_SIZE_DEFAULT,
          ),

          //divider
          Dimensions().paddingDivider(context),

          //infomation product
          if (controller.isLoadingMore)
            V3ProductSpecification(
              productSpecification: controller.sanPhamResponse.moTa.toString(),
            )
          else
            Flexible(
              child: V3ProductSpecification(
                productSpecification:
                    controller.sanPhamResponse.moTa.toString(),
              ),
            ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),

          // more / less
          GestureDetector(
            onTap: () {
              controller.isLoadingMore
                  ? controller.loadingMore()
                  : controller.loadingLess();
            },
            child: Align(
              child: Column(
                children: [
                  Text(
                    controller.isLoadingMore ? "Thu gọn" : "Xem thêm",
                    style: const TextStyle(color: ColorResources.PRIMARY),
                  ),
                  Icon(
                    controller.isLoadingMore
                        ? Icons.arrow_drop_up_outlined
                        : Icons.arrow_drop_down_outlined,
                    color: ColorResources.PRIMARY,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  ///more product
  ///
  Widget _moreProduct(
      BuildContext context, V3ProductDetailController controller) {
    return Container(
      color: ColorResources.WHITE,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //label
          const Label(
            label: "Xem thêm",
            obligatory: false,
            horizontalPadding: 0,
            paddingTitle: 0,
            topPadding: Dimensions.PADDING_SIZE_DEFAULT,
          ),

          //divider
          Dimensions().paddingDivider(context),

          //product list
          if (controller.sanPhamList.isEmpty)
            const SizedBox.shrink()
          else
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .7,
                  crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
                  crossAxisCount: 2,
                ),
                itemCount: controller.sanPhamList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => controller.onGetProduct(index: index),
                      child: ProductWidget(
                        imgUrl: controller.sanPhamList[index].hinhAnhDaiDien
                            .toString(),
                        name: controller.sanPhamList[index].ten.toString(),
                        price:
                            "${PriceConverter.convertPrice(context, double.parse(controller.sanPhamList[index].gia.toString()))} vnđ",
                      ));
                }),
        ],
      ),
    );
  }
}
