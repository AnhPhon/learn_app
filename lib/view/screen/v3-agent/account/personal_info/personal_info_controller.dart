import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/validate.dart';

class V3PersonalInfoController extends GetxController {
  //file image
  File? image;

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //textEditingController
  TextEditingController nameCompanyController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController bornController = TextEditingController();
  TextEditingController cMNDController = TextEditingController();
  TextEditingController ngayCapController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //TaiKhoan
  TaiKhoanProvider taiKhoanProvider = TaiKhoanProvider();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();
  TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();

  //value of dropdown
  String? sex;
  Map<String, String> sexMap = {
    "2": "Nữ",
    "1": "Nam",
  };

  //user id
  String idUser = "";

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get load data
    getAccounInfomation();
  }

  @override
  void onClose() {
    nameCompanyController.dispose();
    fullNameController.dispose();
    bornController.dispose();
    cMNDController.dispose();
    ngayCapController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }

  ///
  ///get account infomation
  ///
  void getAccounInfomation() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      //get user id
      idUser = userId!;

      //get account infomation by user id
      taiKhoanProvider.find(
        id: userId.toString(),
        onSuccess: (value) {
          taiKhoanResponse = value;

          //set controller.text
          if (value.tenPhapLy != "null") {
            nameCompanyController =
                TextEditingController(text: value.tenPhapLy);
          }
          fullNameController = TextEditingController(text: value.hoTen);
          //convert date to ddYYmmmm
          bornController = TextEditingController(
            text: DateConverter.formatDateTimeGlobal(
              value.ngaySinh.toString(),
            ),
          );
          sex = value.gioiTinh;
          cMNDController = TextEditingController(text: value.cMND);
          ngayCapController = TextEditingController(
            text: DateConverter.formatDateTime(
              value.ngayCap.toString(),
            ),
          );
          phoneController = TextEditingController(text: value.soDienThoai);
          if (value.email != "null") {
            emailController = TextEditingController(text: value.email);
          }

          isLoading = false;
          update();
        },
        onError: (error) {
          print("V3PersonalInfoController getAccounInfomation onError $error");
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
  ///pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      EasyLoading.show(status: 'Loading...');

      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      uploadImage(image: [imageTemporary]);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required List<File> image}) {
    imageUpdateProvider.addImages(
      files: image,
      onSuccess: (value) {
        EasyLoading.dismiss();
        taiKhoanRequest.hinhDaiDien = value.files!.first;
      },
      onError: (error) {
        print("V3PersonalInfoController uploadImage onError $error");
      },
    );
  }

  ///
  ///update account
  ///
  void updateAccount(BuildContext context) {
    //validate
    if (nameCompanyController.text.isEmpty) {
      Alert.error(
          message: 'Vui lòng nhập tên doanh nghiệp/ đội trưởng/ cá nhân');
    } else if (fullNameController.text.isEmpty) {
      Alert.error(message: 'Vui lòng nhập họ và tên');
    } else if (emailController.text.isNotEmpty &&
        Validate.email(emailController.text) == false) {
      Alert.error(message: "Email không hợp lệ");
    } else {
      //show loading
      EasyLoading.show(status: 'loading...');

      //set data
      taiKhoanRequest.id = idUser;
      taiKhoanRequest.tenPhapLy = nameCompanyController.text;
      taiKhoanRequest.hoTen = fullNameController.text;
      taiKhoanRequest.gioiTinh = sex ?? taiKhoanResponse.gioiTinh;
      taiKhoanRequest.ngaySinh = DateConverter.convertStringToDate(
        bornController.text.toString(),
      ).toString();
      taiKhoanRequest.email =
          (emailController.text.isNotEmpty) ? emailController.text : '';

      //update
      taiKhoanProvider.update(
        data: taiKhoanRequest,
        onSuccess: (value) {
          EasyLoading.dismiss();
          Get.back(result: true);

          //show dialog
          Alert.success(message: 'Cập nhật thông tin thành công');
        },
        onError: (error) {
          EasyLoading.dismiss();
          print("V3PersonalInfoController updateAccount onError $error");
        },
      );
    }
  }

  ///
  ///btn back
  ///
  void onBtnBackClick() {
    Get.back();
  }
}
