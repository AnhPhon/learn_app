import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/nhan_vien_request.dart';
import 'package:template/data/model/response/nhan_vien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
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
  List<TinhTpResponse> tinhTpList = [];
  TinhTpResponse? tinhTp;
  String hintTextTinhTp = '';

  //Quận/Huyện
  QuanHuyenProvider quuanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  List<QuanHuyenResponse> quanHuyenList = [];
  QuanHuyenResponse? quanHuyen;
  String hintTextQuanHuyen = '';

  //Phường/Xã
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<PhuongXaResponse> phuongXaList = [];
  PhuongXaResponse? phuongXa;
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
    getTinhTp();
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
          birthdayController = TextEditingController(
            text: DateConverter.formatDateTime(
              value.ngaySinh.toString(),
            ),
          );

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

          // Email
          emailController = TextEditingController(text: value.email);

          //Địa chỉ thường trú
          addressController = TextEditingController(text: value.diaChi);

          //Tỉnh/Tp
          final int indexTinhTp =
              tinhTpList.map((e) => e.id).toList().indexOf(value.idTinhTp!.id);
          if (indexTinhTp != -1) {
            tinhTp = tinhTpList[indexTinhTp];
          }

          //Quận/Huyện
          final int indexQuanHuyen = quanHuyenList
              .map((e) => e.id)
              .toList()
              .indexOf(value.idQuanHuyen!.id);
          if (indexQuanHuyen != -1) {
            quanHuyen = quanHuyenList[indexQuanHuyen];
            getPhuongXa(id: quanHuyen!.id);
          }

          print(quanHuyenList);
          print(value.idQuanHuyen);

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

  ///
  ///on changed sex
  ///
  void onChangedSex(String? value) {
    sex = value;
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    this.tinhTp = tinhTp;
    getQuanHuyen(id: tinhTp.id);
    phuongXaList.clear();
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    this.quanHuyen = quanHuyen;
    getPhuongXa(id: quanHuyen.id);
    update();
  }

  ///
  ///Thay đổi phường xã
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    this.phuongXa = phuongXa;
    update();
  }

  ///
  ///Get tỉnh/Tp
  ///
  void getTinhTp() {
    tinhTpProvider.all(
      onSuccess: (value) {
        tinhTpList.clear();
        if (value.isNotEmpty) {
          tinhTpList.addAll(value);
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Lấy tất cả quận huyện
  ///
  void getQuanHuyen({String? id}) {
    quuanHuyenProvider.paginate(
        filter: '&idTinhTp=$id',
        limit: 100,
        page: 1,
        onSuccess: (data) {
          quanHuyenList.clear();
          if (data.isNotEmpty) {
            quanHuyenList.addAll(data);
            quanHuyen = quanHuyenList.first;
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }

  ///
  /// Lấy tất cả phường xã
  ///
  void getPhuongXa({String? id}) {
    phuongXaProvider.paginate(
        filter: '&idQuanHuyen=$id',
        limit: 100,
        page: 1,
        onSuccess: (value) {
          phuongXaList.clear();
          if (value.isNotEmpty) {
            phuongXaList.addAll(value);
            phuongXa = phuongXaList.first;
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }

  ///
  ///pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      avatarFile = imageTemporary;
      uploadImage(image: imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required File image}) {
    imageUpdateProvider.add(
      file: image,
      onSuccess: (value) {
        nhanVienRequest.hinhDaiDien = value.data;
        print(value.data);
      },
      onError: (error) {
        print("V1PersonalInfoController uploadImage onError $error");
      },
    );
  }

  ///
  ///update account
  ///
  void updateAccount(BuildContext context) {
    //show loading
    EasyLoading.show(status: 'loading...');

    //validate
    if (nameController.text.isEmpty) {
      EasyLoading.dismiss();

      //show snackbar
      Get.snackbar(
        "Họ và tên không hợp lệ!",
        "Vui lòng nhập họ và tên hợp lệ!",
      );
    } else if (birthdayController.text.isEmpty) {
      EasyLoading.dismiss();

      //show snackbar
      Get.snackbar(
        "Ngày sinh không hợp lệ!",
        "Vui lòng chọn ngày sinh hợp hợp lệ!",
      );
    } else if (sex == null) {
      EasyLoading.dismiss();

      //show snackbar
      Get.snackbar(
        "Giới tính khôn",
        "Vui lòng nhập số điện thoại",
      );
    } else if (indentityCardController.text.isEmpty) {
      EasyLoading.dismiss();

      //show snackbar
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập email",
      );
    } else {
      //set data
      taiKhoanRequest.id = idUser;
      taiKhoanRequest.tenPhapLy = nameCompanyController!.text;
      taiKhoanRequest.hoTen = fullNameController!.text;
      taiKhoanRequest.gioiTinh = sex ?? taiKhoanResponse.gioiTinh;
      taiKhoanRequest.ngaySinh = DateConverter.formatDate(
        DateConverter.convertStringddMMyyyyToDate(
          bornController!.text.toString(),
        ),
      );
      taiKhoanRequest.soDienThoai = phoneController!.text;
      taiKhoanRequest.email = emailController!.text;

      //update
      taiKhoanProvider.update(
        data: taiKhoanRequest,
        onSuccess: (value) {
          EasyLoading.dismiss();
          Get.back(result: true);

          //show dialog
          showAnimatedDialog(
            context,
            const MyDialog(
              icon: Icons.check,
              title: "Hoàn tất",
              description: "Cập nhật thông tin thành công",
            ),
            dismissible: false,
            isFlip: true,
          );
        },
        onError: (error) {
          print("V1PersonalInfoController updateAccount onError $error");
        },
      );
    }
  }
}
