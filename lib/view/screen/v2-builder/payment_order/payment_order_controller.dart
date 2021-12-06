import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/cai_dat_chung_response.dart';
import 'package:template/data/model/response/phi_app_response.dart';
import 'package:template/provider/cai_dat_chung_provider.dart';
import 'package:template/provider/phi_app_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/screen/payment/payment_account/patment_dialog_accept.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';

class V2PaymentOrderController extends GetxController {
  String title = "Thanh toán đơn hàng";

  final CaiDatChungProvider caiDatChungProvider = GetIt.I.get<CaiDatChungProvider>();
  final PhiAppProvider phiAppProvider = GetIt.I.get<PhiAppProvider>();

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

  //khuyenMai
  double phanTramKhuyenMai = 0;

  //phí dịch vụ
  double phanTramPhiDichVu = 0;

  //idDonDichVu
  String? idDonDichVu;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //set data
    //check số tiền
    if (Get.parameters['soTien'] != null) {
      // Gia su 1 trieu
      soTien = double.parse(Get.parameters['soTien'].toString());
    }

    //check tiền cọc
    if (Get.parameters['tienCoc'] != null) {
      // Gia su 100k
      tienCoc = double.parse(Get.parameters['tienCoc'].toString());
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
        onError: (error) => print('OrderInformationController getDataPhiDichVuKhuyenMai $error'));
  }

  void getDataPhiApp() {
    //get phí app
    phiAppProvider.all(
        onSuccess: (value) {
          phiAppResponse = value;

          for (int i = 0; i < phiAppResponse.length; i++) {
            if (soTien > phiAppResponse[i].donGiaBatDau! && soTien <= phiAppResponse[i].donGiaKetThuc!) {
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
            tongTien = 0;
          } else {
            tongTien = tienCoc + phiDichVu - khuyenMai;
          }

          isLoading = false;
          update();
        },
        onError: (error) => print('OrderInformationController getDataPhiDichVuKhuyenMai $error'));
  }

  //
  // ///
  // ///cancel
  // ///
  // void onCancleClick() {
  //   Get.back();
  // }
  //
  // ///
  // ///go to payment_account page
  // ///
  // void onCheckoutClick() {
  //   // Get.toNamed("${AppRoutes.V2_PAYMENT_METHOD}?isBuy=false");
  //
  //   // Get.toNamed(
  //   //     '${AppRoutes.ORDER_INFORMATION}?soTien=${tuyenDungRequest.soTien!}&tienCoc=${tuyenDungRequest.tienCoc}').then((value) => null)
  // }

  ///
  ///dialog button back
  ///
  void onCancleClick() {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        contentPadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        title: "Bạn có chắc chắn muốn hủy thanh toán không?",
        content: PaymentDialogAccept(
          textContent: 'Bấm nút hủy thanh toán để thoát trang thanh toán, nút trở lại để đóng popup',
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
  ///  Hiển thị xác nhận
  ///
  void onCheckoutClick() {
    Get.defaultDialog(
        title: "Xác nhận thông tin",
        content: DialogContentPriceAccept(
          textContent: 'Bạn chắc chắn đồng ý thanh toán đơn hàng với tổng số tiền',
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
    Get.toNamed('${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${tongTien.toStringAsFixed(0)}&noiDung=Thanh toán đơn dịch vụ')!.then((value) {
      if (value != null && value['status'] == true) {
        print('OrderInformationController onNextPage callback $value ');
        //set value param
        param['type'] = value['type'];
        param['hinhAnhHoaDon'] = value['type'] == 2 ? value['hinhAnhHoaDon'] : '';
        param['phiDichVu'] = phiDichVu.toStringAsFixed(0);
        param['khuyenMai'] = khuyenMai.toStringAsFixed(0);

        Get.back(result: param);
      }
    });
  }
}
