import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
import 'package:template/utils/alert.dart';

import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V4InfoController extends GetxController {
  GetIt sl = GetIt.instance;

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //Nhân viên
  NhanVienProvider nhanVienProvider = GetIt.I.get<NhanVienProvider>();
  NhanVienResponse? nhanVienResponse;
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
          print("IDThongTIntaiKhoan $idUser");
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

          //mappingAddress
          mappingAddress();

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
  ///mapping address
  ///
  Future<void> mappingAddress() async {
    //get user id
    idUser = (await sl.get<SharedPreferenceHelper>().userId)!;

    if (nhanVienResponse != null) {
      getTinhTp(isFisrt: true);
      getQuanHuyen(
          id: nhanVienResponse!.idTinhTp!.id.toString(), isFisrt: true);
      getPhuongXa(
          id: nhanVienResponse!.idQuanHuyen!.id.toString(), isFisrt: true);
      print(quanHuyen.toString());
    } else {
      getTinhTp();
    }
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
  void onChangedTinhThanh(TinhTpResponse? value) {
    tinhTp = value;

    //clear list
    quanHuyen = null;
    phuongXa = null;
    quanHuyenList.clear();
    phuongXaList.clear();

    getQuanHuyen(id: tinhTp!.id.toString());
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse? value) {
    quanHuyen = value;

    //clear list
    phuongXa = null;
    phuongXaList.clear();
    getPhuongXa(id: quanHuyen!.id.toString());
    update();
  }

  ///
  ///Thay đổi phường xã
  ///
  void onChangedPhuongXa(PhuongXaResponse? value) {
    phuongXa = value;
    update();
  }

  ///
  ///Get tỉnh/Tp
  ///
  void getTinhTp({bool? isFisrt = false}) {
    //get Tỉnh TP
    tinhTpProvider.all(
      onSuccess: (value) {
        tinhTpList = value;

        if (nhanVienResponse != null && isFisrt == true) {
          tinhTp = tinhTpList[tinhTpList.indexWhere(
              (element) => element.id == nhanVienResponse!.idTinhTp!.id)];
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
  void getQuanHuyen({required String id, bool? isFisrt = false}) {
    quuanHuyenProvider.paginate(
        filter: '&idTinhTp=$id',
        limit: 100,
        page: 1,
        onSuccess: (data) {
          quanHuyenList = data;

          if (nhanVienResponse != null && isFisrt == true) {
            quanHuyen = quanHuyenList[quanHuyenList.indexWhere(
                (element) => element.id == nhanVienResponse!.idQuanHuyen!.id)];
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
  void getPhuongXa({required String id, bool? isFisrt = false}) {
    phuongXaProvider.paginate(
        filter: '&idQuanHuyen=$id',
        limit: 100,
        page: 1,
        onSuccess: (value) {
          phuongXaList = value;
          if (nhanVienResponse != null && isFisrt == true) {
            phuongXa = phuongXaList[phuongXaList.indexWhere(
                (element) => element.id == nhanVienResponse!.idPhuongXa!.id)];
          }

          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }

  ///
  /// Pick Avatar Image
  ///
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');

      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          print('V4Infor pickImages Avatar addImages ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            nhanVienRequest.hinhDaiDien = value.files![0];
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Pick front of Identity card
  ///
  Future pickIdentityFront() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');

      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          print(
              'V4Infor pickImages Front Identity Card addImages ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            nhanVienRequest.anhMTCMND = value.files![0];
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Pick After of Identity card
  ///
  Future pickIdentityAfter() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');

      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          print(
              'V4Infor pickImages After Identity Card addImages ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            nhanVienRequest.anhMSCMND = value.files![0];
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  ///Check null value
  ///
  bool validate() {
    //validate
    if (nameController.text.isEmpty) {
      //show snackbar check họ và tên
      Alert.error(message: 'Vui lòng nhập họ và tên!');
      return false;
    }
    if (birthdayController.text.isEmpty) {
      //show snackbar check ngày sinh
      Alert.error(message: 'Vui lòng chọn ngày sinh!');
      return false;
    }
    if (sex == null) {
      //show snackbar check giới tính
      Alert.error(message: 'Vui lòng chọn giới tính!');
      return false;
    }
    if (phoneNumberController.text.isEmpty) {
      //show snackbar check số điện thoại
      Alert.error(message: 'Vui lòng nhập số điện thoại!');
      return false;
    }
    if (addressController.text.isEmpty) {
      //show snackbar check địa chỉ
      Alert.error(message: 'Vui lòng nhập địa chỉ thường trú hiện tại!');
      return false;
    }
    return true;
  }

  ///
  ///update account
  ///
  void updateAccount(BuildContext context) {
    if (validate()) {
      //set data
      nhanVienRequest.id = idUser;
      nhanVienRequest.hoTen = nameController.text;
      nhanVienRequest.ngaySinh = DateConverter.formatDate(
        DateConverter.convertStringddMMyyyyToDate(
          birthdayController.text.toString(),
        ),
      );
      nhanVienRequest.gioiTinh = sex ?? nhanVienRequest.gioiTinh;
      nhanVienRequest.soDienThoai = phoneNumberController.text;
      nhanVienRequest.email = emailController.text;
      nhanVienRequest.diaChi = addressController.text;
      nhanVienRequest.idTinhTp = tinhTp!.id;
      nhanVienRequest.idQuanHuyen = quanHuyen!.id;
      nhanVienRequest.idPhuongXa = phuongXa!.id;
      //show loading
      EasyLoading.show(status: 'Loading...');
      print(nhanVienRequest.toJson());
      //update
      nhanVienProvider.update(
        data: nhanVienRequest,
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
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }
  }
}
