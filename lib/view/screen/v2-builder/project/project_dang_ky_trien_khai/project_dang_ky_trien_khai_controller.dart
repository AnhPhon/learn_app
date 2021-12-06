import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:template/data/model/request/danh_sach_tho_thau_bao_gia_request.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_tho_thau_bao_gia_provider.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

class V2ProjectDangKyTrienKhaiController extends GetxController {
  String title = "";

  String? idProject;

  DuAnKhachHangProvider duAnKhachHangProvider = GetIt.I.get<DuAnKhachHangProvider>();
  DuAnKhachHangResponse? duAnKhachHangResponse;

  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  List<NhomDichVuResponse>? nhomDichVuResponse;
  NhomDichVuResponse currentNhomDichVuResponse = NhomDichVuResponse.fromJson({});

  LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  List<LoaiCongViecResponse>? loaiCongViecResponse;
  LoaiCongViecResponse? currentLoaiCongViecResponseList = LoaiCongViecResponse.fromJson({});
  List<MultiSelectItem<LoaiCongViecResponse?>> loaiCongViecMultiSelectItem = [];

  DanhSachThoThauBaoGiaRequest danhSachThoThauBaoGiaRequest = DanhSachThoThauBaoGiaRequest();

  DanhSachThoThauBaoGiaProvider danhSachThoThauBaoGiaProvider = GetIt.I.get<DanhSachThoThauBaoGiaProvider>();

  TextEditingController textDateController = TextEditingController();
  TextEditingController soLuongNguoiLamController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['idProject'] != null) {
      // Khoi tao gia tri lay tu argument
      idProject = arguments!['idProject'].toString();
      title = arguments!['title'].toString();

      // Lay chi tiet du an
      getChiTietDuAn();

      // Lay nhom dich vu
      getNhomDichVu();
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }

  ///
  /// Goi api chi tiet du an
  Future<void> getChiTietDuAn() async {
    danhSachThoThauBaoGiaRequest.idDuAnKhachHang = idProject;
    danhSachThoThauBaoGiaRequest.idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;

    duAnKhachHangProvider.find(
      id: idProject.toString(),
      onSuccess: (data) {
        duAnKhachHangResponse = data;
        update();
      },
      onError: (error) {
        print('V2ProjectDangKyTrienKhaiController duAnKhachHangProvider all onError $error');
      },
    );
  }

  ///
  /// Goi api lay tat ca nhom dich vu
  ///
  void getNhomDichVu() {
    nhomDichVuProvider.all(
      onSuccess: (data) {
        if (data.isNotEmpty) {
          // Selectbox khong cho phep init null gia tri, nen chon 1 gia tri dau tien de init
          selectedNhomCongViec(data[0]);
        }
        nhomDichVuResponse = data;
        update();
      },
      onError: (error) {
        print('V2ProjectDangKyTrienKhaiController nhomDichVuProvider onError all $error');
      },
    );
  }

  ///
  /// Kiem tra id hang muc xay dung co gia tri hay k0
  ///
  bool kiemTraIdHangMucXayDungs() {
    if (duAnKhachHangResponse!.idHangMucXayDungs != null && duAnKhachHangResponse!.idHangMucXayDungs!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  ///
  /// Chon nhom cong viec
  ///
  void selectedNhomCongViec(NhomDichVuResponse? nhomDichVuResponse) {
    currentNhomDichVuResponse = nhomDichVuResponse!;
    danhSachThoThauBaoGiaRequest.idNhomDichVu = currentNhomDichVuResponse.id.toString();
    currentLoaiCongViecResponseList = LoaiCongViecResponse.fromJson({});
    loaiCongViecResponse = [];
    loaiCongViecMultiSelectItem = [];
    update();
    updateNhomDichVu(nhomDichVuResponse);
  }

  ///
  /// Chon cac cong viec trong nhom cong viec
  ///
  void selectedCongViecPhuHop(LoaiCongViecResponse? results) {
    currentLoaiCongViecResponseList = results as LoaiCongViecResponse;
    danhSachThoThauBaoGiaRequest.idLoaiCongViecs = [currentLoaiCongViecResponseList!.id.toString()].cast<String>().toList();
    update();
  }

  ///
  /// Kiem tra dang ky du an
  ///
  void moViewDangKyViecMoi() {
    if (danhSachThoThauBaoGiaRequest.idLoaiCongViecs == null || danhSachThoThauBaoGiaRequest.idLoaiCongViecs!.isEmpty) {
      IZIAlert.error(message: 'Hãy chọn ít nhất 1 công việc');
    } else if (danhSachThoThauBaoGiaRequest.idNhomDichVu == null || danhSachThoThauBaoGiaRequest.idNhomDichVu!.isEmpty) {
      IZIAlert.error(message: 'Hãy chọn ít nhất 1 nhóm');
    } else if (danhSachThoThauBaoGiaRequest.thoiGianBatDauLam == null || danhSachThoThauBaoGiaRequest.thoiGianBatDauLam!.isEmpty) {
      IZIAlert.error(message: 'Hãy chọn ngày bắt đầu làm');
    } else if (danhSachThoThauBaoGiaRequest.soLuongNguoi == null || danhSachThoThauBaoGiaRequest.soLuongNguoi! <= 0) {
      IZIAlert.error(message: 'Số lượng người làm không hợp lệ');
    } else {
      // Goi yeu cau dang ky du an
      guiYeuCauDangKy();
    }
  }

  ///
  /// Goi yeu cau dang ky du an
  ///
  void guiYeuCauDangKy() {
    try {
      EasyLoading.show(status: "Loading ...");
      danhSachThoThauBaoGiaRequest.loaiBaoGia = "1";
      danhSachThoThauBaoGiaProvider.add(
        data: danhSachThoThauBaoGiaRequest,
        onSuccess: (data) {
          EasyLoading.dismiss();
          Future.delayed(Duration.zero, () {
            IZIAlert.success(message: 'Đã gửi yêu cầu thành công');
          });

          Future.delayed(Duration.zero, () {
            Get.back(result: true);
          });
        },
        onError: (error) {
          EasyLoading.dismiss();
          print('V2ProjectDangKyTrienKhaiController guiYeuCauDangKy onError $error');
        },
      );
    } catch (error) {
      EasyLoading.dismiss();
      print('V2ProjectDangKyTrienKhaiController guiYeuCauDangKy catch $error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  ///
  /// Chon nhom dich vu va lay danh sach cong viec
  ///
  void updateNhomDichVu(NhomDichVuResponse nhomDichVuResponse) {
    loaiCongViecProvider.paginate(
      filter: '&idNhomDichVu=${currentNhomDichVuResponse.id.toString()}',
      limit: 100,
      page: 1,
      onSuccess: (data) {
        currentLoaiCongViecResponseList = LoaiCongViecResponse.fromJson({});
        loaiCongViecResponse = [];
        loaiCongViecMultiSelectItem = [];

        if (data.isNotEmpty) {
          loaiCongViecResponse = data;
          loaiCongViecMultiSelectItem = loaiCongViecResponse!.map((e) => MultiSelectItem(e, e.tenCongViec.toString())).toList();
        }

        update();
      },
      onError: (error) {
        print('V2ProjectDangKyTrienKhaiController loaiCongViecProvider onError all $error');
      },
    );
  }

  ///
  /// Chon nhom dich vu va lay danh sach cong viec
  ///
  void updateNgayBatDau(String dateTimeStart) {

    final DateTime _dateTime = DateTime.now();
    final DateTime _dateTimeStart = DateTime.parse(dateTimeStart);
    final DateTime _dateTimeEnd = DateTime.parse(duAnKhachHangResponse!.ngayKetThuc.toString());

    final dateDiff = _dateTimeEnd.difference(_dateTimeStart).inDays;
    final dateDiffNow = _dateTimeStart.difference(_dateTime).inDays;
    if(dateDiff < 0) {
      IZIAlert.error(message: 'Ngày bắt đầu không được lớn hơn ngày kết thúc');
      danhSachThoThauBaoGiaRequest.thoiGianBatDauLam = null;
    } else if(dateDiffNow < 0) {
      IZIAlert.error(message: 'Ngày bắt đầu phải lớn hơn hoặc bằng ngày hiện tại');
      danhSachThoThauBaoGiaRequest.thoiGianBatDauLam = null;
    } else {
      danhSachThoThauBaoGiaRequest.thoiGianBatDauLam = dateTimeStart;
      update();
    }
  }
}
