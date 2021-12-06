import 'package:flutter/material.dart';
import 'package:template/helper/dimensions.dart';

class BackButton extends StatelessWidget {
  final Color color;

  const BackButton(this.color);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back_ios, color: color, size: Dimensions.FONT_SIZE_LARGE),
    );
  }
}
