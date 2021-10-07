import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWhiteBorder extends StatelessWidget {
  String text;
  TextWhiteBorder({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
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
