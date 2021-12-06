import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/body/yeu_cau_bao_gia_model.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class V3QuoteResponseController extends GetxController {
  // provider
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();

  String tieuDeBaoGia = "Phản hồi báo giá";

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TimeOfDay fromSelectedTime = TimeOfDay.now();
  TimeOfDay toSelectedTime = TimeOfDay.now();

  TextEditingController dateStartController = TextEditingController();
  TextEditingController dateEndController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "");
  List<TextEditingController> textControllerList = [];

  bool isCheck = true;
  List<List<Map<String, dynamic>>> infoCard = [];
  String loaiCongTrinh = "";
  String tinhThanh = "";
  String quan = "";
  String phuong = "";
  String diaChiCuThe = "";
  String from = "";
  String to = "";
  String title = "Yêu cầu báo giá";
  List<String>? noiDungYeuCau;
  List<Map<String, dynamic>>? features;
  List<String> images = [];
  double vatTuCost = 0;
  double phiCost = 0;
  double giaTriDonHang = 0;

  String loaiHinh = "";
  String filepath = "";

  bool isLoading = true;

  DonDichVuResponse? idDonDichVu;

  DateTime start = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime end = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    idDonDichVu = Get.arguments[0] as DonDichVuResponse;
    infoCard = Get.arguments[1] as List<List<Map<String, dynamic>>>;

    final String date = DateConverter.isoStringToVNDateOnly(
        DateConverter.localDateToIsoString(DateTime.now()));

    fromController = TextEditingController(text: "9:30");
    toController = TextEditingController(text: "10:30");

    dateStartController = TextEditingController(text: date);
    dateEndController = TextEditingController(text: date);

    // load thông tin
    loadInfo(idDonDichVu!);
    loadVatTu(idDonDichVu!);
  }

  ///
  /// loai vat tu
  ///
  void loadVatTu(DonDichVuResponse idDonDichVu) {
    // load vat tu theo don dich vu
    for (int i = 0; i < infoCard.length; i++) {
      textControllerList.add(TextEditingController(text: ""));
    }

    loaiHinh = idDonDichVu.tienDoGiaoHang == "1" ? "Giao gấp" : "Không gấp";
    update();
    for (int index = 0; index < infoCard.length; index++) {
      infoCard[index][4]['visible'] = true;
    }
  }

  ///
  /// load thongo tin don gia dich vu bằng id
  ///
  void loadInfo(DonDichVuResponse donGiaDichVuId) {
    images = donGiaDichVuId.hinhAnhThucTes!.map((e) => e.toString()).toList();
    tieuDeBaoGia = donGiaDichVuId.tieuDe.toString();
    loaiCongTrinh = donGiaDichVuId.loai.toString();

    if (donGiaDichVuId.idTaiKhoanNhanDon != null) {
      if (donGiaDichVuId.idTaiKhoanNhanDon!.idTinhTp != null) {
        tinhThanh = donGiaDichVuId.idTaiKhoanNhanDon!.idTinhTp!.ten.toString();
      }

      if (donGiaDichVuId.idTaiKhoanNhanDon!.idQuanHuyen != null) {
        quan = donGiaDichVuId.idTaiKhoanNhanDon!.idQuanHuyen!.ten.toString();
      }

      if (donGiaDichVuId.idTaiKhoanNhanDon!.idPhuongXa != null) {
        phuong = donGiaDichVuId.idTaiKhoanNhanDon!.idPhuongXa!.ten.toString();
      }
      diaChiCuThe = donGiaDichVuId.idTaiKhoanNhanDon!.diaDiemCuThe.toString();
    } else {
      tinhThanh = "";
      quan = "";
      phuong = "";
      diaChiCuThe = "";
    }
    isLoading = false;
    update();
  }

  ///
  /// onMoneyChange
  ///
  void onMoneyChange(String? val) {
    if (val != null) {
      String value = val;
      if (val.isEmpty) {
        value = "0";
      }
      value = value.replaceAll(".", "");
      value = value.replaceAll("VND", "").trim();
      vatTuCost = 0;
      for (int i = 0; i < infoCard.length; i++) {
        vatTuCost +=
            double.parse(value) * int.parse(infoCard[i][2]['value'].toString());
      }
      update();
    }
    phiCost = double.parse(
        costController.text.replaceAll(".", "").replaceAll("VND", "").trim());
    giaTriDonHang = vatTuCost + phiCost;
    update();
  }

  ///
  /// datePicker
  ///
  void dateStartPicker(
      BuildContext context, DateTime firstDate, DateTime lastDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((_dateTime) {
      if (_dateTime != null) {
        start = _dateTime;
        dateStartController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
  }

  ///
  /// datePicker
  ///
  void dateEndPicker(
      BuildContext context, DateTime firstDate, DateTime lastDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((_dateTime) {
      if (_dateTime != null) {
        end = _dateTime;
        dateEndController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
  }

  ///
  ///onBtnDownCv
  ///
  Future<void> onBtnDownload() async {
    if (await canLaunch(filepath)) {
      await launch(filepath);
    } else {
      throw 'Could not launch $filepath';
    }
  }

  ///
  /// on Cost Change
  ///
  void onCostChange(BuildContext context, String value) {
    if (value.isNotEmpty) {
      costController = TextEditingController(
        text: PriceConverter.convertPrice(context, double.parse(value)),
      );
      // update();
    }
  }

  Future<void> fromSelectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: fromSelectedTime,
    );
    if (timeOfDay != null) {
      if (timeOfDay.hour > toSelectedTime.hour ||
          (timeOfDay.hour == toSelectedTime.hour &&
              timeOfDay.minute > toSelectedTime.minute)) {
        IZIAlert.error(
            message: "Thời gian 'đến' không được nhỏ hơn thời gian 'từ'");
      } else {
        fromSelectedTime = timeOfDay;
        toSelectedTime = timeOfDay;

        fromController = TextEditingController(
            text: "${fromSelectedTime.hour}:${fromSelectedTime.minute}");
        toController = TextEditingController(
            text: "${toSelectedTime.hour}:${toSelectedTime.minute}");
      }
    }
    update();
  }

  Future<void> toSelectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: toSelectedTime,
    );

    if (timeOfDay != null) {
      if (timeOfDay.hour < fromSelectedTime.hour ||
          (timeOfDay.hour == fromSelectedTime.hour &&
              timeOfDay.minute < fromSelectedTime.minute)) {
        IZIAlert.error(
            message: "Thời gian 'đến' không được nhỏ hơn thời gian 'từ'");
      } else {
        toSelectedTime = timeOfDay;
        toController = TextEditingController(
            text: "${toSelectedTime.hour}:${toSelectedTime.minute}");
      }
    }
    update();
  }

  ///
  ///pick image
  ///
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');
      uploadImage(images: files);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required List<File> images}) {
    imageUpdateProvider.addImages(
      files: images,
      onSuccess: (value) {
        if (value.files != null && value.files!.isNotEmpty) {
          this.images = value.files!;
        }
        EasyLoading.dismiss();
        update();
      },
      onError: (error) {
        EasyLoading.dismiss();
        print("V3StoreInfomationController uploadImage onError $error");
      },
    );
  }

  ///
  /// Pick multi files
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<PlatformFile> files = result.files;

      print('Count files select ${files.length}');
      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            filepath = value.files!.first;

            // load thông tin
            loadInfo(idDonDichVu!);
            loadVatTu(idDonDichVu!);
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          IZIAlert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: e.toString());
    }
  }

  ///
  /// on Continue Click
  ///
  void onContinueClick() {
    if (end.difference(start).inDays >= 0) {
      Get.toNamed(
        AppRoutes.V3_QUOTE_CHECK,
        arguments: YeuCauBaoGiaModel(
          diaChiCuThe: diaChiCuThe,
          features: features,
          from: dateStartController.text,
          giaTriDonHang: giaTriDonHang,
          images: images,
          loaiCongTrinh: loaiCongTrinh,
          noiDungYeuCau: noiDungYeuCau,
          phuong: phuong,
          quan: quan,
          tinhThanh: tinhThanh,
          title: title,
          to: dateEndController.text,
          infoCard: infoCard,
          isCheck: isCheck,
          tieuDeBaoGia: tieuDeBaoGia,
          phiGiaoHang: double.parse(
            costController.text.isEmpty
                ? "0"
                : costController.text
                    .replaceAll(".", "")
                    .replaceAll("VND", "")
                    .trim(),
          ),
          filepath: filepath,
          loaiHinh: loaiHinh,
          timeStart: fromController.text,
          timeEnd: toController.text,
          idDonDichVu: idDonDichVu,
        ),
      );
    } else {
      IZIAlert.error(message: "Thời gian hiệu lực\nphải lớn hơn ngày bắt đầu");
    }
  }
}
