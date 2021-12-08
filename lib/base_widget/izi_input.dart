import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';

import 'package:template/helper/izi_validate.dart';
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

  @override
  _IZIInputState createState() => _IZIInputState();
}

class _IZIInputState extends State<IZIInput> {
  final focusNode = FocusNode();
  final textEditingController = TextEditingController();
  final numberEditingController = MaskedTextController(mask: "000.000.000.000.000.000.000.000.000.000", translator: {'0': RegExp(r'[0-9]')});
  final doubleEditingController = MoneyMaskedTextController(
    precision: 1,
  );

  bool isShowedError = false;
  bool isVisible = false;
  String? _errorText = "";

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
    }
    return TextInputType.text;
  }

  TextEditingController getController(IZIInputType type) {
    if (type == IZIInputType.NUMBER) {
      return numberEditingController;
    } else if (type == IZIInputType.PASSWORD) {
      return textEditingController;
    } else if (type == IZIInputType.PRICE) {
      return numberEditingController;
    } else if (type == IZIInputType.TEXT) {
      return textEditingController;
    } else if (type == IZIInputType.EMAIL) {
      return textEditingController;
    } else if (type == IZIInputType.PHONE) {
      return textEditingController;
    } else if (type == IZIInputType.DOUBLE) {
      return doubleEditingController;
    }
    return textEditingController;
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
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!focusNode.hasListeners) {
      focusNode.addListener(() {
        setState(() {});
      });
    }
    if (!IZIValidate.nullOrEmpty(widget.errorText) && IZIValidate.nullOrEmpty(_errorText)) {
      _errorText = widget.errorText.toString();
    }
    return Container(
      width: widget.width ?? IZIDevice.getScaledWidth(context, 1),
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
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
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
          Container(
            height: widget.miniSize ? 45 : null,
            child: TextFormField(
              onFieldSubmitted: widget.onSubmitted,
              onChanged: (val) {
                isShowedError = true;
                if (widget.type == IZIInputType.NUMBER || widget.type == IZIInputType.DOUBLE) {
                  if (IZIValidate.nullOrEmpty(val)) {
                    // getController(widget.type).text = '0';
                    val = '0';
                  }
                }
                if (widget.onChanged != null) {
                  widget.onChanged!(val);
                }
                if (checkValidate(widget.type) != null && isShowedError) {
                  setState(() {
                    _errorText = checkValidate(widget.type)!(val.toString());
                  });
                  if (widget.isValidate != null) {
                    widget.isValidate!(IZIValidate.nullOrEmpty(_errorText));
                  }
                }
              },
              textInputAction: widget.textInputAction,
              keyboardType: getType(widget.type),
              maxLines: widget.maxLine,
              textAlignVertical: TextAlignVertical.top,
              enabled: widget.allowEdit,
              controller: getController(widget.type),
              obscureText: widget.type == IZIInputType.PASSWORD && isVisible,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: widget.miniSize ? const EdgeInsets.all(12) : null,
                isDense: true,
                labelText: widget.isLegend == true ? widget.label : null,
                labelStyle: TextStyle(fontSize: focusNode.hasFocus ? IZIDimensions.FONT_SIZE_H4 : IZIDimensions.FONT_SIZE_SPAN, fontWeight: focusNode.hasFocus ? FontWeight.w600 : FontWeight.normal, color: ColorResources.BLACK),
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
                suffixIcon: widget.type == IZIInputType.PRICE
                    ? SizedBox.shrink(
                        child: Padding(
                          padding: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_1X),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("VNĐ"),
                          ),
                        ),
                      )
                    : (widget.type == IZIInputType.PASSWORD
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                          )
                        : const SizedBox.shrink()),
              ),
            ),
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
