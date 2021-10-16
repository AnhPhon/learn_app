import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2WorkRegisterController extends GetxController {
  // provider
  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  LoaiCongViecProvider loaiCongViecProvider =
      GetIt.I.get<LoaiCongViecProvider>();
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  // text editing controller
  TextEditingController tieuDeBaoGiaController = TextEditingController();
  TextEditingController loaiCongTrinh = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController nhomCongViec = TextEditingController();
  TextEditingController congViecPhuHop = TextEditingController();
  TextEditingController toanTinh = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController diaDiemKhacController = TextEditingController();

  // List
  List<String>? currencies;
  List<bool>? checkList;

  List<NhomDichVuResponse> nhomDichVu = [];
  List<DonDichVuResponse> dichVuList = [];

  // String
  String? firstSelect;
  String title = "Đăng ký việc";

  // value first for checkbox
  String tenNhomCongViec = "";
  String tenCongViec = "";

  String quanHuyenHCM = "";
  String phuongXaHCM = "";

  String quanHuyenHaNoi = "";
  String phuongXaHaNoi = "";

  String quanHuyenDaNang = "";
  String phuongXaDaNang = "";

  String tinhKhac = "";
  String quanHuyenTinhKhac = "";
  String phuongXaTinhKhac = "";

  // bool
  bool tphcmCheck = false;
  bool hanoiCheck = false;
  bool danangCheck = false;
  bool tinhKhacCheck = false;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    checkList = [tphcmCheck, hanoiCheck, danangCheck, tinhKhacCheck];

    firstSelect = "Công trình 1";
    currencies = ["Công trình 1", "Công trình 2", "Công trình 3"];

    // load nhom cong viec phu hop
    _loadNhomCongViecPhuHop();

    // load quận huyện TPHCM
    _loadQuanHuyenHCM("");

    // load phương xã theo huận huyện TP.HCM
    _loadPhuongXaHCM("");

    // load quận huyện Hà Nội
    _loadQuanHuyenHaNoi("");

    // load phương xã theo huận huyện Hà Nội
    _loadPhuongXaHaNoi("");

    // load quận huyện Đà Nẵng
    _loadQuanHuyenDaNang("");

    // load phương xã theo huận huyện Đà Nẵng
    _loadPhuongXaDaNang("");

    // load Tỉnh khác (trừ 3 tỉnh trên)
    _loadTinhKhac([]);

    // load quận huyện Tỉnh khác
    _loadQuanHuyenTinhKhac("");

    // load phương xã theo huận huyện Tỉnh khác
    _loadPhuongXaTinhKhac("");

    // load dia diem khac - loại các tĩnh được chọn
    _loadDiaDiemKhac([]);
  }

  ///
  /// load nhóm công việc phù hợp
  ///
  void _loadNhomCongViecPhuHop() {
    // get all nhóm dịch vụ
    nhomDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "",
      onSuccess: (models) {
        nhomDichVu = models;

        if (nhomDichVu.isNotEmpty) {
          tenNhomCongViec = nhomDichVu[0].tenDichVu!;
          _loadCongViecPhuHop(nhomDichVu[0].id!);

          isLoading = false;
          update();
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load công việc phù hợp - load theo nhóm công việc
  ///
  void _loadCongViecPhuHop(String idNhomCongViec) {
    // get all nhóm dịch vụ
    donDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idNhomDichVu=$idNhomCongViec",
      onSuccess: (models) {
        dichVuList = models;

        if (dichVuList.isNotEmpty) {
          tenCongViec = dichVuList[0].tieuDe!;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load quận huyện TPHCM
  ///
  void _loadQuanHuyenHCM(String idTpHCM) {}

  ///
  /// load phương xã theo huận huyện TP.HCM
  ///
  void _loadPhuongXaHCM(String idQuanHuyenHCM) {}

  ///
  /// load quận huyện Hà Nội
  ///
  void _loadQuanHuyenHaNoi(String idHaNoi) {}

  ///
  /// load phương xã theo huận huyện Hà Nội
  ///
  void _loadPhuongXaHaNoi(String idQuanHuyenHaNoi) {}

  ///
  /// load quận huyện Đà Nẵng
  ///
  void _loadQuanHuyenDaNang(String idDaNang) {}

  ///
  /// load phương xã theo huận huyện Đà Nẵng
  ///
  void _loadPhuongXaDaNang(String idQuanHuyenDaNang) {}

  ///
  /// load Tỉnh khác (trừ 3 tỉnh trên)
  ///
  void _loadTinhKhac(List<String> _idSubList) {}

  ///
  /// load quận huyện Tỉnh khác
  ///
  void _loadQuanHuyenTinhKhac(String idTinhKhac) {}

  ///
  /// load phương xã theo huận huyện Tỉnh khác
  ///
  void _loadPhuongXaTinhKhac(String idQuanHuyenTinhKhac) {}

  ///
  /// load dia diem khac - loại các tĩnh được chọn
  ///
  void _loadDiaDiemKhac(List<String> _idList) {}

  ///
  /// on nhom cong viec phu hop change
  ///
  void onNhomCongViecChange(String? value) {
    tenNhomCongViec = value!;
    update();
  }

  ///
  /// onCheckBoxChange
  ///
  void onCheckBoxChange(int index, {required bool value}) {
    if (index == 0) {
      tphcmCheck = value;
    }

    if (index == 1) {
      hanoiCheck = value;
    }

    if (index == 2) {
      danangCheck = value;
    }

    if (index == 3) {
      tinhKhacCheck = value;
    }

    update();
  }

  ///
  /// date from Picker
  ///
  void dateFromPicker(
      BuildContext context, DateTime firstDate, DateTime lastDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime(2021, 10, 7),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((_dateTime) {
      if (_dateTime != null) {
        fromDate = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
  }

  ///
  /// continue
  ///
  void nextPage() {
    Get.toNamed(AppRoutes.V1_QUOTE_REQUEST_2);
  }

  ///
  /// datePicker
  ///
  void datePicker(BuildContext context, DateTime firstDate, DateTime lastDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime(2021, 10, 7),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((_dateTime) {
      if (_dateTime != null) {
        timeStartController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
  }

  ///
  /// format date
  ///
  String formatDate(String date) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
  }
}
