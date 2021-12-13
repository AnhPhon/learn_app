import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
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
  CARD_CONTRIBUTION,
  CARD_WITHDRAWAL,
  CARD_ORDER,
  CARD_CONTACT,
  CARD_CAPITAL_CONTRIBUTION,
}

//TODO: fix thành izi status label color
enum IZIStatusOrder {
  XAC_NHAN,
  HUY_DON,
  DA_GIAO,
  DANG_GIAO,
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

class IZICard extends StatelessWidget {
  // TODO: Hình ảnh cho bóng mờ
  // TODO: Title card contact cho boxshadown
  // TODO: AUTO margin bottom
  // TODO: ảnh card payment to hơn xiu
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
    this.colorBG = ColorResources.WHITE,
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
    this.title,
    this.actions,
    this.child,
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
  final String? title;
  final List<Widget>? actions;
  final Widget? child;
  final Function(dynamic val)? onChanged;
  final Function(String val)? onChanged1CardTransfer;
  final Function(String val)? onChanged2CardTransfer;

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

  Widget getButtonOrder(IZIStatusOrder statusOrder) {
    if (statusOrder == IZIStatusOrder.XAC_NHAN) {
      return IZIButton(
        colorBG: ColorResources.ORDER_XAC_NHAN,
        isEnabled: isEnabled,
        onTap: () {
          onTap!();
        },
        label: "Xác nhận",
        color: ColorResources.LABEL_ORDER_XAC_NHAN,
        margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
        borderRadius: IZIDimensions.ONE_UNIT_SIZE * 5,
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
      );
    }
    if (statusOrder == IZIStatusOrder.DA_GIAO) {
      return IZIButton(
        colorBG: ColorResources.ORDER_DA_GIAO,
        isEnabled: isEnabled,
        onTap: () {
          onTap!();
        },
        label: "Đã giao",
        color: ColorResources.LABEL_ORDER_DA_GIAO,
        margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
        borderRadius: IZIDimensions.ONE_UNIT_SIZE * 5,
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
      );
    }
    if (statusOrder == IZIStatusOrder.HUY_DON) {
      return IZIButton(
        colorBG: ColorResources.ORDER_HUY_DON,
        isEnabled: isEnabled,
        onTap: () {
          onTap!();
        },
        label: "Hủy đơn",
        color: ColorResources.LABEL_ORDER_HUY_DON,
        margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
        borderRadius: IZIDimensions.ONE_UNIT_SIZE * 5,
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
      );
    }
    if (statusOrder == IZIStatusOrder.DANG_GIAO) {
      return IZIButton(
        colorBG: ColorResources.ORDER_DANG_GIAO,
        isEnabled: isEnabled,
        onTap: () {
          onTap!();
        },
        label: "Đang giao",
        color: ColorResources.LABEL_ORDER_DANG_GIAO,
        margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
        borderRadius: IZIDimensions.ONE_UNIT_SIZE * 5,
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
      );
    }
    return Container();
  }

  Widget getStatusMoney(IZIStatusMoney statusPrice) {
    if (statusPrice == IZIStatusMoney.DRAW && !IZIValidate.nullOrEmpty(row1Right)) {
      return IZIText(
        text: '${row1Right.toString()}',
        style: const TextStyle(
          color: ColorResources.RED,
        ),
        maxLine: 1,
        textAlign: TextAlign.end,
      );
    } else if (statusPrice == IZIStatusMoney.RECHARGE && !IZIValidate.nullOrEmpty(row1Right)) {
      return IZIText(
        text: '${row1Right.toString()}',
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
        urlImage ?? '',
        fit: urlImage.toString().endsWith('.svg') ? fit : BoxFit.cover,
      ),
    );
  }

  Widget getCard(BuildContext context, IZICardType type) {
    if (type == IZICardType.CARD_PAYMENT) {
      return Container(
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_2X,
        ),
        decoration: BoxDecoration(
          color: colorBG ?? ColorResources.WHITE,
          boxShadow: IZIOther().boxShadow,
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
                      if (!IZIValidate.nullOrEmpty(row1Left))
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
    } else if (type == IZICardType.CARD_ORDER) {
      return Container(
        margin: marginCard ?? const EdgeInsets.all(0),
        width: double.infinity,
        padding: paddingCard ??
            EdgeInsets.all(
              IZIDimensions.SPACE_SIZE_2X,
            ),
        decoration: BoxDecoration(
          color: colorBG ?? ColorResources.WHITE,
          boxShadow: IZIOther().boxShadow,
          borderRadius: BorderRadius.circular(
            radiusCard ?? IZIDimensions.BLUR_RADIUS_2X,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BLUR_RADIUS_2X,
                  ),
                  child: IZIImage(
                    urlImage.toString(),
                    height: IZIDimensions.ONE_UNIT_SIZE * 80,
                    width: IZIDimensions.ONE_UNIT_SIZE * 80,
                  ),
                ),
                Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 10,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Row(
                            children: [
                              if (!IZIValidate.nullOrEmpty(row1Left))
                                Expanded(
                                  child: IZIText(
                                    text: row1Left.toString(),
                                    maxLine: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                    ),
                                  ),
                                ),
                              if (!IZIValidate.nullOrEmpty(row1Right))
                                Expanded(
                                  child: IZIText(
                                    text: row1Right.toString(),
                                    maxLine: 1,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.BLACK.withOpacity(.8),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            if (!IZIValidate.nullOrEmpty(row2Left))
                              Expanded(
                                child: Container(
                                  child: IZIText(
                                    text: "${row2Left.toString()} sản phẩm",
                                    maxLine: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                              ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              width: IZIDimensions.ONE_UNIT_SIZE * 3,
                              height: IZIDimensions.ONE_UNIT_SIZE * 30,
                              color: ColorResources.BLACK.withOpacity(
                                .5,
                              ),
                            ),
                            if (!IZIValidate.nullOrEmpty(row2Right))
                              Expanded(
                                child: Container(
                                  child: IZIText(
                                    text: "${row2Right.toString()} đ",
                                    maxLine: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                      color: ColorResources.BLACK.withOpacity(.8),
                                    ),
                                  ),
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
            Container(
              margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_2X),
              width: double.infinity,
              height: IZIDimensions.ONE_UNIT_SIZE * 2,
              color: ColorResources.BLACK.withOpacity(.1),
            ),
            Row(
              children: [
                if (!IZIValidate.nullOrEmpty(row3Left))
                  Expanded(
                    flex: 2,
                    child: IZIText(
                      text: row3Left.toString(),
                      maxLine: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      ),
                    ),
                  ),
                Expanded(
                  child: getButtonOrder(statusOrder!),
                ),
              ],
            ),
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
            if (!IZIValidate.nullOrEmpty(row1Left))
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
          boxShadow: IZIOther().boxShadow,
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
          boxShadow: IZIOther().boxShadow,
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
    } else if (type == IZICardType.CARD_VORCHER) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: IZIOther().boxShadow,
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
                            if (!IZIValidate.nullOrEmpty(row1Left))
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
          boxShadow: IZIOther().boxShadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(IZIDimensions.ONE_UNIT_SIZE * 15),
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
          boxShadow: IZIOther().boxShadow,
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
          boxShadow: IZIOther().boxShadow,
        ),
        child: child,
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
          boxShadow: IZIOther().boxShadow,
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
                      if (!IZIValidate.nullOrEmpty(row1Left))
                        Flexible(
                          child: IZIText(
                            text: row1Left!,
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
    } else if (type == IZICardType.CARD_CONTRIBUTION) {
      return GlassContainer.frostedGlass(
        frostedOpacity: 0.1,
        height: heightCard ?? IZIDimensions.ONE_UNIT_SIZE * 80,
        width: widthCard ?? double.infinity,
        margin: marginCard ?? const EdgeInsets.all(0),
        padding: paddingCard ??
            EdgeInsets.all(
              IZIDimensions.ONE_UNIT_SIZE * 20,
            ),
        borderRadius: BorderRadius.circular(
          radiusCard ?? IZIDimensions.BLUR_RADIUS_2X,
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
          boxShadow: IZIOther().boxShadow,
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
