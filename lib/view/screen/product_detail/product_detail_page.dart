import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/product_detail/product_detail_controller.dart';
import 'package:template/view/screen/product_detail/product_specification_view.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  // final categoriesController = Get.put(CategoriesController());

  ///
  ///icons quality
  ///
  Widget _iconsquality(BuildContext context,
      {VoidCallback? onTap, Icon? icon, String? text, Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.01)),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            border: Border.all(color: color ?? ColorResources.PRIMARY),
            borderRadius: BorderRadius.circular(5)),
        child: text != null ? Align(child: Text(text)) : icon,
      ),
    );
  }

  Widget _sanPhamMoi(BuildContext context, ProductDetailController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.65,
            crossAxisCount: 2,
          ),
          itemCount: controller.productModelList.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                // controller.onProductClick();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorResources.WHITE),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          controller.productModelList[index].thumbnail!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: DeviceUtils.getScaledHeight(context, 0.01)),
                    SizedBox(
                      height: DeviceUtils.getScaledSize(context, 0.101),
                      child: Text(
                        controller.productModelList[index].name!,
                        maxLines: 2,
                        style: Dimensions.fontSizeStyle14w600(),
                      ),
                    ),
                    Text(PriceConverter.convertPrice(
                        context,
                        double.parse(
                            controller.productModelList[index].prices!)))
                  ],
                ),
              ),
            );
          }),
    );
  }

  ///
  ///Hinh anh cua san pham
  ///
  Widget _imgProduct(BuildContext context, ProductDetailController controller) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Image.network(
          controller.productModel!.images!,
          fit: BoxFit.fill,
          width: 1000.0,
        );
      },
      options: CarouselOptions(
        height: DeviceUtils.getScaledHeight(context, 0.4),
        autoPlay: true,
        viewportFraction: 1,
      ),
    );
  }

  Widget _bottomCart(BuildContext context) {
    return GetBuilder<ProductDetailController>(
        init: ProductDetailController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            height: DeviceUtils.getScaledHeight(context, 0.08),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 15,
                    spreadRadius: 1)
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      controller.onCartClick();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),

                      ///
                      ///icon cart count
                      ///
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL + 2),
                            decoration: const ShapeDecoration(
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 2,
                                        color: ColorResources.PRIMARY))),
                            child: Image.asset(
                              Images.cart,
                              color: ColorResources.PRIMARY,
                            ),
                          ),

                          ///
                          ///
                          ///
                          GetBuilder<ProductDetailController>(
                              init: ProductDetailController(),
                              builder: (ProductDetailController controller) {
                                if (controller.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Positioned(
                                  top: 0,
                                  right: DeviceUtils.getScaledHeight(
                                      context, 0.027),
                                  child: Container(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 0.02),
                                    width: DeviceUtils.getScaledWidth(
                                        context, 0.04),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorResources.RED,
                                    ),
                                    child: Text(
                                      controller.productFromCartList.length
                                          .toString(),
                                      style: titilliumSemiBold.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),

                ///
                ///button add to cart
                ///
                Expanded(
                  flex: 8,
                  child: GetBuilder<ProductDetailController>(
                      init: ProductDetailController(),
                      builder: (controller) {
                        if (controller.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            controller.qualityProduct = 1;
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height:
                                        DeviceUtils.getScaledSize(context, 0.7),
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
                                                  style: Dimensions
                                                      .fontSizeStyle16w600(),
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
                                                  padding: EdgeInsets.all(
                                                      DeviceUtils
                                                          .getScaledWidth(
                                                              context, 0.01)),
                                                  alignment: Alignment.center,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorResources.GREY,
                                                  ),
                                                  child: Icon(
                                                    Icons.close_outlined,
                                                    size: DeviceUtils
                                                        .getScaledHeight(
                                                            context, 0.023),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(color: Colors.grey),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                child: Image.network(
                                                  controller
                                                      .productModel!.images!,
                                                  height:
                                                      DeviceUtils.getScaledSize(
                                                          context, 0.178),
                                                  width:
                                                      DeviceUtils.getScaledSize(
                                                          context, 0.178),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              flex: 7,
                                              child: GetBuilder(builder:
                                                  (ProductDetailController
                                                      value) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .productModel!.name!,
                                                      maxLines: 2,
                                                      style: titilliumSemiBold
                                                          .copyWith(
                                                              fontSize: 16),
                                                    ),
                                                    Text(
                                                      PriceConverter.convertPrice(
                                                          context,
                                                          double.parse(
                                                              controller
                                                                  .productModel!
                                                                  .prices!)),
                                                      style: titilliumSemiBold
                                                          .copyWith(
                                                              color:
                                                                  Colors.grey),
                                                    ),

                                                    SizedBox(
                                                        height: DeviceUtils
                                                            .getScaledSize(
                                                                context, 0.02)),

                                                    //button quanlity
                                                    Row(
                                                      children: [
                                                        _iconsquality(context,
                                                            onTap: () {
                                                          controller
                                                              .decrementQuality();
                                                        },
                                                            icon: Icon(
                                                                Icons.remove,
                                                                color: controller
                                                                            .qualityProduct ==
                                                                        1
                                                                    ? Colors
                                                                        .grey
                                                                    : ColorResources
                                                                        .PRIMARY),
                                                            color: controller
                                                                        .qualityProduct ==
                                                                    1
                                                                ? Colors.grey
                                                                : null),
                                                        _iconsquality(context,
                                                            text: controller
                                                                .qualityProduct
                                                                .toString()),
                                                        _iconsquality(context,
                                                            onTap: () {
                                                          controller
                                                              .incrementQuality();
                                                        },
                                                            icon: const Icon(
                                                                Icons
                                                                    .add_outlined,
                                                                color: Colors
                                                                    .grey)),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        GestureDetector(
                                          onTap: () {
                                            controller.order();
                                            Get.back();
                                          },
                                          child: Container(
                                            height: DeviceUtils.getScaledHeight(
                                                context, 0.068),
                                            margin: EdgeInsets.only(
                                                left:
                                                    DeviceUtils.getScaledHeight(
                                                        context, 0.012)),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: ColorResources.PRIMARY,
                                            ),
                                            child: Text(
                                              "Thêm vào giỏ hàng",
                                              style: titilliumSemiBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_LARGE,
                                                  color: ColorResources.WHITE),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: DeviceUtils.getScaledHeight(context, 0.068),
                            margin: EdgeInsets.only(
                                left: DeviceUtils.getScaledHeight(
                                    context, 0.012)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.PRIMARY,
                            ),
                            child: Text(
                              "Thêm vào giỏ hàng",
                              style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: ColorResources.WHITE),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().customAppBar(title: "Chi tiết sản phẩm"),
      bottomNavigationBar: _bottomCart(context),
      body: GetBuilder<ProductDetailController>(
          init: ProductDetailController(),
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///
                  ///img product
                  ///
                  _imgProduct(context, controller),

                  ///
                  ///header product detail
                  ///

                  Container(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    color: ColorResources.WHITE,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.productModel!.name!,
                          ),
                          Text(PriceConverter.convertPrice(context,
                              double.parse(controller.productModel!.prices!))),
                          Text(
                            PriceConverter.convertPrice(
                                context,
                                double.parse(
                                    controller.productModel!.prriceOrigin!)),
                            style: robotoBold.copyWith(
                              color: Theme.of(context).hintColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.027),
                  ),

                  ///
                  ///product info
                  ///
                  ProductSpecification(
                      productSpecification:
                          controller.productModel!.description!),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.027),
                  ),

                  ///
                  ///Xem them
                  ///
                  Container(
                    color: ColorResources.WHITE,
                    padding: EdgeInsets.all(
                        DeviceUtils.getScaledSize(context, 0.027)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: DeviceUtils.getScaledSize(context, 0.027),
                              top: DeviceUtils.getScaledSize(context, 0.02),
                              bottom: DeviceUtils.getScaledSize(context, 0.02)),
                          child: const Text(
                            "Xem thêm",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        _sanPhamMoi(context, controller),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
