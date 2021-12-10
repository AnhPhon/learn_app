import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:ticket_material/ticket_material.dart';

enum IZICardType {
  CARD,
  CARD_OUTLINE,
  CARD_PAYMENT,
  CARD_NOTIFICATION,
  CARD_VORCHER,
  CARD_CIRCLE,
  CARD_NEWS,
  CARD_TRANSFERS,
  CARD_CAPITAL_CONTRIBUTION,
  CARD_WITHDRAWAL,
  CARD_ORDER,
}
enum IZIStatusPayment {
  AWAIT,
  DONE,
  FAIL,
}
enum IZIStatusMoney {
  DRAW,
  RECHARGE,
}
enum IZIStatusOrder {
  XAC_NHAN,
  HUY_DON,
  DA_GIAO,
  DANG_GIAO,
}

class IZICard extends StatelessWidget {
  IZICard({
    Key? key,
    this.row1Left,
    this.row1Right,
    this.row2Left,
    this.row2Right,
    this.row3Left,
    this.row3Right,
    this.urlImage,
    this.marginCard,
    this.paddingCard,
    this.heightCard,
    this.widthCard,
    this.widthBorder,
    this.radiusCard,
    this.colorBorder,
    this.colorBG,
    this.statusMoney,
    this.statusPayment,
    this.icon,
    this.file,
    this.onTap,
    this.isEnabled = true,
    this.cardType = IZICardType.CARD,
    this.imageUrlType = IZIImageUrlType.ICON,
    this.valRadio,
    this.statusOrder,
    this.groupValue,
    this.onChanged,
    this.onChanged1CardTransfer,
    this.onChanged2CardTransfer,
  }) : super(key: key);

  final String? row1Left;
  final String? row1Right;
  final String? row2Left;
  final String? row2Right;
  final String? row3Left;
  final String? row3Right;
  final String? urlImage;
  final EdgeInsets? marginCard, paddingCard;
  final double? heightCard, widthCard, radiusCard, widthBorder;
  final Color? colorBorder, colorBG;
  final File? file;
  final IconData? icon;
  final Function? onTap;
  final bool? isEnabled;
  IZIStatusMoney? statusMoney;
  IZIStatusPayment? statusPayment;
  IZIStatusOrder? statusOrder;
  final IZICardType? cardType;
  final IZIImageUrlType? imageUrlType;
  final dynamic valRadio;
  final dynamic groupValue;
  final Function(dynamic val)? onChanged;
  final Function(String val)? onChanged1CardTransfer;

  final Function(String val)? onChanged2CardTransfer;

  Widget getStatusPayment(IZIStatusPayment statusPayment) {
    if (statusPayment == IZIStatusPayment.DONE) {
      return const IZIText(
        text: "Thành công",
        style: TextStyle(
          color: ColorResources.CIRCLE_COLOR_BG3,
        ),
      );
    } else if (statusPayment == IZIStatusPayment.FAIL) {
      return const IZIText(
        text: "Thất bại",
        style: TextStyle(
          color: ColorResources.RED,
        ),
      );
    }
    return const IZIText(
      text: "Đang chờ",
      style: TextStyle(
        color: ColorResources.YELLOW,
      ),
    );
  }

  Widget getButtonOrder(IZIStatusOrder status) {
    if (status == IZIStatusOrder.XAC_NHAN) {
      return IZIButton(
        colorBG: ColorResources.ORDER_XAC_NHAN,
        isEnabled: isEnabled,
        margin: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 13),
        onTap: () {
          onTap!();
        },
        label: "Xác nhận",
        padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 7),
      );
    }
    if (status == IZIStatusOrder.DA_GIAO) {
      return IZIButton(
        colorBG: ColorResources.ORDER_HUY_DON,
        isEnabled: isEnabled,
        margin: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 13),
        onTap: () {
          onTap!();
        },
        label: "Hủy đơn",
        padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 7),
      );
    }
    if (status == IZIStatusOrder.HUY_DON) {
      return IZIButton(
        colorBG: ColorResources.ORDER_DA_GIAO,
        isEnabled: isEnabled,
        margin: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 13),
        onTap: () {
          onTap!();
        },
        label: "Đã giao",
        padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 7),
      );
    }
    if (status == IZIStatusOrder.DANG_GIAO) {
      return IZIButton(
        colorBG: ColorResources.ORDER_DANG_GIAO,
        isEnabled: isEnabled,
        margin: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 13),
        onTap: () {
          onTap!();
        },
        label: "Đang giao",
        padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 7),
      );
    }
    return Container();
  }

  Widget getStatusMoney(IZIStatusMoney statusPrice) {
    if (statusPrice == IZIStatusMoney.DRAW && !IZIValidate.nullOrEmpty(row1Right)) {
      return IZIText(
        text: '-${row1Right.toString()} vnđ',
        style: const TextStyle(
          color: ColorResources.RED,
        ),
      );
    } else if (statusPrice == IZIStatusMoney.RECHARGE && !IZIValidate.nullOrEmpty(row1Right)) {
      return IZIText(
        text: '+${row1Right.toString()} vnđ',
        style: const TextStyle(
          color: ColorResources.CIRCLE_COLOR_BG3,
        ),
      );
    }
    return const SizedBox();
  }

  Widget getImageUrlType(IZIImageUrlType type) {
    if (type == IZIImageUrlType.ICON && !IZIValidate.nullOrEmpty(icon)) {
      return IZIImage.icon(
        icon ?? Icons.ac_unit_outlined,
        color: ColorResources.WHITE,
        size: IZIDimensions.ONE_UNIT_SIZE * 45,
      );
    } else if (type == IZIImageUrlType.FILE && !IZIValidate.nullOrEmpty(file)) {
      IZIImage.file(
        file,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_7X),
      child: IZIImage(
        urlImage!,
      ),
    );
  }

  Widget getCard(BuildContext context, IZICardType type) {
    if (type == IZICardType.CARD_PAYMENT) {
      return Container(
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: ColorResources.BLACK.withAlpha(40), blurRadius: 10, offset: const Offset(0, 2))],
          border: Border.all(
            width: 2,
            color: colorBorder ?? ColorResources.GREY,
          ),
          borderRadius: BorderRadius.circular(
            radiusCard ?? IZIDimensions.BORDER_RADIUS_3X,
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_1X),
              child: statusMoney == IZIStatusMoney.DRAW ? IZIImage(ImagesPath.draw) : IZIImage(ImagesPath.reCharge),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IZIText(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      text: row1Left.toString(),
                    ),
                    getStatusMoney(statusMoney!),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: IZIDimensions.BLUR_RADIUS_2X),
                  child: IZIText(
                    text: row2Right.toString(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IZIText(
                      text: row2Left.toString(),
                    ),
                    getStatusPayment(statusPayment!)
                  ],
                ),
              ],
            )
          ],
        ),
      );
    } else if (type == IZICardType.CARD_CIRCLE) {
      return Container(
        height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 140,
        width: widthCard ?? IZIDimensions.ONE_UNIT_SIZE * 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 100,
              width: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 100,
              decoration: BoxDecoration(
                color: colorBG ?? ColorResources.WHITE,
                shape: BoxShape.circle,
              ),
              child: getImageUrlType(imageUrlType!),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_1X,
                ),
                child: IZIText(
                  maxLine: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: IZIDimensions.ONE_UNIT_SIZE * 25,
                  ),
                  text: row1Left.toString(),
                ),
              ),
            )
          ],
        ),
      );
    } else if (type == IZICardType.CARD) {
      return Container(
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(
            radiusCard ?? IZIDimensions.BLUR_RADIUS_3X,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(-2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
          ],
        ),
        margin: marginCard ?? const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  radiusCard ?? IZIDimensions.BLUR_RADIUS_3X,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: IZIDimensions.BLUR_RADIUS_2X,
                    color: ColorResources.BLACK.withAlpha(40),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  radiusCard ?? IZIDimensions.BLUR_RADIUS_2X,
                ),
                child: IZIImage(
                  urlImage.toString(),
                ),
              ),
            ),
            Container(
              height: IZIDimensions.ONE_UNIT_SIZE * 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                IZIDimensions.ONE_UNIT_SIZE * 10,
                0,
                IZIDimensions.ONE_UNIT_SIZE * 10,
                IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!IZIValidate.nullOrEmpty(row1Left))
                    Expanded(
                      child: IZIText(
                        text: row1Left.toString(),
                        maxLine: 2,
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row1Right))
                    Expanded(
                      child: IZIText(
                        text: row1Right.toString(),
                        maxLine: 2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                IZIDimensions.ONE_UNIT_SIZE * 10,
                0,
                IZIDimensions.ONE_UNIT_SIZE * 10,
                IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!IZIValidate.nullOrEmpty(row2Left))
                    Expanded(
                      child: Text(
                        "đ${row2Left.toString()}",
                        style: TextStyle(
                          color: ColorResources.GREY,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          decoration: TextDecoration.lineThrough,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row2Right))
                    Expanded(
                      child: IZIText(
                        text: row2Right.toString(),
                        maxLine: 1,
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                IZIDimensions.ONE_UNIT_SIZE * 10,
                0,
                IZIDimensions.ONE_UNIT_SIZE * 10,
                IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!IZIValidate.nullOrEmpty(row3Left))
                    Expanded(
                      child: Text(
                        "đ${row3Left.toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorResources.RED,
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row3Right))
                    Expanded(
                      child: Text(
                        "Đã bán ${row3Right.toString()}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: ColorResources.BLACK.withOpacity(.7),
                          fontSize: IZIDimensions.FONT_SIZE_SPAN * 0.85,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (type == IZICardType.CARD_OUTLINE) {
      return Container(
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(
            radiusCard ?? IZIDimensions.BLUR_RADIUS_3X,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(-2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
          ],
        ),
        margin: marginCard ?? const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  radiusCard ?? IZIDimensions.BLUR_RADIUS_3X,
                ),
                border: Border.all(
                  width: IZIDimensions.ONE_UNIT_SIZE * 10,
                  color: ColorResources.CIRCLE_COLOR_BG,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: IZIDimensions.BLUR_RADIUS_2X,
                    color: ColorResources.BLACK.withAlpha(40),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  radiusCard ?? IZIDimensions.BLUR_RADIUS_1X,
                ),
                child: IZIImage(
                  urlImage.toString(),
                ),
              ),
            ),
            Container(
              height: IZIDimensions.ONE_UNIT_SIZE * 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                IZIDimensions.ONE_UNIT_SIZE * 10,
                0,
                IZIDimensions.ONE_UNIT_SIZE * 10,
                IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: IZIText(
                      text: row1Left.toString(),
                      maxLine: 2,
                      style: TextStyle(
                        color: ColorResources.BLACK,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  if (!IZIValidate.nullOrEmpty(row1Right))
                    Expanded(
                      child: IZIText(
                        text: row1Right.toString(),
                        maxLine: 2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                IZIDimensions.ONE_UNIT_SIZE * 10,
                0,
                IZIDimensions.ONE_UNIT_SIZE * 10,
                IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!IZIValidate.nullOrEmpty(row2Left))
                    Expanded(
                      child: Text(
                        "đ${row2Left.toString()}",
                        style: TextStyle(
                          color: ColorResources.GREY,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          decoration: TextDecoration.lineThrough,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row2Right))
                    Expanded(
                      child: IZIText(
                        text: row2Right.toString(),
                        maxLine: 1,
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                IZIDimensions.ONE_UNIT_SIZE * 10,
                0,
                IZIDimensions.ONE_UNIT_SIZE * 10,
                IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!IZIValidate.nullOrEmpty(row3Left))
                    Expanded(
                      child: Text(
                        "đ${row3Left.toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorResources.RED,
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row3Right))
                    Expanded(
                      child: Text(
                        "Đã bán ${row3Right.toString()}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: ColorResources.BLACK.withOpacity(.7),
                          fontSize: IZIDimensions.FONT_SIZE_SPAN * 0.85,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (type == IZICardType.CARD_VORCHER) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(20),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(20),
            ),
            BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(20),
            ),
            BoxShadow(
              offset: const Offset(-2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(20),
            ),
          ],
        ),
        margin: marginCard ?? const EdgeInsets.all(0),
        width: double.infinity,
        child: TicketMaterial(
          shadowSize: 0,
          radiusCircle: IZIDimensions.BLUR_RADIUS_1X,
          radiusBorder: IZIDimensions.BLUR_RADIUS_2X,
          height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 180,
          leftChild: _buildLeft(),
          rightChild: _buildRight(),
          colorBackground: ColorResources.WHITE,
        ),
      );
    } else if (type == IZICardType.CARD_NOTIFICATION) {
      return Container(
        width: double.infinity,
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: paddingCard ??
            EdgeInsets.fromLTRB(
              IZIDimensions.ONE_UNIT_SIZE * 30,
              IZIDimensions.ONE_UNIT_SIZE * 30,
              IZIDimensions.ONE_UNIT_SIZE * 30,
              IZIDimensions.ONE_UNIT_SIZE * 30,
            ),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusCard ?? IZIDimensions.BLUR_RADIUS_5X * 2),
            bottomRight: Radius.circular(radiusCard ?? IZIDimensions.BLUR_RADIUS_5X * 2),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: IZIDimensions.BLUR_RADIUS_4X,
              color: ColorResources.BLACK.withAlpha(10),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: IZIDimensions.BLUR_RADIUS_4X,
              color: ColorResources.BLACK.withAlpha(10),
            ),
            BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_4X,
              color: ColorResources.BLACK.withAlpha(10),
            ),
            BoxShadow(
              offset: const Offset(-2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_4X,
              color: ColorResources.BLACK.withAlpha(10),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(IZIDimensions.ONE_UNIT_SIZE * 5),
                child: IZIImage(
                  urlImage.toString(),
                  height: IZIDimensions.ONE_UNIT_SIZE * 80,
                  width: IZIDimensions.ONE_UNIT_SIZE * 80,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: IZIDimensions.ONE_UNIT_SIZE * 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: IZIDimensions.ONE_UNIT_SIZE * 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!IZIValidate.nullOrEmpty(row1Left))
                            Expanded(
                              child: Text(
                                row1Left.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                ),
                              ),
                            ),
                          if (!IZIValidate.nullOrEmpty(row1Right))
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      row1Right.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                      ),
                                    ),
                                  ),
                                  if (!IZIValidate.nullOrEmpty(icon))
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            onTap!();
                                          },
                                          child: Icon(icon),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: IZIDimensions.ONE_UNIT_SIZE * 2,
                      color: ColorResources.BLACK.withOpacity(.6),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: IZIDimensions.ONE_UNIT_SIZE * 10,
                        bottom: IZIDimensions.ONE_UNIT_SIZE * 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!IZIValidate.nullOrEmpty(row2Left))
                            Expanded(
                              child: Text(
                                row2Left.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (!IZIValidate.nullOrEmpty(row2Right))
                            Expanded(
                              child: Text(
                                row2Right.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!IZIValidate.nullOrEmpty(row3Left))
                          Expanded(
                            child: Text(
                              row3Left.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              ),
                            ),
                          ),
                        if (!IZIValidate.nullOrEmpty(row3Right))
                          Expanded(
                            child: Text(
                              row3Right.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else if (type == IZICardType.CARD_NEWS) {
      return Container(
        width: double.infinity,
        margin: marginCard ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              radiusCard ?? IZIDimensions.BLUR_RADIUS_5X * 2,
            ),
            bottomRight: Radius.circular(
              radiusCard ?? IZIDimensions.BLUR_RADIUS_5X * 2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(-2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  radiusCard ?? IZIDimensions.BLUR_RADIUS_5X * 2,
                ),
              ),
              child: IZIImage(
                urlImage.toString(),
                width: double.infinity,
                height: IZIDimensions.ONE_UNIT_SIZE * 250,
              ),
            ),
            Container(
              padding: EdgeInsets.all(
                IZIDimensions.ONE_UNIT_SIZE * 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!IZIValidate.nullOrEmpty(row1Left))
                    Expanded(
                      child: Text(
                        row1Left.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row1Right))
                    Expanded(
                      child: Text(
                        row1Right.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                IZIDimensions.ONE_UNIT_SIZE * 20,
                0,
                IZIDimensions.ONE_UNIT_SIZE * 20,
                IZIDimensions.ONE_UNIT_SIZE * 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!IZIValidate.nullOrEmpty(row2Left))
                    Expanded(
                      child: Text(
                        row2Left.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row2Right))
                    Expanded(
                      child: Text(
                        row2Right.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (type == IZICardType.CARD_TRANSFERS) {
      return Container(
        width: double.infinity,
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: paddingCard ??
            EdgeInsets.all(
              IZIDimensions.ONE_UNIT_SIZE * 20,
            ),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(
            radiusCard ?? IZIDimensions.BLUR_RADIUS_4X,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(-2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
          ],
        ),
        child: Column(
          children: [
            //TODO: truyền child vào ko cần custom
            Container(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    //TODO: Truyen vao
                    child: Text(
                      "Tài khoản",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (!IZIValidate.nullOrEmpty(row1Right))
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IZIImage(
                            ImagesPath.logoMomo,
                            height: IZIDimensions.ONE_UNIT_SIZE * 30,
                            width: IZIDimensions.ONE_UNIT_SIZE * 30,
                          ),
                          Flexible(
                            child: Text(
                              row1Right.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Tên người nhận",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (!IZIValidate.nullOrEmpty(row2Right))
                    Expanded(
                      flex: 3,
                      child: Text(
                        row2Right.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.ONE_UNIT_SIZE * 40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Số điện thoại",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (!IZIValidate.nullOrEmpty(row3Right))
                    Expanded(
                      flex: 3,
                      child: Text(
                        row3Right.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: IZIDimensions.ONE_UNIT_SIZE * 2,
              color: ColorResources.BLACK.withOpacity(.4),
            ),
            IZIInput(
              disbleError: true,
              type: IZIInputType.PRICE,
              placeHolder: "Nhập số tiền muốn chuyển",
              onChanged: onChanged1CardTransfer,
            ),
            Container(
              width: double.infinity,
              height: IZIDimensions.ONE_UNIT_SIZE * 2,
              color: ColorResources.BLACK.withOpacity(.4),
            ),
            IZIInput(
              disbleError: true,
              type: IZIInputType.TEXT,
              placeHolder: "Nhập nội dung (Không bắt buộc)",
              onChanged: onChanged2CardTransfer,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                bottom: IZIDimensions.ONE_UNIT_SIZE * 50,
              ),
              height: IZIDimensions.ONE_UNIT_SIZE * 2,
              color: ColorResources.BLACK.withOpacity(.4),
            ),
          ],
        ),
      );
    } else if (type == IZICardType.CARD_CAPITAL_CONTRIBUTION) {
      //TODO: SU DUNG FROSTED GLASS
      return Container(
        width: widthCard ?? double.infinity,
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: paddingCard ??
            EdgeInsets.all(
              IZIDimensions.ONE_UNIT_SIZE * 20,
            ),
        decoration: BoxDecoration(
          color: colorBG ?? ColorResources.CARD_CAPITAL_CONTRIBUTION,
          borderRadius: BorderRadius.circular(
            radiusCard ?? IZIDimensions.BLUR_RADIUS_2X,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(-2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!IZIValidate.nullOrEmpty(row1Left))
              Container(
                padding: EdgeInsets.only(
                  bottom: IZIDimensions.ONE_UNIT_SIZE * 10,
                ),
                child: IZIText(
                  text: row1Left.toString(),
                  maxLine: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ColorResources.BLACK,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (!IZIValidate.nullOrEmpty(row2Left))
              IZIText(
                text: row2Left.toString(),
                maxLine: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
          ],
        ),
      );
    } else if (type == IZICardType.CARD_WITHDRAWAL) {
      return Container(
        width: widthCard ?? double.infinity,
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: paddingCard ??
            EdgeInsets.all(
              IZIDimensions.ONE_UNIT_SIZE * 20,
            ),
        decoration: BoxDecoration(
          color: colorBG ?? ColorResources.WHITE,
          borderRadius: BorderRadius.circular(
            radiusCard ?? IZIDimensions.BLUR_RADIUS_2X,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
            BoxShadow(
              offset: const Offset(-2, 0),
              blurRadius: IZIDimensions.BLUR_RADIUS_2X,
              color: ColorResources.BLACK.withAlpha(30),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!IZIValidate.nullOrEmpty(row1Left))
              Container(
                padding: EdgeInsets.only(
                  bottom: IZIDimensions.ONE_UNIT_SIZE * 10,
                ),
                child: IZIText(
                  text: row1Left.toString(),
                  maxLine: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ColorResources.BLACK,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Row(
              children: [
                if (!IZIValidate.nullOrEmpty(row2Left))
                  Expanded(
                    flex: 4,
                    child: IZIText(
                      text: "Ngày hết hạn ${row2Left.toString()}",
                      maxLine: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorResources.BLACK,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      ),
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: IZIButton(
                    isEnabled: isEnabled,
                    margin: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 13),
                    onTap: () {
                      onTap!();
                    },
                    label: "Rút vốn",
                    padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 7),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Container();
  }

  Widget _buildLeft() {
    return Container(
      padding: EdgeInsets.all(
        IZIDimensions.ONE_UNIT_SIZE * 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!IZIValidate.nullOrEmpty(row1Left))
                Expanded(
                  child: Text(
                    row1Left.toString(),
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (!IZIValidate.nullOrEmpty(row1Right))
                Expanded(
                  child: Text(
                    row1Right.toString(),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          Container(
            height: IZIDimensions.ONE_UNIT_SIZE * 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!IZIValidate.nullOrEmpty(row2Left))
                Expanded(
                  child: Text(
                    "Điều kiện:\nĐơn tối thiểu ${row2Left.toString()}đ",
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.1,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (!IZIValidate.nullOrEmpty(row3Right))
                Expanded(
                  child: Text(
                    row2Right.toString(),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          Container(
            height: IZIDimensions.ONE_UNIT_SIZE * 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IZIText(
                  style: TextStyle(
                    color: ColorResources.BLACK,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.start,
                  text: "Hạn sử dụng: ${row3Left.toString()}",
                  maxLine: 1,
                ),
              ),
              if (!IZIValidate.nullOrEmpty(row3Right))
                Expanded(
                  child: IZIText(
                    textAlign: TextAlign.end,
                    text: row3Right.toString(),
                    maxLine: 1,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRight() {
    if (!IZIValidate.nullOrEmpty(groupValue) && !IZIValidate.nullOrEmpty(valRadio)) {
      return Container(
        child: Center(
          child: Radio(
            value: valRadio,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: ColorResources.CIRCLE_COLOR_BG3,
            focusColor: ColorResources.CIRCLE_COLOR_BG3,
            fillColor: MaterialStateProperty.all(
              ColorResources.CIRCLE_COLOR_BG4,
            ),
          ),
        ),
      );
    } else {
      return Container(
        child: Center(
          child: IZIButton(
            isEnabled: isEnabled,
            margin: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 13),
            onTap: () {
              onTap!();
            },
            label: "Lưu",
            padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 7),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getCard(context, cardType!);
  }
}
