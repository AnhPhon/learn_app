import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/data/model/response/cai_dat_chung_response.dart';
import 'package:template/data/model/response/dang_ky_bao_hiem_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/data/model/response/phi_app_response.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/data/repository/tuyen_dung_repository.dart';
import 'package:template/provider/cai_dat_chung_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/provider/phi_app_provider.dart';
import 'package:template/provider/tuyen_dung_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/payment/payment%20account/patment_dialog_accept.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';

class OrderInformationController extends GetxController {
  // Provider
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final TuyenDungProvider tuyenDungProvider = GetIt.I.get<TuyenDungProvider>();
  final DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();

  final CaiDatChungProvider caiDatChungProvider =
      GetIt.I.get<CaiDatChungProvider>();
  final PhiAppProvider phiAppProvider = GetIt.I.get<PhiAppProvider>();

  // value Model
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();
  TuyenDungResponse tuyenDungResponse = TuyenDungResponse();
  DonHangResponse donHangResponse = DonHangResponse();
  DangKyBaoHiemResponse dangKyBaoHiemResponse = DangKyBaoHiemResponse();

  TuyenDungRepository tuyenDungRepository = TuyenDungRepository();
  CaiDatChungResponse caiDatChungResponse = CaiDatChungResponse();
  List<PhiAppResponse> phiAppResponse = [];

  //isLoading
  bool isLoading = true;

  //value tiền đơn hàng
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;
  double tienCoc = 0;

  //value parameter
  String? idFind;
  TuyenDungRequest? tuyenDungRequest;

  //khuyenMai
  double phanTramKhuyenMai = 0;
  //phí dịch vụ
  double phanTramPhiDichVu = 0;

  //isTuyenDung
  bool isTuyenDung = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //set data
    //check số tiền
    if (Get.parameters['soTien'] != null) {
      soTien = double.parse(Get.parameters['soTien'].toString());
    }
    //check tiền cọc
    if (Get.parameters['tienCoc'] != null) {
      tienCoc = double.parse(Get.parameters['tienCoc'].toString());
    }

    //check isTuyenDung
    if (Get.parameters['isTuyenDung'] != null &&
        Get.parameters['isTuyenDung'] == 'true') {
      isTuyenDung = true;
    }

    //get data khuyến mãi
    getDataKhuyenMai();
  }

  ///
  ///getDataPhiDichVuKhuyenMai
  ///

  void getDataKhuyenMai() {
    //get khuyến mãi
    caiDatChungProvider.all(
        onSuccess: (value) {
          caiDatChungResponse = value.first;
          if (caiDatChungResponse.khuyenMai != 0) {
            phanTramKhuyenMai = caiDatChungResponse.khuyenMai! / 100;
            //get
            getDataPhiApp();
          }
        },
        onError: (error) => print(
            'OrderInformationController getDataPhiDichVuKhuyenMai $error'));
  }

  void getDataPhiApp() {
    //get phí app
    phiAppProvider.all(
        onSuccess: (value) {
          phiAppResponse = value;

          for (int i = 0; i < phiAppResponse.length; i++) {
            if (soTien > phiAppResponse[i].donGiaBatDau! &&
                soTien <= phiAppResponse[i].donGiaKetThuc!) {
              phanTramPhiDichVu = phiAppResponse[i].phi! / 100;
            }
          }

          //tính phí dịch vụ
          if (phanTramPhiDichVu != 0) {
            phiDichVu = soTien * phanTramPhiDichVu;
          } else {
            phiDichVu = 0;
          }
          //tinh khuyến mãi
          if (phanTramKhuyenMai != 0 && phiDichVu != 0) {
            khuyenMai = phiDichVu * phanTramKhuyenMai;
          } else {
            khuyenMai = 0;
          }

          //tổng tiền nếu tiền cọc = 0 là các dịch vụ ko cần cọc
          if (tienCoc == 0) {
            tongTien = soTien + phiDichVu - khuyenMai;
          } else {
            tongTien = tienCoc + phiDichVu - khuyenMai;
          }

          isLoading = false;
          update();
        },
        onError: (error) => print(
            'OrderInformationController getDataPhiDichVuKhuyenMai $error'));
  }

  ///
  ///dialog button back
  ///
  void showDialogBack() {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        contentPadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        title: "Bạn có chắc chắn muốn hủy thanh toán không?",
        content: PaymentDialogAccept(
          textContent:
              'Bấm nút hủy thanh toán để thoát trang thanh toán, nút trở lại để đóng popup',
          price: 0,
          isShowPrice: false,
        ),
        confirm: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Trở lại")),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorResources.GREY,
            ),
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text("Hủy thanh toán")));
  }

  ///
  ///onBtnGoHome
  ///
  void onBtnGoHome() {
    Get.offAllNamed(AppRoutes.V1_DASHBOARD,
        predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD));
  }

  ///
  ///  Hiển thị xác nhận
  ///
  void showDialogAccept() {
    Get.defaultDialog(
        title: "Xác nhận thông tin",
        content: DialogContentPriceAccept(
          textContent:
              'Bạn chắc chắn đồng ý đăng tin tuyển dụng với tổng số tiền',
          price: tongTien,
        ),
        confirm: ElevatedButton(
            onPressed: () {
              Get.back();
              onNextPage();
            },
            child: const Text("Đồng ý")),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorResources.GREY,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("Hủy")));
  }

  ///
  /// Nhấn vào đông ý đơn hàng
  ///
  void onNextPage() {
    //set param back
    final Map<String, dynamic> param = {
      'type': '',
      'tongTien': tongTien.toStringAsFixed(0),
      'phiDichVu': phiDichVu.toStringAsFixed(0),
      'khuyenMai': khuyenMai.toStringAsFixed(0),
      'hinhAnhHoaDon': '',
    };
    Get.toNamed(
            '${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${tongTien.toStringAsFixed(0)}')!
        .then((value) {
      if (value != null && value['status'] == true) {
        //set value param
        param['type'] = value['type'];
        param['hinhAnhHoaDon'] =
            value['type'] == 2 ? value['hinhAnhHoaDon'] : '';

        Get.back(result: param);
      }
    });
  }
}
