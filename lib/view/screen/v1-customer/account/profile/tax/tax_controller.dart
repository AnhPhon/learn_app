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
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V1TaxController extends GetxController {
  //file image
  File? image;
  List<File> taxImageList = [];

  //textEditingController
  final taxController = TextEditingController();

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  List<String> imageUrlList = [];

  //DangKyThue
  DangKyThueProvider dangKyThueProvider = GetIt.I.get<DangKyThueProvider>();
  DangKyThueResponse? dangKyThueResponse;
  DangKyThueRequest dangKyThueRequest = DangKyThueRequest();

  //CircularProgressIndicator
  bool isLoading = true;

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
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          dangKyThueResponse = value.first;

          //if tax already exits => set data to taxController
          if (dangKyThueResponse!.trangThai == "1") {
            taxController.text = dangKyThueResponse!.file!;
          }
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
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      //add file image to list
      taxImageList.add(imageTemporary);

      //convert file to url
      uploadImage(imageFile: imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required File imageFile}) {
    imageUpdateProvider.add(
      file: imageFile,
      onSuccess: (value) {
        //add url to list
        imageUrlList.add(value.data.toString());
      },
      onError: (error) {
        print("V1TaxController uploadImage onError $error");
      },
    );
  }

  ///
  ///on click btn done
  ///
  void onBtnDoneClick(BuildContext context) {
    //validate
    if (taxController.text.isNotEmpty) {
      //show loading
      EasyLoading.show(status: 'loading...');

      //set data
      dangKyThueRequest.idTaiKhoan = userId;
      dangKyThueRequest.trangThai = "1";
      dangKyThueRequest.file = taxController.text;
      dangKyThueRequest.hinhAnhs = imageUrlList;
      dangKyThueRequest.loai = "1";
      // dangKyThueRequest.

      //tax register
      dangKyThueProvider.add(
        data: dangKyThueRequest,
        onSuccess: (value) {
          //dismiss loading
          EasyLoading.dismiss();
          Get.offNamed(AppRoutes.V1_PROFILE);

          //show dialog
          showAnimatedDialog(
            context,
            const MyDialog(
              icon: Icons.check,
              title: "Hoàn tất",
              description: "Đăng ký thuế thành công",
            ),
            dismissible: false,
            isFlip: true,
          );
        },
        onError: (error) {
          print("V1TaxController onBtnDoneClick onError $error");
        },
      );
    } else {
      // show errors
      EasyLoading.dismiss();
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Vui lòng điền mã số thuế",
      );
    }
  }
}
