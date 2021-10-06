import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/product_widget.dart';
import 'package:template/view/screen/v1-customer/product/product_detail/product_detail_controller.dart';

class V1ProductDetailPage extends GetView<V1ProductDetailController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<V1ProductDetailController>(
        init: V1ProductDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //img product
                  _imgProduct(context, controller, height),

                  //header product detail
                  _headerProductDetail(
                    context,
                    height,
                    width,
                    name: "Sản phẩm",
                    price: "230.000 VND",
                    discount: "460.000 VND",
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.013),
                  ),

                  //ProductSpecification
                  _productSpecification(context, controller, height, width),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.013),
                  ),

                  //more product
                  _moreProduct(context, controller, height, width),
                ],
              ),
            ),
            bottomNavigationBar:
                _bottomCart(context, controller, height, width),
          );
        });
  }

  ///
  ///img product
  ///
  Widget _imgProduct(BuildContext context, V1ProductDetailController controller,
      double height) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Image.asset(
            controller.imgProduct,
            fit: BoxFit.fill,
            width: double.infinity,
          );
        },
        options: CarouselOptions(
          height: DeviceUtils.getScaledHeight(context, 270 / height),
          autoPlay: true,
          viewportFraction: 1,
        ),
      ),
    );
  }

  ///
  /// header product detail
  ///
  Widget _headerProductDetail(BuildContext context, double height, double width,
      {required String name, required String price, required String discount}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 15 / width)),
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
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.006)),
            Text(price,
                style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    color: ColorResources.RED,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.006)),
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
  Widget _productSpecification(BuildContext context,
      V1ProductDetailController controller, double height, double width) {
    return Container(
      height: controller.isLoadingMore
          ? null
          : DeviceUtils.getScaledHeight(context, 200 / height),
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 0.038)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: DeviceUtils.getScaledWidth(context, 7 / width),
              top: DeviceUtils.getScaledHeight(context, 0.013),
              bottom: DeviceUtils.getScaledHeight(context, 0.013),
            ),
            child: const Text(
              "Thông tin sản phẩm",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ),
          const Divider(color: Colors.grey),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 17 / height),
          ),

          //infomation product
          if (controller.isLoadingMore)
            Text(controller.productSpecification)
          else
            Flexible(
              child: Text(controller.productSpecification),
            ),

          SizedBox(
            height: DeviceUtils.getScaledSize(context, 17 / height),
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
  Widget _moreProduct(BuildContext context,
      V1ProductDetailController controller, double height, double width) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 0.038)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Padding(
            padding: EdgeInsets.only(
              left: DeviceUtils.getScaledWidth(context, 7 / width),
              top: DeviceUtils.getScaledHeight(context, 0.013),
              bottom: DeviceUtils.getScaledHeight(context, 0.013),
            ),
            child: const Text(
              "Xem thêm",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ),

          //divider
          const Divider(color: Colors.grey),

          //product list
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .7,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: ProductWidget(
                      imgUrl: Images.newsTemplate,
                      name: "Sản phẩm ${index + 1}",
                      price: "230.000 VND"),
                );
              }),
        ],
      ),
    );
  }

  ///
  ///icon cart
  ///
  Expanded _iconCartCount(BuildContext context,
      V1ProductDetailController controller, double height, double width) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: () => controller.onCartClick(),
        child: Padding(
          padding:
              EdgeInsets.all(DeviceUtils.getScaledSize(context, 5 / width)),

          ///icon cart
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(
                    DeviceUtils.getScaledSize(context, 7 / width)),
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
                right: DeviceUtils.getScaledWidth(context, 0.038),
                child: Container(
                  height: DeviceUtils.getScaledHeight(context, 0.019),
                  width: DeviceUtils.getScaledWidth(context, 0.038),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.RED,
                  ),
                  child: const Text(
                    "1",
                    style: TextStyle(
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
  }

  ///
  /// bottom cart
  ///
  Widget _bottomCart(BuildContext context, V1ProductDetailController controller,
      double height, double width) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 60 / height),
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 0.025),
          vertical: DeviceUtils.getScaledHeight(context, 0.006)),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 15, spreadRadius: 1)
        ],
      ),
      child: Row(
        children: [
          //icon cart count
          _iconCartCount(context, controller, height, width),

          // button add to cart
          Expanded(
              flex: 9,
              child: BtnCustom(
                  onTap: () {},
                  color: ColorResources.PRIMARY,
                  text: "Thêm vào giỏ hàng",
                  width: double.infinity))
        ],
      ),
    );
  }
}
