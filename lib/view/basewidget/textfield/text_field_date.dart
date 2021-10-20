import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class TextFieldDate extends StatelessWidget {
  const TextFieldDate(
      {this.label,
      this.isToHour = false,
      required this.holdplacer,
      required this.controller,
      required this.allowEdit,
      required this.isDate,
      required this.typeInput,
      required this.width,
      required this.obligatory,
      this.area = false,
      required this.fontSize,
      this.paddingTop = Dimensions.PADDING_SIZE_LARGE});
  final String holdplacer;
  final String? label;
  final TextEditingController controller;
  final bool allowEdit, isDate;
  final TextInputType typeInput;
  final double width, fontSize;
  final bool obligatory;
  final bool? area;
  final double? paddingTop;
  final bool? isToHour;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT,
          top: paddingTop!),
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
          GestureDetector(
            onTap: isDate  ? (){
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2001),
                lastDate: DateTime(2100),
              ).then((value) {
                isToHour! ? controller.text =
                                "${value!.hour}:${value.minute} ${value.day}-${value.month}-${value.year}" : controller.text =
                    "${value!.day}-${value.month}-${value.year}";
                    
              });
            } : (){},
            child: TextField(
              textInputAction: TextInputAction.done,
              keyboardType: isDate ? null : typeInput,
              textAlignVertical: TextAlignVertical.center,
              maxLines: area! ? 3 : 1,
              enabled: false,
              controller: controller,
              // onTap: (isDate == true)
              //     ? () {
              //         showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(),
              //           firstDate: DateTime(2001),
              //           lastDate: DateTime(2100),
              //         ).then((value) {
              //           isToHour == true
              //               ? controller.text =
              //                   "${value!.year}-${value.month}-${value.day}"
              //               : controller.text =
              //                   "${value!.hour}:${value.minute} ${value.day}-${value.month}-${value.year}";
              //         });
              //       }
              //     : null,
              cursorColor: ColorResources.PRIMARYCOLOR,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT + 3,
                  ),
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
                  hintText: holdplacer,
                  filled: true,
                  fillColor:
                      (allowEdit == false) ? ColorResources.WHITE : Colors.white,
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  suffixIcon: (isDate == true)
                      ? const Padding(
                          padding: EdgeInsets.only(
                              right: Dimensions.FONT_SIZE_EXTRA_SMALL),
                          child: Icon(
                            Icons.date_range,
                            size: Dimensions.ICON_SIZE_SMALL,
                            color: ColorResources.PRIMARYCOLOR,
                          ),
                        )
                      : null),
            ),
          ),
        ],
      ),
    );
  }
}
