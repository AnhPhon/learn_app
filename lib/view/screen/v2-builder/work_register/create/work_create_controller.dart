import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bang_bang_cap_request.dart';
import 'package:template/data/model/response/chuc_vu_response.dart';
import 'package:template/data/model/response/chuyen_mon_response.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/dia_diem_dang_ky_lam_viec_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_tot_nghiep_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chuc_vu_provider.dart';
import 'package:template/provider/chuyen_mon_provider.dart';
import 'package:template/provider/chuyen_nganh_chinh_provider.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/dia_diem_dang_ky_lam_viec_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/loai_tot_nghiep_provider.dart';
import 'package:template/provider/muc_luong_du_kien_provider.dart';
import 'package:template/provider/so_nam_kinh_nghiem_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/trinh_do_hoc_van_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2WorkCreateController extends GetxController {
  // provider
  DangKyViecMoiProvider dangKyViecMoiProvider =
      GetIt.I.get<DangKyViecMoiProvider>();
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  HinhThucLamViecProvider hinhThucLamViecProvider =
      GetIt.I.get<HinhThucLamViecProvider>();
  TrinhDoHocVanProvider trinhDoHocVanProvider =
      GetIt.I.get<TrinhDoHocVanProvider>();

  ChuyenMonProvider chuyenMonProvider = GetIt.I.get<ChuyenMonProvider>();
  LoaiTotNghiepProvider loaiTotNghiepProvider =
      GetIt.I.get<LoaiTotNghiepProvider>();

  ChucVuProvider chucVuProvider = GetIt.I.get<ChucVuProvider>();
  MucLuongDuKienProvider mucLuongDuKienProvider =
      GetIt.I.get<MucLuongDuKienProvider>();
  SoNamKinhNghiemProvider soNamKinhNghiemProvider =
      GetIt.I.get<SoNamKinhNghiemProvider>();
  DiaDiemDangKyLamViecProvider diaDiemDangKyLamViecProvider =
      GetIt.I.get<DiaDiemDangKyLamViecProvider>();
  ChuyenNganhChinhProvider chuyenNganhChinhProvider =
      GetIt.I.get<ChuyenNganhChinhProvider>();

  // Tiêu đề
  TextEditingController titleController = TextEditingController();
  // địa chỉ
  TextEditingController addressController = TextEditingController();

  // Tiêu đề
  // Công ty
  TextEditingController companyController = TextEditingController();
  // địa chỉ
  // miêu tả
  TextEditingController descController = TextEditingController();
  //yêu cẩu
  TextEditingController requiredController = TextEditingController();
  // quyền lợi
  TextEditingController benifitController = TextEditingController();
  // Ưu tiên
  TextEditingController prioritizedController = TextEditingController();
  // Hạn nộp
  TextEditingController endTimeController = TextEditingController();
  // name
  TextEditingController nameController = TextEditingController();
  //phone
  TextEditingController phoneController = TextEditingController();
  // contact address
  TextEditingController contactAddressController = TextEditingController();
  // email
  TextEditingController emailController = TextEditingController();
  // email
  TextEditingController amountController = TextEditingController();

  // hon nhân refer
  final honNhanRefer = ["Độc thân", "Đã lập gia đình", "Khác"];
  final gioiTinhRefer = ["Nam", "Nữ"];
  List<HinhThucLamViecResponse> hinhThucLamViec = [];
  HinhThucLamViecResponse? hinhThucLamViecIndex;

  List<TrinhDoHocVanResponse> trinhDo = [];
  TrinhDoHocVanResponse? trinhDoIndex;

  List<ChuyenMonResponse> chuyenMon = [];
  ChuyenMonResponse? chuyenMonIndex;

  List<LoaiTotNghiepResponse> loaiTotNghiep = [];
  LoaiTotNghiepResponse? loaiTotNghiepIndex;

  List<File> anhBangCap = [];
  List<BangBangCapRequest> bangBangCap = [];
  List<Map<String, String>> bangBangCapDisplay = [];

  ChucVuResponse? chucVuHienTaiIndex;
  ChucVuResponse? chucVuMongMuonIndex;
  List<ChucVuResponse> chucVuList = [];

  MucLuongDuKienResponse? mucLuongDuKienIndex;
  List<MucLuongDuKienResponse> mucLuongDuKienList = [];

  SoNamKinhNghiemResponse? soNamKinhNghiemIndex;
  List<SoNamKinhNghiemResponse> soNamKinhNghiemList = [];

  DiaDiemDangKyLamViecResponse? diaDiemDangKyLamViecIndex;
  List<DiaDiemDangKyLamViecResponse> diaDiemDangKyLamViecList = [];

  ChuyenNganhChinhResponse? chuyenNganhChinhIndex;
  List<ChuyenNganhChinhResponse> chuyenNganhChinhList = [];

  String tenUngVien = "";
  String gioiTinh = "";
  String ngaySinh = "";
  String dienThoai = "";
  String email = "";
  String mucTieuNgheNghiep = "";
  String? honNhan;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    honNhan = honNhanRefer.first;

    // load thong tin co ban
    loadThongTinCoBan();
  }

  ///
  /// load thông tin cơ bản
  ///
  void loadThongTinCoBan() {
    // viec mới
    sl.get<SharedPreferenceHelper>().viecMoi.then((viecMoi) {
      dangKyViecMoiProvider.find(
        id: viecMoi.toString(),
        onSuccess: (data) {
          titleController = TextEditingController(text: data.tieuDe.toString());
          mucTieuNgheNghiep = data.mucTieuNgheNghiep ?? "Không có";

          // load ảnh bằng cấp
          anhBangCap = data.idBangBangCaps!
              .map((e) => File(e.anhBangCap.toString()))
              .toList();
          // update
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });

    // load hình thức làm việc
    hinhThucLamViecProvider.all(
      onSuccess: (data) {
        hinhThucLamViec = data;
        if (data.isNotEmpty) {
          hinhThucLamViecIndex = data.first;
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    // load thông tin người dùng
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      taiKhoanProvider.find(
        id: value.toString(),
        onSuccess: (data) {
          tenUngVien = data.hoTen.toString();
          if (data.gioiTinh != null) {
            gioiTinh = gioiTinhRefer[int.parse(data.gioiTinh.toString())];
          } else {
            gioiTinh = "Nam";
          }
          ngaySinh = data.ngaySinh.toString();
          dienThoai = data.soDienThoai.toString();
          email = data.email.toString();

          addressController =
              TextEditingController(text: data.diaChi.toString());
          // isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });

    // load trình độ
    trinhDoHocVanProvider.all(
      onSuccess: (data) {
        trinhDo = data;
        if (data.isNotEmpty) {
          trinhDoIndex = data.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    // load chuyên môn
    chuyenMonProvider.all(
      onSuccess: (data) {
        chuyenMon = data;
        if (data.isNotEmpty) {
          chuyenMonIndex = data.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    // load tốt nghiệp
    loaiTotNghiepProvider.all(
      onSuccess: (data) {
        loaiTotNghiep = data;
        if (data.isNotEmpty) {
          loaiTotNghiepIndex = data.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    // Chức vụ kinh nghiệm mưc lương
    // chức vụ hiện tại
    chucVuProvider.all(
      onSuccess: (data) {
        chucVuList = data;
        if (data.isNotEmpty) {
          chucVuHienTaiIndex = data.first;
          chucVuMongMuonIndex = data.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    // năm kinh nghiệm
    soNamKinhNghiemProvider.all(
      onSuccess: (data) {
        soNamKinhNghiemList = data;
        if (data.isNotEmpty) {
          soNamKinhNghiemIndex = data.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    // mức lương đề xuất
    mucLuongDuKienProvider.all(
      onSuccess: (data) {
        mucLuongDuKienList = data;
        if (data.isNotEmpty) {
          mucLuongDuKienIndex = data.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    // nơi làm việc
    diaDiemDangKyLamViecProvider.all(
      onSuccess: (data) {
        diaDiemDangKyLamViecList = data;
        if (data.isNotEmpty) {
          diaDiemDangKyLamViecIndex = diaDiemDangKyLamViecList.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    // ngành nghề muôn ứng chuyển tuyển
    chuyenNganhChinhProvider.all(
      onSuccess: (data) {
        chuyenNganhChinhList = data;
        if (data.isNotEmpty) {
          isLoading = false;
          chuyenNganhChinhIndex = chuyenNganhChinhList.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// honNhanChange
  ///
  void honNhanChange(String val) {
    honNhan = honNhanRefer[honNhanRefer.indexOf(val)];
    update();
  }

  ///
  /// hình thức làm việc
  ///
  void hinhThucLamViecChange(HinhThucLamViecResponse val) {
    hinhThucLamViecIndex = val;
    update();
  }

  ///
  /// trình độ
  ///
  void trinhDoChange(TrinhDoHocVanResponse val) {
    trinhDoIndex = val;
    update();
  }

  ///
  /// chuyên môn
  ///
  void chuyenMonChange(ChuyenMonResponse val) {
    chuyenMonIndex = val;
    update();
  }

  ///
  /// hình thức làm việc
  ///
  void loaiTotNghiepChange(LoaiTotNghiepResponse val) {
    loaiTotNghiepIndex = val;
    update();
  }

  ///
  /// hình thức làm việc
  ///
  void themBangCapMoi() {
    // trinhDoIndex.tieuDe

    if (endTimeController.text.isNotEmpty) {
      sl.get<SharedPreferenceHelper>().userId.then((value) {
        bangBangCap.add(BangBangCapRequest(
          anhBangCap: anhBangCap.map((e) => e.path).toList().join(","),
          donViDaoTao: addressController.text,
          namTotNghiep: endTimeController.text,
          idChuyenMon: chuyenMonIndex!.id,
          idLoaiTotNghiep: loaiTotNghiepIndex!.id,
          idTaiKhoan: value,
          idTrinhDo: trinhDoIndex!.id,
        ));

        bangBangCapDisplay.add({
          "donViDaoTao": addressController.text,
          "namTotNghiep": endTimeController.text,
          "chuyenMon": chuyenMonIndex!.tieuDe!,
          "loaiTotNghiep": loaiTotNghiepIndex!.tieuDe!,
          "taiKhoan": value!,
          "trinhDo": trinhDoIndex!.tieuDe!,
        });
        update();
      });
    } else {
      Get.snackbar("Thông báo", "Thời gian tốt nghiệp không được rỗng");
    }
    update();
  }

  ///
  /// honNhanChange
  ///
  void onChucVuHienTaiChange(ChucVuResponse val) {
    chucVuHienTaiIndex = val;
    update();
  }

  ///
  /// hình thức làm việc
  ///
  void onChucVuMongMuonChange(ChucVuResponse val) {
    chucVuMongMuonIndex = val;
    update();
  }

  ///
  /// trình độ
  ///
  void onNamKinhNghiemChange(SoNamKinhNghiemResponse val) {
    soNamKinhNghiemIndex = val;
    update();
  }

  ///
  /// chuyên môn
  ///
  void onMucLuongDeXuatChange(MucLuongDuKienResponse val) {
    mucLuongDuKienIndex = val;
    update();
  }

  ///
  /// hình thức làm việc
  ///
  void onNoiLamViecChange(DiaDiemDangKyLamViecResponse val) {
    diaDiemDangKyLamViecIndex = val;
    update();
  }

  ///
  /// hình thức làm việc
  ///
  void onNgheNghiepMongMuonUngTuyenChange(ChuyenNganhChinhResponse val) {
    chuyenNganhChinhIndex = val;
    update();
  }

  ///
  /// Xem trươc
  ///
  void onClickPreviewButton() {
    Get.toNamed(AppRoutes.V2_WORK_PREVIEW);
  }
}
