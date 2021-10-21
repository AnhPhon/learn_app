import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/dang_ky_bao_hiem_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/provider/tuyen_dung_provider.dart';
import 'package:template/routes/app_routes.dart';

class OrderInformationController extends GetxController {
  // Provider
  final DonDichVuProvider donDichVuProvider = DonDichVuProvider();
  final TuyenDungProvider tuyenDungProvider = TuyenDungProvider();
  final DonHangProvider donHangProvider = DonHangProvider();
  final DangKyBaoHiemProvider dangKyBaoHiemProvider = DangKyBaoHiemProvider();

  // value Model
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();
  TuyenDungResponse tuyenDungResponse = TuyenDungResponse();
  DonHangResponse donHangResponse = DonHangResponse();
  DangKyBaoHiemResponse dangKyBaoHiemResponse = DangKyBaoHiemResponse();

  //isLoading
  bool isLoading = true;

  //value tiền đơn hàng
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;
  double tienCoc = 0;

  //value result
  dynamic result;

  //value parameter
  String? type;
  String? idFind;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //set value frist
    result = Get.arguments;
    if (result != null) {
      type = result['type'].toString();
      idFind = result['id'].toString();
      if (type == '1') {
        //load data đơn dịch vụ
        getDataDonDichVu(id: idFind!);
      } else if (type == '2') {
        //load data tuyển dụng
        getDataTuyenDung(id: idFind!);
      } else {
        //load data đơn hàng
        getDataDonHang(id: idFind!);
      }
    }
  }

  ///
  ///get data đơn dịch vụ
  ///
  void getDataDonDichVu({required String id}) {
    donDichVuProvider.find(
        id: id,
        onSuccess: (value) {
          //add value
          donDichVuResponse = value;

          //set số tiền đơn hàng
          soTien = double.parse(donDichVuResponse.soTien.toString());
          phiDichVu = double.parse(donDichVuResponse.phiDichVu.toString());
          khuyenMai = double.parse(donDichVuResponse.khuyenMai.toString());
          tongTien = double.parse(donDichVuResponse.tongDon.toString());
          tienCoc = double.parse(donDichVuResponse.tienCoc.toString());
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('OrderInformationController getDataDonDichVu $error'));
  }

  ///
  ///get data tuyen dung
  ///
  void getDataTuyenDung({required String id}) {
    tuyenDungProvider.find(
        id: id,
        onSuccess: (value) {
          //add value
          tuyenDungResponse = value;
          print('bbbb ${tuyenDungResponse.toJson()}');

          //set số tiền đơn hàng
          soTien = double.parse(tuyenDungResponse.soTien.toString());
          phiDichVu = double.parse(tuyenDungResponse.phiDichVu.toString());
          khuyenMai = double.parse(tuyenDungResponse.khuyenMai.toString());
          tongTien = double.parse(tuyenDungResponse.tongDon.toString());
          tienCoc = double.parse(tuyenDungResponse.tienCoc.toString());
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('OrderInformationController getDataTuyenDung $error'));
  }

  ///
  ///get data đơn hàng
  ///
  void getDataDonHang({required String id}) {
    donHangProvider.find(
        id: id,
        onSuccess: (value) {
          //add value
          donHangResponse = value;

          //set số tiền đơn hàng
          soTien = double.parse(donHangResponse.soTien.toString());
          phiDichVu = double.parse(donHangResponse.phiDichVu.toString());
          khuyenMai = double.parse(donHangResponse.khuyenMai.toString());
          tongTien = double.parse(donHangResponse.tongTien.toString());
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('OrderInformationController getDataDonHang $error'));
  }

  ///
  ///get data bảo hiểm (xem lại đã)
  ///
  // void getDataBaoHiem({required String id}) {
  //   dangKyBaoHiemProvider.find(
  //       id: id,
  //       onSuccess: (value) {
  //         //add value
  //         dangKyBaoHiemResponse = value;

  //         //set số tiền đơn hàng
  //         soTien = double.parse(dangKyBaoHiemResponse.toString());
  //         phiDichVu = double.parse(donDichVuResponse.phiDichVu.toString());
  //         khuyenMai = double.parse(donDichVuResponse.khuyenMai.toString());
  //         tongTien = double.parse(donDichVuResponse.tongDon.toString());
  //         isLoading = false;
  //         update();
  //       },
  //       onError: (error) =>
  //           print('OrderInformationController getDataBaoHiem $error'));
  // }

  ///
  ///onBtnGoHome
  ///
  void onBtnGoHome() {
    Get.offAllNamed(AppRoutes.V1_DASHBOARD,
        predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD));
  }

  ///
  /// Nhấn vào đông ý đơn hàng
  ///
  void onNextPage() {
    Get.toNamed(AppRoutes.V1_FORMAL_PAYMENT);
  }
}
