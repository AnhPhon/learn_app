import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/product_detail/product_detail_controller.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    ///
    ///san pham xem them
    ///
    Widget _sanPhamDanhMucBtn(Image image, String label, int money,
        {int? discount}) {
      return SizedBox(
          height: 280,
          width: Dimensions.SQUARE_CATEGORY_SIZE,
          child: GestureDetector(
            // ignore: sort_child_properties_last
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: ClipRRect(
                        // borderRadius: BorderRadius.circular(20),
                        child: image)),
                const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    label,
                    style: const TextStyle(
                        color: Color(0xFF27272A),
                        fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                ),
                const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "${controller.moneyNormalize(money, ",")} vnd",
                        style: const TextStyle(
                          color: Color(0xFF27272A),
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // ignore: prefer_if_elements_to_conditional_expressions
                      discount != null
                          ? Container(
                              margin: EdgeInsets.all(
                                  DeviceUtils.getScaledSize(context, 0.008)),
                              padding: EdgeInsets.all(
                                  DeviceUtils.getScaledSize(context, 0.008)),
                              decoration: BoxDecoration(
                                  color: ColorResources.RED,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "-$discount%",
                                style: const TextStyle(
                                    color: ColorResources.WHITE, fontSize: 10),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {},
          ));
    }

    Widget _sanPhamMoi() {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Row(children: [
            _sanPhamDanhMucBtn(
              Image.asset(
                Images.sp3,
                width: Dimensions.SQUARE_CATEGORY_SIZE,
                height: Dimensions.SQUARE_CATEGORY_SIZE,
              ),
              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
              138000,
              discount: 10,
            ),
            const Spacer(),
            _sanPhamDanhMucBtn(
              Image.asset(
                Images.sp4,
                width: Dimensions.SQUARE_CATEGORY_SIZE,
                height: Dimensions.SQUARE_CATEGORY_SIZE,
              ),
              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
              138000,
            ),
          ]),
          const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT * 2),
          Row(children: [
            _sanPhamDanhMucBtn(
              Image.asset(
                Images.sp3,
                width: Dimensions.SQUARE_CATEGORY_SIZE,
                height: Dimensions.SQUARE_CATEGORY_SIZE,
              ),
              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
              138000,
            ),
            const Spacer(),
            _sanPhamDanhMucBtn(
              Image.asset(
                Images.sp4,
                width: Dimensions.SQUARE_CATEGORY_SIZE,
                height: Dimensions.SQUARE_CATEGORY_SIZE,
              ),
              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
              138000,
            ),
          ]),
          Row(children: [
            _sanPhamDanhMucBtn(
              Image.asset(
                Images.sp3,
                width: Dimensions.SQUARE_CATEGORY_SIZE,
                height: Dimensions.SQUARE_CATEGORY_SIZE,
              ),
              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
              138000,
            ),
            const Spacer(),
            _sanPhamDanhMucBtn(
              Image.asset(
                Images.sp4,
                width: Dimensions.SQUARE_CATEGORY_SIZE,
                height: Dimensions.SQUARE_CATEGORY_SIZE,
              ),
              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
              138000,
            ),
          ])
        ]),
      );
    }

    return GetBuilder<ProductDetailController>(
        init: ProductDetailController(),
        builder: (ProductDetailController value) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Chi tiết sản phẩm",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            bottomNavigationBar: _bottomCart(context),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///
                  ///img product
                  ///
                  _imgProduct(context),

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
                          const Text(
                            "Tên sản phẩm",
                          ),
                          Text(PriceConverter.convertPrice(context, 230000)),
                          Text(
                            PriceConverter.convertPrice(context, 230000),
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
                  ///shipping info
                  ///
                  Container(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    color: ColorResources.WHITE,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Thông tin shipping",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                            height:
                                DeviceUtils.getScaledHeight(context, 0.013)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL,
                              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorResources.GREY),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Ship tới"),
                                  SizedBox(
                                      height: DeviceUtils.getScaledHeight(
                                          context, 0.013)),
                                  const Text(
                                    "đây là địa chỉ giao hàng",
                                    maxLines: 2,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {},
                                  child: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.027),
                  ),

                  ///
                  ///product info
                  ///
                  Container(
                    height: DeviceUtils.getScaledHeight(context, 0.27),
                    color: ColorResources.WHITE,
                    padding: EdgeInsets.all(
                        DeviceUtils.getScaledSize(context, 0.027)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "Thông tin sản phẩm",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                  ),

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
                        const Text(
                          "Xem thêm",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        _sanPhamMoi(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

///
///Hinh anh cua san pham
///
Widget _imgProduct(BuildContext context) {
  return CarouselSlider.builder(
    itemCount: 5,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
      return Image.asset(
        "assets/images/product.png",
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
  print(MediaQuery.of(context).size);
  return Container(
    height: DeviceUtils.getScaledHeight(context, 0.08),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Theme.of(context).accentColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade300, blurRadius: 15, spreadRadius: 1)
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),

            ///
            ///icon cart count
            ///
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL + 2),
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(
                            side: BorderSide(
                                width: 2, color: ColorResources.PRIMARY))),
                    child: Image.asset(
                      Images.cart,
                      color: ColorResources.PRIMARY,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: DeviceUtils.getScaledHeight(context, 0.027),
                  child: Container(
                    height: DeviceUtils.getScaledHeight(context, 0.02),
                    width: DeviceUtils.getScaledWidth(context, 0.04),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.RED,
                    ),
                    child: Text(
                      "1",
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        ///
        ///button add to cart
        ///
        Expanded(
            flex: 8,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: DeviceUtils.getScaledHeight(context, 0.068),
                margin: EdgeInsets.only(
                    left: DeviceUtils.getScaledHeight(context, 0.012)),
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
            ))
      ],
    ),
  );
}
