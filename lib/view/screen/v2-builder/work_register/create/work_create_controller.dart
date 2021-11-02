import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bang_bang_cap_request.dart';
import 'package:template/data/model/response/bang_bang_cap_response.dart';
import 'package:template/data/model/response/chuyen_mon_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_tot_nghiep_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chuyen_mon_provider.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/loai_tot_nghiep_provider.dart';
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
          print(anhBangCap);
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
          isLoading = false;
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
  /// Xem trươc
  ///
  void onClickPreviewButton() {
    Get.toNamed(AppRoutes.V2_WORK_PREVIEW);
  }
}
