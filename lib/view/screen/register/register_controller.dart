import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/loai_tai_khoan_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/loai_tai_khoan_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:uuid/uuid.dart';

import '../../../di_container.dart';

class RegisterController extends GetxController {
  // Provider
  final NhomDichVuProvider nhomDichVuprovider = GetIt.I.get<NhomDichVuProvider>();
  final LoaiTaiKhoanProvider loaiTaiKhoanProvider = GetIt.I.get<LoaiTaiKhoanProvider>();
  final TinhTpProvider provinceProvider = GetIt.I.get<TinhTpProvider>();
  final QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  
  //TextEditController
  final enterpriseNameController = TextEditingController();
  final taxCodeController = TextEditingController();
  final fullNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final cmndController = TextEditingController();
  final dateRangeController = TextEditingController();
  final placeIssueController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final amountController = TextEditingController();
  final jobExpertsController = TextEditingController();
  final experienceController = TextEditingController();
  final readyWorkController = TextEditingController();



  //Data default
  final genders = [
    "Nam", "Nữ","Khác"
  ];
  final juridicals = [
    'Doanh nghiệp','Tổ chức','Cá nhân'
  ];

  // Flag
  bool isLoadTypeAccount = true;
  bool isLoadProvince = true;


  // response list
  List<LoaiTaiKhoanResponse> loaiTaiKhoans = [];
  List<TinhTpResponse> provinces = [];
  List<QuanHuyenResponse> districts = [];
  List<PhuongXaResponse> wards = [];
  // Thông số kỹ thuât
  List<MultiSelectItem<TinhTpResponse?>> multipSelecteProvince = [];
  List<TinhTpResponse?> multipSelectedProvinces = [];


  // Variable
  LoaiTaiKhoanResponse? loaiTaiKhoan;
  String? gender;
  String? juridical;
  TinhTpResponse? province;
  QuanHuyenResponse? district;
  PhuongXaResponse? ward;

  // cmnd front file
  File? avatarFile;
  File? faceFile;
  File? frontCMND;
  File? backSideCMND;
  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getTypeAccount();
    onGetProvinces();
  }

  /// 
  ///  Get type account 
  /// 
  void getTypeAccount(){
    loaiTaiKhoanProvider.all(onSuccess: (typeAccounts){
      loaiTaiKhoans.addAll(typeAccounts);
      loaiTaiKhoans.removeWhere((element) => element.tieuDe!.toLowerCase().contains("nhân viên"));
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
  /// on change juridical
  ///
  void onChangedjuridical(String juridical){
    this.juridical = juridical;
    update();
  }

  ///
  /// Get all province
  ///
  void onGetProvinces(){
    provinceProvider.all(onSuccess: (provinces){
      this.provinces.clear();
      this.provinces.addAll(provinces);
      multipSelecteProvince = provinces.map((e) => MultiSelectItem(e, e.ten!)).toList();
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

    district = null;
    ward = null;
    districts.clear();
    wards.clear();
    this.province = province;
    onGetDistrict(filter: province.id!);
    update();
  }


  ///
  /// get all district
  ///
  void onGetDistrict({String filter =''}){
    quanHuyenProvider.paginate(page: 1, limit: 100, filter: '&idTinhTp=$filter',onSuccess: (data){
      districts.clear();
      districts.addAll(data);
      update();
    }, onError: (onError){
      isLoadProvince = false;
      update();
      print("onGetDistrict: $onError");
    });
  }

  ///
  /// on change district
  ///
  void onChangedDistrict(QuanHuyenResponse district){
    this.district = district;
    onGetWard(fillter: district.id!);
    update();
  }

  ///
  /// get all ward
  ///
  void onGetWard({String fillter = ''}){
    phuongXaProvider.paginate(page: 1, limit: 100, filter: '&idQuanHuyen=$fillter', onSuccess: (data){
      wards.clear();
      wards.addAll(data);
      update();
    }, onError: (onError){
      isLoadProvince = false;
      update();
      print("onGetDistrict: $onError");
    });
  }

  ///
  /// on change Ward
  ///
  void onChangedWard(PhuongXaResponse ward){
    this.ward = ward;
    update();
  }

  ///
  /// on avatar picker
  ///
  Future onAvatarPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picker == null) return;
      avatarFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
  ///
  /// on image picker
  ///
  Future onFacePicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picker == null) return;
      faceFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
  ///
  /// on front CMND picker
  ///
  Future onFrontCMNDPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picker == null) return;
      frontCMND = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
  ///
  /// on backside CMND picker
  ///
  Future onbackSideCMNDPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picker == null) return;
      backSideCMND= File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on check valiate
  ///
  bool onCheckValidate(){
    if(loaiTaiKhoan == null){
      Alert.error(message: "Vui lòng chọn loại tài khoản");
      return false;
    }else if(juridical == null){
      Alert.error(message: "Vui lòng chọn loại pháp lý");
      return false;
    }else if(enterpriseNameController.text.toString().isEmpty){
      Alert.error(message: "Tên doanh nghiệp/đội trưởng/cá nhân không được để trống");
      return false;
    }else if(fullNameController.text.toString().isEmpty){
      Alert.error(message: "Họ và tên không được để trống");
      return false;
    }else if(fullNameController.text.toString().isEmpty){
      Alert.error(message: "Họ và tên không được để trống");
      return false;
    }else if(fullNameController.text.toString().isEmpty){
      Alert.error(message: "Họ và tên không được để trống");
      return false;
    }else if(birthDateController.text.toString().isEmpty){
      Alert.error(message: "Ngày sinh không được để trống");
      return false;
    }else if(gender == null){
      Alert.error(message: "Vui lòng chọn giới tính");
      return false;
    }else if(cmndController.text.toString().isEmpty){
      Alert.error(message: "Số CMND/Căn cước không được để trống");
      return false;
    }else if(cmndController.text.toString().length != 12 && cmndController.text.toString().length != 9){
      Alert.error(message: "Số CMND/Căn cước không hợp lệ");
      return false;
    }else if(dateRangeController.text.toString().isEmpty){
      Alert.error(message: "Ngày cấp không được để trống");
      return false;
    }else if(placeIssueController.text.toString().isEmpty){
      Alert.error(message: "Nơi cấp không được để trống");
      return false;
    }else if(phoneNumberController.text.toString().isEmpty){
      Alert.error(message: "Số điện thoại không được để trống");
      return false;
    }else if(passwordController.text.toString().isEmpty){
      Alert.error(message: "Mật khẩu không được để trống");
      return false;
    }else if(passwordController.text.toString() != repeatPasswordController.text.toString()){
      Alert.error(message: "Mật khẩu không trung khớp");
      return false;
    }else if(province == null){
      Alert.error(message: "Vui lòng chọn tỉnh thành phố");
      return false;
    }else if(district == null){
      Alert.error(message: "Vui lòng chọn quận huyện");
      return false;
    }else if(ward == null){
      Alert.error(message: "Vui lòng chọn phường xã");
      return false;
    }else if(multipSelecteProvince.isEmpty){
      Alert.error(message: "Vui lòng chọn khu vực tham gia");
      return false;
    }else if(loaiTaiKhoan!.tieuDe!.toLowerCase().contains('thợ thầu')){
      if(amountController.text.toString().isEmpty){
        Alert.error(message: "Số lượng người không được để trống");
        return false;
      }else if(jobExpertsController.text.toString().isEmpty){
        Alert.error(message: "Chuyên làm việc gì không được để trống");
        return false;
      }else if(experienceController.text.toString().isEmpty){
        Alert.error(message: "Năng lực/Kinh nghiệm không được để trống");
        return false;
      }else if(readyWorkController.text.toString().isEmpty){
        Alert.error(message: "Bạn sẵn sàng làm việc ở những tỉnh nào không được để trống");
        return false;
      }else{
        return true;
      }
    }
    return true;
  }


  ///
  /// on button register tap
  ///
  void onBtnRegisterTap() async{
    if(onCheckValidate()){
      final TaiKhoanRequest auth = TaiKhoanRequest();
      auth.idLoaiTaiKhoan = loaiTaiKhoan!.id;
      auth.loaiPhapLy = juridical;
      // Tên doanh nghiệp
      auth.mST = taxCodeController.text.toString();
      auth.hoTen = fullNameController.text.toString();
      auth.ngaySinh = DateConverter.formatYYYYMMDD(birthDateController.text.toString());
      auth.gioiTinh = gender;
      auth.cMND = cmndController.text.toString();
      auth.ngayCap = DateConverter.formatYYYYMMDD(dateRangeController.text.toString());
      auth.noiCap = placeIssueController.text.toString();
      auth.soDienThoai = phoneNumberController.text.toString();
      if(emailController.text.toString().isNotEmpty){
        auth.email = emailController.text.toString();
      }
      auth.matKhau = passwordController.text.toString();
      // Khu vực tham gia chọn nhiều
      if(addressController.text.toString().isNotEmpty){
        auth.diaDiemCuThe = addressController.text.toString();
      }
      auth.diaChi = '${province!.ten!} - ${district!.ten} - ${ward!.ten}';
      if(frontCMND != null){
        imageUpdateProvider.add(file: frontCMND!, onSuccess: (data){
           auth.hinhCMNDTruoc = data.data;
        }, onError: (onError){
          print("Upload image onError $onError");
        });
       
      }
      // Upload CMND
      if(backSideCMND != null){
        imageUpdateProvider.add(file: backSideCMND!, onSuccess: (data){
           auth.hinhCMNDSau = data.data;
        }, onError: (onError){
          print("Upload image onError $onError");
        });
      }
      // Upload avatar
      if(avatarFile != null){
        imageUpdateProvider.add(file: avatarFile!, onSuccess: (data){
           auth.hinhDaiDien = data.data;
        }, onError: (onError){
          print("Upload image onError $onError");
        });
      }

      Get.toNamed(AppRoutes.OTP_VERIFIER)!.then((value){
          if(value == true){
            EasyLoading.show(status: 'loading...');
            // HÌnh ảnh khuôn mặt không có
            Future.delayed(const Duration(milliseconds: 100)).then((value){
              // Register account
              taiKhoanProvider.add(data: auth, onSuccess: (user){
                // sl.get<SharedPreferenceHelper>().saveJwtToken(user.access!);
                // sl.get<SharedPreferenceHelper>().saveRefreshToken(user.refresh!);
                sl.get<SharedPreferenceHelper>().saveUserId(user.id!);
                // sl.get<SharedPreferenceHelper>().saveIsFirst(id: true);
                Alert.info(message: "Đăng ký Tài khoản thành công");
                Get.back();
                EasyLoading.dismiss();
                
              }, onError: (onError){
                print("Đăng ký tài khoản $onError");
              });
            });
          }else{
            Alert.info(message: "Đăng ký tài khoản thất bại");
          }
      });

    }
  }


  @override
  void onClose() {
    enterpriseNameController.dispose();
    taxCodeController.dispose();
    fullNameController.dispose();
    birthDateController.dispose();
    cmndController.dispose();
    dateRangeController.dispose();
    placeIssueController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    addressController.dispose();
    amountController.dispose();
    jobExpertsController.dispose();
    experienceController.dispose();
    readyWorkController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.onClose();
  }

  
}
