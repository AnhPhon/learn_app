import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

import 'package:template/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:template/view/screen/v4-employee/account/component/v4_small_button.dart';

class V4AccountController extends GetxController {
  //khai báo isLoading
  bool isLoading = true;

  //Khai báo tên
  String title = "IZI Software";

  //Khai email
  String email = "IZISoftware@gmail.com";

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  ///
  ///Click to personal information
  ///
  void onClickToInformation() {
    Get.toNamed(AppRoutes.V4_INFO);
  }

  ///
  ///Click to Salary Page
  ///
  void onClickToSalarypage() {
    Get.defaultDialog(
      title: 'Vui lòng nhập mật khẩu để tiếp tục',
      backgroundColor: ColorResources.HOME_BG,
      radius: Dimensions.BORDER_RADIUS_SMALL,
      titlePadding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_LARGE,
        left: Dimensions.PADDING_SIZE_LARGE,
        right: Dimensions.PADDING_SIZE_LARGE,
      ),
      content: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          //Input Password
          const CustomPasswordTextField(),

          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_DEFAULT,
              left: Dimensions.PADDING_SIZE_SMALL,
              right: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Button Cancel
                _btnCancel(),

                //Button Confirm
                _btnConfirm(),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///
  ///Click to Rules Page
  ///
  void onClickToRulesPage() {
    Get.toNamed(AppRoutes.V4_RULES);
  }

  ///
  /// Button Cancel
  ///
  Widget _btnCancel() {
    return V4SmallButton(
      color: ColorResources.RED,
      onPressed: () {
        Get.back();
      },
      title: 'Hủy',
    );
  }

  ///
  ///Button Confirm
  ///
  Widget _btnConfirm() {
    return V4SmallButton(
      color: ColorResources.PRIMARY,
      onPressed: () {
        Get.toNamed(AppRoutes.V4_SALARY);
      },
      title: 'Xác nhận',
    );
  }
}
