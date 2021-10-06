import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';

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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
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
          const SizedBox(height: 10),
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
