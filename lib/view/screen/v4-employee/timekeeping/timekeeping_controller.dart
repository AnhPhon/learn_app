import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/cham_cong_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';

class V4TimekeepingController extends GetxController {
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();

  List<ChamCongResponse> chamCongList = [];

  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();

  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();

  //Tỉnh thành phố
  List<TinhTpResponse> tinhTps = [];

  TinhTpResponse? tinh;

  List<QuanHuyenResponse> quanHuyenList = [];
  QuanHuyenResponse? quanHuyen;

  //Khai báo isLoading
  bool isLoading = true;

  final timekeeping = TextEditingController();
  final project = TextEditingController();
  final address = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTinhThanh();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    tinh = tinhTp;
    getQuanHuyen(id: tinhTp.id);
    print(tinh);
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    this.quanHuyen = quanHuyen;
    print(quanHuyen);
    update();
  }

  ///
  /// Lấy tất cả tỉnh thành phố
  ///
  void getTinhThanh() {
    tinhTpProvider.all(onSuccess: (data) {
      tinhTps.clear();

      if (data.isNotEmpty) {
        tinhTps.addAll(data);
        tinh = tinhTps.first;
      }

      isLoading = false;

      update();
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");

      update();
    });
  }

  ///
  /// Lấy tất cả quận huyện
  ///
  void getQuanHuyen({String? id}) {
    quanHuyenProvider.paginate(
        filter: '&idTinhTp=$id',
        limit: 100,
        page: 1,
        onSuccess: (data) {
          print(data);
          quanHuyenList.clear();

          if (data.isNotEmpty) {
            quanHuyenList.addAll(data);

            quanHuyen = quanHuyenList.first;
          }

          isLoading = false;

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }
}
