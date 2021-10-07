
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/order_content.dart';

class BillWidget extends StatelessWidget {
  const BillWidget({
    Key? key,
    required this.orderContents,
    this.deposit,
    this.height,
    this.title,
    this.isHasDeposit = true,
  }) : super(key: key);
  final List<OrderContent> orderContents;
  final String? deposit;
  final double? height;
  final String? title;
  final bool? isHasDeposit;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)
      ),
      child: Container(
        height: height ?? DeviceUtils.getScaledHeight(context, 0.6),
        width:  DeviceUtils.getScaledHeight(context,1),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          //boxShadow: boxShadow
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(title ?? "Thông tin đơn hàng", style:const TextStyle(
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
              if(isHasDeposit!)
              const Divider(
                thickness: 2,
              ),
              if(isHasDeposit!)
              const Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Text("Đặt cọc đơn hàng (Chỉ đặt cọc nếu chưa thanh toán đơn hàng. "
                "Tiền này sẽ được khấu trừ khi thanh toán đơn hàng. Trường hợp thợ đã di "
                "chuyển đến nơi làm việc mà Khách hủy đơn  thì Khách sẽ bị mất tiền cọc):",
                textAlign: TextAlign.center,style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE
                ),),
              ),
              if(deposit != null && isHasDeposit!)
              Text("$deposit VNĐ", style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                color: ColorResources.RED,
                fontWeight: FontWeight.bold,
              )),
            ],
          ),
        )
      ),
    );
  }
}
