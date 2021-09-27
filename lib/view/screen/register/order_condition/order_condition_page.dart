// ignore_for_file: unnecessary_null_checks, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';

// dimensions
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/view/basewidget/custom_appbar.dart';

import 'order_condition_controller.dart';

class OrderConditionPage extends GetView<OrderConditionController> {
  final UserModel user;

  const OrderConditionPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetIt sl = GetIt.instance;
    if (user.id != null) {
      controller.createOrder(OrderModel(
        idUser: user.id,
        userAccept: user.idUser,
        idWarehouse: "1",
        description: "",
        imagePayment: "",
        statusOrder: "1",
        statusPayment: "1",
        totalPrice: 0.toString(),
        discountPrice: 0.toString(),
        idProvince: "",
        idDistrict: "",
        address: "",
      ));
    }

    return GetBuilder<OrderConditionController>(
      init: OrderConditionController(),
      builder: (OrderConditionController value) {
        return Scaffold(
          //app bar
          appBar: CustomAppBar().customAppBar(title: "Đơn hàng điều kiện"),

          //bottom navigator
          bottomNavigationBar: _bottomContainer(context),

          //body
          body: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: DeviceUtils.getScaledSize(context, 0.063),
            ),
            itemCount: controller.items.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                margin: EdgeInsets.only(
                  top: DeviceUtils.getScaledSize(context, 0.03),
                ),
                child: GestureDetector(
                  onTap: () {
                    controller.qualityProduct.value = 1;
                    if (controller.items[index].isChoose == false) {
                      //dialog chọn sản phẩm
                      _callProductChooseWidget(context, index);
                    }
                  },

                  //list sản phẩm
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.04)),
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE,

                        //nếu sản phẩm được chọn thì border
                        boxShadow: controller.items[index].isChoose == true
                            ? [
                                BoxShadow(
                                  blurRadius: 2,
                                  color:
                                      ColorResources.PRIMARY.withOpacity(0.3),
                                  spreadRadius: 2, // Shadow position
                                )
                              ]
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //nếu sản phẩm được chọn thì show cancle button
                        if (controller.items[index].isChoose == true)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.cancel(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: DeviceUtils.getScaledWidth(
                                          context, 0.03)),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorResources.WHITE,
                                  ),
                                  child: Icon(
                                    Icons.close_outlined,
                                    size: DeviceUtils.getScaledHeight(
                                        context, 0.023),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          const SizedBox.shrink(),

                        _productWidget(context, index),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _callProductChooseWidget(BuildContext context, int index) {
    Get.defaultDialog(
      title: controller.items[index].title,
      buttonColor: ColorResources.PRIMARY,
      textConfirm: "Xác nhận",
      textCancel: "Huỷ",
      cancelTextColor: ColorResources.PRIMARY,
      confirmTextColor: ColorResources.WHITE,
      onConfirm: () {
        Get.back();
        // controller.addItemToOrder();
        controller.accept(index);
        controller.countTotal(controller.items[index].amount);
      },
      content: Container(
        margin: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledSize(context, 0.025),
            vertical: DeviceUtils.getScaledSize(context, 0.025)),
        color: ColorResources.WHITE,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dialogBorderWidget(context, index),
                SizedBox(
                  width: DeviceUtils.getScaledSize(
                    context,
                    0.063,
                  ),
                ),
                _quailityWidget(context, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// product widget
  ///
  Widget _productWidget(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceUtils.getScaledSize(context, 0.038),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // hình ảnh sản phẩm
          Container(
            height: DeviceUtils.getScaledSize(context, 0.343),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  controller.items[index].url.toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: DeviceUtils.getScaledHeight(context, 0.01)),

          //tên sản phẩm
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 0.068),
            child: Text(
              controller.items[index].title.toString(),
              maxLines: 3,
              style: Dimensions.fontSizeStyle14w600(),
            ),
          ),

          //giá tiền
          Text(
            PriceConverter.convertPrice(
              context,
              controller.items[index].amount.toDouble(),
            ),
          ),
          //số lượng đã chọn
          if (controller.items[index].isChoose == true)
            Text(
              "Đang chọn: ${controller.items[index].quality}",
              style: Dimensions.fontSizeStyle14()
                  .copyWith(color: ColorResources.RED),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  ///
  /// Choose quaility widget
  ///
  Widget _quailityWidget(BuildContext context, int index) {
    // chọn số lượng sản phẩm
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Text(
            PriceConverter.convertPrice(
                context,
                (controller.items[index].amount *
                        controller.qualityProduct.value)
                    .toDouble()),
            style: titilliumSemiBold.copyWith(color: Colors.grey, fontSize: 18),
          ),
        ),

        SizedBox(
          height: DeviceUtils.getScaledSize(context, 0.02),
        ),

        //button quanlity
        Obx(() => Row(
              children: [
                //decrementQuality
                _iconsquality(
                  context,
                  onTap: () {
                    controller.decrementQuality();
                  },
                  icon: Icon(Icons.remove,
                      color: controller.qualityProduct.value > 1
                          ? ColorResources.PRIMARY
                          : ColorResources.GREY),
                  color: controller.qualityProduct.value > 1
                      ? ColorResources.PRIMARY
                      : ColorResources.GREY,
                ),

                //quanlity
                _iconsquality(
                  context,
                  text: controller.qualityProduct.value.toString(),
                ),

                //incrementQuality
                _iconsquality(
                  context,
                  onTap: () {
                    controller.incrementQuality();
                  },
                  icon: const Icon(
                    Icons.add_outlined,
                    color: ColorResources.PRIMARY,
                  ),
                ),
              ],
            )),
      ],
    );
  }

  ///
  /// Dialog Widget
  ///
  Widget _dialogBorderWidget(BuildContext context, int index) {
    //hình ảnh sản phẩm trong dialog
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Image(
        height: DeviceUtils.getScaledSize(
          context,
          0.25,
        ),
        width: DeviceUtils.getScaledSize(
          context,
          0.25,
        ),
        image: NetworkImage(
          controller.items[index].url.toString(),
        ),
      ),
    );
  }

  ///
  ///bottom payment button
  ///
  Widget _bottomContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.04),
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      height: DeviceUtils.getScaledSize(context, 0.55),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2, // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            controller.notificateValidMessage,
            textAlign: TextAlign.justify,
            style: titilliumItalic.copyWith(
                color: ColorResources.PRIMARY, fontSize: 14),
          ),
          Text(
            controller.twoFivePercent,
            style: titilliumSemiBold.copyWith(color: ColorResources.RED),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Tổng tiền phải trả là: ${PriceConverter.convertPrice(context, controller.sum * .75)}",
                style: titilliumBold.copyWith(fontSize: 16),
              ),
              SizedBox(width: DeviceUtils.getScaledSize(context, 0.015)),
              Text(
                PriceConverter.convertPrice(context, controller.sum.toDouble()),
                style: titilliumBold.copyWith(
                  color: ColorResources.GREY,
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black,
                  decorationStyle: TextDecorationStyle.double,
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),

          // btn checkout
          GestureDetector(
            onTap: () {
              controller.btnContinue(context);
            },
            child: _btnContinueWidget(context),
          ),
        ],
      ),
    );
  }

  ///
  ///icons quality
  ///
  Widget _iconsquality(BuildContext context,
      {VoidCallback? onTap, Icon? icon, String? text, Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.01)),
        height: DeviceUtils.getScaledSize(context, 0.064),
        width: DeviceUtils.getScaledSize(context, 0.064),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color ?? ColorResources.PRIMARY),
        ),
        child: text != null ? Align(child: Text(text)) : icon,
      ),
    );
  }

  ///
  /// _btnContinueWidget
  ///
  Widget _btnContinueWidget(BuildContext context) {
    return Container(
      height: DeviceUtils.getScaledSize(context, 0.12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.green,
          ColorResources.PRIMARY,
          Colors.green,
        ], begin: Alignment(0, -1), end: Alignment(0, 1)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      alignment: Alignment.center,
      width: double.infinity,
      child: const Text(
        "Tiếp tục",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}

///
/// normalInputWidget
///
Widget normalInputWidget(String? label, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: const Color(0xFFEBEDEF), // set border color
        width: 3.0,
      ), // set border width
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ), // set rounded corner radius
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: label,
        border: InputBorder.none,
      ),
      controller: controller,
    ),
  );
}

class Item {
  String url;
  String title;
  int amount;
  bool isChoose;
  int quality;
  String id;

  Item({
    required this.id,
    required this.url,
    required this.title,
    required this.amount,
    required this.isChoose,
    required this.quality,
  });
}
