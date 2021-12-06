import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/data/model/request/nhan_vien_request.dart';
import 'package:template/data/model/response/nhan_vien_response.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/nhan_vien_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';

import 'package:template/view/screen/v4-employee/account/component/v4_small_button.dart';

class V4AccountController extends GetxController {
  GetIt sl = GetIt.instance;

  AuthProvider authProvider = GetIt.I.get<AuthProvider>();

  //Nhân viên
  NhanVienProvider nhanVienProvider = GetIt.I.get<NhanVienProvider>();
  NhanVienResponse nhanVienResponse = NhanVienResponse();
  NhanVienRequest nhanVienRequest = NhanVienRequest();

  //user id
  String idUser = "";

  //Email
  String email = "";

  //khai báo isLoading
  bool isLoading = true;

  //Khai báo isloadingImage
  bool isLoadingImage = true;
  final passwordController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAccountInformation();
    getUsername();
  }

  void getAccountInformation() {
    sl.get<SharedPreferenceHelper>().userId.then(
      (userId) {
        //get User Id
        idUser = userId!;

        //Get thông tin nhân viên theo id
        nhanVienProvider.find(
          id: idUser,
          onSuccess: (value) {
            nhanVienResponse = value;

            isLoading = false;
            isLoadingImage = false;
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      },
    );
  }

  ///
  ///Get Usename Nhân viên
  ///
  void getUsername() {
    sl.get<SharedPreferenceHelper>().username.then((value) {
      email = value!;
      print("uername $value");
    });
  }

  ///
  ///Click to personal information
  ///
  void onClickToInformation() {
    Get.toNamed(AppRoutes.V4_INFO)!.then((value) {
      if (value == true) {
        getAccountInformation();
      }
      print(value);
      update();
    });
  }

  ///
  ///Click to Salary Page
  ///
  void onClickToSalarypage(BuildContext context) {
    Get.defaultDialog(
      titleStyle: Dimensions.fontSizeStyle16w600(),
      title: 'Vui lòng nhập mật khẩu để tiếp tục',
      backgroundColor: ColorResources.HOME_BG,
      radius: Dimensions.BORDER_RADIUS_SMALL,
      titlePadding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_LARGE,
        left: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        right: Dimensions.PADDING_SIZE_EXTRA_LARGE,
      ),
      content: Column(
        children: [
          //Input Password
          Container(
            margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_DEFAULT),
            width: DeviceUtils.getScaledWidth(context, 0.7),
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: DeviceUtils.getScaledWidth(context, 0.7),
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            color: ColorResources.BLACK.withAlpha(40),
                          )
                        ]),
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      top: 13,
                      bottom: 7,
                    ),
                    child: TextField(
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      textAlignVertical: TextAlignVertical.center,
                      controller: passwordController,
                      cursorColor: ColorResources.PRIMARY,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Nhập mật khẩu",
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    )),
              ],
            ),
          ),

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
      onPressed: () => onLogin(),
      title: 'Xác nhận',
    );
  }

  ///
  /// Validate login
  ///
  bool onValidateLogin() {
    //validate infomation username password
    if (passwordController.text == '') {
      IZIAlert.info(message: "Vui lòng điền mật khẩu");
      return false;
    }
    return true;
  }

  ///
  /// Đăng nhập để xem bảng lương
  ///
  void onLogin() {
    if (onValidateLogin()) {
      EasyLoading.show(status: "Đăng nhập");
      final AuthRequest authRequest = AuthRequest();
      authRequest.email = email;
      authRequest.password = passwordController.text.toString();
      authProvider.loginToSalaryInEmployee(
          request: authRequest,
          onSuccess: (account) {
            EasyLoading.dismiss();
            Get.toNamed(AppRoutes.V4_SALARY)!.then((value) {
              if (value == true) {
                Get.back();
                passwordController.text = "";
              }
            });
          },
          onError: (error) {
            EasyLoading.dismiss();
            print("Lỗi đăng nhập onError $error");
            update();
          });
    }
  }
}
