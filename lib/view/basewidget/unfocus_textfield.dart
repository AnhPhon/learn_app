import 'package:flutter/material.dart';
import 'package:template/helper/device_utils.dart';

class UnFocusTextField extends StatelessWidget {
  final Widget widget;
  const UnFocusTextField({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtils.unFocus(context),
      child: widget,
    );
  }
}
