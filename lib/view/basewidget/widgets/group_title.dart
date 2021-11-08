import 'package:flutter/material.dart';

import 'package:template/utils/dimensions.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({
    Key? key,
    required this.title,
    this.padding,
  }) : super(key: key);
  final String title;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: Align(
          child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
      )),
    );
  }
}
