import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/provider/thong_bao_provider.dart';

class V4DetailNotificationController extends GetxController {
  //Thông báo Provider
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
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///format date time
  ///
  String getFormattedDate(String date) {
    final localDate = DateTime.parse(date).toLocal();
    final inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    final inputDate = inputFormat.parse(localDate.toString());
    final outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    final outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }
}
