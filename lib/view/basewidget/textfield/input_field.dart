
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
      this.errorText,
      required this.typeInput,
      required this.width,
      this.height = 50,
      required this.hidden,
      required this.obligatory,
      this.line = 5,
      required this.fontSize});
  String label, holdplacer;
  TextEditingController controller;
  bool allowEdit, allowMultiline, hidden, obligatory;
  TextInputType typeInput;
  double width, fontSize;
  double? height;
  Widget? suffixIcon;
  final String? errorText;
  final int? line;
  final Function(String value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_SMALL,
        right: Dimensions.PADDING_SIZE_SMALL, 
        top: Dimensions.PADDING_SIZE_LARGE
      ),
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
                      fontSize: fontSize,// * 2.1, 
                      fontWeight: FontWeight.bold, 
                      color: ColorResources.BLACK.withOpacity(0.7)),
                ),
                if (obligatory) Text(
                        '*',
                        style: TextStyle(
                            fontSize: fontSize,// * 2.1,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ) else Container()
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
                contentPadding:const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL, vertical:Dimensions.PADDING_SIZE_DEFAULT ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)
                ),
                errorText: errorText,
                isDense: true,
                hintText: holdplacer,
                hintStyle: TextStyle(
                  color: ColorResources.BLACK.withOpacity(0.5),
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
                fillColor:(allowEdit == false) ? const Color(0xffEBEAEA) : Colors.transparent,
                suffixIcon: suffixIcon),
            ),
          ),
        ],
      ),
    );
  }
}
