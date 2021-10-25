import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:template/data/model/request/danh_sach_tho_thau_bao_gia_request.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/mat_hang_dac_trung_response.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_tho_thau_bao_gia_provider.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

class V3ProjectDangKyTrienKhaiController extends GetxController {
  String title = "";
  String? idProject;
  String? idTaiKhoan;

  DuAnKhachHangProvider duAnKhachHangProvider = GetIt.I.get<DuAnKhachHangProvider>();
  DuAnKhachHangResponse? duAnKhachHangResponse;

  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  TaiKhoanResponse? taiKhoanResponse;

  List<MatHangDacTrungResponse>? currentMatHangDacTrungResponseList = [];
  List<MultiSelectItem<MatHangDacTrungResponse?>> matHangDacTrungMultiSelectItem = [];

  DanhSachThoThauBaoGiaRequest danhSachThoThauBaoGiaRequest = DanhSachThoThauBaoGiaRequest();
  DanhSachThoThauBaoGiaProvider danhSachThoThauBaoGiaProvider = GetIt.I.get<DanhSachThoThauBaoGiaProvider>();

  TextEditingController noiDungMoTaThemController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['idProject'] != null) {
      /// Khoi tao gia tri lay tu argument
      idProject = arguments!['idProject'].toString();
      title = arguments!['title'].toString();

      /// Lay chi tiet du an
      getChiTietDuAn();

      /// Lay nhom dich vu
      getNhomCuaHang();
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }

  /// Goi api chi tiet du an
  void getChiTietDuAn() async {
    danhSachThoThauBaoGiaRequest.idDuAnKhachHang = idProject;
    danhSachThoThauBaoGiaRequest.idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    print('danhSachThoThauBaoGiaRequest.idTaiKhoanBaoGia ${danhSachThoThauBaoGiaRequest.idTaiKhoanBaoGia}');

    duAnKhachHangProvider.find(
      id: idProject.toString(),
      onSuccess: (data) {
        duAnKhachHangResponse = data;
        update();
      },
      onError: (error) {
        print('V3ProjectDangKyTrienKhaiController duAnKhachHangProvider all onError $error');
      },
    );
  }

  /// Goi api lay tat ca nhom dich vu
  void getNhomCuaHang() async {
    idTaiKhoan = await sl.get<SharedPreferenceHelper>().userId;
    print('getNhomCuaHang idTaiKhoan $idTaiKhoan');
    taiKhoanProvider.find(
      id: idTaiKhoan.toString(),
      onSuccess: (data) {
        print('data $data');
        taiKhoanResponse = data;
        selectedNhomCuaHang();
        updateMatHangDacTrung();
        // if(data.idNhomCuaHang != null){
        //
        // }
        // if (data!.isBlank) {
        //   /// Selectbox khong cho phep init null gia tri, nen chon 1 gia tri dau tien de init
        //   selectedNhomCongViec(data[0]);
        // }
        // nhomDichVuResponse = data;
        update();
      },
      onError: (error) {
        print('V3ProjectDangKyTrienKhaiController nhomDichVuProvider onError all $error');
      },
    );
  }

  /// Neu du an dang xay dung tra ve true
  bool kiemTraIdTrangThaiDuAnDangXayDung() {
    if (duAnKhachHangResponse!.idTrangThaiDuAn != null && duAnKhachHangResponse!.idTrangThaiDuAn!.id.toString() == TRANG_THAI_DU_AN['DANG_TRIEN_KHAI']['id']) {
      return true;
    } else {
      return false;
    }
  }

  /// Kiem tra id hang muc xay dung co gia tri hay k0
  bool kiemTraIdHangMucXayDungs() {
    if (duAnKhachHangResponse!.idHangMucXayDungs != null && duAnKhachHangResponse!.idHangMucXayDungs!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  /// Chon nhom cua hang
  void selectedNhomCuaHang() {
    if (taiKhoanResponse!.idNhomCuaHang != null && taiKhoanResponse!.idNhomCuaHang.isBlank == false) {
      danhSachThoThauBaoGiaRequest.idNhomCuaHang = taiKhoanResponse!.idNhomCuaHang!.id.toString();
      update();
    }
  }

  /// Chon cac cong viec trong nhom cong viec
  void selectedMatHangDacTrung(List<MatHangDacTrungResponse?> results) {
    currentMatHangDacTrungResponseList = results.cast<MatHangDacTrungResponse>();
    danhSachThoThauBaoGiaRequest.idMatHangDacTrungs = currentMatHangDacTrungResponseList!.map((e) => e.id.toString()).toList();
  }

  /// Kiem tra dang ky du an
  void moViewDangKyViecMoi() {
    if (danhSachThoThauBaoGiaRequest.idNhomCuaHang == null || danhSachThoThauBaoGiaRequest.idNhomCuaHang!.isEmpty) {
      Alert.error(message: 'Hãy chọn ít nhất 1 nhóm cửa hàng');
    } else if (danhSachThoThauBaoGiaRequest.idMatHangDacTrungs == null || danhSachThoThauBaoGiaRequest.idMatHangDacTrungs!.isEmpty) {
      Alert.error(message: 'Hãy chọn ít nhất 1 mặt hàng đặc trưng');
    } else {
      /// Goi yeu cau dang ky du an
      guiYeuCauDangKy();
    }
  }

  /// Goi yeu cau dang ky du an
  void guiYeuCauDangKy() {
    try {
      EasyLoading.show(status: "Loading ...");
      danhSachThoThauBaoGiaProvider.add(
        data: danhSachThoThauBaoGiaRequest,
        onSuccess: (data) {
          EasyLoading.dismiss();
          Future.delayed(Duration.zero, () {
            Alert.success(message: 'Đã gửi yêu cầu thành công');
          });

          Future.delayed(Duration.zero, () {
            Get.back();
            Get.back();
          });
        },
        onError: (error) {
          EasyLoading.dismiss();
          print('V3ProjectDangKyTrienKhaiController danhSachThoThauBaoGiaProvider onError $error');
        },
      );
    } catch (error) {
      EasyLoading.dismiss();
      print('V3ProjectDangKyTrienKhaiController danhSachThoThauBaoGiaProvider catch $error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// Convert list mat hang dac trung
  void updateMatHangDacTrung() {
    currentMatHangDacTrungResponseList = [];
    matHangDacTrungMultiSelectItem = [];
    if (taiKhoanResponse!.idMatHangDacTrungs != null && taiKhoanResponse!.idMatHangDacTrungs!.isNotEmpty) {
      matHangDacTrungMultiSelectItem = taiKhoanResponse!.idMatHangDacTrungs!.map((e) => MultiSelectItem(e, e.tieuDe.toString())).toList();
    }
    update();
  }
}
