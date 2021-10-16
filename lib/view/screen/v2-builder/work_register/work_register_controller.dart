import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
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

  String title = "Đăng ký việc";

  TextEditingController? tieuDeBaoGiaController;
  TextEditingController? loaiCongTrinh;

  TextEditingController? fromDate;
  TextEditingController? toDate;

  TextEditingController? nhomCongViec;
  TextEditingController? congViecPhuHop;
  TextEditingController? toanTinh;

  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController diaDiemKhacController = TextEditingController();

  List<String>? currencies;
  String? firstSelect;

  List<bool>? checkList;

  bool tphcmCheck = false;
  bool hanoiCheck = false;
  bool danangCheck = false;
  bool tinhKhacCheck = false;

  @override
  void onInit() {
    super.onInit();
    checkList = [tphcmCheck, hanoiCheck, danangCheck, tinhKhacCheck];

    firstSelect = "Công trình 1";
    currencies = ["Công trình 1", "Công trình 2", "Công trình 3"];

    tieuDeBaoGiaController = TextEditingController();
    loaiCongTrinh = TextEditingController(text: firstSelect);
    nhomCongViec = TextEditingController(text: firstSelect);
    congViecPhuHop = TextEditingController(text: firstSelect);
    toanTinh = TextEditingController(text: firstSelect);

    fromDate = TextEditingController();
    toDate = TextEditingController();
  }

  ///
  /// on change
  ///
  void onLoaiCongTrinhChange(String? value) {
    loaiCongTrinh = TextEditingController(text: value);
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
