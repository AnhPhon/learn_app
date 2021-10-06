

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/components/order_content.dart';

class BillWidget extends StatelessWidget {
  const BillWidget({
    Key? key,
    required this.orderContents,
    required this.deposit,
    this.height,
  }) : super(key: key);
  final List<OrderContent> orderContents;
  final String deposit;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? DeviceUtils.getScaledHeight(context, 0.6),
      width:  DeviceUtils.getScaledHeight(context,1),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 8
          )
        ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text("Thông tin đơn hàng", style:TextStyle(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                fontWeight: FontWeight.bold
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK
                ),
                child: Column(
                  children: [
                    ...orderContents
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            const Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Text("Đặt cọc đơn hàng (Chỉ đặt cọc nếu chưa thanh toán đơn hàng. "
              "Tiền này sẽ được khấu trừ khi thanh toán đơn hàng. Trường hợp thợ đã di "
              "chuyển đến nơi làm việc mà Khách hủy đơn  thì Khách sẽ bị mất tiền cọc):",
              textAlign: TextAlign.center,style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE
              ),),
            ),
            Text("$deposit VNĐ", style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              color: ColorResources.RED,
              fontWeight: FontWeight.bold,
            )),
          ],
        ),
      )
    );
  }
}
