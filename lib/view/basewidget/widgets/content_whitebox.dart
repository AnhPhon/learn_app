import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/dimensions.dart';

class ContentWhiteBox extends StatefulWidget {
  final List<Map<String, dynamic>> infoCard;
  TextEditingController? textController;
  ContentWhiteBox({required this.infoCard, this.textController});

  @override
  State<ContentWhiteBox> createState() => _ContentWhiteBoxState();
}

class _ContentWhiteBoxState extends State<ContentWhiteBox> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Row(
                      children: [
                        Text(
                          "${widget.infoCard[index]['label']}:",
                          style: Dimensions.textNormalStyle(),
                        ),
                        Text(
                          "${widget.infoCard[index]['value']}",
                          style: (widget.infoCard[index]['label']
                                      .toString()
                                      .toLowerCase() ==
                                  "đơn giá")
                              ? Dimensions.textInputNormalStyle()
                              : Dimensions.textNormalStyle(),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
