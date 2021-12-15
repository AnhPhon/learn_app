import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/home_routes.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void onInit() {
    super.onInit();
  }

  ///
  /// Login
  ///
  void onLogin() {
    // TODO: do something
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
