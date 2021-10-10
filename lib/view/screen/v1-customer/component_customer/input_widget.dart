import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/theme/app_theme.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final String? label;
  final double width;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isDate,
      isTime,
      isColorFieldWhite,
      allowEdit,
      labelBold,
      obligatory;
  const InputWidget({
    Key? key,
    required this.textEditingController,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isDate = false,
    this.isTime = false,
    this.isColorFieldWhite = false,
    this.allowEdit = true,
    this.label,
    this.labelBold = false,
    this.obligatory = false,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          if (label != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: [
                  Text(
                    label.toString(),
                    style: labelBold == true
                        ? Dimensions.fontSizeStyle16w600().copyWith(
                            color: ColorResources.BLACK,
                          )
                        : Dimensions.fontSizeStyle16().copyWith(
                            color: ColorResources.BLACK,
                          ),
                  ),
                  if (obligatory == true)
                    const Text(
                      "*",
                      style: TextStyle(
                        color: ColorResources.RED,
                      ),
                    ),
                ],
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
            width: DeviceUtils.getScaledWidth(context, width),
            child: GestureDetector(
              onTap: (isDate == true)
                  ? () {
                      showDatePicker(
                        locale: const Locale("vi", "VI"),
                        builder: (context, child) {
                          return Theme(
                              data: AppTheme.light.copyWith(
                                colorScheme: const ColorScheme.light(
                                    primary: ColorResources.PRIMARY),
                              ),
                              child: child!);
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2100),
                      ).then((value) {
                        textEditingController.text =
                            DateConverter.estimatedDateOnly(value!);
                      });
                    }
                  : (isTime == true)
                      ? () {
                          showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, childWidget) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        // Using 24-Hour format
                                        alwaysUse24HourFormat: true),
                                    // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                    child: childWidget!);
                              }).then((value) {
                            textEditingController.text = value!.toString();
                          });
                        }
                      : () {},
              child: TextField(
                textInputAction: TextInputAction.done,
                textAlignVertical: TextAlignVertical.center,
                controller: textEditingController,
                cursorColor: ColorResources.PRIMARY,
                enabled: allowEdit,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide: const BorderSide(
                        color: ColorResources.PRIMARY, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide: const BorderSide(
                        color: ColorResources.PRIMARY, width: 2),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide: const BorderSide(
                        color: ColorResources.PRIMARY, width: 2),
                  ),
                  hintText: hintText,
                  filled: true,
                  fillColor: (isColorFieldWhite == true)
                      ? ColorResources.WHITE
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
