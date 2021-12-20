import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/home_routes.dart';
import 'package:local_auth/local_auth.dart';
import 'package:template/utils/color_resources.dart';

class LoginController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  TextEditingController phoneController = TextEditingController();

  final money = IZIInput(
      type: IZIInputType.PRICE,
      placeHolder: "Số điện thoại",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(
        Icons.account_circle_outlined,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );

  @override
  void onInit() {
    super.onInit();
    // money.onChanged
  }

  

  ///
  /// Login
  ///
  void onLogin() {
    // TODO: do something
    // phoneController.text = '100.000';
    onToHomePage();
  }

  void onFingerprintUnlock() async {
    // Kiểm tra thiết bị có sử dụng bảo mật không
    final bool canCheckBiometrics = await auth.canCheckBiometrics;
    // List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    const iosStrings = IOSAuthMessages(
      cancelButton: 'Từ chối',
      goToSettingsButton: 'Cài đặt',
      goToSettingsDescription: 'Vui lòng thiết lập Touch ID của bạn.',
      lockOut: 'Vui lòng kích hoạt lại Touch ID của bạn',
    );

    const androidStrings = AndroidAuthMessages(
      cancelButton: 'Từ chối',
      goToSettingsButton: 'Cài đặt',
      goToSettingsDescription: 'Vui lòng thiết lập Touch ID của bạn.',
    );

    // Kiểm tra thiết bị có hộ trợ bằng vân tay không
    if (canCheckBiometrics) {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Vui lòng xác thực để đăng nhập tài khoản',
        biometricOnly: true,
        iOSAuthStrings: iosStrings,
        androidAuthStrings: androidStrings,
      );
      if (didAuthenticate) {
        print("Thành công");
        // Do something
      } else {
        // doSomthing
        print("Thất bại");
      }
    }
  }

  ///
  /// Huỷ xác thực cho android
  ///
  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  // Route page

  void onToSignUpPage() {
    Get.toNamed(AuthRoutes.SIGN_UP);
  }

  void onToForgetPasswordPage() {
    Get.toNamed(AuthRoutes.FORGET_PASSWORD);
  }

  void onToHomePage() {
    Get.offAndToNamed(HomeRoutes.DASH_BOARD);
  }
}
