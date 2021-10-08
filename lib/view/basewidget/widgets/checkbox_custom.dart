
import 'package:flutter/material.dart';

import 'package:template/utils/dimensions.dart';

class CheckBoxCustom extends StatelessWidget {
  CheckBoxCustom({
    Key? key,
    required this.title,
    required this.status,
    required this.onChanged,
  }) : super(key: key);
  final String title;
  final bool status;
  final Function(bool? val) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)
          ),
          value: status, onChanged: onChanged
        ),
        Text(title, style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_LARGE
        ),)
      ],
    );
  }
}
