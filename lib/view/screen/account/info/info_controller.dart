import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class EditInfoController extends GetxController {
  GetIt sl = GetIt.instance;

  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();
  bool isLoading = false;

  TextEditingController textEditFullnameController = TextEditingController();
  TextEditingController textEditAddressController = TextEditingController();

  // avatar file
  File? avatarFile;
  String? avatarPath;

  @override
  void onInit() {
    // first load
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        print(value);
        userProvider.find(
          id: value!,
          onSuccess: (userData) {
            textEditFullnameController.text = userData.fullname!;
            textEditAddressController.text = userData.address!;
            avatarPath = userData.avatar;
            update();
            EasyLoading.dismiss();
          },
          onError: (error) {
            print(error);
          },
        );
      },
    );
    super.onInit();
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
  /// on button Update click
  ///
  void onBtnUpdateClick(BuildContext context) {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      // kiểm tra mã giới thiệu đúng không
      userProvider.find(
          id: value!,
          onSuccess: (userData) {
            // validate input user
            final bool isValid = _checkValidateInput();

            if (isValid) {
              imageProvider.add(
                file: avatarFile!,
                onSuccess: (image) {
                  // create model
                  userData.fullname = textEditFullnameController.text;
                  userData.address = textEditAddressController.text;
                  userData.avatar = image.data;
                  avatarPath = image.data;
                  // chờ duyệt
                  // user.status = '1';

                  // show loading
                  EasyLoading.show(status: 'loading...');

                  // print(userData.toHaveIdJson());

                  userProvider.update(
                    data: userData,
                    onSuccess: (user) {
                      // Thực hiện update
                      print("User updated");
                      Get.back();
                      showAnimatedDialog(
                        context,
                        const MyDialog(
                          icon: Icons.check,
                          title: "Hoàn tất",
                          description: "Cập nhật hoàn tất",
                        ),
                        dismissible: false,
                        isFlip: true,
                      );
                      update();
                      EasyLoading.dismiss();
                    },
                    onError: (error) {
                      print(error);
                      update();
                    },
                  );
                },
                onError: (error) {},
              );
            }
          },
          onError: (error) {
            print(error);
            update();
          });
    });
  }

  ///
  /// check validate input
  ///
  bool _checkValidateInput() {
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

    if (avatarFile == null && avatarPath == null) {
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
