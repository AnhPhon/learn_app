import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  const InputWidget(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      controller: textEditingController,
      cursorColor: ColorResources.PRIMARY,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          borderSide: const BorderSide(color: ColorResources.PRIMARY, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          borderSide: const BorderSide(color: ColorResources.PRIMARY, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          borderSide: const BorderSide(color: ColorResources.PRIMARY, width: 2),
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }
}
