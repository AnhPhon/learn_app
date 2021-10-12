import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/dimensions.dart';

class ContentWhiteBox extends StatelessWidget {
  final List<Map<String, dynamic>> infoCard;
  TextEditingController? textController;
  ContentWhiteBox({required this.infoCard, this.textController});

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
        children: infoCard.isEmpty
            ? []
            : List.generate(
                infoCard.length,
                (index) {
                  if (infoCard[index] != null) {
                    if (infoCard[index]["input"] == false ||
                        textController != null) {
                      textController = TextEditingController(
                          text: infoCard[index]['value'] as String);
                    }

                    return Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Row(
                        children: [
                          Text(
                            "${infoCard[index]['label']}:",
                            style: Dimensions.textNormalStyle(),
                          ),
                          Text(
                            "${infoCard[index]['value']}",
                            style: (infoCard[index]['label']
                                        .toString()
                                        .toLowerCase() ==
                                    "đơn giá")
                                ? Dimensions.textInputNormalStyle()
                                : Dimensions.textNormalStyle(),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
      ),
    );
  }
}
