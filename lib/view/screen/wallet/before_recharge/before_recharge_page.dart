import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/wallet/before_recharge/before_recharge_controller.dart';

class BeforeRechargePage extends GetView<BeforeRechargeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BeforeRechargeController>(
      init: BeforeRechargeController(),
      builder: (controller) {
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //account balance
                _accountBalance(context, controller: controller),

                //box input
                _boxInput(context, controller: controller),

                const Spacer(),

                //btn recharge
                btnRecharge(context, controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ///account balance
  ///
  Widget _accountBalance(BuildContext context,
      {required BeforeRechargeController controller}) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //title
          Text(
            "Số dư tài khoản",
            style: Dimensions.fontSizeStyle18w600(),
          ),

          Row(
            children: [
              //icon
              GestureDetector(
                onTap: () => controller.setShow(),
                child: controller.isShow
                    ? const Icon(
                        Icons.visibility_off,
                        color: ColorResources.GREY,
                      )
                    : const Icon(
                        Icons.remove_red_eye,
                        color: ColorResources.GREY,
                      ),
              ),

              const SizedBox(
                width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
              ),

              //balance
              Text(
                ' ${(controller.isShow) ? PriceConverter.convertPrice(context, double.parse(controller.balance.toString())) : "*********"} vnđ',
                style: Dimensions.fontSizeStyle18w600(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///box input
  ///
  Widget _boxInput(BuildContext context,
      {required BeforeRechargeController controller}) {
    return BoxShadowWidget(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputWidget(
            label: "Nhập số tiền muốn nạp",
            hintText: "Số tiền (vnđ)",
            obligatory: true,
            textEditingController: controller.amountOfMoneyController,
            width: .85,
            thousandsSeparator: true,
            textInputType: TextInputType.number,
            fillColor: ColorResources.WHITE,
            // onChanged: (val) {
            //   controller.onChanged(context, val);
            // },
          ),
          const Label(
            label: "Hoặc chọn nhanh số tiền",
            obligatory: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3,
                crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                crossAxisCount: 3,
              ),
              itemCount: controller.optionList.length,
              itemBuilder: (BuildContext ctx, int index) {
                return GestureDetector(
                  onTap: () => controller.setIndexSelected(index: index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: (controller.indexSelected == index)
                          ? ColorResources.PRIMARY
                          : null,
                      borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                      ),
                      border: (controller.indexSelected == index)
                          ? null
                          : Border.all(color: ColorResources.GREY),
                    ),
                    child: Align(
                      child: Text(
                        controller.optionList[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: (controller.indexSelected == index)
                              ? ColorResources.WHITE
                              : ColorResources.BLACK,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///btn
  ///
  Widget btnRecharge(BuildContext context,
      {required BeforeRechargeController controller}) {
    return BtnCustom(
      onTap: () => controller.onBtnRechargeClick(),
      color: ColorResources.PRIMARY,
      text: "Tiếp tục",
      width: DeviceUtils.getScaledWidth(context, .9),
    );
  }
}
