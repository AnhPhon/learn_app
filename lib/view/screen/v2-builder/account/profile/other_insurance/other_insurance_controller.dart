import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3OtherInsuranceController extends GetxController {
  String title = "Đăng lý tư vấn bảo hiểm khác";

  List optionInsuranceList = [
    "Bảo hiềm xe máy bắt buộc",
    "Bảo hiểm xe máy tự nguyện",
    "Bảo hiểm ô tô bắt buộc",
    "Bảo hiểm ô tô tự nguyện",
    "Bảo hiểm nhân thọ",
  ];

  List<bool>? isChecked;

  @override
  void onInit() {
    super.onInit();
    isChecked = List<bool>.filled(optionInsuranceList.length, false);
  }

  ///
  ///set checked
  ///
  void setChecked({int? index, bool? value}) {
    isChecked![index!] = value!;
    update();
  }

  ///
  ///on checkout click
  ///
  void onInsuranceDetailClick() {
    Get.toNamed(AppRoutes.V3_INSURANCE_DETAIL);
  }
}
