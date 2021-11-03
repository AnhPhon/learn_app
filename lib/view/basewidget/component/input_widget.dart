import 'package:flutter/material.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/theme/app_theme.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/thousands_separator_input_formatter.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(dynamic)? onChanged;
  final String? hintText;
  final String? label;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final VoidCallback? suffixIconTap;
  final Function(dynamic)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLine;
  final DateTime? firstDate, lastDate;
  final Color? fillColor;
  final bool? isDate,
      isddMMyyyy,
      isTime,
      isColorFieldWhite,
      allowEdit,
      labelBold,
      obligatory,
      isBorder,
      isShadow,
      thousandsSeparator;
  const InputWidget({
    Key? key,
    required this.textEditingController,
    this.isddMMyyyy = false,
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
    this.isBorder = true,
    this.isShadow = false,
    this.onChanged,
    this.thousandsSeparator = false,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.maxLine,
    this.firstDate,
    this.lastDate,
    this.fillColor,
    this.padding,
    this.margin,
    this.suffixIconTap,
    this.onSubmitted,
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Wrap(
              children: [
                Text(
                  label.toString(),
                  style: labelBold == true
                      ? Dimensions.fontSizeStyle16w600().copyWith(
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                        )
                      : Dimensions.fontSizeStyle16().copyWith(
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
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
          if (label != null)
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
          Container(
            margin: margin ?? EdgeInsets.zero,
            height: (height != null)
                ? DeviceUtils.getScaledHeight(context, height!)
                : null,
            width: DeviceUtils.getScaledWidth(context, width),
            decoration: BoxDecoration(
              boxShadow: (isShadow == true)
                  ? [
                      BoxShadow(
                          blurRadius: 2,
                          color: ColorResources.BLACK.withOpacity(.2),
                          offset: const Offset(0, 2)),
                    ]
                  : [],
            ),
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
                        firstDate: firstDate ?? DateTime(2000),
                        lastDate: lastDate ?? DateTime(2200),
                      ).then((value) {
                        isddMMyyyy == true
                            ? textEditingController.text =
                                DateConverter.estimatedDateOnly(value!)
                            : textEditingController.text =
                                DateConverter.formatDate(value!);
                        // textEditingController.text =
                        // DateConverter.estimatedDateOnly(value);
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
                            textEditingController.text = value!.format(context);
                          });
                        }
                      : () {},
              child: TextField(
                inputFormatters: (thousandsSeparator == true)
                    ? [ThousandsSeparatorInputFormatter()]
                    : null,
                onChanged: onChanged,
                maxLines: maxLine ?? 1,
                textInputAction: textInputAction,
                onSubmitted: onSubmitted,
                keyboardType: textInputType,
                textAlignVertical: TextAlignVertical.center,
                controller: textEditingController,
                cursorColor: ColorResources.PRIMARY,
                enabled: allowEdit,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: prefixIcon,
                  suffixIcon: GestureDetector(
                    onTap: suffixIconTap ?? () {},
                    child: suffixIcon ?? const SizedBox.shrink(),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      borderSide: (isBorder == true)
                          ? const BorderSide(color: ColorResources.PRIMARY)
                          : BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      borderSide: (isBorder == true)
                          ? const BorderSide(color: ColorResources.PRIMARY)
                          : BorderSide.none),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      borderSide: (isBorder == true)
                          ? const BorderSide(color: ColorResources.PRIMARY)
                          : BorderSide.none),
                  hintText: hintText,
                  filled: true,
                  fillColor: fillColor ?? ColorResources.NOT_ALLOW_EDIT,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
