import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/chi_tiet_cong_viec_request.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/response/chi_tiet_cong_viec_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chi_tiet_cong_viec_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V2QuotationG2Controller extends GetxController {
  String idDonDichVu = "";

  String quotationInfoSelected = '';

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  final ImageUpdateProvider imageUpdateProvider =
      GetIt.I.get<ImageUpdateProvider>();

  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest =
      DanhSachBaoGiaDonDichVuRequest.fromJson({});
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  ChiTietCongViecProvider chiTietCongViecProvider =
      GetIt.I.get<ChiTietCongViecProvider>();
  List<ChiTietCongViecResponse>? chiTietCongViecResponse = [];
  List<ChiTietCongViecRequest> chiTietCongViecRequest = [
    ChiTietCongViecRequest.fromJson({})
  ];

  // File? image;
  // List<File> imageList = [];

  //order value
  final orderValueController = TextEditingController();

  //job name
  List<TextEditingController> jobNameControllers = [TextEditingController()];

  //specifications
  List<TextEditingController> specificationsControllers = [
    TextEditingController()
  ];

  //weight
  List<TextEditingController> weightControllers = [TextEditingController()];

  //unit price
  List<TextEditingController> unitPriceControllers = [TextEditingController()];

  //unit price string arrray
  List<String> unitPrices = ['0'];

  String title = "Báo giá";

  int orderValue = 0;

  bool allowEdit = false;

  List<String> quotationInfo = [
    "Khách hàng cung cấp thông tin",
    "Đến hiện trường",
  ];

  List<String> unitArray = [
    "m2",
    "km2",
    "tấn",
    "ngày",
    "buổi",
  ];

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['id'] != null) {
      idDonDichVu = arguments!['id'] as String;
      danhSachBaoGiaDonDichVuRequest.idDonDichVu = idDonDichVu;
      print('idDonDichVu $idDonDichVu title $title');
      // getListChiTietVatTu();
    }

    Future.delayed(Duration.zero, () {
      initChiTietCongViecCalc();
    });
  }

  ///
  /// Dinh dang ten file da upload
  ///
  String getFileNameBaoGia() {
    if (danhSachBaoGiaDonDichVuRequest.file != null &&
        danhSachBaoGiaDonDichVuRequest.file!.isNotEmpty &&
        danhSachBaoGiaDonDichVuRequest.file.toString() != 'null') {
      final arrayNameSplit =
          danhSachBaoGiaDonDichVuRequest.file.toString().split('/');
      return arrayNameSplit[arrayNameSplit.length - 1];
    }
    return '';
  }

  ///
  /// Add first chi tiet cong viec form
  ///
  void initChiTietCongViecCalc() {
    for (var i = 0; i < chiTietCongViecRequest.length; i++) {
      // unitPriceControllers.add(TextEditingController());
      unitPriceControllers[i].addListener(() => calculator());
      // weightControllers.add(TextEditingController());
      weightControllers[i].addListener(() => calculator());
    }
    update();
  }

  ///
  /// Add chi tiet cong viec form
  ///
  void addChiTietCongViecForm() {
    print('addChiTietCongViecForm');
    chiTietCongViecRequest.add(ChiTietCongViecRequest.fromJson({}));
    unitPriceControllers.add(TextEditingController());
    weightControllers.add(TextEditingController());
    jobNameControllers.add(TextEditingController());
    specificationsControllers.add(TextEditingController());
    unitPrices.add('0');
    initChiTietCongViecCalc();
  }

  ///
  /// Pick multi files
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<PlatformFile> files = result.files;

      print('Count files select ${files.length}');
      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          print('V2QuotationG1Controller pickFiles addFiles ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            danhSachBaoGiaDonDichVuRequest.file = value.files![0];
            allowEdit = true;
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Pick multi images
  ///
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');
      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          print('V2QuotationG1Controller pickImages addImages ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            danhSachBaoGiaDonDichVuRequest.hinhAnhBaoGias = value.files;
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  ///check condition
  ///
  void condition() {
    // if (imageList.isNotEmpty &&
    //     (unitPriceController.text.isEmpty &&
    //         weightController.text.isEmpty &&
    //         jobNameController.text.isEmpty &&
    //         specificationsController.text.isEmpty)) {
    //   allowEdit = true;
    //   orderValue = orderValueController.text as int;
    // }
    update();
  }

  ///
  ///calculator
  ///
  void calculator() {
    orderValue = 0;
    for (var i = 0; i < unitPriceControllers.length; i++) {
      if (unitPriceControllers[i].text != null &&
          unitPriceControllers[i].text.isNotEmpty &&
          unitPriceControllers[i].text != 'null') {
        orderValue += int.parse(unitPriceControllers[i].text) *
            int.parse((chiTietCongViecRequest[i].soLuong != null &&
                    chiTietCongViecRequest[i].soLuong!.isNotEmpty &&
                    chiTietCongViecRequest[i].soLuong != 'null')
                ? chiTietCongViecRequest[i].soLuong.toString()
                : '0');
      }
    }
    update();
  }

  ///
  ///calculator
  ///
  void setPriceFromInputCustom(val) {
    orderValue = 0;
    orderValue += int.parse(val.toString());
    update();
  }

  ///
  ///go to after quotation g2 page
  ///
  void onAfterQuotationG2PageClick() async {
    try {
      EasyLoading.show(status: 'Loading...');

      if (await checkForm()) {
        danhSachBaoGiaDonDichVuProvider.add(
          data: danhSachBaoGiaDonDichVuRequest,
          onSuccess: (data) {
            EasyLoading.dismiss();
            Alert.success(message: 'Báo giá thành công');
            Get.back();
            Get.back();
          },
          onError: (error) {
            print('V2QuotationG1Controller onDoneClick onError $error');
            Alert.error(message: 'Báo giá thất bại');
          },
        );
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }

    // Get.toNamed(AppRoutes.V2_AFTER_QUOTATION_GROUP2);
  }

  ///
  /// Validate form input
  ///
  Future<bool> checkForm() async {
    if (checkFileIsEmpty() == true &&
        checkFormChiTietCongViecIsEmpty() == true) {
      EasyLoading.dismiss();
      Alert.error(message: 'Không được bỏ trống dữ liệu báo giá');
      return false;
    } else if (checkFileIsEmpty() == false &&
        checkFormChiTietCongViecIsEmpty() == true &&
        checkGiaTriDonHangIsEmpty()) {
      EasyLoading.dismiss();
      Alert.error(message: 'Không được bỏ trống giá trị đơn hàng');
      return false;
    } else {
      danhSachBaoGiaDonDichVuRequest.giaCongViecs = [];
      for (var i = 0; i < chiTietCongViecRequest.length; i++) {
        await chiTietCongViecProvider.add(
          data: chiTietCongViecRequest[i],
          onSuccess: (data) {
            print('add chi tiet cong viec ${data.toJson()} $i');
            danhSachBaoGiaDonDichVuRequest.giaCongViecs!
                .add(GiaCongViecRequest.fromJson({
              'idChiTietCongViec': data.id,
              'donGia': unitPrices[i],
            }));

            print('add vo day ${danhSachBaoGiaDonDichVuRequest.giaCongViecs![i].toJson()}');
          },
          onError: (error) {
            print('add chi tiet cong viec onError $error');
            Alert.error(message: error.toString());
          },
        );
      }
    }

    danhSachBaoGiaDonDichVuRequest.idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    danhSachBaoGiaDonDichVuRequest.tongTien = orderValue.toString();
    danhSachBaoGiaDonDichVuRequest.giaVatTus = [];

    return true;
  }

  ///
  /// Return true if has file
  ///
  bool checkFileIsEmpty() {
    return danhSachBaoGiaDonDichVuRequest.file == null ||
        danhSachBaoGiaDonDichVuRequest.file!.isEmpty ||
        danhSachBaoGiaDonDichVuRequest.file.toString() == 'null';
  }

  ///
  /// Return true if has gia tri don hang text
  ///
  bool checkGiaTriDonHangIsEmpty() {
    return orderValueController == null ||
        orderValueController.text.isEmpty ||
        orderValueController.text.toString() == 'null';
  }

  ///
  /// Return true if chiTietCongViecRequest length > 0 and chiTietCongViecRequest item has data
  ///
  bool checkFormChiTietCongViecIsEmpty() {
    for (var i = 0; i < chiTietCongViecRequest.length; i++) {
      print(
          'chiTietCongViecRequest ${chiTietCongViecRequest[i].toJson()} ${unitPrices[i]}');
      if (chiTietCongViecRequest[i].tenCongViec == null ||
          chiTietCongViecRequest[i].tenCongViec!.isEmpty ||
          chiTietCongViecRequest[i].tenCongViec! == 'null') {
        return true;
      }
      if (chiTietCongViecRequest[i].quyCach == null ||
          chiTietCongViecRequest[i].quyCach!.isEmpty ||
          chiTietCongViecRequest[i].quyCach! == 'null') {
        return true;
      }
      if (chiTietCongViecRequest[i].soLuong == null ||
          chiTietCongViecRequest[i].soLuong!.isEmpty ||
          chiTietCongViecRequest[i].soLuong! == 'null') {
        return true;
      }
      if (chiTietCongViecRequest[i].donVi == null ||
          chiTietCongViecRequest[i].donVi!.isEmpty ||
          chiTietCongViecRequest[i].donVi! == 'null') {
        return true;
      }
      if (unitPrices[i] == null ||
          unitPrices[i].isEmpty ||
          unitPrices[i] == 'null') {
        return true;
      }
    }

    if (chiTietCongViecRequest.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
