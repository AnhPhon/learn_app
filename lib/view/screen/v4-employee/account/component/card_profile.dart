import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';

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
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimensions.BORDER_RADIUS_SMALL,
        ),
      ),
      color: ColorResources.WHITE,
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      child: ListTile(
        onTap: press,
        leading: icon,
        title: Text(title),
      ),
    );
  }
}
