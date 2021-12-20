import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/background/background_auth.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/voucher/voucher_controller.dart';

class VoucherPage extends GetView<VoucherController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAuth(),
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Voucher",
      ),
      body: GetBuilder(
        init: VoucherController(),
        builder: (VoucherController controller) {
          return Container(
            color: ColorResources.BACKGROUND,
            width: IZIDimensions.iziSize.width,
            child: IZIListView(
              itemCount: 10,
              builder: (index) {
                return IZICard(
                  marginCard: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  cardType: IZICardType.CARD_VOUCHER,
                  row1Left: "Mã giảm 50k trên giá món",
                  row2Left: "Điều kiện:\nƯu đãi có hạn",
                  row3Left: "Hạn sử dụng: 25/12/2021",
                  statusVoucher: IZIStatusvoucher.LABEL_GREEN,
                  labelStatusvoucher: "SL: 3000 lần ",
                  widgetVoucher: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.discountCode,
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_SPAN * .9,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.copyDiscountCode(
                            content: controller.discountCode,
                          );
                        },
                        child: Icon(
                          Icons.copy,
                          size: IZIDimensions.ONE_UNIT_SIZE * 20,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
