import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/dimensions.dart';

class TextWhiteBorder extends StatelessWidget {
  String text;
  TextWhiteBorder({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
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
          )
        ],
      ),
    );
  }
}
