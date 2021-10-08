import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';

class BtnCategory extends StatelessWidget {
  Gradient gradient;
  String label;
  IconData icon;

  BtnCategory({
    required this.gradient,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
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
            color: Colors.white,
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          Text(
            label,
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
          )
        ],
      ),
    );
  }
}
