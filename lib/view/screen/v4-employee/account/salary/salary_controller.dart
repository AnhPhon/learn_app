import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:template/data/model/response/bang_luong_response.dart';

import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bang_luong_provider.dart';

import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class V4SalaryController extends GetxController {
  GetIt sl = GetIt.instance;

  //Bảng lương
  BangLuongProvider bangLuongProvider = GetIt.I.get<BangLuongProvider>();
  List<BangLuongResponse> bangLuongModelList = [];
  BangLuongResponse bangLuongResponse = BangLuongResponse();

//Khai bao isLoading
  bool isLoading = true;

  //Khai báo user id nhân viên
  String idUser = "";

  String fileURL = "";
  String testUrl = "https://www.youtube.com/watch?v=iMzMRhBx9mQ";

  final salaryController = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
      bangLuongProvider.paginate(
        page: 1,
        limit: 5,
        filter: "&idNhanVien=$idUser&sortBy=created_at:desc",
        onSuccess: (value) {
          if (value.isNotEmpty) {
            bangLuongResponse = value.first;
          }
          print(fileURL);
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  static Future openLink({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  ///
  ///Xem bảng lương
  ///
  Future<void> btnXemLuong({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'V1HelpController btnContact Could not launch $url';
    }
  }
}
