

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class TextHighligt extends StatelessWidget {
  final String title;
  final String content;
  const TextHighligt({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: ColorResources.BLACK,
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
        ),
        text: title,
        children: [
          TextSpan(
            text: content,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: Dimensions.PADDING_SIZE_LARGE
            ),
          ),
        ],
      ),
    );
  }

}
