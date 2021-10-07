

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class TextHighlight extends StatelessWidget {
  final String title;
  final String content;
  final double? fontSize;
  final TextStyle? style;
  const TextHighlight({
    Key? key,
    required this.title,
    required this.content,
    this.fontSize = Dimensions.FONT_SIZE_EXTRA_LARGE,
    this.style,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: ColorResources.BLACK,
          fontWeight: FontWeight.bold,
          fontSize: fontSize
        ),
        text: title,
        children: [
          TextSpan(
            text: content,
            style: style ?? TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: fontSize
            ),
          ),
        ],
      ),
    );
  }
}
