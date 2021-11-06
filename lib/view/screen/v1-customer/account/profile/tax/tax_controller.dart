import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/dang_ky_thue_request.dart';
import 'package:template/data/model/response/dang_ky_thue_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_thue_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V1TaxController extends GetxController {
  //file image
  File? image;
  List<File> taxImageList = [];

  //textEditingController
  final taxController = TextEditingController();

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //DangKyThue
  DangKyThueProvider dangKyThueProvider = GetIt.I.get<DangKyThueProvider>();
  DangKyThueResponse? dangKyThueResponse;
  DangKyThueRequest dangKyThueRequest = DangKyThueRequest();

  //CircularProgressIndicator
  bool isLoading = true;

  //is update
  bool isUpdate = false;

  //user id
  String userId = "";

  //title appbar
  String title = "Hồ sơ thuế của bạn";

  @override
  void onInit() {
    super.onInit();
    //get load data
    getTax();
  }

  @override
  void onClose() {
    taxController.dispose();
    super.onClose();
  }

  ///
  ///get tax
  ///
  Future<void> getTax() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get tax by user id
    dangKyThueProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idTaiKhoan=$userId&loai=1&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          dangKyThueResponse = value.first;

          //if tax already exits => set data to taxController
          if (dangKyThueResponse != null) {
            taxController.text = dangKyThueResponse!.file!;
            dangKyThueRequest.hinhAnhs = dangKyThueResponse!.hinhAnhs;
          }
        } else {
          isUpdate = true;
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1TaxController getTax onError $error");
      },
    );
  }

  ///
  ///pick image
  ///
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');
      //convert file to url
      uploadImage(imageFile: files);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required List<File> imageFile}) {
    imageUpdateProvider.addImages(
      files: imageFile,
      onSuccess: (value) {
        EasyLoading.dismiss();
        if (value.files != null && value.files!.isNotEmpty) {
          dangKyThueRequest.hinhAnhs = value.files;
        }
        update();
      },
      onError: (error) {
        EasyLoading.dismiss();
        print("V1TaxController uploadImage onError $error");
      },
    );
  }

  ///
  ///on click btn done
  ///
  void onBtnDoneClick() {
    //validate
    if (taxController.text.isNotEmpty) {
      //show loading
      EasyLoading.show(status: 'loading...');

      //set data
      dangKyThueRequest.idTaiKhoan = userId;
      dangKyThueRequest.trangThai = "0";
      dangKyThueRequest.file = taxController.text;
      dangKyThueRequest.loai = "1";
      // dangKyThueRequest.

      //tax register
      dangKyThueProvider.add(
        data: dangKyThueRequest,
        onSuccess: (value) {
          //dismiss loading
          EasyLoading.dismiss();
          Get.back();

          //show dialog
          Alert.success(message: 'Đăng ký thuế thành công');
        },
        onError: (error) {
          print("V1TaxController onBtnDoneClick onError $error");
        },
      );
    } else {
      // show errors
      EasyLoading.dismiss();
      Alert.error(message: 'Vui lòng điền mã số thuế');
    }
  }

  ///
  ///on btn update
  ///
  void onBtnUpdate() {
    //show loading
    EasyLoading.show(status: 'loading...');
    if (isUpdate == true) {
      //set data
      dangKyThueRequest.id = dangKyThueResponse!.id;
      dangKyThueRequest.idTaiKhoan = userId;
      dangKyThueRequest.file = taxController.text;

      //update
      dangKyThueProvider.update(
        data: dangKyThueRequest,
        onSuccess: (data) {
          EasyLoading.dismiss();
          Get.back();
          Alert.success(message: "Chỉnh sửa thông tin thuế thành công");
        },
        onError: (error) {
          EasyLoading.dismiss();
          print("V1TaxController onBtnUpdate onError $error");
        },
      );
    } else {
      isUpdate = true;
      EasyLoading.dismiss();
      Alert.info(message: "Cho phép chỉnh sửa thông tin thuế");
      update();
      return;
    }
  }
}
