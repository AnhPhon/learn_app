// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class TextFieldDate extends StatelessWidget {
  const TextFieldDate({
    this.label,
    this.isToHour = false,
    required this.holdplacer,
    required this.controller,
    required this.allowEdit,
    required this.isDate,
    this.typeInput,
    required this.width,
    required this.obligatory,
    this.area = false,
    required this.fontSize,
    this.paddingTop = Dimensions.PADDING_SIZE_LARGE,
    this.onDateTimeChanged,
    this.padding,
    this.isBirthDate = false,
  });

  final Function(String)? onDateTimeChanged;
  final String holdplacer;
  final String? label;
  final TextEditingController controller;
  final bool allowEdit, isDate;
  final TextInputType? typeInput;
  final double width, fontSize;
  final bool obligatory;
  final bool? area;
  final double? paddingTop;
  final bool? isToHour;
  final EdgeInsetsGeometry? padding;
  final bool isBirthDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Container(
              padding: const EdgeInsets.only(
                  bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              alignment: Alignment.centerLeft,
              child: RichText(
              text: TextSpan(
              text: label,
             style: TextStyle(
                fontSize: fontSize, // * 2.1,
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK.withOpacity(0.7)
              ),
              children: [
                if (obligatory)
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: fontSize, // * 2.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),
                )
                else const TextSpan(),
              ]
            ))
            ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),
          GestureDetector(
            onTap: isDate
                ? () {
                  isBirthDate ? showCupertinoModalPopup(
                  context: Get.context!,
                  builder: (_) => Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          color: ColorResources.WHITE,
                        ),
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                )
                              ),
                              height: 300,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (value) {
                                  controller.text =
                              "${value.day < 10 ? '0${value.day}' : value.day}-${value.month < 10 ? '0${value.month}' : value.month}-${value.year < 10 ? '0${value.year}' : value.year}";
                                }),
                            ),

                            GestureDetector(
                              onTap:(){
                                Get.back();
                              },
                              child: const Padding(
                                padding:  EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
                                child: Text("Xác nhận",
                                style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: ColorResources.PRIMARYCOLOR,
                                  fontWeight: FontWeight.bold
                                ),)
                              ),
                            )

                          ],
                        ),
                      )) :
                  
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      isToHour!
                          ? controller.text =
                              "${value!.hour}:${value.minute} ${value.day}-${value.month}-${value.year}"
                          : controller.text =
                              "${value!.day}-${value.month}-${value.year}";
                      if (onDateTimeChanged != null && value != null) {
                        onDateTimeChanged!(value.toIso8601String());
                      }
                      isToHour!
                          ? controller.text =
                              "${value.hour < 10 ? '0${value.hour}' : '1${value.hour}'}:${value.minute < 10 ? '0${value.minute}' : value.minute} ${value.day < 10 ? '0${value.day}' : value.day}-${value.month < 10 ? '0${value.month}' : value.month}-${value.year < 10 ? '0${value.year}' : value.year}"
                          : controller.text =
                              "${value.day < 10 ? '0${value.day}' : value.day}-${value.month < 10 ? '0${value.month}' : value.month}-${value.year < 10 ? '0${value.year}' : value.year}";
                    });
                    DeviceUtils.unFocus(context);
                  }
                : () {},
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              keyboardType: isDate ? null : typeInput,
              textAlignVertical: TextAlignVertical.center,
              maxLines: area! ? 3 : 1,
              enabled: false,
              controller: controller,
              onTap: (isDate == true)
                  ? () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2100),
                      ).then((value) {
                        isToHour == true
                            ? controller.text =
                                "${value!.year}-${value.month}-${value.day}"
                            : controller.text =
                                "${value!.hour}:${value.minute} ${value.day}-${value.month}-${value.year}";
                      });
                    }
                  : null,
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
                  fillColor: (allowEdit == false)
                      ? ColorResources.WHITE
                      : Colors.white,
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

  ///
  /// format date
  ///
  String formatDate(String date) {
    return DateFormat("dd/MM/yyyy")
        .format(DateFormat("yyyy-MM-dd").parse(date));
  }
}
