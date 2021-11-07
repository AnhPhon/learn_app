import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/dang_ky_thue_request.dart';
import 'package:template/data/model/response/dang_ky_thue_response.dart';
import 'package:template/data/model/response/thong_tin_thue_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_thue_provider.dart';
import 'package:template/provider/thong_tin_thue_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V2TaxRegisterController extends GetxController {
  //TextEditingController
  final taxController = TextEditingController();

  // ThongTinThue
  ThongTinThueProvider thongTinThueProvider =
      GetIt.I.get<ThongTinThueProvider>();
  ThongTinThueResponse thongTinThueResponse = ThongTinThueResponse();

  //DangKyThue
  DangKyThueProvider dangKyThueProvider = GetIt.I.get<DangKyThueProvider>();
  List<DangKyThueResponse> dangKyThueResponse = [
    DangKyThueResponse(),
    DangKyThueResponse(),
  ];
  DangKyThueRequest dangKyThueRequest = DangKyThueRequest();

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  List<List<String>> hinhAnhs = [[], []];
  //map tab
  Map<String, String> titleTabBar = {
    "GT": "Giới thiệu",
    "DK": "Đăng ký thuế",
    "CK": "Cam kết thuế",
  };

  //index tab
  int currentIndex = 0;
  //loading
  bool isLoading = true;

  //update
  bool isUpdate = false;

  //userid
  String userId = '';

  //title appbar
  String title = "Đăng ký và cam kết thuế";

  @override
  void onInit() {
    super.onInit();
    getContentTax();
    getUserId().then((value) {
      getTax();
    });
  }

  @override
  void onClose() {
    taxController.dispose();
    super.onClose();
  }

  ///
  ///get userid
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///get tax
  ///
  void getTax() {
    //get tax by user id
    dangKyThueProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          //if tax already exits => set data to taxController
          for (final item in value) {
            if (item.loai == "1") {
              dangKyThueResponse[0] = item;
              taxController.text = item.file!;
              hinhAnhs[0] = item.hinhAnhs!.map((e) => e.toString()).toList();
            } else {
              dangKyThueResponse[1] = item;
              hinhAnhs[1] = item.hinhAnhs!.map((e) => e.toString()).toList();
            }
            if (item.id == value.last.id) {
              isLoading = false;
              update();
            }
          }
        } else {
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print("V2TaxController getTax onError $error");
      },
    );
  }

  ///
  ///get tax
  ///
  void getContentTax() {
    thongTinThueProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&loai=2&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          thongTinThueResponse = value.first;
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V2AccidentInsuranceController getInsurance onError $error");
      },
    );
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
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
          hinhAnhs[currentIndex - 1] = value.files!;
        }
        update();
      },
      onError: (error) {
        EasyLoading.dismiss();
        print("V2TaxController uploadImage onError $error");
      },
    );
  }

  ///
  ///on click btn done
  ///
  void onBtnDoneClick() {
    if (currentIndex == 1) {
      //validate
      if (taxController.text.isNotEmpty) {
        //show loading
        EasyLoading.show(status: 'loading...');

        //set data
        dangKyThueRequest.idTaiKhoan = userId;
        dangKyThueRequest.trangThai = "0";
        dangKyThueRequest.file = taxController.text;
        dangKyThueRequest.loai = "1";
        if (hinhAnhs[0].isNotEmpty) {
          dangKyThueRequest.hinhAnhs = hinhAnhs[0];
        }

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
            print("V2TaxController onBtnDoneClick onError $error");
          },
        );
      } else {
        // show errors
        EasyLoading.dismiss();
        Alert.error(message: 'Vui lòng điền mã số thuế');
      }
    } else {
      if (hinhAnhs[1].isNotEmpty) {
        //set data
        dangKyThueRequest.idTaiKhoan = userId;
        dangKyThueRequest.trangThai = "0";
        dangKyThueRequest.loai = "2";
        dangKyThueRequest.hinhAnhs = hinhAnhs[1];

        //cam ket thue
        dangKyThueProvider.add(
          data: dangKyThueRequest,
          onSuccess: (value) {
            //dismiss loading
            EasyLoading.dismiss();
            Get.back();

            //show dialog
            Alert.success(message: 'Cam kết thuế thành công');
          },
          onError: (error) {
            print("V2TaxController onBtnDoneClick onError $error");
          },
        );
      }
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
      dangKyThueRequest.id = dangKyThueResponse[1].id;
      dangKyThueRequest.hinhAnhs = hinhAnhs[1];

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
          print("V2TaxController onBtnUpdate onError $error");
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
