import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/response/loai_tai_khoan_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/provider/loai_tai_khoan_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/app_routes.dart';

class RegisterController extends GetxController {
  // Provider
  final NhomDichVuProvider nhomDichVuprovider = GetIt.I.get<NhomDichVuProvider>();
  final LoaiTaiKhoanProvider loaiTaiKhoanProvider = GetIt.I.get<LoaiTaiKhoanProvider>();
  final TinhTpProvider provinceProvider = GetIt.I.get<TinhTpProvider>();
  
  //TextEditController
  final usernameController = TextEditingController();
  final enterpriseNameController = TextEditingController();
  final taxCodeController = TextEditingController();
  final fullNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final cmndController = TextEditingController();
  final dateRangeController = TextEditingController();
  final placeIssueController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();



  //Data default
  final genders = [
    "Nam", "Nữ","Khác"
  ];

  // Flag
  bool isLoadTypeAccount = true;
  bool isLoadProvince = true;


  // response list
  List<LoaiTaiKhoanResponse> loaiTaiKhoans = [];
  List<TinhTpResponse> provinces = [];

  // Variable
  LoaiTaiKhoanResponse? loaiTaiKhoan;
  String? gender;
  TinhTpResponse? province;

  // cmnd front file
  File? avatarFile;
  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
  }

  /// 
  ///  Get type account 
  /// 
  void getTypeAccount(){
    loaiTaiKhoanProvider.all(onSuccess: (typeAccounts){
      loaiTaiKhoans.addAll(typeAccounts);
      isLoadTypeAccount = false;
      update();
    }, onError: (onError){
      isLoadTypeAccount = false;
      update();
      print("RegisterController getTypeAccount onError $onError");
    });
  }

  ///
  /// on loai tai khoan change
  ///
  void onLoaiTaikhoanChange(LoaiTaiKhoanResponse value) {
    loaiTaiKhoan = value;
    update();
  }

  ///
  /// on change gender
  ///
  void onChangedGender(String gender){
    this.gender = gender;
    update();
  }

  ///
  /// Get all province
  ///
  void onGetProvinces(){
    provinceProvider.all(onSuccess: (provinces){
      this.provinces.clear();
      this.provinces.addAll(provinces);
      isLoadProvince = false;
      update();
    }, onError: (onError){
      isLoadProvince = false;
      update();
      print("onGetProvinces: $onError");
    });
  }

  ///
  /// on change province
  ///
  void onChangedProvince(TinhTpResponse province){
    this.province = province;
    update();
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

  
}
