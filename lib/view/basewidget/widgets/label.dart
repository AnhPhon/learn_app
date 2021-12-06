

import 'package:flutter/material.dart';

import 'package:template/helper/dimensions.dart';

class Label extends StatelessWidget {
  const Label({
    Key? key,
    required this.label,
    required this.obligatory,
    this.paddingTitle = Dimensions.PADDING_SIZE_EXTRA_SMALL,
    this.horizontalPadding = Dimensions.PADDING_SIZE_DEFAULT,
    this.topPadding = Dimensions.PADDING_SIZE_SMALL,
    this.style,
    this.alignment,
  }) : super(key: key);
  final String label;
  final bool obligatory;
  final double? paddingTitle;
  final double? horizontalPadding;
  final double? topPadding;
  final TextStyle? style;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPadding!,
        right: horizontalPadding!,
        top:topPadding!
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: paddingTitle!),
        alignment: alignment ?? Alignment.centerLeft,
        child: Wrap(
          children: [
            Text(
              label,
              style: style ?? const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold,/*color: ColorResources.BLACK.withOpacity(0.7)*/),
            ),
            if (obligatory) const Text(
                    '*',
                    style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ) else Container()
          ],
        ),
      ),
    );
  }
}
