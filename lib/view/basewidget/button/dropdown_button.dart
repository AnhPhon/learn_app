import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:tiengviet/tiengviet.dart';

class DropDownButton1<T> extends StatelessWidget {
  const DropDownButton1({
    this.hint,
    required this.onChanged,
    required this.data,
    this.value,
    this.obligatory = false,
    this.label,
    this.labelBold = false,
    required this.width,
    this.isBorder = true,
    this.isShadow = false,
    this.padding,
    this.margin,
    this.fillColor,
    this.colorText,
    this.isColorFieldWhite,
    this.isBoldHintText = false,
    this.height,
    this.contentPadding,
  });

  final String? hint;
  final Function(T? i)? onChanged;
  final List<T> data;
  final T? value;
  final bool? obligatory,
      labelBold,
      isBorder,
      isShadow,
      isColorFieldWhite,
      isBoldHintText;
  final String? label;
  final Color? colorText;
  final Color? fillColor;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? padding, contentPadding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    data.sort((a, b)=> TiengViet.parse(a.toString()).toLowerCase().compareTo(TiengViet.parse(b.toString()).toLowerCase()));
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            RichText(
                maxLines: 2,
                text: TextSpan(
                    text: label,
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: labelBold == true ? FontWeight.w600 : null,
                      color: ColorResources.BLACK,
                    ),
                    children: [
                      if (obligatory == true)
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            fontWeight:
                                labelBold == true ? FontWeight.w600 : null,
                            color: Colors.red,
                          ),
                        )
                      else
                        const TextSpan(),
                    ]),
              ),
          if (label != null)
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
          Container(
            height: (height != null)
                ? DeviceUtils.getScaledHeight(context, height!)
                : null,
            width: DeviceUtils.getScaledWidth(context, width),
            margin: margin ?? EdgeInsets.zero,
            decoration: BoxDecoration(
              boxShadow: (isShadow == true)
                  ? [
                      BoxShadow(
                          blurRadius: 2,
                          color: ColorResources.BLACK.withOpacity(.2),
                          offset: const Offset(0, 2)),
                    ]
                  : [],
            ),
            child: FormField(
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillColor ?? ColorResources.NOT_ALLOW_EDIT,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        borderSide: (isBorder == true)
                            ? const BorderSide(color: ColorResources.PRIMARY)
                            : BorderSide.none),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        borderSide: (isBorder == true)
                            ? const BorderSide(color: ColorResources.PRIMARY)
                            : BorderSide.none),
                    contentPadding: contentPadding ??
                        EdgeInsets.symmetric(
                            horizontal:
                                DeviceUtils.getScaledSize(context, 0.025),
                            vertical: DeviceUtils.getScaledSize(context, 0.03)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        borderSide: (isBorder == true)
                            ? const BorderSide(color: ColorResources.PRIMARY)
                            : BorderSide.none),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                        onTap: (){
                          DeviceUtils.unFocus(context);
                        },
                        hint: hint.toString().isNotEmpty
                            ? Text(
                                hint.toString(),
                                style: TextStyle(
                                  color: isBoldHintText == true
                                      ? ColorResources.BLACK
                                      : null,
                                  fontSize: isBoldHintText == true
                                      ? Dimensions.FONT_SIZE_DEFAULT
                                      : null,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                        isDense: true,
                        isExpanded: true,
                        value: value,
                        onChanged: (val){
                          onChanged!(val);
                          DeviceUtils.unFocus(context);
                        },
                        items: data
                            .map((e) => DropdownMenuItem<T>(
                                value: e,
                                child: Text(
                                  (e.toString().contains("Phường") &&
                                          e.toString().length > 10)
                                      ? e.toString().replaceAll('Phường', 'P.')
                                      : (e.toString().contains("Phường") &&
                                              e.toString().length > 10)
                                          ? e
                                              .toString()
                                              .replaceAll('Quận', 'Q.')
                                          : e.toString(),
                                  style: TextStyle(
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    color: colorText ?? ColorResources.BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )))
                            .toList()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
