import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:tiengviet/tiengviet.dart';

class DropDownButtonHideUnderLineWidget<T> extends StatelessWidget {
  final String? hint;
  final double? width;
  final Function(T? value)? onChanged;
  final List<T> data;
  final T? value;
  final bool? highLightHint, isSort;
  const DropDownButtonHideUnderLineWidget({
    Key? key,
    this.hint,
    this.width,
    this.isSort = false,
    this.onChanged,
    this.highLightHint = false,
    required this.data,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    isSort == false
        ? data.sort((a, b) => TiengViet.parse(a.toString())
            .toLowerCase()
            .compareTo(TiengViet.parse(b.toString()).toLowerCase()))
        : null;
    return SizedBox(
      width: width ?? double.minPositive,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          onTap: () {
            DeviceUtils.unFocus(context);
          },
          hint: Text(
            hint!,
            style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: highLightHint!
                    ? ColorResources.BLACK
                    : ColorResources.BLACK.withOpacity(0.4)),
          ),
          value: value,
          style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: ColorResources.BLACK),
          icon: Icon(Icons.arrow_drop_down,
              color: highLightHint!
                  ? ColorResources.BLACK
                  : ColorResources.BLACK.withOpacity(0.4)),
          isDense: true,
          isExpanded: true,
          onChanged: (val) {
            onChanged!(val);
            DeviceUtils.unFocus(context);
          },
          items: data
              .map((e) => DropdownMenuItem<T>(
                  value: e,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          e.toString().length < 10
                              ? e.toString()
                              : e
                                  .toString()
                                  .replaceAll('Phường', '')
                                  .replaceAll('Xã', '')
                                  .replaceAll('Thị trấn', ''),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                          ),
                        ),
                      ),
                    ],
                  )))
              .toList(),
        ),
      ),
    );
  }
}
