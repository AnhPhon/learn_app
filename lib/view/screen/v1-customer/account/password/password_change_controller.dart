import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class PasswordChangeController extends GetxController {
  GetIt sl = GetIt.instance;
  bool isLoading = false;
  // TextEditingController textEditOldPasswordController = TextEditingController();
  TextEditingController textEditPasswordController = TextEditingController();
  TextEditingController textEditRePasswordController = TextEditingController();

  ///
  /// on button Update click
  ///
  void onBtnUpdateClick(BuildContext context) {
    // sl.get<SharedPreferenceHelper>().userId.then((value) {
    //   // kiểm tra mã giới thiệu đúng không
    //   userProvider.find(
    //       id: value!,
    //       onSuccess: (userData) {
    //         // print(userData.toJson());
    //         // validate input user
    //         final bool isValid = _checkValidateInput();

    //         if (isValid) {
    //           final Map<String, String> data = {
    //             "id": userData.id!,
    //             "password": textEditPasswordController.text,
    //           };
    //           userProvider.infoUpdate(
    //             data: data,
    //             onSuccess: (user) {
    //               // Thực hiện update
    //               Get.back();
    //               print("Password updated");
    //               showAnimatedDialog(
    //                 context,
    //                 const MyDialog(
    //                   icon: Icons.check,
    //                   title: "Hoàn tất",
    //                   description: "Cập nhật hoàn tất",
    //                 ),
    //                 dismissible: false,
    //                 isFlip: true,
    //               );
    //               EasyLoading.dismiss();
    //               update();
    //             },
    //             onError: (error) {
    //               print("TermsAndPolicyController getTermsAndPolicy onError $error");
    //               update();
    //             },
    //           );
    //         }
    //       },
    //       onError: (error) {
    //         print("TermsAndPolicyController getTermsAndPolicy onError $error");
    //         update();
    //       });
    // });
  }

  ///
  /// check validate input
  ///
  bool checkValidateInput() {
    // if (textEditOldPasswordController.text == '') {
    //   // mật khẩu cũ
    //   _showSnakebar('Vui lòng kiểm tra lại!', 'Mật khẩu cũ không được rỗng', 3);
    //   return false;
    // }

    if (textEditPasswordController.text == '') {
      // mật khẩu mới
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Mật khẩu mới không được trống', 3);
      return false;
    }

    if (textEditPasswordController.text.length < 6) {
      // mật khẩu mới
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Mật khẩu phải ít nhất 6 ký tự', 3);
      return false;
    }

    if (textEditPasswordController.text != textEditRePasswordController.text) {
      // xem thử mới và nhập lại giống nhau không
      _showSnakebar('Vui lòng kiểm tra lại!',
          'Mật khẩu nhập lại không giống với mật khẩu mới', 3);
      return false;
    }

    return true;
  }

  ///
  /// show snackbar
  ///
  void _showSnakebar(String title, String message, int seconds) {
    Get.snackbar(
      title, // title
      message, // message
      backgroundColor: const Color(0xffFFEBEE),
      icon: const Icon(Icons.error_outline),
      shouldIconPulse: true,
      isDismissible: true,
      duration: Duration(seconds: seconds),
    );
  }
}
