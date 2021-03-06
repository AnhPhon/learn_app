import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_date.dart';

import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_other.dart';

import 'package:template/helper/izi_validate.dart';
import 'package:template/theme/app_theme.dart';
import 'package:template/utils/color_resources.dart';

// Text, number, tiền đều có thể hiện thị defaul = text
// PrefixIcon
// Lable bên trên có thể không (Có thể null)
// Label trên border (Có thể có or null)
// Có bắt phải nhập hay không
// Validate EditText -> Fail hiển thị error label
// Sufix label nếu nó là tiền (Nếu là tiền hiện thị thêm icon tiền)
//

enum IZIInputType {
  TEXT,
  PASSWORD,
  NUMBER,
  DOUBLE,
  PRICE,
  EMAIL,
  PHONE,
  INCREMENT,
}

enum IZIPickerDate {
  MATERIAL,
  CUPERTINO,
}

class IZIInput extends StatefulWidget {
  IZIInput({
    Key? key,
    this.label,
    this.placeHolder,
    this.allowEdit = true,
    this.maxLine = 1,
    this.isRequired = false,
    required this.type,
    this.width,
    this.fontSize,
    this.height,
    this.suffixIcon,
    this.paddingTop,
    this.errorText,
    this.textInputAction,
    this.onChanged,
    this.isValidate,
    this.focusNode,
    this.padding,
    this.onSubmitted,
    this.borderRadius,
    this.hintStyle,
    this.borderSide,
    this.isBorder = false,
    this.fillColor,
    this.prefixIcon,
    this.validate,
    this.isLegend = false,
    this.borderSize,
    this.disbleError = false,
    this.miniSize = false,
    this.colorDisibleBorder = ColorResources.GREY,
    this.colorBorder = ColorResources.CIRCLE_COLOR_BG3,
    this.min = 1,
    this.max = 10,
    this.widthIncrement,
    this.onSetValue,
    this.newValue,
    this.isDatePicker = false,
    this.iziPickerDate = IZIPickerDate.MATERIAL,
    this.obscureText,
    this.contentPaddingIncrement,
  }) : super(key: key);
  final String? label;
  final String? placeHolder;
  final bool? allowEdit;
  final int? maxLine;
  final IZIInputType type;
  final bool? isRequired;
  final double? width;
  final double? fontSize;
  final double? height;
  final Widget? suffixIcon;
  final double? paddingTop;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged;
  final Function(bool value)? isValidate;
  Function()? onSetValue;
  double? newValue;
  bool? boldHinText;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;
  final Function(dynamic)? onSubmitted;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final BorderSide? borderSide;
  final bool? isBorder;
  final Color? fillColor;
  final Widget? prefixIcon;
  final String? Function(String)? validate;
  final bool? isLegend;
  final double? borderSize;
  final bool disbleError;
  final bool miniSize;
  final Color? colorDisibleBorder;
  final Color? colorBorder;
  final double? min;
  final double? max;
  final double? widthIncrement;
  final bool? isDatePicker;
  final IZIPickerDate? iziPickerDate;
  final bool? obscureText;
  final EdgeInsets? contentPaddingIncrement;
  @override
  _IZIInputState createState() => _IZIInputState();
}

class _IZIInputState extends State<IZIInput> {
  FocusNode? focusNode;
  TextEditingController? textEditingController;
  MoneyMaskedTextController? numberEditingController;
  MoneyMaskedTextController? doubleEditingController;

  bool isShowedError = false;
  bool isVisible = false;
  bool isDisibleIncrement = false;
  bool isDisibleReduction = false;
  String? _errorText = "";

  @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController();
    //TODO: fork lại fackage của họ, Thêm try catch
    // Khởi tạo lại NumberController set IniitValue
    if (widget.type == IZIInputType.INCREMENT) {
      numberEditingController = MoneyMaskedTextController(
        initialValue: IZINumber.parseDouble(widget.min.toString()),
        precision: 0,
        decimalSeparator: '',
      );
    } else {
      numberEditingController = MoneyMaskedTextController(
        initialValue: 0,
        precision: 0,
        decimalSeparator: '',
      );
    }

    doubleEditingController = MoneyMaskedTextController(
      precision: 1,
    );

    focusNode = widget.focusNode ?? FocusNode();
    if (widget.type == IZIInputType.INCREMENT) {
      checkDisibleIncrement(IZINumber.parseInt(numberEditingController!.text));
    }
    // else if (widget.type == IZIInputType.NUMBER || widget.type == IZIInputType.PRICE) {
    //   numberEditingController!.clear();
    //   doubleEditingController!.clear();
    // }

    onSetValue();
  }

  @override
  void dispose() {
    focusNode?.dispose();
    textEditingController?.dispose();
    numberEditingController?.dispose();
    doubleEditingController?.dispose();
    super.dispose();
  }

  void onSetValue() {
    widget.onSetValue = () {
      if (!IZIValidate.nullOrEmpty(widget.newValue) && widget.type == IZIInputType.NUMBER || !IZIValidate.nullOrEmpty(widget.newValue) && widget.type == IZIInputType.PRICE || !IZIValidate.nullOrEmpty(widget.newValue) && widget.type == IZIInputType.DOUBLE) {
        numberEditingController = MoneyMaskedTextController(
          initialValue: widget.newValue!,
          precision: 0,
          decimalSeparator: '',
        );
        doubleEditingController = MoneyMaskedTextController(
          initialValue: widget.newValue!,
          precision: 1,
        );
        setState(() {});
      }
    };
  }

  TextInputType getType(IZIInputType type) {
    if (type == IZIInputType.NUMBER) {
      return TextInputType.number;
    } else if (type == IZIInputType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (type == IZIInputType.PRICE) {
      return TextInputType.number;
    } else if (type == IZIInputType.TEXT) {
      return TextInputType.text;
    } else if (type == IZIInputType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (type == IZIInputType.PHONE) {
      return TextInputType.phone;
    } else if (type == IZIInputType.DOUBLE) {
      return TextInputType.numberWithOptions();
    } else if (type == IZIInputType.INCREMENT) {
      return TextInputType.number;
    }
    return TextInputType.text;
  }

  TextEditingController getController(IZIInputType type) {
    if (type == IZIInputType.NUMBER) {
      return numberEditingController!;
    } else if (type == IZIInputType.PASSWORD) {
      return textEditingController!;
    } else if (type == IZIInputType.PRICE) {
      return numberEditingController!;
    } else if (type == IZIInputType.TEXT) {
      return textEditingController!;
    } else if (type == IZIInputType.EMAIL) {
      return textEditingController!;
    } else if (type == IZIInputType.PHONE) {
      return textEditingController!;
    } else if (type == IZIInputType.DOUBLE) {
      return doubleEditingController!;
    } else if (type == IZIInputType.INCREMENT) {
      return numberEditingController!;
    }
    return textEditingController!;
  }

  String? Function(String)? checkValidate(
    IZIInputType type,
  ) {
    if (widget.validate != null) {
      return widget.validate;
    }
    if (type == IZIInputType.NUMBER) {
      return null;
    } else if (type == IZIInputType.PASSWORD) {
      return IZIValidate.password;
    } else if (type == IZIInputType.PRICE) {
      return null;
    } else if (type == IZIInputType.TEXT) {
      return null;
    } else if (type == IZIInputType.EMAIL) {
      return IZIValidate.email;
    } else if (type == IZIInputType.PHONE) {
      return IZIValidate.phone;
    } else if (type == IZIInputType.INCREMENT) {
      return IZIValidate.increment;
    }
    return null;
  }

  void onIncrement(IZIInputType type, {required bool increment}) {
    if (type == IZIInputType.INCREMENT) {
      final controller = getController(widget.type);
      if (IZIValidate.nullOrEmpty(controller.text)) {
        controller.text = '1';
      }
      int value = int.parse(controller.text);
      if (increment) {
        value++;
        controller.text = value.toString();
        checkDisibleIncrement(value);
      } else {
        validator(widget.type, value.toString());
        if (value > 0) {
          value--;
          controller.text = value.toString();
        }
        checkDisibleIncrement(value);
      }
      if (widget.onChanged != null) {
        widget.onChanged!(value.toString());
        validator(widget.type, value.toString());
      }
    }
  }

  void checkDisibleIncrement(int value) {
    if (value <= widget.min! && !isDisibleReduction) {
      setState(() {
        isDisibleReduction = true;
      });
      return;
    }
    if (value > widget.min! && isDisibleReduction) {
      setState(() {
        isDisibleReduction = false;
      });
      return;
    }
    if (value >= widget.max! && !isDisibleIncrement) {
      setState(() {
        isDisibleIncrement = true;
      });
      return;
    }
    if (value < widget.max! && isDisibleIncrement) {
      setState(() {
        isDisibleIncrement = false;
      });
      return;
    }
  }

  void validator(IZIInputType type, String val) {
    if (checkValidate(widget.type) != null && isShowedError) {
      setState(() {
        _errorText = checkValidate(widget.type)!(val.toString());
      });
      if (widget.isValidate != null) {
        widget.isValidate!(IZIValidate.nullOrEmpty(_errorText));
      }
    }
  }

  void datePicker(IZIPickerDate pickerType) {
    print("Onlick");
    if (pickerType == IZIPickerDate.CUPERTINO) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: ColorResources.WHITE,
          ),
          height: IZIDimensions.ONE_UNIT_SIZE * 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
                height: IZIDimensions.ONE_UNIT_SIZE * 400,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (value) {
                      getController(widget.type).text = IZIDate.formatDate(value);
                      // "${value.day < 10 ? '0${value.day}' : value.day}-${value.month < 10 ? '0${value.month}' : value.month}-${value.year < 10 ? '0${value.year}' : value.year}";
                    }),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6, color: ColorResources.CIRCLE_COLOR_BG3, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: AppTheme.light.copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorResources.GREEN,
              ),
            ),
            child: child!,
          );
        },
      ).then(
        (value) {
          if (!IZIValidate.nullOrEmpty(value)) {
            getController(widget.type).text = IZIDate.formatDate(value!);
          }
        },
      );
    }
  }

  Widget? getSuffixIcon() {
    if (widget.isDatePicker! && IZIValidate.nullOrEmpty(widget.suffixIcon)) {
      return const Icon(
        Icons.calendar_today,
        color: ColorResources.BLACK,
      );
    }
    if (widget.type == IZIInputType.PRICE) {
      return SizedBox.shrink(
        child: Padding(
          padding: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Text("VNĐ"),
          ),
        ),
      );
    } else if (widget.type == IZIInputType.PASSWORD) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
        ),
      );
    }
    if (!IZIValidate.nullOrEmpty(widget.suffixIcon)) {
      return widget.suffixIcon!;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!focusNode!.hasListeners) {
      focusNode!.addListener(() {
        setState(() {});
      });
    }
    if (!IZIValidate.nullOrEmpty(widget.errorText) && IZIValidate.nullOrEmpty(_errorText)) {
      _errorText = widget.errorText.toString();
    }
    return Container(
      width: widget.width ?? IZIDimensions.iziSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLegend == false && widget.label != null)
            Container(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                  children: [
                    if (widget.isRequired!)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      )
                    else
                      const TextSpan(),
                  ],
                ),
              ),
            ),
          Row(
            children: [
              if (IZIInputType.INCREMENT == widget.type)
                GestureDetector(
                  onTap: () {
                    if (!isDisibleReduction) {
                      onIncrement(widget.type, increment: false);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(
                      IZIDimensions.ONE_UNIT_SIZE * 10,
                    ),
                    height: widget.height ?? IZIDimensions.ONE_UNIT_SIZE * 80,
                    constraints: BoxConstraints(
                      maxHeight: IZIDimensions.ONE_UNIT_SIZE * 80,
                    ),
                    width: widget.widthIncrement ?? IZIDimensions.ONE_UNIT_SIZE * 80,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: IZIOther().boxShadow,
                      border: widget.isBorder!
                          ? isDisibleReduction
                              ? Border.all(
                                  color: widget.colorDisibleBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                                )
                              : Border.all(
                                  color: widget.colorBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                                )
                          : isDisibleReduction
                              ? Border.all(
                                  color: widget.colorDisibleBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                                )
                              : Border.all(
                                  color: widget.colorBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                                ),
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_2X,
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: isDisibleReduction ? widget.colorDisibleBorder ?? ColorResources.GREY : widget.colorBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                    ),
                  ),
                ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    if (widget.isDatePicker! && widget.allowEdit!) {
                      datePicker(widget.iziPickerDate!);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: IZIOther().boxShadow,
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                      ),
                    ),
                    width: IZIInputType.INCREMENT == widget.type ? widget.width ?? IZIDimensions.ONE_UNIT_SIZE * 90 : null,
                    height: widget.miniSize ? 45 : null,
                    child: TextFormField(
                      textAlign: IZIInputType.INCREMENT == widget.type ? TextAlign.center : TextAlign.start,
                      onFieldSubmitted: (val) {
                        if (!IZIValidate.nullOrEmpty(widget.onSubmitted)) {
                          widget.onSubmitted!(val);
                        }
                        if (!IZIValidate.nullOrEmpty(val)) {
                          if (IZINumber.parseInt(val) < widget.min!) {
                            getController(widget.type).text = IZINumber.parseInt(widget.min.toString()).toString();
                          }
                        }
                      },
                      onChanged: (val) {
                        isShowedError = true;
                        if (widget.type == IZIInputType.NUMBER || widget.type == IZIInputType.DOUBLE) {
                          if (IZIValidate.nullOrEmpty(val)) {
                            // getController(widget.type).text = '0';
                            // val = '0';
                          }
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(val);
                          // onIncrement(widget.type, increment: true);
                        }
                        validator(widget.type, val.toString());
                      },
                      textInputAction: widget.textInputAction,
                      keyboardType: getType(widget.type),
                      maxLines: widget.maxLine,
                      textAlignVertical: TextAlignVertical.top,
                      enabled: widget.isDatePicker! ? false : widget.allowEdit,
                      controller: getController(widget.type),
                      obscureText: widget.obscureText ?? widget.type == IZIInputType.PASSWORD && isVisible,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        contentPadding: widget.miniSize ? const EdgeInsets.all(12) : widget.contentPaddingIncrement,
                        isDense: true,
                        labelText: widget.isLegend == true ? widget.label : null,
                        labelStyle: TextStyle(
                          fontSize: focusNode!.hasFocus ? IZIDimensions.FONT_SIZE_H5 : IZIDimensions.FONT_SIZE_H6,
                          fontWeight: focusNode!.hasFocus ? FontWeight.w600 : FontWeight.normal,
                          color: ColorResources.BLACK,
                        ),
                        prefixIcon: widget.prefixIcon,
                        border: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false) ? ColorResources.LIGHT_GREY : ColorResources.LIGHT_GREY,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false) ? ColorResources.LIGHT_GREY : ColorResources.LIGHT_GREY,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false) ? ColorResources.LIGHT_GREY : ColorResources.LIGHT_GREY,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: widget.isBorder! || widget.isLegend!
                              ? widget.borderSide ??
                                  BorderSide(
                                    width: widget.borderSize ?? 1,
                                    color: (widget.allowEdit == false) ? ColorResources.LIGHT_GREY : ColorResources.LIGHT_GREY,
                                  )
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? IZIDimensions.BLUR_RADIUS_1X,
                          ),
                        ),
                        filled: true,
                        hintText: widget.placeHolder,
                        hintStyle: widget.hintStyle ??
                            TextStyle(
                              color: ColorResources.BLACK.withOpacity(0.5),
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            ),
                        fillColor: (widget.allowEdit == false) ? widget.fillColor ?? ColorResources.LIGHT_GREY.withOpacity(0.4) : widget.fillColor ?? ColorResources.WHITE,
                        suffixIcon: getSuffixIcon(),
                      ),
                    ),
                  ),
                ),
              ),
              if (IZIInputType.INCREMENT == widget.type)
                GestureDetector(
                  onTap: () {
                    if (!isDisibleIncrement) {
                      onIncrement(widget.type, increment: true);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(
                      IZIDimensions.ONE_UNIT_SIZE * 10,
                    ),
                    constraints: BoxConstraints(maxHeight: IZIDimensions.ONE_UNIT_SIZE * 80),
                    height: widget.height ?? IZIDimensions.ONE_UNIT_SIZE * 80,
                    width: widget.widthIncrement ?? IZIDimensions.ONE_UNIT_SIZE * 80,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: IZIOther().boxShadow,
                      border: widget.isBorder!
                          ? isDisibleIncrement
                              ? Border.all(
                                  color: widget.colorDisibleBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                                )
                              : Border.all(
                                  color: widget.colorBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                                )
                          : isDisibleIncrement
                              ? Border.all(
                                  color: widget.colorDisibleBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                                )
                              : Border.all(
                                  color: widget.colorBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                                ),
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_2X,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: isDisibleIncrement ? widget.colorDisibleBorder ?? ColorResources.GREY : widget.colorBorder ?? ColorResources.CIRCLE_COLOR_BG3,
                    ),
                  ),
                ),
            ],
          ),
          if (!widget.disbleError)
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
              alignment: Alignment.topLeft,
              child: Text(
                IZIValidate.nullOrEmpty(_errorText.toString()) ? "" : _errorText.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: ColorResources.RED,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
