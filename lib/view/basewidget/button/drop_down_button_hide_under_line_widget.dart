


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class DropDownButtonHideUnderLineWidget<T> extends StatelessWidget {
  final String? hint;
  final double? width;
  final Function(T? value) onChanged;
  final List<T> data;
  final T? value;
  const DropDownButtonHideUnderLineWidget({
    Key? key,
    this.hint,
    this.width,
    required this.onChanged,
    required this.data,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.minPositive,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          hint: Text(hint!, style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE
          ),),
          value: value,
          style: const TextStyle(
            fontSize: Dimensions.PADDING_SIZE_DEFAULT,
            color: ColorResources.BLACK
          ),
          isDense: true,
          isExpanded: true,
          onChanged: onChanged,
          items: data.map((e) => DropdownMenuItem<T>(value: e,child: Text(e.toString(), style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),))).toList(),
        ),
      ),
    );
  }

}
