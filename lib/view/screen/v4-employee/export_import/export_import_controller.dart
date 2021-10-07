import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V4ExportImportControleer extends GetxController {
//khi báo isLoading
  bool isLoading = true;
  //khai báo isExport
  bool isExport = true;

  final timeExportImport = TextEditingController();
  final exportController = TextEditingController();
  final importController = TextEditingController();
  final projectController = TextEditingController();
  final suppliesController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isExport = Get.parameters['export'].toString() == 'true';
  }
}
