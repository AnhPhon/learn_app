import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/routes/route_path/transfers_routers.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/transfers/transfers_confirm/components/component_confirm_password_dialog.dart';
import 'package:template/view/screen/transfers/transfers_confirm/components/component_money_transfers_confirm_dialog.dart';

class TransfersConfirmController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  // Variable
  Timer? timer;
  int count = 10;
  bool isCountDown = false;
  final String contentMoneyTransfers = 'Xác nhận chuyển 10.000 VNĐ cho Bùi Thị Thu Hương, số điện thoại 0961225417, phí GD 0 VNĐ ';

  String password = '';
  bool isEnableConfirmPassword = true;
  bool isEnableTransferMoney = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
  /// Hiện thị dialog xác nhận chuyển tiền
  ///
  void showDialogMoneyTransferConfirmation() {
    isCountDown = true;
    countDown();
    // update();
    Get.defaultDialog(
      // barrierDismissible: false,
      title: 'Xác thực OTP',
      titleStyle: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_H6,
        fontWeight: FontWeight.bold,
      ),
      content: const ComponentMoneyTransferConfirmDialog(),
    );
  }

  ///
  /// onTap  money transfer confirm
  ///
  void onTapMoneyTransferConfirm() {
    EasyLoading.show(status: "Đang chuyển tiền");
    Future.delayed(Duration(seconds: 2), () {
      IZIAlert.error(message: "Chuyển tiền thành công");
      EasyLoading.dismiss();
      Get.back();
      // onToTransfersSuccessPage();
      onToTransfersFailPage();
    });
  }

  ///
  /// Countdown otp
  ///
  void countDown() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (count < 1) {
        timer.cancel();
        isCountDown = false;
      } else {
        count = count - 1;
      }
      update();
    });
  }

  ///
  /// void send again otp
  ///
  void sendAgainOtp() {
    if (isCountDown) {
      return;
    } else {
      // Gửi lại mã
      isCountDown = true;
      count = 10;
      countDown();
      update();
    }
  }

  ///
  /// Hiển thị dialog xác nhận mật khẩu
  ///
  void showDialogConfirmPassword() {
    Get.defaultDialog(
      // barrierDismissible: false,
      title: 'Vui lòng nhập mật khẩu của bạn',
      titleStyle: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_H6,
        fontWeight: FontWeight.bold,
      ),
      content: const ComponentConfirmPasswordDialog(),
      // Chuyển vào để làm disible luôn
      confirm: IZIButton(
        // isEnabled: isEnableConfirmPassword,
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_3X,
        ),
        width: IZIDimensions.ONE_UNIT_SIZE * 190,
        onTap: () {
          onConfirmPassword();
        },
        label: "Xác nhận",
      ),
    );
  }

  void onConfirmPassword() {
    String pass = '123456';
    if (password.isEmpty) {
      IZIAlert.error(message: "Mật khẩu không được để trống");
      return;
    }
    EasyLoading.show(status: "Đang xác thực");
    if (password == pass) {
      // Nếu mật khẩu chính xác dosomething
      Future.delayed(const Duration(seconds: 1), () {
        EasyLoading.dismiss();
        Get.back();
        sendAgainOtp();
        showDialogMoneyTransferConfirmation();
      });
    } else {
      Future.delayed(const Duration(seconds: 2), (){
        EasyLoading.dismiss();
        IZIAlert.error(message: "Xác thực thất bại");
      });
    }
  }


  // Routers

  ///
  /// go to transfer success
  ///
  void onToTransfersSuccessPage() {
    Get.toNamed(TransfersRouters.TRANSFERS_SUCCESS);
  }
  ///
  /// go to transfer fail
  ///
  void onToTransfersFailPage() {
    Get.toNamed(TransfersRouters.TRANSFERS_FAIL);
  }


  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }
}
