import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

enum IZIButtonType {
  DEFAULT,
  OUTLINE,
}

class IZIButton extends StatelessWidget {
  const IZIButton({
    Key? key,
    required this.onTap,
    this.label,
    this.height,
    this.maxLine,
    this.type = IZIButtonType.DEFAULT,
    this.isEnabled = true,
    this.padding,
    this.margin,
    this.borderRadius,
    this.icon,
    this.color = ColorResources.WHITE,
    this.colorBGDisabled = ColorResources.GREY,
    this.colorDisible = ColorResources.BLACK,
    this.colorBG = ColorResources.CIRCLE_COLOR_BG3,
    this.colorIcon,
    this.colorText,
    this.imageUrlIcon,
    this.withBorder,
    this.width,
    this.fontSizedLabel,
  }) : super(key: key);

  // OnTap
  // Decoration defaul nền xanh
  // Title defaul căn giữ , maxLine defaul 1 dòng , có thể truyền thêm số dòng, nếu quá dòng là overflow
  // clickble (có thể có or không defaul true) Nếu true click vào thì mới thực hiện onTap esle thì không
  final String? label;
  final Color? color;
  final Color? colorDisible;
  final Color? colorBGDisabled;
  final Color? colorBG;
  final Function onTap;
  final double? height;
  final int? maxLine;
  final IZIButtonType? type;
  final Color? colorIcon;
  final Color? colorText;
  final bool? isEnabled;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final IconData? icon;
  final String? imageUrlIcon;
  final double? withBorder;
  final double? width;
  final double? fontSizedLabel;

  Color getColorBG(IZIButtonType type) {
    if (type == IZIButtonType.DEFAULT) {
      if (isEnabled!) {
        return colorBG!;
      }
      return colorBGDisabled!;
    } else if (type == IZIButtonType.OUTLINE) {
      if (isEnabled!) {
        return ColorResources.WHITE;
      }
      return ColorResources.WHITE;
    }
    return colorBG!;
  }

  Color getColor(IZIButtonType type) {
    if (type == IZIButtonType.DEFAULT) {
      if (isEnabled!) {
        return color!;
      }
      return colorDisible!;
    } else if (type == IZIButtonType.OUTLINE) {
      if (isEnabled!) {
        return colorBG!;
      }
      return ColorResources.GREY;
    }
    return color!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled!
          ? () {
              onTap();
            }
          : null,
      child: Container(
        width: width ?? IZIDimensions.iziSize.width,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_4X,
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
        margin: margin ??
            EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
        decoration: BoxDecoration(
          color: getColorBG(type!),
          border: type == IZIButtonType.DEFAULT
              ? null
              : Border.all(
                  color: isEnabled! ? colorBG! : ColorResources.GREY,
                  width: withBorder ?? IZIDimensions.ONE_UNIT_SIZE * 5,
                ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? IZIDimensions.ONE_UNIT_SIZE * 20,
          ),
        ),
        // height: height ?? IZIDevice.getScaledSize(context, 0.14),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!IZIValidate.nullOrEmpty(imageUrlIcon))
              IZIImage(
                imageUrlIcon.toString(),
              ),
            if (icon != null)
              Icon(
                icon,
                color: colorIcon ?? getColor(type!),
                size: IZIDimensions.FONT_SIZE_H6 * 1.25,
              )
            else
              const SizedBox(),
            if (label != null)
              Flexible(
                child: Text(
                  " $label",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: colorText ?? getColor(type!),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: maxLine ?? 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
