import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/helper/dimensions.dart';

class FieldWidget extends StatelessWidget {
  final Widget widget;
  final Function() onTap;
  final String title;

  const FieldWidget({
    required this.title,
    required this.onTap,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    const double _fontSize = Dimensions.FONT_SIZE_DEFAULT;
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _fontSize,
                color: Color(0xff040404),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: const [
                  Text(
                    "Xem thêm",
                    style: TextStyle(
                      color: Color(0xff2196f3),
                      fontSize: _fontSize,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xff2196f3),
                    size: _fontSize,
                  ),
                ],
              ),
            )
          ],
        ),
        widget
      ],
    );
  }
}
