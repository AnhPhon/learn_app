import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/hop_thu_request.dart';
import 'package:template/provider/hop_thu_provider.dart';
import 'package:template/utils/alert.dart';

class V2MailController extends GetxController {
  //textEditingController
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final contentController = TextEditingController();

  //hopThu
  HopThuProvider hopThuProvider = GetIt.I.get<HopThuProvider>();
  HopThuRequest hopThuRequest = HopThuRequest();

  //title appbar
  String title = "Hộp thư";

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    contentController.dispose();
    super.onClose();
  }

  ///
  ///send
  ///
  void onBtnSendClick(BuildContext context) {
    //validate
    if (nameController.text.isEmpty) {
      Alert.error(message: 'Vui lòng nhập tên');
    } else if (phoneController.text.isEmpty) {
      Alert.error(message: 'Vui lòng nhập số điện thoại');
    } else if (contentController.text.isEmpty) {
      Alert.error(message: 'Vui lòng nhập nội dung');
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
          Alert.success(message: 'Liên hệ thành công');
        },
        onError: (error) {
          print("V2MailController onBtnSendClick onError $error");
        },
      );
    }
  }
}
