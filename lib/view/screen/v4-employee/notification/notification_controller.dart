import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/provider/thong_bao_provider.dart';

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
        limit: 100,
        filter: '',
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
}
