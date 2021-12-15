import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/account_management/withdrawal/withdrawal_controller.dart';

class WithdrawalPage extends GetView<WithdrawalController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: IZIScreen(
        background: const BackgroundHome(),
        appBar: IZIAppBar(
          iconBack: GestureDetector(
            onTap: () {
              Get.back(
                result: true,
              );
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.WHITE,
            ),
          ),
          title: "Rút tiền",
        ),
        body: GetBuilder(
          init: WithdrawalController(),
          builder: (WithdrawalController controller) {
            return Stack(
              children: [
                Container(
                  width: IZIDimensions.iziSize.width,
                  height: IZIDimensions.iziSize.height - IZIDimensions.iziSize.width * 0.4,
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
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      //Thông tin người nhận
                      _cardWithdrawal(controller),

                      //Card rút tiền
                      _receiverInformation(),

                      //Button Rút tiền
                      Container(
                        margin: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: IZIButton(
                          label: "Rút tiền",
                          maxLine: 1,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  ///
  ///Thông tin người nhận
  ///
  Widget _receiverInformation() {
    return Container(
      padding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_3X,
              top: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Text(
              "THÔNG TIN TÀI KHOẢN NGƯỜI NHẬN",
              style: TextStyle(
                color: ColorResources.BLACK,
                fontSize: IZIDimensions.FONT_SIZE_H6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IZIInput(
            placeHolder: "Chủ tài khoản",
            label: "Chủ tài khoản",
            isRequired: true,
            type: IZIInputType.TEXT,
            textInputAction: TextInputAction.next,
          ),
          IZIInput(
            placeHolder: "Số tài khoản",
            label: "Số tài khoản",
            isRequired: true,
            type: IZIInputType.TEXT,
            textInputAction: TextInputAction.next,
          ),
          IZIInput(
            placeHolder: "Tên ngân hàng",
            label: "Tên ngân hàng",
            isRequired: true,
            type: IZIInputType.TEXT,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  ///
  ///Card rút tiền
  ///
  Widget _cardWithdrawal(WithdrawalController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      width: IZIDimensions.iziSize.width,
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BLUR_RADIUS_5X * 1.3,
        ),
        boxShadow: IZIOther().boxShadow,
      ),
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_5X * 1.2,
        horizontal: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                IZIDimensions.BORDER_RADIUS_2X,
              ),
              color: ColorResources.GREY.withOpacity(.4),
            ),
            width: IZIDimensions.iziSize.width * .75,
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_balance_wallet_rounded,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: IZIDimensions.ONE_UNIT_SIZE * 4,
                  ),
                  child: Text(
                    "Số dư: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_1X,
                      vertical: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Center(
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
                ),
                GestureDetector(
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
                )
              ],
            ),
          ),
          Container(
            width: IZIDimensions.iziSize.width * .75,
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: IZIInput(
              disbleError: true,
              borderSize: 2,
              isLegend: true,
              label: "Số tiền cần rút",
              isBorder: true,
              min: 0,
              type: IZIInputType.PRICE,
              onChanged: (val) {
                controller.withdrawalAmount = val;
                print(controller.withdrawalAmount);
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(controller.defaultAmountList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.setDefaultAmount(index: index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.BLUR_RADIUS_2X,
                        ),
                        border: Border.all(
                          color: ColorResources.BLACK.withOpacity(.7),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: IZIDimensions.SPACE_SIZE_2X,
                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: Text(
                        controller.defaultAmountList[index].toString(),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
