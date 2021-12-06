import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';

class RadioButton<T> extends StatelessWidget {
  final String title;
  final Function(T? value) onChanged;
  final TextStyle? style;
  final T value;
  final T groupValue;
  bool? active;
  RadioButton({
    Key? key,
    required this.title,
    required this.onChanged,
    this.style,
    required this.value,
    required this.groupValue,
    this.active,
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
          activeColor: (active == false)
              ? ColorResources.LIGHT_GREY
              : ColorResources.THEME_DEFAULT,
        ),
        Text(
          title,
          style: style ??
              const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
        ),
      ],
    );
  }
}
