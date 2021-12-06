// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

// ignore: must_be_immutable
class ContentWhiteBox extends StatefulWidget {
  final List<Map<String, dynamic>> infoCard;
  Function(String?)? onChanged;

  TextEditingController? textController;
  ContentWhiteBox({
    required this.infoCard,
    this.textController,
    this.onChanged,
  });

  @override
  State<ContentWhiteBox> createState() => _ContentWhiteBoxState();
}

class _ContentWhiteBoxState extends State<ContentWhiteBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(.4),
          )
        ],
      ),
      child: Column(
        children: widget.infoCard.isEmpty
            ? []
            : List.generate(
                widget.infoCard.length,
                (index) {
                  if (widget.infoCard[index]["input"] != false &&
                      widget.textController != null) {
                    widget.textController = TextEditingController(
                        text: widget.infoCard[index]['value'] as String);
                  }

                  if (widget.infoCard[index]['visible'] == true ||
                      widget.infoCard[index]['visible'] == null) {
                    return SizedBox(
                      height:
                          (widget.infoCard[index]['input'] == true) ? 70 : 30,
                      width: DeviceUtils.getScaledWidth(context, 1),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SizedBox(
                              width: DeviceUtils.getScaledWidth(context, .3),
                              child: Text("${widget.infoCard[index]['label']}:",
                                  style: Dimensions.textNormalStyle()),
                            ),
                          ),
                          Positioned(
                            bottom: (widget.infoCard[index]['input'] == true)
                                ? 20
                                : 7,
                            right: 0,
                            left: DeviceUtils.getScaledWidth(context, .3),
                            child: SizedBox(
                              width: DeviceUtils.getScaledWidth(context, .7),
                              child: (widget.infoCard[index]['input'] == true)
                                  ? TextField(
                                      inputFormatters: [
                                        CurrencyTextInputFormatter(locale: "vi")
                                      ],
                                      onChanged: widget.onChanged,
                                      keyboardType: TextInputType.number,
                                      controller: widget.infoCard[index]
                                              ['controller']
                                          as TextEditingController,
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderSide: BorderSide(
                                              color: ColorResources
                                                  .LIGHT_SKY_BLUE_HEIGHT),
                                        ),
                                        hintText: 'Phí',
                                        contentPadding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                      ),
                                    )
                                  : Text(
                                      "${(widget.infoCard[index]['controller'] != null) ? (widget.infoCard[index]['controller'] as TextEditingController).text : widget.infoCard[index]['value']}",
                                      style: (widget.infoCard[index]['input'] ==
                                              true)
                                          ? Dimensions.textInputNormalStyle()
                                          : widget.infoCard[index]["label"] !=
                                                  "Đơn giá"
                                              ? Dimensions.textNormalStyle()
                                              : const TextStyle(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: ColorResources.RED,
                                                ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
      ),
    );
  }
}
