import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/account_management_routers.dart';

class BankTransferController extends GetxController {
  //Khai báo isLoading
  bool isLoading = false;

  //Khai báo số tài khoản
  String accountNumber = "8000.111.68.68.68";

  //Khai báo nội dung chuyển khoản
  String contentTransfer = "0335467823-100VNĐ";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///Copy Account Number
  ///
  void onBtnCopyAccountNumber({required String content}) {
    Clipboard.setData(ClipboardData(text: content));

    IZIAlert.success(message: 'Copy $content thành công');
  }

  ///
  ///Copy Content Transfer
  ///
  void onBtnCopyContentTransfer({required String content}) {
    Clipboard.setData(ClipboardData(text: content));

    IZIAlert.success(message: 'Copy $content thành công');
  }

  ///
  ///Go to Transaction Confirmation
  ///
  void goToTransactionConfirmation() {
    Get.toNamed(AccountManagementRouter.TRANSACTION_CONFIRMATION)!.then((value) {
      if (!IZIValidate.nullOrEmpty(value) && value == true) {
        onInit();
        update();
      }
    });
    update();
  }
}
