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
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V4InfoController extends GetxController {
  GetIt sl = GetIt.instance;

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //Nhân viên
  NhanVienProvider nhanVienProvider = GetIt.I.get<NhanVienProvider>();
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

  // Avatar file
  File? avatarFile;

  // Image Indentity Front File
  File? imageIndentityFront;

  // Image Indentity After File
  File? imageIndentityAfter;

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
          hintTextTinhTp = value.idTinhTp!.ten.toString();
          //Quận/huyện
          hintTextQuanHuyen = value.idQuanHuyen!.ten.toString();
          //Phường/Xã
          hintTextPhuongXa = value.idPhuongXa!.ten.toString();

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
  ///Pick Image Avatar
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      avatarFile = File(image.path);
      uploadImage(image: avatarFile!);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///Upload Image Avatar
  ///
  void uploadImage({required File image}) {
    // show loading
    EasyLoading.show(status: 'Loading...');
    imageUpdateProvider.add(
      file: image,
      onSuccess: (value) {
        nhanVienRequest.hinhDaiDien = value.data;
        EasyLoading.dismiss();
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///Pick CMND mặt trước
  ///
  Future pickIndentiryFront() async {
    try {
      final imageFront =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFront == null) return;
      imageIndentityFront = File(imageFront.path);
      uploadIndentiryFront(image: imageIndentityFront!);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///Upload CMND mặt trước
  ///
  void uploadIndentiryFront({required File image}) {
    // show loading
    EasyLoading.show(status: 'Loading...');
    imageUpdateProvider.add(
      file: image,
      onSuccess: (value) {
        nhanVienRequest.anhMTCMND = value.data;
        EasyLoading.dismiss();
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///Pick CMND mặt sau
  ///
  Future pickIndentiryAfter() async {
    try {
      final imageAfter =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageAfter == null) return;
      imageIndentityAfter = File(imageAfter.path);
      uploadIndentiryAfter(image: imageIndentityAfter!);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///Upload CMND mặt sau
  ///
  void uploadIndentiryAfter({required File image}) {
    // show loading
    EasyLoading.show(status: 'Loading...');
    imageUpdateProvider.add(
      file: image,
      onSuccess: (value) {
        nhanVienRequest.anhMSCMND = value.data;
        EasyLoading.dismiss();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
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
    if (tinhTp == null) {
      //show snackbar check địa chỉ
      Alert.error(message: 'Vui lòng chọn Tỉnh/Tp!');
      return false;
    }
    if (quanHuyen == null) {
      //show snackbar check địa chỉ
      Alert.error(message: 'Vui lòng chọn Quận/Huyện!');
      return false;
    }
    if (phuongXa == null) {
      //show snackbar check địa chỉ
      Alert.error(message: 'Vui lòng chọn Phường/Xã!');
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
          Get.back(result: nhanVienResponse.hinhDaiDien);

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

  void backHome() {
    Get.back(result: nhanVienResponse.hinhDaiDien);
  }
}
