import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
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

class V4InfoController extends GetxController {
  GetIt sl = GetIt.instance;

  //ImageUpdate Provider
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //Nhân viên Provider
  NhanVienProvider nhanVienProvider = GetIt.I.get<NhanVienProvider>();
  NhanVienResponse? nhanVienResponse;
  NhanVienRequest nhanVienRequest = NhanVienRequest();

  //Tỉnh/Tp Provider
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  List<TinhTpResponse> tinhTpList = [];

  TinhTpResponse? tinhTp;
  String hintTextTinhTp = 'Chọn Tỉnh/Tp';

  //Quận/Huyện Provider
  QuanHuyenProvider quuanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  List<QuanHuyenResponse> quanHuyenList = [];
  QuanHuyenResponse? quanHuyen;
  String hintTextQuanHuyen = 'Chọn Quận/Huyện';

  //Phường/Xã Provider
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<PhuongXaResponse> phuongXaList = [];
  PhuongXaResponse? phuongXa;
  String hintTextPhuongXa = 'Chọn Phường/Xã';

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

  //Khai báo Avatar
  String avatar = "";

  //Khai báo ảnh CMNDMT
  String anhCMNDMT = "";

  //Khai báo ảnh CMNDMS
  String anhCMNDMS = "";

  //Check Phường/Xã null
  String? phuongXaCheckNull;

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

    //getAccountInformation
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

          //Mapping Avatar
          if (nhanVienResponse!.hinhDaiDien != null) {
            avatar = nhanVienResponse!.hinhDaiDien.toString();
          }

          //Mapping ảnh CMND Mặt trước
          if (nhanVienResponse!.anhMTCMND != null) {
            anhCMNDMT = nhanVienResponse!.anhMTCMND.toString();
          }

          //Mapping ảnh CMND Mặt sau
          if (nhanVienResponse!.anhMSCMND != null) {
            anhCMNDMS = nhanVienResponse!.anhMSCMND.toString();
          }

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
  /// Load tất cả quận huyện
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
  /// Load tất cả phường xã
  ///
  void getPhuongXa({required String id, bool? isFisrt = false}) {
    phuongXaProvider.paginate(
        filter: '&idQuanHuyen=$id',
        limit: 100,
        page: 1,
        onSuccess: (value) {
          phuongXaList = value;
          if (nhanVienResponse != null && isFisrt == true) {
            if (nhanVienResponse!.idQuanHuyen!.ten.toString().toLowerCase() !=
                "hoàng sa") {
              phuongXa = phuongXaList[phuongXaList.indexWhere(
                  (element) => element.id == nhanVienResponse!.idPhuongXa!.id)];
            }
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
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<PlatformFile> files = result.files;

      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            avatar = value.files![0];
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
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      Alert.error(
          message: "Vui lòng cho phép ứng dụng truy cập vào thư viện ảnh!");
    }
  }

  ///
  /// Pick front of Identity card
  ///
  Future pickIdentityFront() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<PlatformFile> files = result.files;

      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            anhCMNDMT = value.files![0];
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
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      Alert.error(
          message: "Vui lòng cho phép ứng dụng truy cập vào thư viện ảnh!");
    }
  }

  ///
  /// Pick After of Identity card
  ///
  Future pickIdentityAfter() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<PlatformFile> files = result.files;

      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            anhCMNDMS = value.files![0];
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
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      Alert.error(
          message: "Vui lòng cho phép ứng dụng truy cập vào thư viện ảnh!");
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
    if (phuongXa == null &&
        quanHuyen!.ten.toString().toLowerCase() != "hoàng sa") {
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
      nhanVienRequest.hinhDaiDien = avatar.toString();
      nhanVienRequest.anhMTCMND = anhCMNDMT.toString();
      nhanVienRequest.anhMSCMND = anhCMNDMS.toString();
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
      if (phuongXa != null) {
        phuongXaCheckNull = phuongXa!.id;
      } else {
        phuongXaCheckNull = null;
      }
      nhanVienRequest.idPhuongXa = phuongXaCheckNull;
      //show loading
      EasyLoading.show(status: 'Loading...');
      //update
      nhanVienProvider.update(
        data: nhanVienRequest,
        onSuccess: (value) {
          EasyLoading.dismiss();
          Get.back(result: true);

          //show dialog
          Alert.success(message: "Cập nhật thông tin thành công!");
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }
  }
}
