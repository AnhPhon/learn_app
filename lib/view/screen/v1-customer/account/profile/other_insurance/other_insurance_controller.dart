import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/request/dang_ky_bao_hiem_request.dart';
import 'package:template/data/model/request/tu_van_request.dart';
import 'package:template/data/model/response/bao_hiem_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/bao_hiem_provider.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/provider/tu_van_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';
import 'package:template/utils/alert.dart';

class V1OtherInsuranceController extends GetxController {
  //DangKyBaoHiem
  DangKyBaoHiemProvider dangKyBaoHiemProvider = DangKyBaoHiemProvider();
  DangKyBaoHiemRequest dangKyBaoHiemRequest = DangKyBaoHiemRequest();

  //TuVan
  TuVanProvider tuVanProvider = TuVanProvider();
  TuVanRequest tuVanRequest = TuVanRequest();

  //BaoHiem
  BaoHiemProvider baoHiemProvider = BaoHiemProvider();
  List<BaoHiemResponse> baoHiemResponse = [];

  //title appbar
  String title = "Đăng ký tư vấn bảo hiểm khác";

  //user id
  String userId = "";

  //check box value
  List<bool>? isChecked;

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get laod data
    getInsurance();
  }

  ///
  ///get insurance
  ///
  Future<void> getInsurance() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get insurance
    baoHiemProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&loai=2&sortBy=created_at:desc",
      onSuccess: (value) {
        baoHiemResponse = value;

        //generate list
        isChecked = List<bool>.generate(value.length, (_) => false);

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1OtherInsuranceController getInsurance onError $error");
      },
    );
  }

  ///
  ///set checked
  ///
  void setChecked({int? index, bool? value}) {
    isChecked![index!] = value!;
    update();
  }

  ///
  ///on checkout click
  ///
  void onInsuranceDetailClick() {
    Get.toNamed(AppRoutes.V1_INSURANCE_DETAIL);
  }

  ///
  ///dang ky mua
  ///
  void dangKyMuaBtn(BuildContext context) {
    if (isChecked!.indexWhere((element) => element == true) != -1) {
      for (var i = 0; i < isChecked!.length; i++) {
        //check value of check box
        if (isChecked![i] == true) {
          //set data
          dangKyBaoHiemRequest.idTaiKhoan = userId;
          dangKyBaoHiemRequest.idBaoHiem = baoHiemResponse[i].id;
          dangKyBaoHiemRequest.trangThai = "0";

          //register
          dangKyBaoHiemProvider.add(
            data: dangKyBaoHiemRequest,
            onSuccess: (value) {},
            onError: (error) {
              print("V1OtherInsuranceController dangKyMuaBtn onError $error");
            },
          );
        }
        if (i == isChecked!.length - 1) {
          Get.back();

          //show dialog
          Alert.success(message: 'Đăng ký mua bảo hiểm thành công');
        }
      }
    } else {
      // show errors
      Alert.error(message: 'Vui lòng chọn bảo hiểm muốn mua');
    }
  }

  ///
  ///dang ky tu van
  ///
  void dangKyTuVanBtn(BuildContext context) {
    tuVanRequest.idTaiKhoan = userId;
    tuVanRequest.chuDeTuVan = "Tư vấn bảo hiểm";
    tuVanRequest.trangThai = "1";
    tuVanProvider.add(
      data: tuVanRequest,
      onSuccess: (value) {
        //go to checkout page
        Get.back();

        //show dialog
        Alert.success(message: 'Đăng ký tư vấn thành công');
      },
      onError: (error) {
        print("V1OtherInsuranceController dangKyTuVanBtn onError $error");
      },
    );
  }
}
