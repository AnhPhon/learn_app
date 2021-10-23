import 'package:flutter/material.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class PaymentDialogAccept extends StatelessWidget {
  PaymentDialogAccept(
      {Key? key,
      required this.textContent,
      required this.price,
      this.isShowPrice = true})
      : super(key: key);
  String? textContent;
  double? price;
  bool isShowPrice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Text(textContent.toString())),
                if (isShowPrice)
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
                else
                  Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
