import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/transfers/transfers_confirm/transfers_confirm_controller.dart';

class ComponentMoneyTransferConfirmDialog extends StatelessWidget {
  const ComponentMoneyTransferConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TransfersConfirmController(),
      builder: (TransfersConfirmController controller) {
        return Column(
          children: [
            content(
              controller: controller,
            ),
            otpInput(
              controller: controller,
            ),
            IZIButton(
              isEnabled: controller.isCountDown,
              padding: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_3X,
              ),
              width: IZIDimensions.ONE_UNIT_SIZE * 190,
              onTap: () {
                controller.onTapMoneyTransferConfirm();
              },
              label: "Xác nhận",
            ),
          ],
        );
      },
    );
  }

  Widget content({required TransfersConfirmController controller}) {
    return IZIText(
      text: controller.contentMoneyTransfers,
      maxLine: 4,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_H6,
      ),
    );
  }

  Widget otpInput({required TransfersConfirmController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: IZIInput(
        type: IZIInputType.TEXT,
        placeHolder: "Nhập mã otp",
        hintStyle: TextStyle(color: ColorResources.BLACK.withOpacity(0.7)),
        borderRadius: IZIDimensions.BLUR_RADIUS_4X,
        fillColor: ColorResources.LIGHT_GREY.withOpacity(0.3),
        textInputAction: TextInputAction.done,
        suffixIcon: GestureDetector(
          onTap: () {
            controller.onFingerprintUnlock();
          },
          child: GestureDetector(
            onTap: () {
              controller.sendAgainOtp();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_3X,
              ),
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(color: ColorResources.WHITE, shape: BoxShape.circle),
              height: IZIDimensions.ONE_UNIT_SIZE * 40,
              width: IZIDimensions.ONE_UNIT_SIZE * 40,
              child: Text(
                controller.isCountDown ? "${(controller.count ~/ 60) > 0 ? '${controller.count ~/ 60}:' : ''}${controller.count.toInt() % 60}s" : 'Gưi lại',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
