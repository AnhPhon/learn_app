import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account_management/account_management_controller.dart';

class AccountManagementPage extends GetView<AccountManagementController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundHome(),
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
        title: "Quản lý tài khoản",
      ),
      body: GetBuilder(
        init: AccountManagementController(),
        builder: (AccountManagementController controller) {
          return Container(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            margin: EdgeInsets.only(
              top: IZIDimensions.SPACE_SIZE_3X,
            ),
            decoration: BoxDecoration(
              color: ColorResources.BACKGROUND,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  IZIDimensions.BLUR_RADIUS_5X * 1.5,
                ),
                topRight: Radius.circular(
                  IZIDimensions.BLUR_RADIUS_5X * 1.5,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Column(
              children: [
                //Ví của tôi
                _myWallet(controller),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_5X * 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Button nạp tiền
                      _btnRecharge(controller),

                      //Button rút tiền
                      _btnWithdrawal(controller),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          child: Text(
                            "Lịch sử giao dịch",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.w600,
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                            ),
                          ),
                        ),

                        //Card lịch sử giao dịch
                        _cardTransactionJistory()
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  ///Card lịch sử giao dịch
  ///
  Expanded _cardTransactionJistory() {
    return Expanded(
      child: IZISmartRefresher(
        isLoading: false,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        refreshController: controller.refreshController,
        enablePullDown: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return IZICard(
              marginCard: EdgeInsets.fromLTRB(
                IZIDimensions.SPACE_SIZE_2X,
                0,
                IZIDimensions.SPACE_SIZE_2X,
                IZIDimensions.SPACE_SIZE_3X,
              ),
              cardType: IZICardType.CARD_PAYMENT,
              row1Left: "2123123FGS4312",
              row1Right: "500.000",
              row2Left: "Thanh toán đơn hàng ĐH001",
              row3Left: "26/09/2021 15:30",
              //TODO: Rap trạng thái card lịch sử giao dịch ở đây
              statusMoney: IZIStatusMoney.RECHARGE,
              statusPayment: IZIStatusPayment.DONE,
            );
          },
        ),
      ),
    );
  }

  ///
  ///Button rút tiền
  ///
  IZIButton _btnWithdrawal(AccountManagementController controller) {
    return IZIButton(
      withBorder: IZIDimensions.ONE_UNIT_SIZE * 3,
      margin: const EdgeInsets.all(0),
      borderRadius: IZIDimensions.BORDER_RADIUS_3X,
      isEnabled: controller.isEnableButton,
      onTap: () {
        controller.goToWithdrawal();
      },
      label: "Rút tiền",
      colorBG: ColorResources.RED,
      color: ColorResources.RED,
      type: IZIButtonType.OUTLINE,
      imageUrlIcon: ImagesPath.draw,
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
    );
  }

  ///
  /// Button nạp tiền
  ///
  Widget _btnRecharge(AccountManagementController controller) {
    return IZIButton(
      withBorder: IZIDimensions.ONE_UNIT_SIZE * 3,
      margin: const EdgeInsets.all(0),
      borderRadius: IZIDimensions.BORDER_RADIUS_3X,
      isEnabled: controller.isEnableButton,
      onTap: () {
        controller.goToRecharge();
      },
      label: "Nạp tiền",
      colorBG: ColorResources.CIRCLE_COLOR_BG,
      color: ColorResources.CIRCLE_COLOR_BG,
      type: IZIButtonType.OUTLINE,
      imageUrlIcon: ImagesPath.reCharge,
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
    );
  }

  ///
  /// Ví của tôi
  ///
  Widget _myWallet(AccountManagementController controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        IZIDimensions.SPACE_SIZE_2X,
        IZIDimensions.SPACE_SIZE_1X,
        IZIDimensions.SPACE_SIZE_2X,
        0,
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Ví của tôi ",
                  style: TextStyle(
                    color: ColorResources.BLACK,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: controller.obscure == false
                        ? () {
                            controller.onChangedNoVisible();
                          }
                        : () {
                            controller.onChangedIsVisible();
                          },
                    child: Icon(
                      controller.obscure == true ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: IZIDimensions.ONE_UNIT_SIZE * 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_3X,
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Center(
              //Số dư ví
              child: Text(
                controller.obscure == false ? "${IZIPrice.currencyConverterVND(double.parse(controller.accountBalance.toString()))} VNĐ" : controller.obscureCharacters,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
