import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/product_widget.dart';
import 'package:template/view/screen/v1-customer/product/product_detail/product_detail_controller.dart';
import 'package:template/view/screen/v1-customer/product/product_detail/product_specification.dart';

class V1ProductDetailPage extends GetView<V1ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProductDetailController>(
        init: V1ProductDetailController(),
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
            bottomNavigationBar: _bottomCart(context, controller),
          );
        });
  }

  ///
  ///img product
  ///
  Widget _imgProduct(
      BuildContext context, V1ProductDetailController controller) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: controller.sanPhamResponse.hinhAnhSanPhams!.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return FadeInImage.assetNetwork(
            placeholder: Images.logo,
            image: controller.sanPhamResponse.hinhAnhSanPhams![itemIndex],
            fit: BoxFit.fill,
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
      BuildContext context, V1ProductDetailController controller) {
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
          const Padding(
            padding: EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_SMALL,
              top: Dimensions.PADDING_SIZE_DEFAULT,
              bottom: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Text(
              "Thông tin sản phẩm",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ),
          const Divider(color: Colors.grey),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),

          //infomation product
          if (controller.isLoadingMore)
            V1ProductSpecification(
              productSpecification: controller.sanPhamResponse.moTa.toString(),
            )
          else
            Flexible(
              child: V1ProductSpecification(
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
      BuildContext context, V1ProductDetailController controller) {
    return Container(
      color: ColorResources.WHITE,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          const Padding(
            padding: EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_SMALL,
              top: Dimensions.PADDING_SIZE_DEFAULT,
              bottom: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Text(
              "Xem thêm",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ),

          //divider
          const Divider(color: Colors.grey),

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

  ///
  ///icon cart
  ///
  Widget _iconCartCount(
      BuildContext context, V1ProductDetailController controller) {
    return GetBuilder<V1ProductDetailController>(builder: (controller) {
      return Expanded(
        flex: 2,
        child: GestureDetector(
          onTap: () => controller.onCartClick(),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),

            ///icon cart
            child: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(
                          side: BorderSide(
                              width: 2, color: ColorResources.PRIMARY))),
                  child: Image.asset(
                    Images.cart,
                    color: ColorResources.PRIMARY,
                  ),
                ),

                ///quanlity
                Positioned(
                  top: 0,
                  right: Dimensions.PADDING_SIZE_LARGE,
                  child: Container(
                    height: DeviceUtils.getScaledHeight(context, .019),
                    width: DeviceUtils.getScaledWidth(context, .038),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.RED,
                    ),
                    child: Text(
                      controller.donHangResponse != null
                          ? controller.chiTietDonHangList.length.toString()
                          : "0",
                      style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: ColorResources.WHITE),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  ///
  /// bottom cart
  ///
  Widget _bottomCart(
      BuildContext context, V1ProductDetailController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, .08),
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
          topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 15, spreadRadius: 1)
        ],
      ),
      child: Row(
        children: [
          //icon cart count
          _iconCartCount(context, controller),

          // button add to cart
          Expanded(
              flex: 9,
              child: BtnCustom(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        controller.quantityProduct = 1;
                        return _modalBottomSheet(context);
                      },
                    );
                  },
                  color: ColorResources.PRIMARY,
                  text: "Thêm vào giỏ hàng",
                  width: double.infinity))
        ],
      ),
    );
  }

  ///
  ///icons quality
  ///
  Widget _iconQuality(
    BuildContext context, {
    VoidCallback? onTap,
    Icon? icon,
    String? text,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
        height: DeviceUtils.getScaledSize(context, .064),
        width: DeviceUtils.getScaledSize(context, .064),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color ?? ColorResources.PRIMARY),
        ),
        child: text != null ? Align(child: Text(text)) : icon,
      ),
    );
  }

  ///
  ///ModalBottomSheet
  ///
  Widget _modalBottomSheet(BuildContext context) {
    return GetBuilder<V1ProductDetailController>(
      builder: (controller) {
        return Container(
          height: DeviceUtils.getScaledSize(context, 0.8),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 9,
                      child: Center(
                          child: Text(
                        "Chọn số lượng",
                        style: Dimensions.fontSizeStyle18w600(),
                      ))),

                  ///
                  /// close
                  ///
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResources.GREY.withOpacity(.5),
                        ),
                        child: const Icon(
                          Icons.close_outlined,
                          size: Dimensions.ICON_SIZE_SMALL,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_DEFAULT,
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          height: DeviceUtils.getScaledSize(context, .2),
                          width: DeviceUtils.getScaledSize(context, .2),
                          image: controller.sanPhamResponse.hinhAnhDaiDien
                              .toString(),
                          fit: BoxFit.cover,
                          imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder,
                            height: DeviceUtils.getScaledSize(context, .2),
                            width: DeviceUtils.getScaledSize(context, .2),
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                  Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.sanPhamResponse.ten.toString(),
                            maxLines: 2,
                            style: titilliumSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          Text(
                            "${PriceConverter.convertPrice(context, double.parse(controller.sanPhamResponse.gia.toString()))} vnđ",
                            style:
                                titilliumSemiBold.copyWith(color: Colors.grey),
                          ),

                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //button quanlity
                          Row(
                            children: [
                              _iconQuality(context, onTap: () {
                                controller.decrementQuality();
                              },
                                  icon: Icon(Icons.remove,
                                      color: controller.quantityProduct == 1
                                          ? Colors.grey
                                          : ColorResources.PRIMARY),
                                  color: controller.quantityProduct == 1
                                      ? Colors.grey
                                      : null),
                              _iconQuality(context,
                                  text: controller.quantityProduct.toString()),
                              _iconQuality(context, onTap: () {
                                controller.incrementQuality();
                              },
                                  icon: const Icon(Icons.add_outlined,
                                      color: Colors.grey)),
                            ],
                          ),
                        ],
                      )),
                ],
              ),

              const Spacer(),

              //btn
              BtnCustom(
                onTap: () {
                  controller.addProductToCart();

                  // close dialog
                  Get.back();
                },
                color: ColorResources.PRIMARY,
                text: "Thêm vào giỏ hàng",
                width: DeviceUtils.getScaledWidth(context, .9),
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),
            ],
          ),
        );
      },
    );
  }
}
