import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class CardProfile extends StatelessWidget {
  const CardProfile({
    Key? key,
    required this.press,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final Function() press;
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimensions.BORDER_RADIUS_SMALL,
        ),
      ),
      color: ColorResources.WHITE,
      // shadowColor: ColorResources.BLACK.withOpacity(.4),
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_LARGE,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: ListTile(
        onTap: press,
        leading: icon,
        title: Text(title),
      ),
    );
  }
}
