import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/helper/dimensions.dart';

class TextWhiteBorder extends StatelessWidget {
  final String text;
  const TextWhiteBorder({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: Dimensions.FONT_SIZE_DEFAULT,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: Colors.white,
            offset: Offset(2, 0),
          ),
          Shadow(
            color: Colors.white,
            offset: Offset(0, 2),
          ),
          Shadow(
            color: Colors.white,
            offset: Offset(0, -2),
          ),
          Shadow(
            color: Colors.white,
            offset: Offset(-2, 0),
          ),
        ],
      ),
    );
  }
}
