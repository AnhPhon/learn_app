import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/thong_bao_provider.dart';

class V4DetailNotificationController extends GetxController {
  ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();

  ThongBaoResponse thongBaoModel = ThongBaoResponse();
  //Khai báo isLoading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDetailNotifications();
  }

  ///
  ///get detail notifications
  ///
  void getDetailNotifications() {
    thongBaoProvider.find(
      id: Get.parameters['id'].toString(),
      onSuccess: (value) {
        thongBaoModel = value;
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }
}
