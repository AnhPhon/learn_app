import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:tiengviet/tiengviet.dart';

class DropDownButton<T> extends StatelessWidget {
  const DropDownButton({
    Key? key,
    this.hint = "",
    this.onChanged,
    required this.data,
    required this.width,
    required this.value,
    this.label,
    required this.isRequired,
    this.paddingTop,
    this.isColorFieldWhite = false,
    this.isEnable = true,
    this.isSort = true,
    this.padding,
  }) : super(key: key);
  final String? hint;
  final double width;
  final Function(T? value)? onChanged;
  final String? label;
  final bool? isRequired;
  final List<T> data;
  final double? paddingTop;
  final bool? isColorFieldWhite;
  final T? value;
  final bool? isEnable;
  final EdgeInsetsGeometry? padding;
  final bool? isSort;

  @override
  Widget build(BuildContext context) {
    if (isSort!) {
      data.sort((a, b) => TiengViet.parse(a.toString()).toLowerCase().compareTo(TiengViet.parse(b.toString()).toLowerCase()));
    }
    return Container(
      width: width,
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          if (label != null)
            Container(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                  children: [
                    if (isRequired!)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      )
                    else
                      const TextSpan(),
                  ],
                ),
              ),
            ),
          Container(
            height: 49,
            margin: EdgeInsets.only(
              bottom: IZIDimensions.FONT_SIZE_H5,
            ),
            child: FormField(
              enabled: isEnable!,
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorResources.WHITE),
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorResources.WHITE),
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorResources.WHITE),
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_3X,
                      ),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: ColorResources.WHITE,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      autofocus: true,
                      onTap: () {},
                      hint: Text(
                        hint!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      value: value,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        color: ColorResources.BLACK,
                      ),
                      isDense: true,
                      isExpanded: true,
                      onChanged: isEnable!
                          ? (val) {
                              onChanged!(val);
                            }
                          : null,
                      items: data
                          .map(
                            (e) => DropdownMenuItem<T>(
                              value: e,
                              child: Text(
                                e.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                    ),
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
