import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v1-customer/account/wallet/before_recharge/before_recharge_controller.dart';

class V1BeforeRechargePage extends GetView<V1BeforeRechargeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1BeforeRechargeController>(
        init: V1BeforeRechargeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //account balance
                _accountBalance(controller: controller),

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
          );
        });
  }

  ///
  ///account balance
  ///
  Widget _accountBalance({required V1BeforeRechargeController controller}) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //title
          Text(
            "Số dư tài khoản",
            style: Dimensions.fontSizeStyle18(),
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
                ' ${(controller.isShow) ? controller.balance : "*********"} vnđ',
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
      {required V1BeforeRechargeController controller}) {
    return BoxShadowWidget(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputWidget(
            label: "Nhập số tiền muốn nạp",
            hintText: "Số tiền (vnđ)",
            textEditingController: controller.amountOfMoneyController,
            width: 1,
            thousandsSeparator: true,
            textInputType: TextInputType.number,
            onChanged: (val) {
              controller.onChanged(context, val);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(
              "Hoặc chọn nhanh số tiền",
              style: Dimensions.fontSizeStyle16(),
            ),
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
                        "${controller.optionList[index]}vnđ",
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
      {required V1BeforeRechargeController controller}) {
    return BtnCustom(
      onTap: () => controller.onBtnRechargeClick(),
      color: ColorResources.PRIMARY,
      text: "Tiếp tục",
      width: DeviceUtils.getScaledWidth(context, .9),
    );
  }
}
