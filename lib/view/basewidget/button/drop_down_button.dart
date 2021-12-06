import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:tiengviet/tiengviet.dart';

class DropDownButton<T> extends StatelessWidget {
  const DropDownButton(
      {Key? key,
      this.hint = "",
      this.onChanged,
      required this.data,
      required this.width,
      required this.value,
      this.label,
      required this.obligatory,
      this.paddingTop = Dimensions.PADDING_SIZE_LARGE,
      this.isColorFieldWhite = false,
      this.isEnable = true,
      this.isSort = true,
      this.padding})
      : super(key: key);
  final String? hint;
  final double width;
  final Function(T? value)? onChanged;
  final String? label;
  final bool? obligatory;
  final List<T> data;
  final double? paddingTop;
  final bool? isColorFieldWhite;
  final T? value;
  final bool? isEnable;
  final EdgeInsetsGeometry? padding;
  final bool? isSort;

  @override
  Widget build(BuildContext context) {
    if(isSort!){
      data.sort((a, b)=> TiengViet.parse(a.toString()).toLowerCase().compareTo(TiengViet.parse(b.toString()).toLowerCase()));
    }
    return Container(
      width: width,
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          if (label != null)
            Container(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                        text: label,
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                          fontWeight: FontWeight.w600,
                          color: ColorResources.BLACK,
                        ),
                        children: [
                      if (obligatory!)
                        const TextSpan(
                          text: '*',
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )
                      else
                        const TextSpan(),
                    ])))
          else
            const SizedBox.shrink(),
          FormField(
            enabled: isEnable!,
            builder: (field) {
              return InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isColorFieldWhite == true
                      ? ColorResources.WHITE
                      : Colors.transparent,
                  //isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT,
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    autofocus: true,
                    onTap: (){
                      DeviceUtils.unFocus(context);
                    },
                    hint: Text(
                      hint!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    value: value,
                    style: const TextStyle(
                        fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                        color: ColorResources.BLACK),
                    isDense: true,
                    isExpanded: true,
                    onChanged: isEnable! ? (val){
                      DeviceUtils.unFocus(context);
                      onChanged!(val);
                    } : null,
                    items: data
                        .map((e) => DropdownMenuItem<T>(
                            value: e,
                            child: Text(e.toString(),
                                overflow: TextOverflow.ellipsis)))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
