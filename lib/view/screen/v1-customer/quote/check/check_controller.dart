import 'package:get/get.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class V1CheckController extends GetxController {
  String title = "Kiểm tra lại đơn hàng";
  List<Map<String, dynamic>>? infoCard;
  String? fileURL = "";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    infoCard = [
      {
        "label": "Tên vật liệu",
        "value": "Xi măng",
        "input": false,
      },
      {
        "label": "Quy cách",
        "value": "Kim đỉnh",
        "input": false,
      },
      {
        "label": "Số lượng",
        "value": "5",
        "input": false,
      },
      {
        "label": "Đơn vị",
        "value": "Tấn",
        "input": false,
      },
    ];
  }

  ///
  /// xác nhận
  ///
  void onxacNhanClick() {
    Get.toNamed(AppRoutes.V1_QUOTE_DONE);
  }

  ///
  ///onBtnDownCv
  ///
  Future<void> onBtnDownloadCv({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
