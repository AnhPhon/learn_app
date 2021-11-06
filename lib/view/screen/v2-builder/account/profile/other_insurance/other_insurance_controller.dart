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
import 'package:template/utils/alert.dart';

class V2OtherInsuranceController extends GetxController {
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

    dangKyBaoHiemProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (data) {
        //get insurance
        baoHiemProvider.paginate(
          page: 1,
          limit: 5,
          filter: "&loai=2&sortBy=created_at:desc",
          onSuccess: (value) {
            baoHiemResponse = value;
            if (data.isNotEmpty) {
              for (var i = 0; i < data.length; i++) {
                final index = baoHiemResponse.indexWhere(
                    (element) => element.id == data[i].idBaoHiem!.id);
                if (index != -1) {
                  baoHiemResponse.removeAt(index);
                }
                if (i == data.length - 1) {
                  //generate list
                  isChecked =
                      List<bool>.generate(baoHiemResponse.length, (_) => false);

                  isLoading = false;
                  update();
                }
              }
            } else {
              //generate list
              isChecked =
                  List<bool>.generate(baoHiemResponse.length, (_) => false);

              isLoading = false;
              update();
            }
          },
          onError: (error) {
            print("V2OtherInsuranceController getInsurance onError $error");
          },
        );
      },
      onError: (error) {
        print("V2OtherInsuranceController dangKyBaoHiem onError $error");
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
    Get.toNamed(AppRoutes.V2_INSURANCE_DETAIL);
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
              print("V2OtherInsuranceController dangKyMuaBtn onError $error");
            },
          );
        }
        if (i == isChecked!.length - 1) {
          Get.back();
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
        Get.back();

        //show dialog
        Alert.success(message: 'Đăng ký tư vấn thành công');
      },
      onError: (error) {
        print("V2OtherInsuranceController dangKyTuVanBtn onError $error");
      },
    );
  }
}
