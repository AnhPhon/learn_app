import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

enum IZICardType { CARD, CARD_OUTLINE, CARD_PAYMENT, CARD_NOTIFICATION, CARD_VORCHER, CARD_CIRCLE, CARD_CONTACT, CARD_CAPITAL_CONTRIBUTION }
enum IZIStatusPayment {
  AWAIT,
  DONE,
  FAIL,
}
enum IZIStatusMoney {
  DRAW,
  RECHARGE,
}

class IZICard extends StatelessWidget {
  IZICard({
    Key? key,
    required this.row1Left,
    this.row1Right,
    this.row2Left,
    this.row2Right,
    this.row3Left,
    this.row3Right,
    this.urlImage,
    this.marginCard,
    this.heightCard,
    this.widthCard,
    this.widthBorder,
    this.radiusCard,
    this.colorBorder,
    this.colorBG = ColorResources.WHITE,
    this.statusMoney,
    this.statusPayment,
    this.icon,
    this.file,
    this.cardType = IZICardType.CARD,
    this.imageUrlType = IZIImageUrlType.ICON,
    this.title,
    this.actions,
    // this.onTapMessage,
    // this.onTapPhone,
    this.valRadio,
    this.groupValue,
    this.onChanged,
  }) : super(key: key);

  final String row1Left;
  final String? row1Right;
  final String? row2Left;
  final String? row2Right;
  final String? row3Left;
  final String? row3Right;
  final String? urlImage;
  final EdgeInsets? marginCard;
  final double? heightCard, widthCard, radiusCard, widthBorder;
  final Color? colorBorder, colorBG;
  final File? file;
  final IconData? icon;
  IZIStatusMoney? statusMoney;
  IZIStatusPayment? statusPayment;
  final IZICardType? cardType;
  final IZIImageUrlType? imageUrlType;
  final String? title;
  final List<Widget>? actions;
  // final Function? onTapMessage;
  // final Function? onTapPhone;
  final dynamic valRadio;
  final dynamic groupValue;
  final Function(dynamic val)? onChanged;

  Widget getStatusPayment(IZIStatusPayment statusPayment) {
    if (statusPayment == IZIStatusPayment.DONE) {
      return IZIText(
        text: row3Right ?? "Thành công",
        style: const TextStyle(
          color: ColorResources.CIRCLE_COLOR_BG3,
        ),
        maxLine: 1,
        textAlign: TextAlign.end,
      );
    } else if (statusPayment == IZIStatusPayment.FAIL) {
      return IZIText(
        text: row3Right ?? "Thất bại",
        style: const TextStyle(
          color: ColorResources.RED,
        ),
        maxLine: 1,
        textAlign: TextAlign.end,
      );
    }
    return IZIText(
      text: row3Right ?? "Đang chờ",
      style: const TextStyle(
        color: ColorResources.YELLOW,
      ),
      maxLine: 1,
      textAlign: TextAlign.end,
    );
  }

  Widget getStatusMoney(IZIStatusMoney statusPrice) {
    if (statusPrice == IZIStatusMoney.DRAW && !IZIValidate.nullOrEmpty(row1Right)) {
      return IZIText(
        text: '-${row1Right.toString()} vnđ',
        style: const TextStyle(
          color: ColorResources.RED,
        ),
        maxLine: 1,
        textAlign: TextAlign.end,
      );
    } else if (statusPrice == IZIStatusMoney.RECHARGE && !IZIValidate.nullOrEmpty(row1Right)) {
      return IZIText(
        text: '+${row1Right.toString()} vnđ',
        style: const TextStyle(
          color: ColorResources.CIRCLE_COLOR_BG3,
        ),
        maxLine: 1,
        textAlign: TextAlign.end,
      );
    }
    return const SizedBox();
  }

  Widget getImageUrlType(IZIImageUrlType type, {BoxFit? fit = BoxFit.cover}) {
    if (type == IZIImageUrlType.ICON && !IZIValidate.nullOrEmpty(icon)) {
      return IZIImage.icon(
        icon ?? Icons.ac_unit_outlined,
        color: ColorResources.WHITE,
        size: IZIDimensions.ONE_UNIT_SIZE * 45,
        fit: fit,
      );
    } else if (type == IZIImageUrlType.FILE && !IZIValidate.nullOrEmpty(file)) {
      IZIImage.file(
        file,
        fit: fit,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_7X),
      child: IZIImage(
        urlImage!,
        fit: fit,
      ),
    );
  }

  Widget getCard(BuildContext context, IZICardType type) {
    if (type == IZICardType.CARD_PAYMENT) {
      return Container(
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X,),
        decoration: BoxDecoration(
          color: colorBG,
          boxShadow: [
            BoxShadow(
              color: ColorResources.BLACK.withAlpha(40),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          // border: Border.all(
          //   width: 2,
          //   color: colorBorder ?? ColorResources.GREY,
          // ),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IZIText(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLine: 2,
                          text: row1Left.toString(),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: getStatusMoney(statusMoney!),
                      ),
                    ],
                  ),
                  if (!IZIValidate.nullOrEmpty(row2Left) || !IZIValidate.nullOrEmpty(row2Right))
                    Row(
                      children: [
                        if (!IZIValidate.nullOrEmpty(row2Left))
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: IZIDimensions.BLUR_RADIUS_2X),
                              child: IZIText(
                                text: row2Left.toString(),
                                maxLine: 2,
                              ),
                            ),
                          ),
                        if (!IZIValidate.nullOrEmpty(row2Right))
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: IZIDimensions.BLUR_RADIUS_2X),
                              child: IZIText(
                                text: row2Right.toString(),
                                maxLine: 1,
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (!IZIValidate.nullOrEmpty(row3Left) || !IZIValidate.nullOrEmpty(row3Right))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!IZIValidate.nullOrEmpty(row3Left))
                          Expanded(
                            child: IZIText(
                              text: row3Left.toString(),
                              maxLine: 1,
                            ),
                          ),
                        Expanded(
                          child: getStatusPayment(statusPayment!),
                        )
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      );
    } else if (type == IZICardType.CARD_CIRCLE) {
      return Container(
        height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 140,
        width: widthCard ?? IZIDimensions.ONE_UNIT_SIZE * 120,
        margin: marginCard ?? const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 100,
              width: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 100,
              decoration: BoxDecoration(
                color: colorBG,
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
                    fontSize: IZIDimensions.FONT_SIZE_H6,
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
              color: ColorResources.BLACK.withAlpha(40),
            )
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
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row3Right))
                    Expanded(
                      child: Text(
                        "Đã bán ${row3Right.toString()}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: ColorResources.BLACK.withOpacity(.7),
                          fontSize: IZIDimensions.FONT_SIZE_SPAN * 0.9,
                        ),
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
              color: ColorResources.BLACK.withAlpha(40),
            )
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
                      ),
                    ),
                  if (!IZIValidate.nullOrEmpty(row3Right))
                    Expanded(
                      child: Text(
                        "Đã bán ${row3Right.toString()}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: ColorResources.BLACK.withOpacity(.7),
                          fontSize: IZIDimensions.FONT_SIZE_SPAN * 0.9,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
      // } else if (type == IZICardType.CARD_VORCHER) {
      //   return Container(
      //     margin: marginCard ?? const EdgeInsets.all(20),
      //     height: IZIDevice.getScaledHeight(context, 0.15),
      //     width: widthCard ?? IZIDevice.getScaledWidth(context, 1),
      //     child: TicketMaterial(
      //       radiusCircle: IZIDimensions.BLUR_RADIUS_1X,
      //       radiusBorder: IZIDimensions.BLUR_RADIUS_2X,
      //       height: IZIDevice.getScaledHeight(context, 0.15),
      //       leftChild: _buildLeft(),
      //       rightChild: _buildRight(),
      //       colorBackground: Colors.blue,
      //     ),
      //   );
    } else if (type == IZICardType.CARD_CONTACT) {
      return Container(
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_3X,
        ),
        height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 140,
        width: widthCard ?? double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 100,
                  width: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 100,
                  decoration: BoxDecoration(
                    color: colorBG,
                    shape: BoxShape.circle,
                  ),
                  child: IZIText(
                    text: title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorResources.RED, fontWeight: FontWeight.bold, fontSize: IZIDimensions.FONT_SIZE_H4),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: IZIText(
                                maxLine: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                ),
                                text: row1Left.toString(),
                              ),
                            ),
                            if (!IZIValidate.nullOrEmpty(row1Right))
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: IZIText(
                                    maxLine: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                    ),
                                    text: row1Right.toString(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (!IZIValidate.nullOrEmpty(row2Right) || !IZIValidate.nullOrEmpty(row2Left))
                          Row(
                            children: [
                              if (!IZIValidate.nullOrEmpty(row2Left))
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_1X,
                                    ),
                                    child: IZIText(
                                      maxLine: 2,
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK.withOpacity(0.6),
                                      ),
                                      text: row2Left.toString(),
                                    ),
                                  ),
                                ),
                              if (!IZIValidate.nullOrEmpty(row2Right))
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: IZIDimensions.SPACE_SIZE_1X,
                                      top: IZIDimensions.SPACE_SIZE_1X,
                                    ),
                                    child: IZIText(
                                      maxLine: 1,
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK.withOpacity(0.6),
                                      ),
                                      text: row2Right.toString(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                if (IZIValidate.nullOrEmpty(actions)) const SizedBox() else ...actions!,
            
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                left: IZIDimensions.ONE_UNIT_SIZE * 40,
              ),
              child: Divider(
                color: ColorResources.BLACK.withOpacity(0.7),
              ),
            )
          ],
        ),
      );
    } else if (type == IZICardType.CARD_CAPITAL_CONTRIBUTION) {
      return Container(
        height: heightCard,
        width: widthCard,
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_3X,
        ),
        decoration: BoxDecoration(
          color: colorBG ?? ColorResources.WHITE,
          borderRadius: !IZIValidate.nullOrEmpty(radiusCard)
              ? BorderRadius.circular(
                  radiusCard!,
                )
              : BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_3X,
                ),
          // Đổ bóng default
          // border: Border.all(
          //   width: widthBorder ?? IZIDimensions.ONE_UNIT_SIZE * 4,
          //   color: colorBorder ?? ColorResources.GREY,
          // ),
        ),
        child: Row(
          children: [
            Container(
              height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 100,
              width: widthCard ?? IZIDimensions.ONE_UNIT_SIZE * 100,
              margin: EdgeInsets.only(
                right: IZIDimensions.SPACE_SIZE_3X,
              ),
              child: IZIValidate.nullOrEmpty(
                imageUrlType,
              )
                  ? const SizedBox()
                  : getImageUrlType(
                      imageUrlType!,
                      fit: BoxFit.contain,
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: IZIText(
                          text: row1Left,
                          maxLine: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                      ),
                      if (!IZIValidate.nullOrEmpty(row1Right))
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: IZIText(
                              text: row1Right!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (!IZIValidate.nullOrEmpty(row2Left) || !IZIValidate.nullOrEmpty(row2Right))
                    Row(
                      children: [
                        if (!IZIValidate.nullOrEmpty(row2Left))
                          Flexible(
                            child: IZIText(
                              text: row2Left!,
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                                color: ColorResources.BLACK.withOpacity(0.6),
                              ),
                            ),
                          ),
                        if (!IZIValidate.nullOrEmpty(row2Right))
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: IZIText(
                                text: row2Right!,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: ColorResources.BLACK.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            if (!IZIValidate.nullOrEmpty(groupValue) && !IZIValidate.nullOrEmpty(valRadio))
              Radio(
                value: valRadio,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: ColorResources.CIRCLE_COLOR_BG3,
                focusColor: ColorResources.CIRCLE_COLOR_BG3,
                fillColor: MaterialStateProperty.all(
                  ColorResources.CIRCLE_COLOR_BG4,
                ),
              )
          ],
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return getCard(context, cardType!);
  }
}

// Widget _buildLeft() {
//   return Container(
//     child: Center(
//       child: Text('LEFT PART'),
//     ),
//   );
// }

// Widget _buildRight() {
//   return Container(
//     child: Center(
//       child: Icon(Icons.airplanemode_active),
//     ),
//   );
// }
