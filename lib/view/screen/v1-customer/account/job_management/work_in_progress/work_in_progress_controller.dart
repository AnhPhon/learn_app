import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';

class V1WorkInProgressController extends GetxController {
  //TextEditingController
  final customerOpinionController = TextEditingController();
  final agentsOpinionController = TextEditingController();

  //donDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  //PhanHoiDonDichVu
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();

  //title appbar
  String title = "Việc đang làm";

  //loading
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get arguments
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
      getDonDichVu();
    }
  }

  @override
  void onClose() {
    customerOpinionController.dispose();
    agentsOpinionController.dispose();
    super.onClose();
  }

  ///
  ///get phan hoi don dich vu
  ///
  void getDonDichVu() {
    phanHoiDonDichVuProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idDonDichVu=${donDichVuResponse.id}",
      onSuccess: (data) {
        if (data.isNotEmpty) {
          agentsOpinionController.text = data.first.yKienThoThau ?? "";
          update();
        }
      },
      onError: (error) {
        print("V1WorkInProgressController getDonDichVu onError $error");
      },
    );
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
