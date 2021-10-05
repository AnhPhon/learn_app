

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class Label extends StatelessWidget {
  const Label({
    Key? key,
    required this.label,
    required this.obligatory,
  }) : super(key: key);
  final String label;
  final bool obligatory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left:Dimensions.PADDING_SIZE_DEFAULT,
        right:Dimensions.PADDING_SIZE_DEFAULT,
        top:Dimensions.PADDING_SIZE_LARGE
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, fontWeight: FontWeight.bold,color: ColorResources.BLACK.withOpacity(0.7)),
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
