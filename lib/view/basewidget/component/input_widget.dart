import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/theme/app_theme.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/thousands_separator_input_formatter.dart';

class InputWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final bool autofocus;
  final TextEditingController textEditingController;
  final Function(dynamic)? onChanged;
  final String? hintText;
  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding, contentPadding;
  final EdgeInsetsGeometry? margin;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final VoidCallback? suffixIconTap;
  final Function(dynamic)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLine;
  final DateTime? firstDate, lastDate, initialDate;
  final Color? fillColor;
  final bool? isDate, isddMMyyyy, isTime, isColorFieldWhite, allowEdit, labelBold, obligatory, isBorder, isShadow, thousandsSeparator;

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
    this.focusNode,
    this.labelBold = false,
    this.obligatory = false,
    this.width,
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
    this.initialDate,
    this.contentPadding,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      width: width != null ? DeviceUtils.getScaledWidth(context, width!) : DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            RichText(
              maxLines: 2,
              text: TextSpan(
                  text: label,
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: labelBold == true ? FontWeight.w600 : null,
                    color: ColorResources.BLACK,
                  ),
                  children: [
                    if (obligatory == true)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: labelBold == true ? FontWeight.w600 : null,
                          color: Colors.red,
                        ),
                      )
                    else
                      const TextSpan(),
                  ]),
            ),
          if (label != null)
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
          Container(
            margin: margin ?? EdgeInsets.zero,
            height: (height != null) ? DeviceUtils.getScaledHeight(context, height!) : null,
            decoration: BoxDecoration(
              boxShadow: (isShadow == true)
                  ? [
                      BoxShadow(blurRadius: 2, color: ColorResources.BLACK.withOpacity(.2), offset: const Offset(0, 2)),
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
                                colorScheme: const ColorScheme.light(primary: ColorResources.PRIMARY),
                              ),
                              child: child!);
                        },
                        context: context,
                        initialDate: initialDate ?? DateTime.now(),
                        firstDate: firstDate ?? DateTime(DateTime.now().year - 100),
                        lastDate: lastDate ?? DateTime(DateTime.now().year + 100),
                      ).then((value) {
                        isddMMyyyy == true ? textEditingController.text = DateConverter.estimatedDateOnly(value!) : textEditingController.text = DateConverter.formatDate(value!);
                        // textEditingController.text =
                        // DateConverter.estimatedDateOnly(value);
                      });
                      DeviceUtils.unFocus(context);
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
                            print(textEditingController.text);
                          });
                          DeviceUtils.unFocus(context);
                        }
                      : () {},
              child: TextField(
                inputFormatters: (thousandsSeparator == true)
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                        ThousandsSeparatorInputFormatter(),
                      ]
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
                  suffixIcon: (suffixIcon != null)
                      ? GestureDetector(
                          onTap: suffixIconTap ?? () {},
                          child: suffixIcon ?? const SizedBox.shrink(),
                        )
                      : null,
                  contentPadding: contentPadding ??
                      EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.025),
                        vertical: DeviceUtils.getScaledSize(context, 0.03),
                      ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide: (isBorder == true) ? const BorderSide(color: ColorResources.PRIMARY) : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide: (isBorder == true) ? const BorderSide(color: ColorResources.PRIMARY) : BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    borderSide: (isBorder == true) ? const BorderSide(color: ColorResources.LIGHT_BLACK) : BorderSide.none,
                  ),
                  hintText: hintText,
                  filled: true,
                  fillColor: fillColor ?? (isColorFieldWhite == true ? ColorResources.WHITE : ColorResources.NOT_ALLOW_EDIT),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
