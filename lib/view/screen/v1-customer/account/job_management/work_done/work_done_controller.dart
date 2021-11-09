import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/helper/date_converter.dart';

class V1WorkDoneController extends GetxController {

  //TextEditingController
  final customerOpinionController = TextEditingController();
  final agentsOpinionController = TextEditingController();
  final warrantyClaimsContentController = TextEditingController();
  final warrantyContentController = TextEditingController();

  //donDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  //index
  int indexTinhTrang = 0;

  //title appbar
  String title = "Việc đã làm";

  //loading
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get arguments
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
    }
  }

  @override
  void onClose() {
    customerOpinionController.dispose();
    agentsOpinionController.dispose();
    super.onClose();
  }

  ///
  ///set selected index 
  ///
  void setSelectedIndexFee(int? index) {
    indexTinhTrang= index!;
    update();
  }

  ///
  /// format date
  ///
  String getDeadline(String end) {
    final DateTime current = DateTime.now();
    final DateTime dateEnd = DateConverter.convertStringToDatetime(
      end.replaceAll("T", " ").substring(
            0,
            end.length - 1,
          ),
    );

    return "${dateEnd.difference(current).inDays} ngày";
  }
}
