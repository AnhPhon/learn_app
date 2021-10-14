import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/cham_cong_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';

class V4TimekeepingController extends GetxController {
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();

  List<ChamCongResponse> chamCongList = [];

  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();

  List<TinhTpResponse> tinhTpModelList = [];

  List<String> tinhTpList = [];

  String? tinhTp;
  //Khai báo isLoading
  bool isLoading = true;

  final timekeeping = TextEditingController();
  final project = TextEditingController();
  final address = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  ///
  ///Get Tỉnh TP
  ///
  void getTinhTp() {
    tinhTpProvider.all(onSuccess: (value) {
      tinhTpModelList = value;
      tinhTpModelList.map((e) => tinhTpList.add(e.ten.toString())).toList();
      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///Set chọn Tỉnh TP
  ///
  void setChonTinhTp(String? value) {
    tinhTp = value;
    update();
  }
}
