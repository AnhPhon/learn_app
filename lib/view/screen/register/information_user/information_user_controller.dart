import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';

class InformationUserController extends GetxController {
  GetIt sl = GetIt.instance;

  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();
  bool isLoadingMore = false;

  final Map<String, TextEditingController> textEditControllers = {
    "magioithieu": TextEditingController(),
    "matkhau": TextEditingController(),
    "xacnhanmatkhau": TextEditingController(),
    "sodienthoai": TextEditingController(),
    "hoten": TextEditingController(),
    "cmnd": TextEditingController(),
    "noicap": TextEditingController(),
    "nghenghiep": TextEditingController(),
    "diachithuongtru": TextEditingController(),
    "diachitlienlac": TextEditingController(),
  };

  String? ngaySinh = 'Ngày sinh';
  String? ngayCap = 'Ngày cấp';

  // value dropdown
  String? gender;

  // cmnd front file
  File? cmndFrontFile;

  // cmnd back file
  File? cmndBackFile;

  var focusNodeMaGioiThieu = FocusNode();

  @override
  void onInit() {
    focusNodeMaGioiThieu.addListener(() {
      print('focusNode.hasFocus ${focusNodeMaGioiThieu.hasFocus}');

      // listen lost focus
      if (!focusNodeMaGioiThieu.hasFocus) {
        // kiểm tra mã nhập vào có đúng không

        // nếu sai thì cần phải show lên thông báo là sai mã
      }
    });
    super.onInit();
  }

  ///
  /// on ngay sinh change
  ///
  void onNgaySinhChange(DateTime? value) {
    ngaySinh = DateConverter.isoStringToVNDateOnly(value.toString());
    update();
  }

  ///
  /// on ngay sinh change
  ///
  void onNgayCapChange(DateTime? value) {
    ngayCap = DateConverter.isoStringToVNDateOnly(value.toString());
    update();
  }

  void createUser(UserModel model) {
    userProvider.add(
      data: model,
      onSuccess: (model) {
        update();
      },
      onError: (error) {
        print(error);
        update();
      },
    );
  }

  ///
  /// on CMND front picker
  ///
  Future onCmndFrontPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      cmndFrontFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on CMND back picker
  ///
  Future onCmndBackPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      cmndBackFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on gender change
  ///
  void onGenderChange(String value) {
    gender = value;
    update();
  }

  // void uploadImage() {
  //   imageProvider.add(
  //       file: image!,
  //       onSuccess: (image) {
  //         print('link image nè ${image.data}');

  //         // tempModel.imagePayment = image.data;
  //         // // print(tempModel.haveIDtoJson());
  //         // orderProvider.update(
  //         //   data: tempModel,
  //         //   onSuccess: (model) {
  //         //     print("success updated");
  //         //     update();
  //         //   },
  //         //   onError: (error) {},
  //         // );
  //       },
  //       onError: (error) {
  //         print(error);
  //         update();
  //       });
  // }

  void onBtnContinueClick() {
    final UserModel userModel = UserModel(
      password: textEditControllers["matkhau"]!.text,
      idUser: "",
      idRole: "",
      idOptionalRole: "0",
      fullname: textEditControllers["hoten"]!.text,
      username: textEditControllers["taikhoan"]!.text,
      sex: gender ?? "",
      avatar:
          "https://izisoft.s3.ap-southeast-1.amazonaws.com/p08yamamoto/1632456310...",
      // born: DateConverter.estimatedDate(ngaysinh!),
      phone: textEditControllers["sodienthoai"]!.text,
      address: textEditControllers["diachithuongtru"]!.text,
      citizenIdentification: textEditControllers["cmnd"]!.text,
      status: "1",
      imageCitizenIdentification:
          "https://izisoft.s3.ap-southeast-1.amazonaws.com/p08yamamoto/1632455894...",
      imageCitizenIdentification1:
          "https://izisoft.s3.ap-southeast-1.amazonaws.com/p08yamamoto/1632455901...",
      paymentProofImage: "",
    );

    // // cho phép tạo
    // bool allowCreate = false;
    // if (allowCreate == true) {
    //   controller.createUser(userModel);
    // }

    Get.toNamed(AppRoutes.ORDER_CONDITION);
  }
}
