

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/button/long_button.dart';

class AddInfoButton extends StatelessWidget {
  const AddInfoButton({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);
  final String title;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL
      ),
      child: LongButton(title: title, color: ColorResources.PRIMARYCOLOR, onPressed: onPress),
    );
  }
}
