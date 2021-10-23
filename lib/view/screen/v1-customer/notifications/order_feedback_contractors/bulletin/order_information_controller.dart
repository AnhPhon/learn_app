import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/data/model/response/dang_ky_bao_hiem_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/data/repository/tuyen_dung_repository.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/provider/tuyen_dung_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';

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

  TuyenDungRepository tuyenDungRepository = TuyenDungRepository();

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
  TuyenDungRequest? tuyenDungRequest;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //set value frist
    tuyenDungRequest = Get.arguments as TuyenDungRequest;
    if (tuyenDungRequest != null) {
      soTien = double.parse(tuyenDungRequest!.soTien.toString());
      phiDichVu = double.parse(tuyenDungRequest!.phiDichVu.toString());
      khuyenMai = double.parse(tuyenDungRequest!.khuyenMai.toString());
      tongTien = double.parse(tuyenDungRequest!.tongDon.toString());
      isLoading = false;
    }
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
    Get.toNamed(
            '${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${tongTien.toStringAsFixed(0)}&url=${AppRoutes.V1_DASHBOARD}')!
        .then((value) {
      if (value == true) {
        SnackBarUtils.showSnackBarSuccess(
            title: 'Thao tác thành công',
            message: 'Đăng tin tuyển dụng thành công');
        //set trạng thái đã thanh toán
        tuyenDungRequest!.idTrangThaiThanhToan = "61604f4cc8e6fa122227e29f";
        //insert db
        tuyenDungRepository.add(tuyenDungRequest!).then((value) => {
              if (value.response.data != null)
                {
                  Get.offAllNamed(AppRoutes.V1_CANDICATE,
                      predicate: ModalRoute.withName(AppRoutes.V1_CANDICATE))
                }
              else
                SnackBarUtils.showSnackBar(
                    title: 'Thao tác thất bại',
                    message: 'Vui lòng thực hiện lại')
            });
      } else {
        SnackBarUtils.showSnackBarSuccess(
            title: 'Thao tác thành công',
            message: 'Đăng tin tuyển dụng thành công');
        //set trạng thái chưa thanh toán
        tuyenDungRequest!.idTrangThaiThanhToan = "61615180e87a9124404abe82";
        //insert db
        tuyenDungRepository.add(tuyenDungRequest!).then((value) => {
              if (value.response.data != null)
                {
                  Get.offAllNamed(AppRoutes.V1_CANDICATE,
                      predicate: ModalRoute.withName(AppRoutes.V1_CANDICATE))
                }
              else
                {
                  SnackBarUtils.showSnackBar(
                      title: 'Thao tác thất bại',
                      message: 'Vui lòng thực hiện lại')
                }
            });
      }
    });
  }
}
