import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/export_import/export_import_controller.dart';

class V4ExportImportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4ExportImportControleer>(() => V4ExportImportControleer());
  }
}
