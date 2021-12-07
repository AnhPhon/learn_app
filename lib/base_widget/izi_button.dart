import 'package:flutter/material.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class IZIButton extends StatelessWidget {
  const IZIButton({
    Key? key,
    required this.title,
    required this.width,
    this.color,
    required this.onPressed,
    this.height,
    this.maxLine,
    this.colorBorder,
    this.isButtonActive = true,
    this.padding,
    this.withBorder,
    this.borderRadius,
    this.disabledColor = false,
  }) : super(key: key);

  // OnTap
  // Decoration defaul nền xanh
  // Title defaul căn giữ , maxLine defaul 1 dòng , có thể truyền thêm số dòng, nếu quá dòng là overflow
  // clickble (có thể có or không defaul true) Nếu true click vào thì mới thực hiện onTap esle thì không
  final String title;
  final Color? color;
  final Function onPressed;
  final double width;
  final double? height;
  final int? maxLine;
  final Color? colorBorder;
  final bool? isButtonActive;
  final EdgeInsets? padding;
  final double? withBorder;
  final double? borderRadius;
  final bool? disabledColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: IZIDimensions.SPACE_SIZE_4X,
            horizontal: IZIDimensions.SPACE_SIZE_4X,
          ),
      child: MaterialButton(
        onPressed: isButtonActive == true ? () => onPressed() : null,
        color: color ?? ColorResources.BUTTON_DEFAULT,
        minWidth: IZIDevice.getScaledSize(context, width),
        height: height ?? IZIDevice.getScaledSize(context, 0.14),
        splashColor: ColorResources.WHITE.withOpacity(0.8),
        elevation: 5,
        visualDensity: VisualDensity.comfortable,
        disabledColor: disabledColor == true
            ? isButtonActive == false
                ? ColorResources.GREY
                : null
            : null,
        disabledElevation: disabledColor == true ? 5 : null,
        colorBrightness: Brightness.light,
        animationDuration: const Duration(milliseconds: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? IZIDimensions.BORDER_RADIUS_2X,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_5X,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H5,
            color: ColorResources.WHITE,
            fontWeight: FontWeight.w500,
          ),
          maxLines: maxLine ?? 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
