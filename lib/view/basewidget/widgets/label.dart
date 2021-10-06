

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class Label extends StatelessWidget {
  const Label({
    Key? key,
    required this.label,
    required this.obligatory,
    this.paddingTitle = Dimensions.PADDING_SIZE_SMALL,
    this.horizontalPadding = Dimensions.PADDING_SIZE_DEFAULT,
    this.topPadding = Dimensions.PADDING_SIZE_LARGE,
  }) : super(key: key);
  final String label;
  final bool obligatory;
  final double? paddingTitle;
  final double? horizontalPadding;
  final double? topPadding;
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
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, fontWeight: FontWeight.bold,/*color: ColorResources.BLACK.withOpacity(0.7)*/),
            ),
            if (obligatory) const Text(
                    '*',
                    style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ) else Container()
          ],
        ),
      ),
    );
  }
}
