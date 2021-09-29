import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';

class PasswordChangeController extends GetxController {
  GetIt sl = GetIt.instance;

  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();
  bool isLoading = false;

  TextEditingController textEditInviteUsernameController =
      TextEditingController();
  TextEditingController textEditPasswordController = TextEditingController();
  TextEditingController textEditRePasswordController = TextEditingController();
  TextEditingController textEditPhoneController = TextEditingController();
  TextEditingController textEditFullnameController = TextEditingController();
  TextEditingController textEditCmndController = TextEditingController();
  TextEditingController textEditAddressController = TextEditingController();

  String? ngaySinh = 'Ngày sinh';
  String? born = '';

  // value dropdown
  String? gender;

  // cmnd front file
  File? avatarFile;

  // cmnd front file
  File? cmndFrontFile;

  // cmnd back file
  File? cmndBackFile;

  var focusNodeMaGioiThieu = FocusNode();

  @override
  void onInit() {
    focusNodeMaGioiThieu.addListener(() {
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
    born = DateConverter.formatDate(value!);
    update();
  }

  ///
  /// on avatar picker
  ///
  Future onAvatarPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      avatarFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
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

  ///
  /// on button Update click
  ///
  void onBtnUpdateClick() {
    // validate data input
    // kiểm tra mã giới thiệu có nhập hay chưa
    if (textEditInviteUsernameController.text.toString() == '') {
      _showSnakebar('Vui lòng kiểm tra lại!', 'Mã giới thiệu không tồn tại', 3);
      return;
    }

    // kiểm tra mã giới thiệu đúng không
    userProvider.checkUsernameExists(
        username: textEditInviteUsernameController.text.toString(),
        onSuccess: (userData) {
          // validate input user
          final bool isValid = _checkValidateInput(userData.idUser.toString());

          if (isValid) {
            // create model
            final UserModel user = UserModel();
            user.fullname = textEditFullnameController.text;
            user.address = textEditAddressController.text;

            // chờ duyệt
            // user.status = '1';

            // show loading
            EasyLoading.show(status: 'loading...');

            imageProvider.add(
              file: avatarFile!,
              onSuccess: (imageFront) {
                // mặt trước cmnd
                user.avatar = imageFront.data;

                // upload cmnd
                imageProvider.add(
                  file: cmndFrontFile!,
                  onSuccess: (imageFront) {
                    // mặt trước cmnd
                    user.imageCitizenIdentification = imageFront.data;

                    imageProvider.add(
                        file: cmndFrontFile!,
                        onSuccess: (imageBack) {
                          // mặt sau cmnd
                          user.imageCitizenIdentification1 = imageBack.data;

                          // hide loading
                          EasyLoading.dismiss();

                          // Thực hiện update
                        },
                        onError: (error) {
                          print(error);
                          update();
                        });
                  },
                  onError: (error) {
                    print(error);
                    update();
                  },
                );
              },
              onError: (error) {
                print(error);
                update();
              },
            );

            // sent model to order information page
          }
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  /// check validate input
  ///
  bool _checkValidateInput(String idUser) {

    if (textEditFullnameController.text == '') {
      // Fullname
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Họ và tên không được để trống', 3);
      return false;
    }
    if (textEditAddressController.text == '') {
      // Địa chỉ liên lạc
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Địa chỉ liên lạc không được để trống', 3);
      return false;
    }

    if (avatarFile == null) {
      // Địa chỉ liên lạc
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Hình avatar không được để trống', 3);
      return false;
    }

    return true;
  }

  ///
  /// show snackbar
  ///
  void _showSnakebar(String title, String message, int seconds) {
    Get.snackbar(
      title, // title
      message, // message
      backgroundColor: const Color(0xffFFEBEE),
      icon: const Icon(Icons.error_outline),
      shouldIconPulse: true,
      isDismissible: true,
      duration: Duration(seconds: seconds),
    );
  }
}
