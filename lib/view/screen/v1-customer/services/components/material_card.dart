import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';

class MaterialCard extends StatelessWidget {

  final double? topPading;
  final double? bottomPading;
  final double? leftPading; 
  final double? rightPading;
  const MaterialCard({
    Key? key,
    this.topPading = Dimensions.PADDING_SIZE_DEFAULT,
    this.bottomPading = 0,
    this.leftPading = Dimensions.PADDING_SIZE_DEFAULT,
    this.rightPading = Dimensions.PADDING_SIZE_DEFAULT,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPading!,
        right: rightPading!,
        top: topPading!,
      ),
      child: Material(
        type: MaterialType.card,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Container(
          padding: paddingSmall,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TextHighlight(
                title: "Tên công việc: ",
                content: "Lát gạch phòng ngủ 600*600",
              ),
              TextHighlight(
                title: "Quy cách: ",
                content: "Dùng keo, gạch thạch bàn mã TB123",
              ),
              TextHighlight(
                title: "Khối lượng: ",
                content: "20",
              ),
              TextHighlight(
                title: "Đơn vị: ",
                content: "m2",
              ),
            ],
          ),
        ),
      ),
    );
  }

}
