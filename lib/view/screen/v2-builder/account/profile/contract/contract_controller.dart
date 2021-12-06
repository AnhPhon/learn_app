import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dang_ky_hop_dong_s_b_s_request.dart';
import 'package:template/data/model/response/dang_ky_hop_dong_s_b_s_response.dart';
import 'package:template/data/model/response/thong_tin_dang_ky_hop_dong_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_hop_dong_s_b_s_provider.dart';
import 'package:template/provider/thong_tin_dang_ky_hop_dong_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

class V2ContractController extends GetxController {
  //DangKyHopDongSBS
  DangKyHopDongSBSProvider dangKyHopDongSBSProvider =
      GetIt.I.get<DangKyHopDongSBSProvider>();
  DangKyHopDongSBSResponse? dangKyHopDongSBSResponse;
  DangKyHopDongSBSRequest dangKyHopDongSBSRequest = DangKyHopDongSBSRequest();

  //ThongTinDangKyHopDong
  ThongTinDangKyHopDongProvider thongTinDangKyHopDongProvider =
      GetIt.I.get<ThongTinDangKyHopDongProvider>();
  ThongTinDangKyHopDongResponse? thongTinDangKyHopDongResponse;

  // check box
  bool isChecked1 = false;
  bool isChecked2 = false;

  //title appbar
  String title = "Hợp đồng nguyên tắc với FSS";

  //user id
  String userId = "";

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get load data
    getContract();
  }

  ///
  ///get contract
  ///
  Future<void> getContract() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get contract
    thongTinDangKyHopDongProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&loai=2&sortBy=created_at:desc",
      onSuccess: (contract) {
        //check is not empty
        if (contract.isNotEmpty) {
          thongTinDangKyHopDongResponse = contract.first;
        }

        //check contract already exits
        dangKyHopDongSBSProvider.paginate(
          page: 1,
          limit: 10,
          filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
          onSuccess: (value) {
            //check is not empty
            if (value.isNotEmpty) {
              dangKyHopDongSBSResponse = value.first;
              IZIAlert.success(message: "Bạn đã đăng ký hợp đồng với FSS");
            }

            isLoading = false;
            update();
          },
          onError: (error) {
            print("V2ContractController getContract onError $error");
          },
        );
      },
      onError: (error) {
        print("V2ContractController getContract onError $error");
      },
    );
  }

  ///
  ///set selected checkBox
  ///
  void setSeletedCheckBox1({bool? value}) {
    isChecked1 = value!;
    update();
  }

  ///
  ///set selected checkBox
  ///
  void setSeletedCheckBox2({bool? value}) {
    isChecked2 = value!;
    update();
  }

  ///
  ///accept click
  ///
  void onBtnAceptClick(BuildContext context) {
    //validate
    if (isChecked1 && isChecked2) {
      //check contract already exits
      if (dangKyHopDongSBSResponse == null) {
        //set data
        dangKyHopDongSBSRequest.idTaiKhoan = userId;
        dangKyHopDongSBSRequest.trangThai = "0";
        dangKyHopDongSBSRequest.file = thongTinDangKyHopDongResponse!.noiDung;
        dangKyHopDongSBSProvider.add(
          data: dangKyHopDongSBSRequest,
          onSuccess: (value) {
            //get back and show dialog
            Get.back(result: true);
            IZIAlert.success(message: 'Đăng ký hợp đông nguyên tắc thành công');
          },
          onError: (error) {
            print("V2ContractController onBtnAceptClick onError $error");
          },
        );
      } else {
        //set data
        dangKyHopDongSBSRequest.id = dangKyHopDongSBSResponse!.id;
        dangKyHopDongSBSRequest.idTaiKhoan = userId;
        dangKyHopDongSBSRequest.trangThai = "1";
        dangKyHopDongSBSRequest.file = thongTinDangKyHopDongResponse!.noiDung;

        //update
        dangKyHopDongSBSProvider.update(
          data: dangKyHopDongSBSRequest,
          onSuccess: (value) {
            //get back and show dialog
            Get.back(result: true);
            IZIAlert.success(message: 'Đăng ký hợp đông nguyên tắc thành công');
          },
          onError: (error) {
            print("V2ContractController onBtnAceptClick onError $error");
          },
        );
      }
    } else {
      // show errors
      IZIAlert.error(message: 'Vui lòng chọn đồng ý với tất cả nội dung');
    }
  }
}
