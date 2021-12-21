import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/shopping_cart/shopping_cart_controller.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      appBar: const IZIAppBar(
        colorBG: ColorResources.WHITE,
        iconBack: SizedBox(),
        title: "Giỏ hàng",
        colorTitle: ColorResources.BLACK,
      ),
      body: GetBuilder(
        init: ShoppingCartController(),
        builder: (ShoppingCartController controller) {
          return Container(
            constraints: BoxConstraints(
              minHeight: IZIDimensions.iziSize.height,
              minWidth: IZIDimensions.iziSize.width,
            ),
            decoration: const BoxDecoration(
              color: ColorResources.BACKGROUND,
            ),
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_4X,
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chi tiết giao hàng",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    0,
                    IZIDimensions.SPACE_SIZE_2X,
                    0,
                    IZIDimensions.SPACE_SIZE_3X,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    boxShadow: IZIOther().boxShadow,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_3X,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.location_on_outlined,
                                size: IZIDimensions.ONE_UNIT_SIZE * 45,
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: Text(
                                  "Địa chỉ nhận hàng",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.BLACK,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: Text(
                                  "183 Quách Thị Trang",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              child: Text(
                                "Liên hệ • 0969696969",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK.withOpacity(.8),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Divider(
                          color: ColorResources.BLACK.withOpacity(.8),
                          thickness: IZIDimensions.ONE_UNIT_SIZE * .3,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(
                                  IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: IZIImage(
                                  ImagesPath.logo_tiki,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: Text(
                                  "Dịch vụ vận chuyển",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.BLACK,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: Text(
                                  "Tên dịch vụ",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              child: Text(
                                "Trong ngày 2h - 3h",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK.withOpacity(.8),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  "Thông tin sản phẩm",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                ),

                //Thông tin sản phẩm
                Container(
                  margin: EdgeInsets.fromLTRB(
                    0,
                    IZIDimensions.SPACE_SIZE_2X,
                    0,
                    IZIDimensions.SPACE_SIZE_3X,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    boxShadow: IZIOther().boxShadow,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_3X,
                    ),
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            width: IZIDimensions.iziSize.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          IZIDimensions.SPACE_SIZE_2X,
                                        ),
                                        child: IZIImage(
                                          ImagesPath.logoMomo,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        "Sản phẩm 1",
                                                        style: TextStyle(
                                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                                          color: ColorResources.BLACK,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.onConfirm();
                                                    },
                                                    child: CircleAvatar(
                                                      radius: IZIDimensions.ONE_UNIT_SIZE * 18,
                                                      backgroundColor: ColorResources.GREY.withOpacity(.5),
                                                      child: Icon(
                                                        Icons.close_outlined,
                                                        color: ColorResources.BLACK.withOpacity(.6),
                                                        size: IZIDimensions.ONE_UNIT_SIZE * 32,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: IZIDimensions.SPACE_SIZE_2X,
                                            ),
                                            Text(
                                              "100.000 ₫ x 1",
                                              style: TextStyle(
                                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                color: ColorResources.BLACK.withOpacity(.7),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                IZIInput(
                                  type: IZIInputType.INCREMENT,
                                  disbleError: true,
                                  isBorder: true,
                                  height: IZIDimensions.ONE_UNIT_SIZE * 60,
                                  widthIncrement: IZIDimensions.ONE_UNIT_SIZE * 60,
                                  contentPaddingIncrement: EdgeInsets.all(
                                    IZIDimensions.ONE_UNIT_SIZE * 17,
                                  ),
                                ),
                                Container(
                                  child: Divider(
                                    color: ColorResources.BLACK.withOpacity(.8),
                                    thickness: IZIDimensions.ONE_UNIT_SIZE * .3,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Giá trị",
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "110.000 ₫",
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Phí vận chuyển",
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "Miễn phí",
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Tổng",
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "110.000 ₫",
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    boxShadow: IZIOther().boxShadow,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_3X,
                    ),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.goToChooseVoucher();
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: IZIDimensions.SPACE_SIZE_2X,
                                    ),
                                    child: IZIImage(
                                      ImagesPath.icon_coupon,
                                    ),
                                  ),
                                  Text(
                                    "Nội dung Voucher",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.BLACK,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ColorResources.BLACK.withOpacity(.7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IZIButton(
                        colorBG: ColorResources.RED,
                        label: "Thanh toán 110.000 đ",
                        maxLine: 1,
                        onTap: () {},
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
