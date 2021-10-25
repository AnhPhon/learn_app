import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/hop_thu_request.dart';
import 'package:template/provider/hop_thu_provider.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V1MailController extends GetxController {
  //textEditingController
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final contentController = TextEditingController();

  //hopThu
  HopThuProvider hopThuProvider = GetIt.I.get<HopThuProvider>();
  HopThuRequest hopThuRequest = HopThuRequest();

  //title appbar
  String title = "Hộp thư";

  ///
  ///send
  ///
  void onBtnSendClick(BuildContext context) {
    //validate
    if (nameController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Vui lòng nhập tên",
      );
    } else if (phoneController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Vui lòng nhập số điện thoại",
      );
    } else if (contentController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Vui lòng nhập nội dung",
      );
    } else {
      //set data
      hopThuRequest.hoTen = nameController.text.trim();
      hopThuRequest.sdt = phoneController.text.trim();
      hopThuRequest.noiDungTuVan = contentController.text.trim();

      //insert
      hopThuProvider.add(
        data: hopThuRequest,
        onSuccess: (value) {
          //back
          Get.back();

          //show dialog
          showAnimatedDialog(
            context,
            const MyDialog(
              icon: Icons.check,
              title: "Hoàn tất",
              description: "Liên hệ thành công",
            ),
            dismissible: false,
            isFlip: true,
          );
        },
        onError: (error) {
          print("V1MailController onBtnSendClick onError $error");
        },
      );
    }
  }
}
