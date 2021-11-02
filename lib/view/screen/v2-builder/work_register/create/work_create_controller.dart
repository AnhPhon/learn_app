import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bang_bang_cap_request.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/request/ke_khai_kinh_nghiem_request.dart';
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
import 'package:url_launcher/url_launcher.dart';

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
  // start
  TextEditingController startTimeController = TextEditingController();
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

  // đơn vị
  TextEditingController donViController = TextEditingController();
  // chức vụ
  TextEditingController chucVuController = TextEditingController();
  // mức lương
  TextEditingController mucLuongController = TextEditingController();
  // công việc phụ trách
  TextEditingController congViecPhuTrachController = TextEditingController();
  // kết quả
  TextEditingController ketQuaController = TextEditingController();

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

  List<KeKhaiKinhNghiemRequest> keKhaiKinhNghiemRequestList = [];
  List<Map<String, String>> keKhaiKinhNghiemDisplay = [];

  String tenUngVien = "";
  String gioiTinh = "";
  String ngaySinh = "";
  String dienThoai = "";
  String email = "";
  String mucTieuNgheNghiep = "";
  String donVi = "";
  String chucVu = "";
  String mucLuong = "";
  String congViecPhuTrach = "";
  String ketQuaThanhTich = "";
  String kyNangSotruong = "";
  String filePath = "";
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
          kyNangSotruong = data.kyNangSoTruong ?? "không có";

          // load ảnh bằng cấp
          anhBangCap = data.idBangBangCaps!
              .map((e) => File(e.anhBangCap.toString()))
              .toList();

          // reset file
          filePath = data.fileHoSoXinViec.toString();

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
  /// thêm bằng cấp mới
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
  /// thêm kê khai kinh nghiệm
  ///
  void themKeKhaiKinhNghiem() {
    // trinhDoIndex.tieuDe

    if (keKhaiValidate()) {
      sl.get<SharedPreferenceHelper>().userId.then((value) {
        keKhaiKinhNghiemRequestList.add(KeKhaiKinhNghiemRequest(
          chucVu: chucVuController.text,
          congViecPhuTrach: congViecPhuTrachController.text,
          donVi: donViController.text,
          idTaiKhoan: value.toString(),
          ketQua: ketQuaController.text,
          mucLuong: mucLuongController.text,
          thoiGianBatDau:
              startTimeController.text.split("-").reversed.toList().join("-"),
          thoiGianKetThuc:
              endTimeController.text.split("-").reversed.toList().join("-"),
        ));

        sl.get<SharedPreferenceHelper>().viecMoi.then((viecMoi) {
          dangKyViecMoiProvider.update(
            data: DangKyViecMoiRequest(
              id: viecMoi.toString(),
              chucVuHienTai: chucVuHienTaiIndex == null
                  ? "..."
                  : chucVuHienTaiIndex!.tieuDe.toString(),
              chucVuMongMuon: chucVuMongMuonIndex == null
                  ? "..."
                  : chucVuMongMuonIndex!.tieuDe.toString(),
              idSoNamKinhNghiem: soNamKinhNghiemIndex == null
                  ? "..."
                  : soNamKinhNghiemIndex!.id.toString(),
              thoiGianBatDau: startTimeController.text
                  .split("-")
                  .reversed
                  .toList()
                  .join("-"),
              thoiGianKetThuc:
                  endTimeController.text.split("-").reversed.toList().join("-"),
              noiLamViec: diaDiemDangKyLamViecIndex == null ||
                      diaDiemDangKyLamViecIndex!.idTinhTp == null
                  ? "..."
                  : diaDiemDangKyLamViecIndex!.idTinhTp!.ten.toString(),
            ),
            onSuccess: (data) {},
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
          dangKyViecMoiProvider.find(
            id: viecMoi.toString(),
            onSuccess: (data) {
              keKhaiKinhNghiemDisplay.add({
                "chucVu": chucVuController.text,
                "congViecPhuTrach": congViecPhuTrachController.text,
                "donVi": donViController.text,
                "idTaiKhoan": value.toString(),
                "ketQua": ketQuaController.text,
                "mucLuong": mucLuongController.text,
                "thoiGianBatDau": startTimeController.text,
                "thoiGianKetThuc": endTimeController.text,
                "chucVuHienTai": chucVuHienTaiIndex == null
                    ? ""
                    : chucVuHienTaiIndex!.tieuDe.toString(),
                "chucVuMongMuon": chucVuMongMuonIndex == null
                    ? ""
                    : chucVuMongMuonIndex!.tieuDe.toString(),
                "soNamKinhNghiem": soNamKinhNghiemIndex == null
                    ? ""
                    : soNamKinhNghiemIndex!.tieuDe.toString(),
                "noiLamViec": diaDiemDangKyLamViecIndex == null
                    ? ""
                    : diaDiemDangKyLamViecIndex!.idTinhTp.toString(),
                "nganhNgheMongMuon": chuyenMonIndex == null
                    ? ""
                    : chuyenMonIndex!.tieuDe.toString(),
              });
              // update
              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
        });
        update();
      });
    } else {
      Get.snackbar("Thông báo", "Thời gian tốt nghiệp không được rỗng");
    }
    update();
  }

  ///
  /// chức vụ hiện tại
  ///
  void onChucVuHienTaiChange(ChucVuResponse val) {
    chucVuHienTaiIndex = val;
    update();
  }

  ///
  /// chức vụ mong muốn
  ///
  void onChucVuMongMuonChange(ChucVuResponse val) {
    chucVuMongMuonIndex = val;
    update();
  }

  ///
  /// on Nam Kinh Nghiem Change
  ///
  void onNamKinhNghiemChange(SoNamKinhNghiemResponse val) {
    soNamKinhNghiemIndex = val;
    update();
  }

  ///
  /// on Muc Luong De Xuat Change
  ///
  void onMucLuongDeXuatChange(MucLuongDuKienResponse val) {
    mucLuongDuKienIndex = val;
    update();
  }

  ///
  /// on Noi Lam Viec Change
  ///
  void onNoiLamViecChange(DiaDiemDangKyLamViecResponse val) {
    diaDiemDangKyLamViecIndex = val;
    update();
  }

  ///
  /// on Nghe Nghiep Mong Muon Ung Tuyen Change
  ///
  void onNgheNghiepMongMuonUngTuyenChange(ChuyenNganhChinhResponse val) {
    chuyenNganhChinhIndex = val;
    update();
  }

  ///
  /// onMucLuongChange
  ///
  void onMucLuongChange(ChuyenNganhChinhResponse val) {
    chuyenNganhChinhIndex = val;
    update();
  }

  ///
  /// load file
  ///
  Future<void> launchURL() async => await canLaunch(filePath)
      ? await launch(filePath)
      : throw 'Could not launch $filePath';

  ///
  /// validate ke khai
  ///
  bool keKhaiValidate() {
    if (startTimeController.text.isEmpty) {
      Get.snackbar("Thông báo", "Ngày bắt đầu không được rỗng");
      return false;
    }

    if (endTimeController.text.isEmpty) {
      Get.snackbar("Thông báo", "Ngày kết thuc không được rỗng");
      return false;
    }

    if (donViController.text.isEmpty) {
      Get.snackbar("Thông báo", "Đơn vị không được rỗng");
      return false;
    }

    if (chucVuController.text.isEmpty) {
      Get.snackbar("Thông báo", "kết quả / thành đát không được rỗng");
      return false;
    }

    if (mucLuongController.text.isEmpty) {
      Get.snackbar("Thông báo", "Mức lương không được rỗng");
      return false;
    }

    if (congViecPhuTrachController.text.isEmpty) {
      Get.snackbar("Thông báo", "Công việc phụ trách không được rỗng");
      return false;
    }

    if (ketQuaController.text.isEmpty) {
      Get.snackbar("Thông báo", "kết quả / thành đát không được rỗng");
      return false;
    }

    return true;
  }

  ///
  /// Xem trươc
  ///
  void onClickPreviewButton() {
    Get.toNamed(AppRoutes.V2_WORK_PREVIEW);
  }
}
