import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/response/loai_tai_khoan_response.dart';
import 'package:template/routes/app_routes.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();

  // response
  LoaiTaiKhoanResponse? loaiTaiKhoan;
  List<LoaiTaiKhoanResponse> loaiTaiKhoans = [];

  // cmnd front file
  File? avatarFile;

  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
  }

  ///
  /// on avatar picker
  ///
  Future onAvatarPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      avatarFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on button register tap
  ///
  void onBtnRegisterTap() {
    Get.toNamed(AppRoutes.OTP_VERIFIER);
  }

  ///
  /// on loai tai khoan change
  ///
  void onLoaiTaikhoanChange(LoaiTaiKhoanResponse value) {}
}
