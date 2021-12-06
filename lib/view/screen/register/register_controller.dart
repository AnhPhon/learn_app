import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/request/vi_tien_request.dart';
import 'package:template/data/model/response/loai_tai_khoan_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/loai_tai_khoan_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/constants/preferences.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/helper/izi_validate.dart';

class RegisterController extends GetxController {
  // Provider
  final NhomDichVuProvider nhomDichVuprovider =
      GetIt.I.get<NhomDichVuProvider>();
  final LoaiTaiKhoanProvider loaiTaiKhoanProvider =
      GetIt.I.get<LoaiTaiKhoanProvider>();
  final TinhTpProvider provinceProvider = GetIt.I.get<TinhTpProvider>();
  final QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  final ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
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
  final genders = ["Nam", "Nữ", "Khác"];
  final juridicals = ['Doanh nghiệp', 'Tổ chức', 'Cá nhân'];

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
  final TaiKhoanRequest account = TaiKhoanRequest();

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
  void getTypeAccount() {
    loaiTaiKhoanProvider.all(onSuccess: (typeAccounts) {
      loaiTaiKhoans.addAll(typeAccounts);
      loaiTaiKhoans.removeWhere(
          (element) => element.tieuDe!.toLowerCase().contains("nhân viên"));
      isLoadTypeAccount = false;
      update();
    }, onError: (onError) {
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
  void onChangedGender(String gender) {
    this.gender = gender;
    update();
  }

  ///
  /// on change juridical
  ///
  void onChangedjuridical(String juridical) {
    this.juridical = juridical;
    update();
  }

  ///
  /// Get all province
  ///
  void onGetProvinces() {
    provinceProvider.all(onSuccess: (provinces) {
      this.provinces.clear();
      this.provinces.addAll(provinces);
      multipSelecteProvince =
          provinces.map((e) => MultiSelectItem(e, e.ten!)).toList();
      isLoadProvince = false;
      update();
    }, onError: (onError) {
      isLoadProvince = false;
      update();
      print("onGetProvinces: $onError");
    });
  }

  ///
  /// on change province
  ///
  void onChangedProvince(TinhTpResponse province) {
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
  void onGetDistrict({String filter = ''}) {
    quanHuyenProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idTinhTp=$filter',
        onSuccess: (data) {
          districts.clear();
          districts.addAll(data);
          update();
        },
        onError: (onError) {
          isLoadProvince = false;
          update();
          print("onGetDistrict: $onError");
        });
  }

  ///
  /// on change district
  ///
  void onChangedDistrict(QuanHuyenResponse district) {
    this.district = district;
    onGetWard(fillter: district.id!);
    update();
  }

  ///
  /// get all ward
  ///
  void onGetWard({String fillter = ''}) {
    phuongXaProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idQuanHuyen=$fillter',
        onSuccess: (data) {
          wards.clear();
          wards.addAll(data);
          update();
        },
        onError: (onError) {
          isLoadProvince = false;
          update();
          print("onGetDistrict: $onError");
        });
  }

  ///
  /// on change Ward
  ///
  void onChangedWard(PhuongXaResponse ward) {
    this.ward = ward;
    update();
  }

  ///
  /// on avatar picker
  ///
  Future onAvatarPicker(bool isCamera) async {
    try {
      final picker = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (picker == null) return;
      avatarFile = File(picker.path);
      EasyLoading.show();
      imageUpdateProvider.add(
        file: avatarFile!,
        onSuccess: (data) {
          account.hinhDaiDien = data.files!.first;
          EasyLoading.dismiss();
          Get.back();
        },
        onError: (onError) {
          print("Upload CMND truoc onError $onError");
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on face picker
  ///
  Future onFacePicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picker == null) return;
      faceFile = File(picker.path);
      EasyLoading.show();
      imageUpdateProvider.add(
        file: faceFile!,
        onSuccess: (data) {
          account.hinhAnhKhuonMat = data.files!.first;
          EasyLoading.dismiss();
        },
        onError: (onError) {
          print("Upload CMND truoc onError $onError");
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on front CMND picker
  ///
  Future onFrontCMNDPicker(bool isCamera) async {
    try {
      final picker = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (picker == null) return;
      frontCMND = File(picker.path);
      EasyLoading.show();
      imageUpdateProvider.add(
        file: frontCMND!,
        onSuccess: (data) {
          account.hinhCMNDTruoc = data.files!.first;
          EasyLoading.dismiss();
          Get.back();
        },
        onError: (onError) {
          print("Upload CMND truoc onError $onError");
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on backside CMND picker
  ///
  Future onbackSideCMNDPicker(bool isCamera) async {
    try {
      final picker = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (picker == null) return;
      backSideCMND = File(picker.path);
      EasyLoading.show();
      imageUpdateProvider.add(
        file: backSideCMND!,
        onSuccess: (data) {
          account.hinhCMNDSau = data.files!.first;
          EasyLoading.dismiss();
          Get.back();
        },
        onError: (onError) {
          print("Upload CMND truoc onError $onError");
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on check valiate
  ///
  bool onCheckValidate() {
    if (loaiTaiKhoan == null) {
      IZIAlert.error(message: "Vui lòng chọn loại tài khoản");
      return false;
    } else if (juridical == null) {
      IZIAlert.error(message: "Vui lòng chọn loại pháp lý");
      return false;
    } else if (enterpriseNameController.text.toString().isEmpty) {
      IZIAlert.error(
          message: "Tên doanh nghiệp/đội trưởng/cá nhân không được để trống");
      return false;
    } else if (fullNameController.text.toString().isEmpty) {
      IZIAlert.error(message: "Họ và tên không được để trống");
      return false;
    } else if (fullNameController.text.toString().isEmpty) {
      IZIAlert.error(message: "Họ và tên không được để trống");
      return false;
    } else if (fullNameController.text.toString().isEmpty) {
      IZIAlert.error(message: "Họ và tên không được để trống");
      return false;
    } else if (birthDateController.text.toString().isEmpty) {
      IZIAlert.error(message: "Ngày sinh không được để trống");
      return false;
    } else if (gender == null) {
      IZIAlert.error(message: "Vui lòng chọn giới tính");
      return false;
    } else if (cmndController.text.toString().isEmpty) {
      IZIAlert.error(message: "Số CMND/Căn cước không được để trống");
      return false;
    } else if (cmndController.text.toString().length != 12 &&
        cmndController.text.toString().length != 9) {
      IZIAlert.error(message: "Số CMND/Căn cước không hợp lệ");
      return false;
    } else if (dateRangeController.text.toString().isEmpty) {
      IZIAlert.error(message: "Ngày cấp không được để trống");
      return false;
    } else if (placeIssueController.text.toString().isEmpty) {
      IZIAlert.error(message: "Nơi cấp không được để trống");
      return false;
    } else if (phoneNumberController.text.toString().isEmpty) {
      IZIAlert.error(message: "Số điện thoại không được để trống");
      return false;
    } else if (!Validate.phone(phoneNumberController.text.toString())) {
      IZIAlert.error(message: "Số điện thoại không Hợp lệ");
      return false;
    } else if (emailController.text.toString().isNotEmpty) {
      if (!Validate.email(emailController.text.toString())) {
        IZIAlert.error(message: "Email không hợp lệ");
        return false;
      }
    }
    if (passwordController.text.toString().isEmpty) {
      IZIAlert.error(message: "Mật khẩu không được để trống");
      return false;
    } else if (Validate.charactersLength(passwordController.text.toString()) ==
        false) {
      IZIAlert.error(message: 'Mật khẩu ít nhất 8 ký tự');
      return false;
    } else if (Validate.oneLowerCase(passwordController.text.toString()) ==
        false) {
      IZIAlert.error(message: 'Mật khẩu ít nhất phải có 1 chữ thường');
      return false;
    } else if (Validate.oneUpperCase(passwordController.text.toString()) ==
        false) {
      IZIAlert.error(message: 'Mật khẩu ít nhất phải có 1 chữ hoa');
      return false;
    } else if (Validate.leastOneDigit(passwordController.text.toString()) ==
        false) {
      IZIAlert.error(message: 'Mật khẩu ít nhất phải có 1 số');
      return false;
    } else if (passwordController.text.toString() !=
        repeatPasswordController.text.toString()) {
      IZIAlert.error(message: "Mật khẩu không trùng khớp");
      return false;
    } else if (province == null) {
      IZIAlert.error(message: "Vui lòng chọn tỉnh thành phố");
      return false;
    } else if (district == null) {
      IZIAlert.error(message: "Vui lòng chọn quận huyện");
      return false;
    } else if (ward == null) {
      IZIAlert.error(message: "Vui lòng chọn phường xã");
      return false;
    } else if (multipSelecteProvince.isEmpty) {
      IZIAlert.error(message: "Vui lòng chọn khu vực tham gia");
      return false;
    } else if (loaiTaiKhoan!.tieuDe!.toLowerCase().contains('thợ thầu')) {
      if (experienceController.text.toString().isEmpty) {
        IZIAlert.error(message: "Năng lực/Kinh nghiệm không được để trống");
        return false;
      } else if (readyWorkController.text.toString().isEmpty) {
        IZIAlert.error(
            message:
                "Bạn sẵn sàng làm việc ở những tỉnh nào không được để trống");
        return false;
      }
    }
    if (avatarFile == null) {
      IZIAlert.error(message: "Vui lòng chọn ảnh đại diện");
      return false;
    } else if (frontCMND == null) {
      IZIAlert.error(message: "Vui lòng chọn ảnh chứng minh nhân dân mặt trước");
      return false;
    } else if (backSideCMND == null) {
      IZIAlert.error(message: "Vui lòng chọn ảnh chứng minh nhân dân mặt sau");
      return false;
    } else if (faceFile == null) {
      IZIAlert.error(message: "Vui lòng chụp ảnh khuôn mặt của bạn");
      return false;
    }
    // if(loaiTaiKhoan!.tieuDe!.toLowerCase().contains('nhân viên') || loaiTaiKhoan!.id == NHAN_VIEN){
    //   if(faceFile == null){
    //     IZIAlert.error(message: "Vui lòng chụp ảnh khuôn mặt của bạn");
    //     return false;
    //   }
    // }

    return true;
  }

  ///
  /// Get giới tính
  ///
  String getGender() {
    if (gender!.contains('Nam')) {
      return "1";
    } else if (gender!.contains('Nữ')) {
      return "2";
    }
    return '3';
  }

  ///
  /// Get Loai pháp lý
  ///
  String getJuridical() {
    if (juridical!.contains('Doanh nghiệp')) {
      return '1';
    } else if (juridical!.contains('Cá nhân')) {
      return '3';
    }
    return '2';
  }

  ///
  /// on button register tap
  ///
  Future<void> onBtnRegisterTap() async {
    if (onCheckValidate()) {
      account.idLoaiTaiKhoan = loaiTaiKhoan!.id;
      account.loaiPhapLy = getJuridical();
      // Tên doanh nghiệp
      account.mST = taxCodeController.text.toString();
      account.hoTen = fullNameController.text.toString();
      account.ngaySinh =
          DateConverter.formatYYYYMMDD(birthDateController.text.toString());
      account.gioiTinh = getGender();
      account.cMND = cmndController.text.toString();
      account.ngayCap =
          DateConverter.formatYYYYMMDD(dateRangeController.text.toString());
      account.noiCap = placeIssueController.text.toString();
      account.soDienThoai = phoneNumberController.text.toString();
      account.tenPhapLy = enterpriseNameController.text.toString();
      if (emailController.text.toString().isNotEmpty) {
        account.email = emailController.text.toString();
      }
      account.matKhau = passwordController.text.toString();
      // Khu vực tham gia chọn nhiều
      if (addressController.text.toString().isNotEmpty) {
        account.diaChi = addressController.text.toString();
      }
      account.idTinhTp = province!.id;
      account.idQuanHuyen = district!.id;
      account.idPhuongXa = ward!.id;
      multipSelectedProvinces.forEach((province) {
        account.tinhTpHoatDong = '${account.tinhTpHoatDong},${province!.ten}';
      });

      if (loaiTaiKhoan!.tieuDe!.toLowerCase().contains('thợ thầu') ||
          loaiTaiKhoan!.id == THO_THAU) {
        account.chuyenMon = jobExpertsController.text.toString();
        // THiếu trường kinh nghiệm experienceController
        account.gioiThieu = experienceController.text.toString();
        account.noiLamViec = readyWorkController.text.toString();
        account.soLuongNguoi = amountController.text.toString();
      }
      //'${province!.ten!} - ${district!.ten} - ${ward!.ten}';

      // Đăng ký tài khoản
      registerAccount(account);
    }
  }

  void registerAccount(TaiKhoanRequest account) {
    EasyLoading.show(status: 'loading...');
    authProvider.sendOTP(
        phone: {"phone": account.soDienThoai},
        onSuccess: (String registerToken) {
          EasyLoading.dismiss();
          IZIAlert.success(
              message:
                  "Mã xác thực gửi số điện thoại của bạn. Vui lòng xác thực hoàn tất đăng ký");

          account.registerToken = registerToken;
          // Go to verify page
          Get.toNamed(AppRoutes.OTP_VERIFIER, arguments: {
            Preferences.isRegister: true,
            Preferences.registerToken: registerToken
          })!
              .then((value) {
            if (value[0] == true && value[0] != null) {
              EasyLoading.show(status: 'loading...');
              account.otp = value[1].toString();

              // // Upload Image
              // if (frontCMND != null) {
              //   imageUpdateProvider.add(
              //       file: frontCMND!,
              //       onSuccess: (data) {
              //         account.hinhCMNDTruoc = data.data;
              //       },
              //       onError: (onError) {
              //         print("Upload CMND truoc onError $onError");
              //       });
              // }

              // // Upload CMND
              // if (backSideCMND != null) {
              //   imageUpdateProvider.add(
              //       file: backSideCMND!,
              //       onSuccess: (data) {
              //         account.hinhCMNDSau = data.data;
              //       },
              //       onError: (onError) {
              //         print("Upload CMND sau onError $onError");
              //       });
              // }
              // // Upload avatar
              // if (avatarFile != null) {
              //   imageUpdateProvider.add(
              //       file: avatarFile!,
              //       onSuccess: (data) {
              //         account.hinhDaiDien = data.data;
              //       },
              //       onError: (onError) {
              //         print("Upload avatar onError $onError");
              //       });
              // }

              // // Upload hình ảnh khuôn mat
              // if (faceFile != null) {
              //   imageUpdateProvider.add(
              //       file: faceFile!,
              //       onSuccess: (data) {
              //         account.hinhAnhKhuonMat = data.data;
              //       },
              //       onError: (onError) {
              //         print("Upload khuôn mặt onError $onError");
              //       });
              // }

              // Register account
              authProvider.registerAccount(
                  request: account,
                  onSuccess: (user) {
                    // sl.get<SharedPreferenceHelper>().saveJwtToken(user.access!);
                    // sl.get<SharedPreferenceHelper>().saveRefreshToken(user.refresh!);
                    // sl.get<SharedPreferenceHelper>().saveUserId(user.id!);
                    // sl.get<SharedPreferenceHelper>().saveIsFirst(id: true);
                    walletRequest(user: user);
                    IZIAlert.success(message: "Đăng ký Tài khoản thành công");
                    Get.back();
                    EasyLoading.dismiss();
                  },
                  onError: (onError) {
                    EasyLoading.dismiss();
                    IZIAlert.error(message: "Đăng ký tài khoản thất bại");
                    print(" Lỗi đăng ký tài khoản $onError");
                  });
            } else {
              EasyLoading.dismiss();
              IZIAlert.error(message: "Đăng ký tài khoản thất bại");
            }
          });
        },
        onError: (onError) {
          IZIAlert.error(
              message:
                  "Đã xảy ra lỗi khi đăng ký tài khoản vui lòng thử lại sau");
          EasyLoading.dismiss();
          print("Lỗi đăng ký tài khoản $onError");
        });
  }

  ///
  /// Tạo ví tiền
  ///
  void walletRequest({required TaiKhoanResponse user}) {
    final ViTienRequest wallet = ViTienRequest();
    wallet.idTaiKhoan = user.id;
    wallet.tongTien = '0';
    wallet.trangThai = '1';
    viTienProvider.add(
        data: wallet,
        onSuccess: (data) {
          print("Tạo thành công ví tiền");
        },
        onError: (onError) {
          print("Tạo ví tiền thất bại $onError}");
        });
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
