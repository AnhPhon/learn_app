import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/notification_model.dart';
import 'package:template/provider/notifications_provider.dart';

class NotificationController extends GetxController {
  NotificationProvider notificationProvider =
      GetIt.I.get<NotificationProvider>();

  List<NotificationModel> notificationList = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }

  ///
  /// lấy tất cả sản phẩm
  ///
  void getAllProduct() {
    notificationProvider.all(onSuccess: (value) {
      notificationList = value;
      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }
}
