import 'package:flutter/material.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';

class BillWidget extends StatelessWidget {
  const BillWidget({
    Key? key,
    required this.orderContents,
    this.deposit,
    this.height,
    this.title,
    this.isHasDeposit = true,
  }) : super(key: key);
  final List<Widget> orderContents;
  final double? deposit;
  final double? height;
  final String? title;
  final bool? isHasDeposit;
  @override
  Widget build(BuildContext context) {
    return BoxShadowWidget(
      child: Container(
          height: height ?? DeviceUtils.getScaledHeight(context, 0.7),
          width: DeviceUtils.getScaledHeight(context, 1),
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius:
                BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            //boxShadow: boxShadow
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  child: Text(
                    title ?? "Thông tin đơn hàng",
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: ColorResources.BLACK,
                    ),
                    child: Column(
                      children: [...orderContents],
                    ),
                  ),
                ),
                if (isHasDeposit!)
                  const Divider(
                    thickness: 2,
                  ),
                if (isHasDeposit!)
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text:
                                "Tiền đặt cọc đơn hàng sẽ được khấu trừ khi thanh toán tổng giá trị đơn hàng. Trường hợp bên cung cấp dịch vụ đã di chuyển đến nơi mà khách hủy đơn thì khách sẽ bị mất tiền cọc và phí dịch vụ:",
                            style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              color: ColorResources.BLACK,
                            ),
                          ),
                          if (deposit != null)
                            TextSpan(
                              text:
                                  " ${CurrencyConverter.currencyConverterVND(deposit!)} VNĐ",
                              style: const TextStyle(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color: ColorResources.RED,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                // if (deposit != null && isHasDeposit!)
              ],
            ),
          )),
    );
  }
}
