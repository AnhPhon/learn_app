import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/product/cart/cart_controller.dart';
import 'package:template/view/screen/product/component/textfield_quanlity.dart';

class CartPage extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          if (controller.isReloadAddress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return UnFocusTextField(
            widget: Scaffold(
              appBar: AppBarWidget(
                title: controller.title,
                leading: IconButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorResources.WHITE,
                  ),
                ),
              ),
              body: (controller.chiTietDonHangList.isEmpty ||
                      controller.donHangResponse == null)
                  ? const Center(
                      child: Text("Giỏ hàng trống!"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //title shipping detail
                          const Label(
                            label: "Chi tiết về shipping",
                            obligatory: false,
                            topPadding: Dimensions.PADDING_SIZE_DEFAULT,
                          ),

                          //shipping detail
                          _shipping(context, controller),

                          //title order product detail
                          const Label(
                            label: "Chi tiết đơn hàng",
                            obligatory: false,
                            topPadding: Dimensions.PADDING_SIZE_DEFAULT,
                          ),

                          //order product detail
                          _orderProductDetail(context),

                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                          ),

                          //payment detail
                          _bottomPaymentBtn(context, controller: controller),

                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_LARGE,
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  ///
  ///shipping widget
  ///
  Row _shippingWidget(
    BuildContext context, {
    Image? image,
    Icon? icon,
    required String text1,
    required String text2,
    String? text3,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          Container(
              height: DeviceUtils.getScaledHeight(context, .032),
              width: DeviceUtils.getScaledWidth(context, .063),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              child: image)
        else
          icon!,
        const SizedBox(
          width: Dimensions.MARGIN_SIZE_SMALL,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
              Text(
                text2,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (text3 == null)
                const SizedBox.shrink()
              else
                Text(
                  text3.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///row shipping component
  ///
  Widget _rowShipping(
    BuildContext context, {
    required VoidCallback onTap,
    required Widget shippingWidget,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: ColorResources.WHITE,
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: shippingWidget,
            ),
            const Expanded(
              child: Icon(
                Icons.arrow_forward_ios,
                color: ColorResources.PRIMARY,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///shipping
  ///
  Widget _shipping(
    BuildContext context,
    CartController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_SMALL,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(.3),
            spreadRadius: 2,
          ),
        ],
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
      child: Column(
        children: [
          // shipping address
          _rowShipping(
            context,
            onTap: () => controller.onSelectShippingAddress(),
            shippingWidget: _shippingWidget(
              context,
              icon: const Icon(
                Icons.location_on_outlined,
                color: ColorResources.PRIMARY,
              ),
              text1: "Địa chỉ ship",
              text2:
                  "${controller.donHangResponse!.diaChi}${controller.donHangResponse!.idPhuongXa != null ? ', ${controller.donHangResponse!.idPhuongXa}' : ''}, ${controller.donHangResponse!.idQuanHuyen!.ten}, ${controller.donHangResponse!.idTinhTp!.ten}",
            ),
          ),

          Dimensions().paddingDivider(context),

          //partner shipping
          _rowShipping(
            context,
            onTap: () => controller.onSelectShippingMethod(),
            shippingWidget: _shippingWidget(
              context,
              image: Image.asset("assets/images/logo.png"),
              text1: "Loại vận chuyển",
              text2: LOAI_VAN_CHUYEN[controller.donHangResponse!.loaiVanChuyen]
                  .toString(),
              // text3: "Cùng ngày 2h - 3h",
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
        height: DeviceUtils.getScaledSize(context, .055),
        width: DeviceUtils.getScaledSize(context, .055),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color ?? ColorResources.PRIMARY),
        ),
        child: text != null
            ? Align(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                  ),
                ),
              )
            : icon,
      ),
    );
  }

  ///
  ///edit quality
  ///
  Widget _editQuanlity(BuildContext context,
      {required int index, required CartController controller}) {
    return Row(
      children: [
        //decrementQuality
        _iconQuality(
          context,
          onTap: () => controller.decreQuality(index: index, onTap: 0),
          onTapDown: (TapDownDetails details) =>
              controller.decreQuality(index: index, onTap: 1),
          onTapUp: (TapUpDetails details) =>
              controller.decreQuality(index: index, onTap: 2),
          onTapCancel: () => controller.decreQuality(index: index, onTap: 3),
          icon: Icon(
            Icons.remove,
            size: Dimensions.ICON_SIZE_SMALL,
            color: controller.quanlityControllerList[index].text == '1'
                ? ColorResources.GREY
                : ColorResources.PRIMARY,
          ),
          color: controller.quanlityControllerList[index].text == '1'
              ? ColorResources.GREY
              : ColorResources.PRIMARY,
        ),

        //quanlity
        TextFieldQuanlity(
          textEditingController: controller.quanlityControllerList[index],
          height: .045,
          width: .15,
          borderRadius: 10,
          contentPadding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),
          onFocusChange: (val) =>
              controller.onChanged(context, index, isUpdate: val),
          onSubmitted: (val) =>
              controller.onChanged(context, index, quanlity: val),
        ),

        //incrementQuality
        _iconQuality(
          context,
          onTap: () => controller.increQuality(index: index, onTap: 0),
          onTapDown: (TapDownDetails details) =>
              controller.increQuality(index: index, onTap: 1),
          onTapUp: (TapUpDetails details) =>
              controller.increQuality(index: index, onTap: 2),
          onTapCancel: () => controller.increQuality(index: index, onTap: 3),
          icon: const Icon(
            Icons.add_outlined,
            size: Dimensions.ICON_SIZE_SMALL,
            color: ColorResources.PRIMARY,
          ),
        ),
      ],
    );
  }

  ///
  ///row text info
  ///
  Row rowText({
    required String text1,
    required String text2,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: color ?? ColorResources.BLACK,
          ),
        ),
      ],
    );
  }

  ///
  ///payment detail
  ///
  Widget _paymentDetail(
    BuildContext context,
    CartController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      child: Column(
        children: [
          //Giá trị
          rowText(
            text1: "Giá trị",
            text2:
                "${PriceConverter.convertPrice(context, controller.total.toDouble())} vnđ",
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),

          //Phí vận chuyển
          rowText(
            text1: "Phí vận chuyển",
            text2:
                "${PriceConverter.convertPrice(context, double.parse(controller.donHangResponse!.phiVanChuyen.toString()))} vnđ",
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),

          //Tổng
          rowText(
            text1: "Tổng",
            text2:
                "${PriceConverter.convertPrice(context, controller.totalAmount.toDouble())} vnđ",
          ),
        ],
      ),
    );
  }

  ///
  ///order poduct detail
  ///
  Widget _orderProductDetail(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.grey.withOpacity(.3),
              spreadRadius: 2,
            ),
          ],
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
        ),
        child: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.chiTietDonHangList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //img order product
                              Expanded(
                                flex: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.BORDER_RADIUS_SMALL),
                                  child: FadeInImageCustom(
                                    urlImage: controller
                                        .chiTietDonHangList[index]
                                        .idSanPham!
                                        .hinhAnhDaiDien
                                        .toString(),
                                    height: .18,
                                    width: .12,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: Dimensions.MARGIN_SIZE_SMALL,
                              ),

                              // name, price, quality
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //name
                                    Text(
                                      controller.chiTietDonHangList[index]
                                          .idSanPham!.ten
                                          .toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                    ),

                                    //price
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "${PriceConverter.convertPrice(context, double.parse(controller.chiTietDonHangList[index].idSanPham!.gia.toString()))} vnđ",
                                            style: const TextStyle(
                                              color: ColorResources.RED,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height:
                                          Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                    ),

                                    // edit quality
                                    _editQuanlity(
                                      context,
                                      index: index,
                                      controller: controller,
                                    ),

                                    const SizedBox(
                                      height:
                                          Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                    ),
                                  ],
                                ),
                              ),

                              /// delete btn
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    //showDialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Dialog(
                                              child: _deleteItem(context,
                                                  index: index,
                                                  controller: controller),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  //remove icon
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          ColorResources.GREY.withOpacity(.2),
                                    ),
                                    child: const Icon(
                                      Icons.close_outlined,
                                      size: Dimensions.ICON_SIZE_EXTRA_SMALL,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //divider
                    Dimensions().paddingDivider(context),
                  ],
                );
              }),

          //payment detail
          _paymentDetail(context, controller),
        ]),
      );
    });
  }

  ///
  ///delete
  ///
  Widget _deleteItem(BuildContext context,
      {required int index, required CartController controller}) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //note
          Column(
            children: const [
              Text(
                "Xác nhận",
                style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: ColorResources.GREY,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                child: Text(
                  "Bạn có muốn xoá sản phẩm này khỏi giỏ hàng của mình không?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Row(
            children: [
              //accept
              Expanded(
                child: BtnCustomBorder(
                  onTap: () => controller.deleteProduct(index: index),
                  text: "Đồng ý",
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                width: Dimensions.MARGIN_SIZE_SMALL,
              ),

              //cancel
              Expanded(
                child: BtnCustom(
                  onTap: () => Get.back(),
                  color: ColorResources.PRIMARY,
                  text: "Huỷ",
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///payment detail
  ///
  Widget _bottomPaymentBtn(BuildContext context,
      {required CartController controller}) {
    return Align(
      child: BtnCustom(
        onTap: () => controller.onCheckoutClick(),
        color: ColorResources.PRIMARY,
        text:
            "Thanh toán ${PriceConverter.convertPrice(context, controller.totalAmount.toDouble())} vnđ",
        width: DeviceUtils.getScaledWidth(context, .9),
      ),
    );
  }
}
