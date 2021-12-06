import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/product_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/product/component/textfield_quanlity.dart';
import 'package:template/view/screen/product/product_detail/product_detail_controller.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(
      init: ProductDetailController(),
      builder: (controller) {
        if (controller.isLoading || controller.isLoadingStock) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Scrollbar(
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: controller.sanPhamList.isNotEmpty,
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
      },
    );
  }

  ///
  ///img product
  ///
  Widget _imgProduct(BuildContext context, ProductDetailController controller) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: controller.sanPhamResponse.hinhAnhSanPhams!.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return FadeInImageCustom(
            urlImage: controller.sanPhamResponse.hinhAnhSanPhams![itemIndex]
                .toString(),
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
  Widget _headerProductDetail(
    BuildContext context, {
    required String name,
    required String price,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      color: ColorResources.WHITE,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_LARGE,
          color: ColorResources.BLACK,
          fontWeight: FontWeight.w600,
        ),
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
            Text(
              price,
              style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                color: ColorResources.RED,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///Product Specification
  ///
  Widget _productSpecification(
      BuildContext context, ProductDetailController controller) {
    return Container(
      height: controller.isLoadingMore
          ? null
          : DeviceUtils.getScaledHeight(context, .565),
      color: ColorResources.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //label
          const Label(
            label: "Thông tin sản phẩm",
            obligatory: false,
            paddingTitle: 0,
            topPadding: Dimensions.PADDING_SIZE_DEFAULT,
          ),

          //divider
          Dimensions().paddingDivider(context),

          //product detail
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Column(
              children: [
                RowText(
                  text1: "Mã sản phẩm",
                  text2: controller.sanPhamResponse.maSanPham.toString(),
                  notFontSize: true,
                  notFontWeight: true,
                  colorRed: true,
                ),
                Dimensions().paddingDivider(context, height: 0),
                RowText(
                  text1: "Thương hiệu",
                  text2: controller.sanPhamResponse.thuongHieu.toString(),
                  notFontSize: true,
                  notFontWeight: true,
                  colorRed: true,
                ),
                Dimensions().paddingDivider(context, height: 0),
                RowText(
                  text1: "Danh mục",
                  text2: controller.sanPhamResponse.idDanhMucSanPham!.ten
                      .toString(),
                  notFontSize: true,
                  notFontWeight: true,
                  colorRed: true,
                ),
                Dimensions().paddingDivider(context, height: 0),
                RowText(
                  text1: "Quy cách",
                  text2: controller.sanPhamResponse.quyCach.toString(),
                  notFontSize: true,
                  notFontWeight: true,
                  colorRed: true,
                ),
                Dimensions().paddingDivider(context, height: 0),
                RowText(
                  text1: "Đơn vị",
                  text2: controller.sanPhamResponse.donVi.toString(),
                  notFontSize: true,
                  notFontWeight: true,
                  colorRed: true,
                ),
                Dimensions().paddingDivider(context, height: 0),
                RowText(
                  text1: "Tình trạng",
                  text2: TINH_TRANG_SAN_PHAM[
                          controller.sanPhamResponse.tinhTrangSanPham!]
                      .toString(),
                  notFontSize: true,
                  notFontWeight: true,
                  colorRed: true,
                ),
                Dimensions().paddingDivider(context, height: 0),
                RowText(
                  text1: "Số lượng tồn",
                  text2: controller.stock == 0
                      ? "Hết hàng"
                      : controller.stock.toString(),
                  notFontSize: true,
                  notFontWeight: true,
                  colorRed: true,
                ),
              ],
            ),
          ),

          //infomation product
          if (controller.isLoadingMore)
            Specification(
              specification: controller.sanPhamResponse.moTa.toString(),
              isScroll: false,
            )
          else
            Flexible(
              child: Specification(
                specification: controller.sanPhamResponse.moTa.toString(),
                isScroll: false,
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
      BuildContext context, ProductDetailController controller) {
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
            const Center(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text("Chưa có sản phẩm tương tự"),
              ),
            )
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
                    imgUrl:
                        controller.sanPhamList[index].hinhAnhDaiDien.toString(),
                    name: controller.sanPhamList[index].ten.toString(),
                    price:
                        "${PriceConverter.convertPrice(context, double.parse(controller.sanPhamList[index].gia.toString()))} vnđ",
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  ///
  ///icon cart
  ///
  Widget _iconCartCount(
      BuildContext context, ProductDetailController controller) {
    return GetBuilder<ProductDetailController>(builder: (controller) {
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
                        width: 2,
                        color: ColorResources.PRIMARY,
                      ),
                    ),
                  ),
                  child: Image.asset(
                    Images.cart,
                    color: ColorResources.PRIMARY,
                  ),
                ),

                ///quanlity
                Positioned(
                  top: 0,
                  child: Container(
                    height: DeviceUtils.getScaledHeight(context, .025),
                    width: DeviceUtils.getScaledWidth(context, .04),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.RED,
                    ),
                    child: Text(
                      controller.chiTietDonHangList.length.toString(),
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        color: ColorResources.WHITE,
                      ),
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
  Widget _bottomCart(BuildContext context, ProductDetailController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, .1),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_SMALL,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
          topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          //icon cart count
          _iconCartCount(context, controller),

          // button add to cart
          Expanded(
            flex: 9,
            child: (controller.stock == 0)
                ? BtnCustom(
                    onTap: () {},
                    color: ColorResources.GREY,
                    text: "Hết hàng",
                    width: DeviceUtils.getScaledWidth(context, .9),
                  )
                : BtnCustom(
                    onTap: () {
                      controller.quanlityController.text = '1';
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return _modalBottomSheet(context);
                        },
                      );
                    },
                    color: ColorResources.PRIMARY,
                    text: "Thêm vào giỏ hàng",
                    width: double.infinity,
                  ),
          ),
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
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    VoidCallback? onTapCancel,
    Icon? icon,
    String? text,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      child: Container(
        margin: const EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
        height: DeviceUtils.getScaledSize(context, .064),
        width: DeviceUtils.getScaledSize(context, .064),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color ?? ColorResources.PRIMARY),
        ),
        child: Center(
          child: text != null ? Align(child: Text(text)) : icon,
        ),
      ),
    );
  }

  ///
  ///ModalBottomSheet
  ///
  Widget _modalBottomSheet(BuildContext context) {
    return GetBuilder<ProductDetailController>(
      builder: (controller) {
        return UnFocusTextField(
          widget: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: DeviceUtils.getScaledSize(context, .7),
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      //label
                      Expanded(
                        flex: 9,
                        child: Center(
                          child: Text(
                            "Chọn số lượng",
                            style: Dimensions.fontSizeStyle18w600(),
                          ),
                        ),
                      ),

                      /// close
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back(result: true);
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

                  //image
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
                          child: FadeInImageCustom(
                            urlImage: controller.sanPhamResponse.hinhAnhDaiDien
                                .toString(),
                            height: .2,
                            width: .2,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //infomation
                      Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //name
                              Text(
                                controller.sanPhamResponse.ten.toString(),
                                maxLines: 2,
                                style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                ),
                              ),

                              //price
                              Text(
                                "${PriceConverter.convertPrice(context, double.parse(controller.sanPhamResponse.gia.toString()))} vnđ",
                                style: titilliumSemiBold.copyWith(
                                    color: Colors.grey),
                              ),

                              const SizedBox(
                                height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                              ),

                              //button quanlity
                              Row(
                                children: [
                                  //decrement
                                  _iconQuality(
                                    context,
                                    onTap: () =>
                                        controller.decrementQuality(onTap: 0),
                                    onTapDown: (TapDownDetails details) =>
                                        controller.decrementQuality(onTap: 1),
                                    onTapUp: (TapUpDetails details) =>
                                        controller.decrementQuality(onTap: 2),
                                    onTapCancel: () =>
                                        controller.decrementQuality(onTap: 3),
                                    icon: Icon(
                                      Icons.remove,
                                      color:
                                          controller.quanlityController.text ==
                                                  '1'
                                              ? Colors.grey
                                              : ColorResources.PRIMARY,
                                    ),
                                    color: controller.quanlityController.text ==
                                            '1'
                                        ? Colors.grey
                                        : null,
                                  ),

                                  // quality
                                  TextFieldQuanlity(
                                    textEditingController:
                                        controller.quanlityController,
                                    height: .045,
                                    width: .15,
                                    borderRadius: 10,
                                    contentPadding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                    ),
                                  ),

                                  //increment
                                  _iconQuality(
                                    context,
                                    onTap: () =>
                                        controller.incrementQuality(onTap: 0),
                                    onTapDown: (TapDownDetails details) =>
                                        controller.incrementQuality(onTap: 1),
                                    onTapUp: (TapUpDetails details) =>
                                        controller.incrementQuality(onTap: 2),
                                    onTapCancel: () =>
                                        controller.incrementQuality(onTap: 3),
                                    icon: const Icon(
                                      Icons.add_outlined,
                                      color: ColorResources.PRIMARY,
                                    ),
                                  ),
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
                      controller
                          .addProductToCart(controller.quanlityController.text);
                      Get.back(result: true);
                    },
                    color: ColorResources.PRIMARY,
                    text: "Thêm vào giỏ hàng",
                    width: DeviceUtils.getScaledWidth(context, .9),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}