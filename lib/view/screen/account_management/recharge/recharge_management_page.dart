import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account_management/recharge/recharge_controller.dart';

class RechargePage extends GetView<RechargeController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: IZIScreen(
        background: const BackgroundAccount(),
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
          title: "Nạp tiền",
        ),
        body: GetBuilder(
          init: RechargeController(),
          builder: (RechargeController controller) {
            return Stack(
              children: [
                Container(
                  width: IZIDimensions.iziSize.width,
                  // height: IZIDimensions.iziSize.height,
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
                      //Card nạp tiền
                      _cardRecharge(controller),

                      //Nguồn nạp tiền
                      _rechargeSource(),

                      //Button nạp tiền
                      Container(
                        margin: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_5X * 2,
                        ),
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: IZIButton(
                          label: "Nạp tiền",
                          maxLine: 1,
                          onTap: () {
                            controller.goToBankStransfer();
                          },
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
  ///Nguồn nạp tiền
  ///
  Widget _rechargeSource() {
    return Container(
      padding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
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
            ),
            child: Text(
              "NGUỒN NẠP",
              style: TextStyle(
                color: ColorResources.BLACK,
                fontSize: IZIDimensions.FONT_SIZE_H6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: IZICard(
              heightCard: IZIDimensions.ONE_UNIT_SIZE * 70,
              widthCard: IZIDimensions.ONE_UNIT_SIZE * 70,
              urlImage: ImagesPath.logoMomo,
              cardType: IZICardType.CARD_CAPITAL_CONTRIBUTION,
              row1Left: "Ví Momo",
              row2Left: "Miễn phí thanh toán",
              groupValue: controller.groupValue,
              valRadio: 1,
              onChanged: (val) {
                controller.onChangedRadio(val as int);
              },
            ),
          ),
          Container(
            child: IZICard(
              heightCard: IZIDimensions.ONE_UNIT_SIZE * 70,
              widthCard: IZIDimensions.ONE_UNIT_SIZE * 70,
              icon: Icons.account_balance_outlined,
              cardType: IZICardType.CARD_CAPITAL_CONTRIBUTION,
              row1Left: "Chuyển khoản ngân hàng",
              groupValue: controller.groupValue,
              valRadio: 2,
              onChanged: (val) {
                controller.onChangedRadio(val as int);
              },
              colorIcon: ColorResources.BLACK,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///Card nạp tiền
  ///
  Widget _cardRecharge(RechargeController controller) {
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
        vertical: IZIDimensions.SPACE_SIZE_5X * 1.3,
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
            child: controller.moneyDraw
            // IZIInput(
            //   disbleError: true,
            //   borderSize: 2,
            //   isLegend: true,
            //   label: "Số tiền cần rút",
            //   isBorder: true,
            //   min: 0,
            //   type: IZIInputType.PRICE,
            //   onChanged: (val) {
            //     controller.withdrawalAmount = val;
            //     print(controller.withdrawalAmount);
            //   },
            // ),
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
