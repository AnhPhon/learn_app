import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/transfers/transfers_confirm/transfers_confirm_controller.dart';

class ComponentConfirmPasswordDialog extends StatelessWidget {
  const ComponentConfirmPasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TransfersConfirmController(),
      builder: (TransfersConfirmController controller) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: IZIInput(
            type: IZIInputType.TEXT,
            placeHolder: "Nhập mật khẩu",
            borderRadius: IZIDimensions.BLUR_RADIUS_4X,
            textInputAction: TextInputAction.done,
            obscureText: true,
            prefixIcon: Icon(
              Icons.lock,
              size: IZIDimensions.ONE_UNIT_SIZE * 40,
              color: ColorResources.LIGHT_GREY,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                controller.onFingerprintUnlock();
              },
              child: Icon(
                Icons.fingerprint,
                size: IZIDimensions.ONE_UNIT_SIZE * 40,
                color: ColorResources.LIGHT_GREY,
              ),
            ),
            onChanged: (val){
              controller.password = val;
            },
          ),
        );
      },
    );
  }
}
