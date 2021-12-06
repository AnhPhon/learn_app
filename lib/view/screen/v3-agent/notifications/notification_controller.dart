import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/thong_bao_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3NotificationController extends GetxController {
  final ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  List<ThongBaoResponse> notifications = [];
  List<DonDichVuResponse> donDichVuResponses = [];

  int pageMax = 1;
  int limit = 10;
  bool isLoading = true;
  String userId = '';

  // refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((val) {
      print("Kiểm tra Id đại lý $val");
      userId = val.toString();
      getNotifications();
    });
  }

  ///
  /// Get notifications
  ///
  void getNotifications() {
    thongBaoProvider.paginate(
        page: pageMax,
        limit: limit,
        filter: '&doiTuong=2&idTaiKhoan=$userId&sortBy=created_at:desc',
        onSuccess: (data) {
          notifications.clear();
          notifications.addAll(data);
          isLoading = false;
          update();
        },
        onError: (onError) {
          print("Notification: ${onError.toString()}");
          isLoading = false;
          update();
        });
  }

  Future<void> onRefresh() async {
    pageMax = 1;
    limit = 10;
    refreshNotification();
  }

  Future<void> moreData() async {
    getMoreNotification();
  }

  ///
  /// Load danh sách thông báo
  ///
  void refreshNotification() {
    thongBaoProvider.paginate(
        page: pageMax,
        limit: limit,
        filter: '&doiTuong=2&idTaiKhoan=$userId&sortBy=created_at:desc',
        onSuccess: (data) {
          notifications.clear();
          notifications = data;
          refreshController.resetNoData();
          refreshController.refreshCompleted();
          isLoading = false;
          update();
        },
        onError: (onError) {
          print("Notification: ${onError.toString()}");
          isLoading = false;
          update();
        });
  }

  ///
  /// more data
  ///
  void getMoreNotification() {
    pageMax += 1;
    limit = 10;
    thongBaoProvider.paginate(
        page: pageMax,
        limit: limit,
        filter: '&doiTuong=2&idTaiKhoan=$userId&sortBy=created_at:desc',
        onSuccess: (data) {
          if (data.isEmpty) {
            refreshController.loadNoData();
          } else {
            notifications.addAll(data);

            refreshController.loadComplete();
          }
          isLoading = false;
          update();
        },
        onError: (onError) {
          print("Notification: ${onError.toString()}");
          isLoading = false;
          update();
        });
  }

  ///
  /// On Click notification
  ///
  void onClickItem(ThongBaoResponse notification) {
    updateNotification(notification);
    if (notification.idDonDichVu != null) {
      donDichVuProvider.find(
          id: notification.idDonDichVu!.id!,
          onSuccess: (data) {
            sl.get<SharedPreferenceHelper>().saveIdDonDichVu(id: data.id!);
            sl.get<SharedPreferenceHelper>().saveIdYeuCau(id: data.id!);
            Get.toNamed(AppRoutes.V3_QUOTE_REQUEST);
          },
          onError: (onError) {
            print("V1NotificationController onClickItem onError $onError");
          });
    } else {
      Get.toNamed(AppRoutes.V3_DETAIL_NOTIFICATION,
          parameters: {'id': notification.id!});
    }
  }

  ///
  /// Update status notificaiton
  ///
  void updateNotification(ThongBaoResponse response) {
    // 0 chua xem
    if (response.status!.contains('0')) {
      final ThongBaoRequest thongBaoRequest = ThongBaoRequest();
      thongBaoRequest.id = response.id;
      thongBaoRequest.status = '1';
      thongBaoProvider.update(
          data: thongBaoRequest,
          onSuccess: (data) {
            refreshNotification();
          },
          onError: (onError) => print("Lỗi thay đổi trạng thái thông báo"));
    }
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
