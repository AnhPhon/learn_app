import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class RowText extends StatelessWidget {
  final String text1;
  final String text2;
  final bool? colorRed;
  final bool? notFontWeight;
  final bool? notFontSize;
  final EdgeInsets? padding;

  const RowText({Key? key, required this.text1, required this.text2, this.colorRed, this.notFontWeight, this.notFontSize, this.padding, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_SMALL,
        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      child: DefaultTextStyle(
        style: TextStyle(fontWeight: notFontWeight == true ? null : FontWeight.w600, fontSize: notFontSize == true ? Dimensions.FONT_SIZE_LARGE : Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.BLACK),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(text1, textAlign: TextAlign.left),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            Expanded(
              child: Text(
                text2,
                textAlign: TextAlign.right,
                style: colorRed == true ? const TextStyle(color: ColorResources.RED) : null,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
