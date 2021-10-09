import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class DropDownButton1 extends StatelessWidget {
  const DropDownButton1({
    required this.hint,
    required this.onChanged,
    required this.data,
    this.value,
    this.isColorFieldWhite = false,
  });

  final String hint;
  final Function(String? i) onChanged;
  final List<String> data;
  final String? value;
  final bool? isColorFieldWhite;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledSize(context, 0.025)),
        child: FormField(
          builder: (field) {
            return InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: (isColorFieldWhite == true)
                    ? ColorResources.WHITE
                    : Colors.transparent,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARY)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARY)),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledSize(context, 0.025),
                    vertical: DeviceUtils.getScaledSize(context, 0.038)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARY)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    hint: Text(hint),
                    value: value,
                    isDense: true,
                    isExpanded: true,
                    // value: getCutContent(value),
                    // onChanged: onChanged,
                    onChanged: onChanged,
                    items: data
                        .map<DropdownMenuItem<String>>(
                            (String e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                                      color: ColorResources.BLACK),
                                  overflow: TextOverflow.ellipsis,
                                )))
                        .toList()),
              ),
            );
          },
        ));
  }
}
