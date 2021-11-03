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
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';

class V2QuotationG1Controller extends GetxController {
  File? image;
  List<File> imageList = [];

  final unitPriceController = TextEditingController();

  String weight = "20";

  String orderValue = "0";

  String title = "Báo giá";

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  final ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  List<VatTuResponse>? vatTuResponse;

  bool flagSeeMore = false;

  String getDateOutput(String dateString) {
    return DateConverter.isoStringToddMMYYYY(dateString.toString());
  }

  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest = DanhSachBaoGiaDonDichVuRequest.fromJson({});

  @override
  void onInit() {
    super.onInit();
    unitPriceController.addListener(() => calculator());
  }


  String getFileNameBaoGia(){
    if(danhSachBaoGiaDonDichVuRequest.file != null && danhSachBaoGiaDonDichVuRequest.file!.isNotEmpty){
      final arrayNameSplit = danhSachBaoGiaDonDichVuRequest.file.toString().split('/');
      return arrayNameSplit[arrayNameSplit.length - 1];
    }
    return '';
  }
  ///
  ///pick pickFile
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
      EasyLoading.show(status: 'Loading...');
      if (result == null) return;

      final List<PlatformFile> files = result.files;

      print('Count file select ${files.length}');
      // load file
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
  ///pick image
  ///
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      EasyLoading.show(status: 'Loading...');
      if (images == null) return;

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count file select ${files.length}');
      // load file
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
    if (unitPriceController.text.isNotEmpty) {
      orderValue = (int.parse(unitPriceController.text) * int.parse(weight)).toString();
    }
    update();
  }

  ///
  ///on done click
  ///
  void onDoneClick() {
    Get.offNamed(AppRoutes.V2_SHORTHANDED);
  }
}
