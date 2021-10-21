import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/nhan_vien_request.dart';

import 'package:template/data/model/response/nhan_vien_response.dart';
import 'package:template/data/model/response/phuong_xa_response_REMOTE_1763.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/nhan_vien_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V4InfoController extends GetxController {
  GetIt sl = GetIt.instance;

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //Nhân viên
  NhanVienProvider nhanVienProvider = NhanVienProvider();
  NhanVienResponse nhanVienResponse = NhanVienResponse();
  NhanVienRequest nhanVienRequest = NhanVienRequest();

  //Tỉnh/Tp
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  List<TinhTpResponse> tinhTpModelList = [];
  TinhTpResponse? tinhTp;
  String hintTextTinhTp = '';

  //Quận/Huyện
  QuanHuyenProvider quuanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  List<QuanHuyenResponse> quanHuyenModelList = [];
  TinhTpResponse? quanHuyen;
  String hintTextQuanHuyen = '';

  //Phường/Xã
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<PhuongXaResponse> phuongXaModelList = [];
  TinhTpResponse? phuongXa;
  String hintTextPhuongXa = '';

  //value of dropdown sex
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

  //Khai báo is Loading image
  bool isLoadingImage = true;

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
    getTinhTp();
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

          //Giới tính
          sex = value.gioiTinh;

          //CMND
          indentityCardController = TextEditingController(text: value.cMND);

          //Ngày cấp CMND/Căn cước
          dateIndentityController = TextEditingController(
            text: DateConverter.formatDateTime(
              value.ngayCap.toString(),
            ),
          );

          //Nơi cấp CMND
          addressIndentityController =
              TextEditingController(text: value.noiCap);

          //Số điện thoại
          phoneNumberController =
              TextEditingController(text: value.soDienThoai);

          //Địa chỉ thường trú
          addressController = TextEditingController(text: value.diaChi);

          //Tỉnh/Tp
          hintTextTinhTp = value.idTinhTp!.ten.toString();
          print(value.idTinhTp!.id);
          print(value.idTinhTp!.ten);

          isLoading = false;

          isLoadingImage = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  void printImage() {
    print(nhanVienResponse.hinhDaiDien.toString());
  }

  ///
  ///on changed sex
  ///
  void onChangedSex(String? value) {
    sex = value;
    update();
  }

  ///
  ///On change Tinh/Tp
  ///
  void onChangedTinhTp(TinhTpResponse tinhTp) {
    this.tinhTp = tinhTp;
    update();
  }

  ///
  ///Get tỉnh/Tp
  ///
  void getTinhTp() {
    tinhTpProvider.all(
      onSuccess: (value) {
        tinhTpModelList.clear();
        if (value.isNotEmpty) {
          tinhTpModelList.addAll(value);
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }
}
