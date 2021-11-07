import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/response/chi_tiet_cong_viec_response.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/chi_tiet_cong_viec_provider.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V2QuotationG1Controller extends GetxController {
  List<TextEditingController> unitPriceControllers = [];

  String idDonDichVu = "";

  int orderValue = 0;

  String title = "Báo giá";

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  final ImageUpdateProvider imageUpdateProvider =
      GetIt.I.get<ImageUpdateProvider>();
  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest =
      DanhSachBaoGiaDonDichVuRequest.fromJson({});
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  ChiTietCongViecProvider chiTietCongViecProvider =
      GetIt.I.get<ChiTietCongViecProvider>();
  List<ChiTietCongViecResponse>? chiTietCongViecResponse;

  bool flagSeeMore = false;

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['id'] != null) {
      idDonDichVu = arguments!['id'] as String;
      danhSachBaoGiaDonDichVuRequest.idDonDichVu = idDonDichVu;
      print('idDonDichVu $idDonDichVu title $title');
      getListChiTietCongViec();
    }

    Future.delayed(Duration.zero, () {});
  }

  ///
  /// Dinh dang ngay thang nam
  ///
  String getDateOutput(String dateString) {
    return DateConverter.isoStringToddMMYYYY(dateString.toString());
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

  /// Lay danh sach vat tu cua don dich vu
  void getListChiTietCongViec() {
    chiTietCongViecProvider.paginate(
      page: 1,
      limit: 100,
      filter: '&idDonDichVu=${idDonDichVu.toString()}',
      onSuccess: (data) {
        chiTietCongViecResponse = data;
        if (chiTietCongViecResponse != null && chiTietCongViecResponse!.isNotEmpty) {
          for (var i = 0; i < chiTietCongViecResponse!.length; i++) {
            unitPriceControllers.add(TextEditingController());
            unitPriceControllers[i].addListener(() => calculator());
          }
        }
        print(
            'V2ShorthandedGroup1Controller getListChiTietCongViec onSuccess ${chiTietCongViecResponse}');
        update();
      },
      onError: (error) {
        print(
            'V2ShorthandedGroup1Controller getListChiTietCongViec onError $error');
      },
    );
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
  ///calculator
  ///
  void calculator() {
    orderValue = 0;
    for (var i = 0; i < unitPriceControllers.length; i++) {
      if (unitPriceControllers[i].text != null &&
          unitPriceControllers[i].text.isNotEmpty &&
          unitPriceControllers[i].text != 'null') {
        orderValue += int.parse(unitPriceControllers[i].text) *
            int.parse((chiTietCongViecResponse![i].soLuong != null &&
                    chiTietCongViecResponse![i].soLuong!.isNotEmpty &&
                    chiTietCongViecResponse![i].soLuong != 'null')
                ? chiTietCongViecResponse![i].soLuong.toString()
                : '0');
      }
    }
    update();
  }

  ///
  ///on done click
  ///
  void onDoneClick() async {
    print('onDoneClick');
    // Get.offNamed(AppRoutes.V2_SHORTHANDED);

    try {
      EasyLoading.show(status: "Loading");

      if (await checkFormIsVaild()) {
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
  }

  ///
  /// Kiem tra dieu kien bao gia
  ///
  Future<bool> checkFormIsVaild() async {
    for (var i = 0; i < unitPriceControllers.length; i++) {
      if (unitPriceControllers[i].text == null ||
          unitPriceControllers[i].text.isEmpty ||
          unitPriceControllers[i].text == 'null') {
        Alert.error(message: 'Không được bỏ trống đơn giá');
        return false;
      }
    }

    danhSachBaoGiaDonDichVuRequest.idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    danhSachBaoGiaDonDichVuRequest.tongTien = orderValue.toString();
    danhSachBaoGiaDonDichVuRequest.giaVatTus = [];
    for (var i = 0; i < unitPriceControllers.length; i++) {
      danhSachBaoGiaDonDichVuRequest.giaVatTus!.add(GiaVatTuRequest.fromJson({
        'idChiTietCongViec': chiTietCongViecResponse![i].id,
        'donGia': int.parse(unitPriceControllers[i].text),
      }));
      print('Gia vat tu $i ${danhSachBaoGiaDonDichVuRequest.giaVatTus![i].toJson()}');
    }

    return true;
  }
}
