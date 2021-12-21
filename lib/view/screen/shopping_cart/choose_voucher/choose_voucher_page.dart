import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/shopping_cart/choose_voucher/choose_voucher_controller.dart';

class ChooseVoucherPage extends GetView<ChooseVoucherController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: IZIScreen(
        isSingleChildScrollView: false,
        background: const BackgroundAccount(),
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
          title: "Chọn Voucher",
        ),
        body: GetBuilder(
          init: ChooseVoucherController(),
          builder: (ChooseVoucherController controller) {
            return Container(
              constraints: BoxConstraints(
                minHeight: IZIDimensions.iziSize.height,
                minWidth: IZIDimensions.iziSize.width,
              ),
              decoration: const BoxDecoration(
                color: ColorResources.BACKGROUND,
              ),
              padding: EdgeInsets.symmetric(
                vertical: IZIDimensions.SPACE_SIZE_4X,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IZIInput(
                          width: IZIDimensions.iziSize.width * .62,
                          type: IZIInputType.TEXT,
                          placeHolder: "Nhập mã voucher, gift code",
                          disbleError: true,
                        ),
                        IZIButton(
                          margin: const EdgeInsets.all(0),
                          borderRadius: IZIDimensions.BORDER_RADIUS_3X,
                          padding: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_3X,
                          ),
                          width: IZIDimensions.iziSize.width * .25,
                          onTap: () {},
                          label: "Áp dụng",
                          colorBG: ColorResources.RED,
                          isEnabled: true,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: Text(
                      "Rất tiếc! Không thể tìm thấy mã Voucher này.\nBạn vui lòng kiểm tra lại mã và hạn sử dụng nhé",
                      style: TextStyle(
                        color: ColorResources.RED,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      0,
                      IZIDimensions.SPACE_SIZE_1X,
                      0,
                      IZIDimensions.SPACE_SIZE_1X,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: IZIDimensions.SPACE_SIZE_2X,
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    color: ColorResources.LIGHT_YELLOW.withOpacity(.6),
                    child: Text(
                      "Chọn  sản phẩm trong giỏ hàng trước khi chọn áp dụng Voucher nhé!",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.BLACK,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: IZIDimensions.iziSize.width,
                      child: IZISmartRefresher(
                        isLoading: false,
                        onLoading: controller.onLoading,
                        enablePullDown: true,
                        onRefresh: controller.onRefresh,
                        refreshController: controller.refreshController,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return IZICard(
                              marginCard: EdgeInsets.symmetric(
                                vertical: IZIDimensions.SPACE_SIZE_2X,
                                horizontal: IZIDimensions.SPACE_SIZE_4X,
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
                              widgetVouche2: Checkbox(
                                activeColor: ColorResources.CIRCLE_COLOR_BG,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    IZIDimensions.BORDER_RADIUS_1X,
                                  ),
                                ),
                                value: controller.isCheckBox,
                                onChanged: (val) {
                                  controller.onChanged(index, val: val!);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: IZIDimensions.iziSize.height * .15,
                  ),
                ],
              ),
            );
          },
        ),
        widgetBottomSheet: Container(
          height: IZIDimensions.iziSize.height * .18,
          width: IZIDimensions.iziSize.width,
          color: ColorResources.BACKGROUND,
          padding: EdgeInsets.fromLTRB(
            IZIDimensions.SPACE_SIZE_4X,
            0,
            IZIDimensions.SPACE_SIZE_4X,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_1X,
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                    ),
                    children: const [
                      TextSpan(
                        text: "2 Voucher đã được chọn. ",
                        style: TextStyle(
                          color: ColorResources.RED,
                        ),
                      ),
                      TextSpan(
                        text: "Đã chọn giảm 30% và mã giảm giá 50k",
                        style: TextStyle(
                          color: ColorResources.BLACK,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              Container(
                child: IZIButton(
                  onTap: () {},
                  label: "Xác nhận",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
