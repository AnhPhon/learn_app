import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/app_routes.dart';

class V4NotificationController extends GetxController {
  ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();

  //Khai báo model thông báo
  List<ThongBaoResponse> thongbaoList = [];

  // khai báo is loading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotification();
  }

  ///
  /// lấy danh sách thông báo
  ///
  void getNotification() {
    thongBaoProvider.paginate(
        page: 1,
        limit: 10,
        filter: '&doiTuong=1&sortBy=create_at:desc',
        onSuccess: (value) {
          thongbaoList = value;

          isLoading = false;

          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalDateHMS(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  ///go to news detail page
  ///
  void onClickDetailNotification({required int index}) {
    Get.toNamed(
        "${AppRoutes.V4_DETAIL_NOTIFICATION}?id=${thongbaoList[index].id}");
  }
}
