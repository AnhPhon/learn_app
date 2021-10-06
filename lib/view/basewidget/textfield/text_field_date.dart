import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class TextFieldDate extends StatelessWidget {
  const TextFieldDate(
      {this.label,
      required this.holdplacer,
      required this.controller,
      required this.allowEdit,
      required this.isDate,
      required this.typeInput,
      required this.width,
      required this.obligatory,
      this.area = false,
      required this.fontSize,
      this.paddingTop});
  final String holdplacer;
  final String? label;
  final TextEditingController controller;
  final bool allowEdit, isDate;
  final TextInputType typeInput;
  final double width, fontSize;
  final bool obligatory;
  final bool? area;
  final double? paddingTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT,
          top: Dimensions.PADDING_SIZE_LARGE),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Container(
              padding: const EdgeInsets.only(
                  bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: [
                  Text(
                    label!,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                  if (obligatory)
                    Text(
                      '*',
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )
                  else
                    Container()
                ],
              ),
            ),
          TextField(
            textInputAction: TextInputAction.done,
            keyboardType: isDate ? null : typeInput,
            textAlignVertical: TextAlignVertical.center,
            maxLines: area! ? 3 : 1,
            enabled: allowEdit,
            controller: controller,
            onTap: (isDate == true)
                ? () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      controller.text =
                          "${value!.year}-${value.month}-${value.day}";
                    });
                  }
                : null,
            cursorColor: ColorResources.PRIMARYCOLOR,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.PRIMARYCOLOR)),
                hintText: holdplacer,
                filled: true,
                fillColor: (allowEdit == false)
                    ? ColorResources.GREY
                    : Colors.transparent,
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: Dimensions.PADDING_SIZE_SMALL * 2,
                ),
                suffixIcon: (isDate == true)
                    ? const Padding(
                        padding: EdgeInsets.only(
                            right: Dimensions.FONT_SIZE_EXTRA_SMALL),
                        child: Icon(
                          Icons.date_range,
                          size: 18,
                          color: ColorResources.PRIMARYCOLOR,
                        ),
                      )
                    : null),
          ),
        ],
      ),
    );
  }
}
