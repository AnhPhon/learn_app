import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class DropDownButton<T> extends StatelessWidget {
  const DropDownButton({
    Key? key,
    this.hint = "",
    required this.onChanged,
    required this.data,
    required this.width,
    required this.value,
    this.label,
    required this.obligatory,
    this.paddingTop = Dimensions.PADDING_SIZE_LARGE,
    this.isColorFieldWhite = false,
  }) : super(key: key);
  final String? hint;
  final double width;
  final Function(T? value) onChanged;
  final String? label;
  final bool? obligatory;
  final List<T> data;
  final double? paddingTop;
  final bool? isColorFieldWhite;
  final T? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT,
          top: paddingTop ?? 0),
      child: Column(
        children: [
          if (label != null)
            Container(
              padding: const EdgeInsets.only(
                  bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: [
                  Text(
                    label!,
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.BLACK,
                    ),
                  ),
                  if (obligatory == true)
                    const Text(
                      '*',
                      style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )
                  else
                    Container()
                ],
              ),
            )
          else
            const SizedBox.shrink(),
          FormField(
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
                    hint: Text(hint!),
                    value: value,
                    style: const TextStyle(
                        fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                        color: ColorResources.BLACK),
                    isDense: true,
                    isExpanded: true,
                    onChanged: onChanged,
                    items: data
                        .map((e) => DropdownMenuItem<T>(
                            value: e, child: Text(e.toString())))
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
