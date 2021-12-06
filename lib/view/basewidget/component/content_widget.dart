import 'package:flutter/material.dart';
import 'package:template/utils/dimensions.dart';

class ContentWidget extends StatelessWidget {
  final String label;
  final String? content;
  final bool? center;
  final bool? centerLabel;
  final bool? centerContent;
  final Color? colorLabel;
  final EdgeInsetsGeometry? padding;
  final int? maxLineLabel;

  const ContentWidget({
    Key? key,
    required this.label,
    this.content,
    this.center = false,
    this.colorLabel,
    this.centerLabel = false,
    this.centerContent = false,
    this.padding,
    this.maxLineLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL,
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
      child: Align(
        alignment: center == false ? Alignment.centerLeft : Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              textAlign: centerLabel == true ? TextAlign.center : TextAlign.left,
              style: Dimensions.fontSizeStyle16w600().copyWith(
                height: 1.5,
                color: colorLabel,
              ),
              overflow: TextOverflow.visible,
              maxLines: maxLineLabel ?? 9999,
            ),
            if (content != null)
              Text(
                content.toString(),
                textAlign: centerContent == true ? TextAlign.center : TextAlign.left,
                style: Dimensions.fontSizeStyle16().copyWith(
                  height: 1.5,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
