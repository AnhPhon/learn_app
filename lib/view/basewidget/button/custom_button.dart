import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  const CustomButton({required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0xFFD4D4D4),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 1)), // changes position of shadow
            ],
            gradient: const LinearGradient(colors: [
                    ColorResources.PRIMARY,
                    ColorResources.PRIMARY,
                    ColorResources.PRIMARY,
                  ]),
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
        child: Text(buttonText,
            style: titilliumSemiBold.copyWith(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: Theme.of(context).accentColor,
            )),
      ),
    );
  }
}
