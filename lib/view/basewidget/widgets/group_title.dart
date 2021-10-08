

import 'package:flutter/material.dart';

import 'package:template/utils/dimensions.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: Align(
        child: Text(title, textAlign: TextAlign.center, style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.FONT_SIZE_OVER_LARGE
        ),)
      ),
    );
  }
}
