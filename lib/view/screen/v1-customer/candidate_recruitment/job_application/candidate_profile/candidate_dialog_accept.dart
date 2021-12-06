import 'package:flutter/material.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';

class CandidateDialogAccept extends StatelessWidget {
  CandidateDialogAccept(
      {Key? key, required this.textContent, required this.price})
      : super(key: key);
  String? textContent;
  double? price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text(textContent.toString()),
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Center(
                    child: Text(
                        "${CurrencyConverter.currencyConverterVND(price!)} VNĐ",
                        style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                            color: ColorResources.RED)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
