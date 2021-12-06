import 'package:flutter/material.dart';
import 'package:template/data/model/response/chi_tiet_cong_viec_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v1-customer/services/components/order_content_string_value.dart';

class WorkCard extends StatelessWidget {

  final double? topPading;
  final double? bottomPading;
  final double? leftPading; 
  final double? rightPading;
  final ChiTietCongViecResponse work;
  final Function? onDelete;
  const WorkCard({
    Key? key,
    this.topPading = Dimensions.PADDING_SIZE_EXTRA_SMALL,
    this.bottomPading = 0,
    this.leftPading = Dimensions.PADDING_SIZE_DEFAULT,
    this.rightPading = Dimensions.PADDING_SIZE_DEFAULT,
    required this.work,
    this.onDelete
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (onDelete != null)
            GestureDetector(
              onTap: (){
                onDelete!();
              },
              child: const Icon(
                Icons.cancel,
                color: ColorResources.RED,
              ),
            )
            else
            const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
              child: Container(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    OrderContentStringValue(
                      title: "Tên công việc: ",
                      value: work.tenCongViec!,
                      boldTitle: true,
                      padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_SMALL,
                        right: Dimensions.PADDING_SIZE_SMALL,
                        top: Dimensions.PADDING_SIZE_EXTRA_SMALL
                      ),
                    ),
                    OrderContentStringValue(
                      title: "Quy cách: ",
                      value: work.quyCach!,
                      boldTitle: true,
                      padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_SMALL,
                        right: Dimensions.PADDING_SIZE_SMALL,
                        top: Dimensions.PADDING_SIZE_EXTRA_SMALL
                      ),
                    ),
                    OrderContentStringValue(
                      title: "Khối lượng: ",
                      value: work.soLuong!,
                      boldTitle: true,
                      padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_SMALL,
                        right: Dimensions.PADDING_SIZE_SMALL,
                        top: Dimensions.PADDING_SIZE_EXTRA_SMALL
                      ),
                    ),
                    OrderContentStringValue(
                      title: "Đơn vị: ",
                      value: work.donVi!,
                      boldTitle: true,
                      padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_SMALL,
                        right: Dimensions.PADDING_SIZE_SMALL,
                        top: Dimensions.PADDING_SIZE_EXTRA_SMALL
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
