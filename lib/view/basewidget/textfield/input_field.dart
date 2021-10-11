import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class InputField extends StatelessWidget {
  InputField(
      {required this.label,
      required this.holdplacer,
      required this.controller,
      required this.allowEdit,
      required this.allowMultiline,
      this.suffixIcon,
      this.onChanged,
      this.boldHinText,
      this.errorText,
      required this.typeInput,
      required this.width,
      this.height = 50,
      required this.hidden,
      required this.obligatory,
      this.line = 5,
      this.paddingTop = Dimensions.PADDING_SIZE_LARGE,
      required this.fontSize});
  final String label, holdplacer;
  final TextEditingController controller;
  final bool allowEdit, allowMultiline, hidden, obligatory;
  final TextInputType typeInput;
  final double width, fontSize;
  final double? height;
  final Widget? suffixIcon;
  final double? paddingTop;
  final String? errorText;
  final int? line;
  final Function(String value)? onChanged;
  bool? boldHinText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT,
          top: paddingTop!),
      //padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL, left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
      width: width,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: fontSize, // * 2.1,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.BLACK.withOpacity(0.7)),
                ),
                if (obligatory)
                  Text(
                    '*',
                    style: TextStyle(
                        fontSize: fontSize, // * 2.1,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  )
                else
                  Container()
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: TextField(
              textInputAction: TextInputAction.done,
              keyboardType: typeInput,
              maxLines: (allowMultiline == true) ? line : 1,
              textAlignVertical: TextAlignVertical.top,
              enabled: allowEdit,
              controller: controller,
              obscureText: hidden,
              onChanged: onChanged,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  errorText: errorText,
                  isDense: true,
                  hintText: holdplacer,
                  hintStyle: TextStyle(
                    color: boldHinText == true
                        ? ColorResources.BLACK
                        : ColorResources.BLACK.withOpacity(0.5),
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: boldHinText == true ? FontWeight.w600 : null,
                  ),
                  fillColor: (allowEdit == false)
                      ? ColorResources.GREY
                      : Colors.transparent,
                  suffixIcon: suffixIcon),
            ),
          ),
        ],
      ),
    );
  }
}
