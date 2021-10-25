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
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V1PersonalInfoController extends GetxController {
  //file image
  File? image;

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //textEditingController
  TextEditingController? nameCompanyController;
  TextEditingController? fullNameController;
  TextEditingController? bornController;
  TextEditingController? cMNDController;
  TextEditingController? ngayCapController;
  TextEditingController? phoneController;
  TextEditingController? emailController;

  //TaiKhoan
  TaiKhoanProvider taiKhoanProvider = TaiKhoanProvider();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();
  TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();

  //value of dropdown
  String? sex;
  Map<String, String> sexMap = {
    "0": "Nữ",
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
    super.onClose();
    nameCompanyController!.dispose();
    fullNameController!.dispose();
    bornController!.dispose();
    cMNDController!.dispose();
    ngayCapController!.dispose();
    phoneController!.dispose();
    emailController!.dispose();
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
          nameCompanyController = TextEditingController(text: value.tenPhapLy);
          fullNameController = TextEditingController(text: value.hoTen);
          //convert date to ddYYmmmm
          bornController = TextEditingController(
            text: DateConverter.formatDateTimeFull(
              dateTime: value.ngaySinh.toString(),
            ),
          );
          sex = value.gioiTinh;
          cMNDController = TextEditingController(text: value.cMND);
          ngayCapController = TextEditingController(
            text: DateConverter.formatDateTimeFull(
              dateTime: value.ngayCap.toString(),
            ),
          );
          phoneController = TextEditingController(text: value.soDienThoai);
          emailController = TextEditingController(text: value.email);

          isLoading = false;
          update();
        },
        onError: (error) {
          print("V1PersonalInfoController getAccounInfomation onError $error");
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
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
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
        taiKhoanRequest.hinhDaiDien = value.data;
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
    if (nameCompanyController!.text.isEmpty) {
      EasyLoading.dismiss();

      //show snackbar
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập tên doanh nghiệp/ đội trưởng/ cá nhân",
      );
    } else if (fullNameController!.text.isEmpty) {
      EasyLoading.dismiss();

      //show snackbar
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập họ và tên",
      );
    } else if (phoneController!.text.isEmpty) {
      EasyLoading.dismiss();

      //show snackbar
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập số điện thoại",
      );
    } else if (emailController!.text.isEmpty) {
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

  ///
  ///btn back
  ///
  void onBtnBackClick() {
    Get.back();
  }
}
