import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/data/model/response/cham_cong_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';

class V4TimekeepingController extends GetxController {
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();
  List<ChamCongResponse> chamCongList = [];

  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();

  //Tỉnh thành phố
  List<TinhTpResponse> tinhTps = [];
  TinhTpResponse? tinh;

  //Quận / Huyện
  List<QuanHuyenResponse> quanHuyenList = [];
  QuanHuyenResponse? quanHuyen;

  // Phường / Xã
  List<PhuongXaResponse> phuongXaList = [];
  PhuongXaResponse? phuongXa;

  // Dự án của nhân viên
  List<DuAnNhanVienResponse> duAnNhanVienList = [];
  DuAnNhanVienResponse? duAnNhanVien;

  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo Thời gian chấm công phải trùng với thời gian hiện tại
  final timekeeping = TextEditingController(
      text: DateConverter.estimatedDateMonthYear(DateTime.now()));

  //Khai báo TextEditingController của địa chỉ chấm công
  final addressController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTinhThanh();
    getDuAnNhanVien();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    addressController.dispose();
  }

  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse duAnNhanVien) {
    this.duAnNhanVien = duAnNhanVien;
    update();
  }

  ///
  ///Lấy dự án của nhân viên
  ///
  void getDuAnNhanVien() {
    duAnNhanVienProvider.all(
      onSuccess: (value) {
        duAnNhanVienList.clear();
        if (value.isNotEmpty) {
          duAnNhanVienList.addAll(value);
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
        update();
      },
    );
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    tinh = tinhTp;
    getQuanHuyen(id: tinhTp.id);
    phuongXaList.clear();
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    this.quanHuyen = quanHuyen;
    getPhuongXa(id: quanHuyen.id);
    update();
  }

  ///
  ///Thay đổi phường xã
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    this.phuongXa = phuongXa;
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
          quanHuyenList.clear();
          if (data.isNotEmpty) {
            quanHuyenList.addAll(data);
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }

  ///
  /// Lấy tất cả phường xã
  ///
  void getPhuongXa({String? id}) {
    phuongXaProvider.paginate(
        filter: '&idQuanHuyen=$id',
        limit: 100,
        page: 1,
        onSuccess: (data) {
          phuongXaList.clear();
          if (data.isNotEmpty) {
            phuongXaList.addAll(data);
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }

  ///
  /// Check rỗng
  ///
  bool validate() {
    if (addressController.text.toString().isEmpty) {
      Get.snackbar("Địa chỉ không hợp lệ!", "Vui lòng nhập địa chỉ hợp lệ!");
      return false;
    }
    if (tinh == null) {
      Get.snackbar("Tỉnh không hơp lệ!", "Vui lòng chọn tỉnh hợp lệ!");
      return false;
    }
    if (quanHuyen == null) {
      Get.snackbar(
          "Quận huyện không hơp lệ!", "Vui lòng chọn quận huyện hợp lệ!");
      return false;
    }
    if (phuongXa == null) {
      Get.snackbar(
          "Phường xã không hơp lệ!", "Vui lòng chọn phường xã hợp lệ!");
      return false;
    }
    return true;
  }

  ///
  ///Chấm công
  ///
  void onChamCong() {
    if (validate()) {
      chamCongProvider.add(
        data: ChamCongRequest(
          thoiGianBatDau: timekeeping.text,
          idDuAnNhanVien: duAnNhanVien!.id,
          diaChi: addressController.text,
          idTinhTp: tinh!.id,
          idQuanHuyen: quanHuyen!.id,
          idPhuongXa: phuongXa!.id,
        ),
        onSuccess: (value) {
          Get.back(result: true);
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        },
      );
    }
  }
}
