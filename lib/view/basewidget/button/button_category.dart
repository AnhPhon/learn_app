import 'package:flutter/material.dart';
import 'package:template/helper/dimensions.dart';

class BtnCategory extends StatelessWidget {
  final Gradient gradient;
  final List<String> label;
  final IconData icon;
  Color? iconColor;

  BtnCategory({
    required this.gradient,
    required this.label,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          )
        ],
        gradient: gradient,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor ?? Colors.white,
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: List.generate(
                label.length,
                (index) => Text(
                  label[index],
                  style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
