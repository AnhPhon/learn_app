

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class RadioButton<T> extends StatelessWidget {
  final String title;
  final Function(T? value) onChanged;
  final TextStyle? style;
  final T value;
  final T groupValue;
  const RadioButton({
    Key? key,
    required this.title,
    required this.onChanged,
    this.style,
    required this.value,
    required this.groupValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          toggleable: true,
          value: value, 
          groupValue: groupValue, 
          onChanged: onChanged,
          activeColor: ColorResources.PRIMARYCOLOR,
        ),
        Text(title, style: style ?? const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Dimensions.FONT_SIZE_LARGE
        ),),
      ],
    );
  }
  
}
