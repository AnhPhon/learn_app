import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

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

                  return SizedBox(
                    height: (widget.infoCard[index]['input'] == true) ? 70 : 30,
                    width: DeviceUtils.getScaledWidth(context, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 7,
                          child: SizedBox(
                            width: DeviceUtils.getScaledWidth(context, .3),
                            child: Text("${widget.infoCard[index]['label']}:",
                                style: Dimensions.textNormalStyle()),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: DeviceUtils.getScaledWidth(context, .3),
                          child: SizedBox(
                            width: DeviceUtils.getScaledWidth(context, .7),
                            child: (widget.infoCard[index]['input'] == true)
                                ? TextField(
                                    onChanged: widget.onChanged,
                                    controller: widget.infoCard[index]
                                        ['controller'] as TextEditingController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Phí',
                                    ),
                                  )
                                : Text(
                                    "${(widget.infoCard[index]['controller'] != null) ? (widget.infoCard[index]['controller'] as TextEditingController).text : widget.infoCard[index]['value']}",
                                    style: (widget.infoCard[index]['input'] ==
                                            true)
                                        ? Dimensions.textInputNormalStyle()
                                        : Dimensions.textNormalStyle(),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
