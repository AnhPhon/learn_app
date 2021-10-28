import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/data/model/response/bang_gia_dang_tin_response.dart';
import 'package:template/data/model/response/bang_gia_loc_ho_so_response.dart';
import 'package:template/data/repository/tuyen_dung_repository.dart';
import 'package:template/provider/bang_gia_dang_tin_provider.dart';
import 'package:template/provider/bang_gia_loc_ho_so_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

class V1G7PriceListController extends GetxController {
  //provider

  final BangGiaDangTinProvider bangGiaDangTinProvider =
      GetIt.I.get<BangGiaDangTinProvider>();
  final BangGiaLocHoSoProvider bangGiaLocHoSoProvider =
      GetIt.I.get<BangGiaLocHoSoProvider>();
  final TuyenDungRepository tuyenDungRepository =
      GetIt.I.get<TuyenDungRepository>();

  //value model
  List<BangGiaDangTinResponse> bangGiaDangTinModel = [];
  List<BangGiaLocHoSoResponse> bangGiaLocHoSoModel = [];
  //value tuyển dụng
  TuyenDungRequest tuyenDungRequest = TuyenDungRequest();

  // isloading
  bool isLoading = true;

  //value chọn bảng giá
  String? chooseDangTin;
  String? chooseLocHoSo;

  //value tính tiền
  double tienDangTin = 0;
  double tienLocHoSo = 0;
  double tongTien = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //set value tuyển dụng
    tuyenDungRequest = Get.arguments as TuyenDungRequest;
    tuyenDungRequest.gioiTinh = tuyenDungRequest.gioiTinh == "1" ? "Nam" : "Nữ";

    //get load data bảng giá
    getDataBangGiaDangTin();
    // getDataBangGiaLocHoSo();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  /// load data hình thức làm việc
  ///
  void getDataBangGiaDangTin() {
    //list hinh thuc lam iec
    bangGiaDangTinProvider.all(
        onSuccess: (value) {
          //add list
          bangGiaDangTinModel = value;

          //set chọn đầu tiên
          getChangeDangTin(value.first.id.toString());
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7PriceListController getDataBangGiaDangTin $error'));
  }

  ///
  /// load data hình thức làm việc
  ///
  void getDataBangGiaLocHoSo() {
    //list hinh thuc lam iec
    bangGiaLocHoSoProvider.all(
        onSuccess: (value) {
          //add list
          bangGiaLocHoSoModel = value;

          //set chọn đầu tiên
          getChangeLocHoSo(value.first.id.toString());
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7PriceListController getDataBangGiaLocHoSo $error'));
  }

  ///
  ///Chọn đăng tin
  ///
  void getChangeDangTin(String val) {
    chooseDangTin = val.toString();

    //set tiền
    tienDangTin = 0;
    tienDangTin = double.parse(bangGiaDangTinModel
        .firstWhere((element) => element.id!.contains(val))
        .donGia
        .toString());

    update();
  }

  ///
  ///Chọn lọc hồ sơ
  ///
  void getChangeLocHoSo(String val) {
    chooseLocHoSo = val;

    //set tiền
    tienLocHoSo = 0;
    tienLocHoSo = double.parse(bangGiaLocHoSoModel
        .firstWhere((element) => element.id!.contains(val))
        .donGia
        .toString());
    update();
  }

  ///
  /// Nhấn tiếp tục
  ///
  void onClickContinueButton() {
    tongTien = 0;
    tongTien = tienDangTin;
    //set value tuyendung
    tuyenDungRequest.soTien = tongTien.toStringAsFixed(0);
    tuyenDungRequest.tienCoc = '0';
    tuyenDungRequest.loaiTin = '2';

    Get.toNamed(
            '${AppRoutes.ORDER_INFORMATION}?soTien=${tuyenDungRequest.soTien!}&tienCoc=${tuyenDungRequest.tienCoc}&isTuyenDung=true')!
        .then((value) => {
              //đã thanh toán
              if (value != null && value['type'] == 1)
                {
                  //set trạng thái đã thanh toán
                  tuyenDungRequest.idTrangThaiThanhToan =
                      app_constants.TUYEN_DUNG_DA_THANH_TOAN,
                  tuyenDungRequest.phiDichVu = value['phiDichVu'].toString(),
                  tuyenDungRequest.khuyenMai = value['khuyenMai'].toString(),
                  tuyenDungRequest.tongDon = value['tongTien'].toString(),
                  //insert db
                  tuyenDungRepository.add(tuyenDungRequest).then((value) => {
                        if (value.response.data != null)
                          {
                            Get.back(result: true),
                            Alert.success(
                                message: 'Đăng tin tuyển dụng thành công'),
                          }
                        else
                          Alert.error(message: 'Vui lòng thực hiện lại')
                      })
                }
              //chưa thanh toán
              else if (value != null && value['type'] == 2)
                {
                  //set trạng thái chưa thanh toán
                  tuyenDungRequest.idTrangThaiThanhToan =
                      app_constants.TUYEN_DUNG_CHUA_THANH_TOAN,
                  tuyenDungRequest.phiDichVu = value['phiDichVu'].toString(),
                  tuyenDungRequest.khuyenMai = value['khuyenMai'].toString(),
                  tuyenDungRequest.tongDon = value['tongTien'].toString(),
                  //insert db
                  tuyenDungRepository.add(tuyenDungRequest).then((value) => {
                        if (value.response.data != null)
                          {
                            Get.back(result: true),
                            Alert.success(
                                message: 'Đăng tin tuyển dụng thành công'),
                          }
                        else
                          {Alert.error(message: 'Vui lòng thực hiện lại')}
                      })
                }
            });
  }
}
