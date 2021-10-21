import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/xuat_nhap_kho_request.dart';
import 'package:template/data/model/response/don_vi_cung_cap_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/data/model/response/kho_hang_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/data/repository/don_vi_cung_cap_repository.dart';
import 'package:template/data/repository/du_an_nhan_vien_repository.dart';
import 'package:template/data/repository/vat_tu_repository.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/don_vi_cung_cap_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/provider/kho_hang_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/provider/xuat_nhap_kho_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class V4ExportImportControleer extends GetxController {
  GetIt sl = GetIt.instance;
  //Khai báo Dự án Nhân viên
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();
  List<DuAnNhanVienResponse> duAnNhanVienModelList = [];
  DuAnNhanVienResponse? duAnNhanVien;

  //Khai báo kho Hàng
  KhoHangProvider khohangProvider = GetIt.I.get<KhoHangProvider>();
  List<KhoHangResponse> khoHangModelList = [];
  KhoHangResponse? khoHang;

  //Khai báo tên vật tư
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  List<VatTuResponse> vatTuModelList = [];
  VatTuResponse? vatTu;

  //Khai báo xuất nhập kho
  XuatNhapKhoProvider xuatNhapKhoProvider = GetIt.I.get<XuatNhapKhoProvider>();

  //Khai báo đơn vị cung chấp
  DonViCungCapProvider donViCungCapProvider =
      GetIt.I.get<DonViCungCapProvider>();
  List<DonViCungCapResponse> donViCungCapModelList = [];
  DonViCungCapResponse? donViCungCap;
//khi báo isLoading
  bool isLoading = true;

  //khai báo isExport
  bool isExport = true;

  //Khai báo id
  String userId = '';

  //khai báo đơn vik
  String donVi = "";

  //khai bao chỉ click 1 lần
  bool justOnlyClick = false;

  final timeExportImport = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));
  final exportController = TextEditingController(text: "Xuất");
  final importController = TextEditingController(text: "Nhập");

  final countController = TextEditingController();
  TextEditingController utils = TextEditingController(text: "Tấn");
  final contentController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isExport = Get.parameters['export'].toString() == 'true';
    getAllDuAnNhanVien();
    getAllVatTu();
    getIdTaiKhoanNhanVien();
    getDonViCungCap();
  }

  ///
  /// Thêm số lượng
  ///
  void cong() {
    final int cong = int.parse(countController.text);
    countController.text = (cong + 1).toString();
    print(countController.text);
  }

  ///
  /// Trừ số lượng
  ///
  void tru() {
    final int tru = int.parse(countController.text);
    countController.text = (tru - 1).toString();
    print(countController.text);
  }

  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse duAnNhanVien) {
    this.duAnNhanVien = duAnNhanVien;
    getKhoHang(id: duAnNhanVien.id);
    update();
  }

  ///
  ///Thay đổi kho hàng theo dự án nhân viên
  ///
  void onChangedKhoHang(KhoHangResponse khoHang) {
    this.khoHang = khoHang;
    update();
  }

  ///
  ///Thay đổi vật tư
  ///
  void onChangedVatTu(VatTuResponse vatTu) {
    this.vatTu = vatTu;
    utils = TextEditingController(text: vatTu.donVi);
    update();
  }

  ///
  ///Thay đổi đơn vị cung cấp
  ///
  void onChangedDonViCungCap(DonViCungCapResponse donViCungCap) {
    this.donViCungCap = donViCungCap;
    update();
  }

  ///
  ///Get all dự án nhân viên
  ///
  void getAllDuAnNhanVien() {
    duAnNhanVienProvider.all(
      onSuccess: (value) {
        duAnNhanVienModelList.clear();
        if (value.isNotEmpty) {
          duAnNhanVienModelList.addAll(value);
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Lấy kho hàng theo id dự án nhân viên
  ///
  void getKhoHang({String? id}) {
    khohangProvider.paginate(
        filter: '&idDuAnNhanVien=$id',
        limit: 100,
        page: 1,
        onSuccess: (value) {
          if (value.isNotEmpty) {
            khoHangModelList.addAll(value);
            khoHang = khoHangModelList.first;
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }

  ///
  ///Get all Vật tư
  ///
  void getAllVatTu() {
    vatTuProvider.all(
      onSuccess: (value) {
        vatTuModelList.addAll(value);
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///Get đơn vị cung cấp
  ///
  void getDonViCungCap() {
    donViCungCapProvider.all(
      onSuccess: (value) {
        donViCungCapModelList.clear();
        if (value.isNotEmpty) {
          donViCungCapModelList.addAll(value);
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///Get iD tài khoản nhân viên
  ///
  void getIdTaiKhoanNhanVien() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value!;
      print(value);
    });
  }

  ///
  /// Check null value xuất kho
  ///
  bool validate() {
    if (duAnNhanVien == null) {
      Get.snackbar(
        "Tên dự án không hợp lệ!",
        "Vui lòng chọn tên dự án hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (khoHang == null) {
      Get.snackbar(
        "Kho hàng không hơp lệ!",
        "Vui lòng chọn kho hàng hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (donViCungCap == null) {
      Get.snackbar(
        "Đơn vị cung cấp không hơp lệ!",
        "Vui lòng chọn đơn vị cung cấp hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (vatTu == null) {
      Get.snackbar(
        "Vật tư/Thiết bị không hơp lệ!",
        "Vui lòng chọn vật tư/chi tiết hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (countController.text.toString().isEmpty) {
      Get.snackbar(
        "Số lượng không hơp lệ!",
        "Vui lòng nhập số lượng hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    return true;
  }

  ///
  ///Xuất kho
  ///
  void xuat() {
    if (validate() && justOnlyClick == false) {
      justOnlyClick = true;
      xuatNhapKhoProvider.add(
        data: XuatNhapKhoRequest(
          idDonViCungCap: donViCungCap!.id,
          ghiChu: contentController.text,
          soLuong: countController.text,
          idNhanVien: userId,
          idKhoHang: khoHang!.id,
          idDuAnNhanVien: duAnNhanVien!.id,
          idVatTu: vatTu!.id,
        ),
        onSuccess: (models) {
          Get.back(result: true);
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }
  }

  ///
  ///Nhập kho
  ///
  void nhap() {
    if (validate() && justOnlyClick == false) {
      justOnlyClick = true;
      xuatNhapKhoProvider.add(
        data: XuatNhapKhoRequest(
          idDonViCungCap: donViCungCap!.id,
          ghiChu: contentController.text,
          soLuong: countController.text,
          idNhanVien: userId,
          idKhoHang: khoHang!.id,
          idDuAnNhanVien: duAnNhanVien!.id,
          idVatTu: vatTu!.id,
        ),
        onSuccess: (models) {
          Get.back(result: true);
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }
  }
}
