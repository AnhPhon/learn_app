import 'package:flutter/material.dart';
import 'package:template/data/model/response/vat_tu_response.dart';

import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/services/components/order_content_string_value.dart';

class MaterialCard extends StatelessWidget {

  final double? topPading;
  final double? bottomPading;
  final double? leftPading; 
  final double? rightPading;
  final VatTuResponse mass;
  const MaterialCard({
    Key? key,
    this.topPading = Dimensions.PADDING_SIZE_DEFAULT,
    this.bottomPading = 0,
    this.leftPading = Dimensions.PADDING_SIZE_DEFAULT,
    this.rightPading = Dimensions.PADDING_SIZE_DEFAULT,
    required this.mass,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPading!,
        right: rightPading!,
        top: topPading!,
      ),
      child: BoxShadowWidget(
        child: Container(
          padding: paddingSmall,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              OrderContentStringValue(
                title: "Tên công việc: ",
                value: mass.tenVatTu!,
                boldTitle: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL
                ),
              ),
              OrderContentStringValue(
                title: "Quy cách: ",
                value: mass.quyCach!,
                boldTitle: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL
                ),
              ),
              OrderContentStringValue(
                title: "Khối lượng: ",
                value: mass.donGia!,
                boldTitle: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL
                ),
              ),
              OrderContentStringValue(
                title: "Đơn vị: ",
                value: mass.donVi!,
                boldTitle: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
