import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/nhan_vien_request.dart';

import 'package:template/data/model/response/nhan_vien_response.dart';
import 'package:template/provider/nhan_vien_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V4InfoController extends GetxController {
  GetIt sl = GetIt.instance;

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //TaiKhoan
  NhanVienProvider nhanVienProvider = NhanVienProvider();
  NhanVienResponse nhanVienResponse = NhanVienResponse();
  NhanVienRequest nhanVienRequest = NhanVienRequest();

  //value of dropdown
  String? sex;
  Map<String, String> sexMap = {
    "0": "Nữ",
    "1": "Nam",
  };

  //user id
  String idUser = "";

  // avatar file
  File? avatarFile;
  String? avatarPath;

  // khai báo is loading
  bool isLoading = true;

  //khai báo TextEditingController
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController indentityCardController = TextEditingController();
  TextEditingController dateIndentityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressIndentityController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAccountInformation();
  }

  ///
  ///Get thông tin nhân viên
  ///
  void getAccountInformation() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      //get User Id
      idUser = userId!;

      //Get thông tin nhân viên theo id
      nhanVienProvider.find(
        id: idUser,
        onSuccess: (value) {
          nhanVienResponse = value;

          //set họ và tên
          nameController = TextEditingController(text: value.hoTen);

          //Ngày sinh
          // birthdayController = TextEditingController(text: value.ngaySinh);

          sex = value.gioiTinh;

          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  ///on changed sex
  ///
  void onChangedSex(String? value) {
    sex = value;
    update();
  }
}
