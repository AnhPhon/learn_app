import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/thong_bao_request.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class V1NotificationController extends GetxController {
  final ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  List<ThongBaoResponse> notifications = [];
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
      print("id user $val");
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
        filter: '&doiTuong=4&idTaiKhoan=$userId&sortBy=created_at:desc',
        onSuccess: (data) {
          notifications.clear();
          notifications = data;
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
        filter: '&doiTuong=4&idTaiKhoan=$userId&sortBy=created_at:desc',
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
        filter: '&doiTuong=4&idTaiKhoan=$userId&sortBy=created_at:desc',
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

  void onClickItem(ThongBaoResponse notification) {
    updateNotification(notification);
    if (notification.idDonDichVu != null) {
      donDichVuProvider.find(
          id: notification.idDonDichVu!.id!,
          onSuccess: (data) {
            // print("Data: $data");
            final String id = data.idNhomDichVu!.nhomDichVu!;
            // Nếu trạng thái được admin duyệt thì thông báo vào xem chi tiết
            if (data.idTrangThaiDonDichVu!.id == DA_DUYET) {
              return Get.toNamed(AppRoutes.V1_DETAIL_NOTIFICATION,
                  parameters: {'id': notification.id!});
            }
            // Nếu đã được thợ thầu phản hồi chốt giá
            if (id.contains('1')) {
              // phản hồi nhóm 1
              Get.toNamed(AppRoutes.V1_BUILD_ORDER_FEEDBACK, arguments: data);
            } else if (id.contains('2')) {
              // Đây là nhóm 2 Công việc DVTX khảo sát báo giá
              Get.toNamed(AppRoutes.V1_ORDER_FEEDBACK_CONTRACTORS,
                  arguments: data);
            } else if (id.contains('5')) {
              // Đây là nhóm 5 phản hồi dịch vụ xe tải, xe ben, cầu thùng
              Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK5, arguments: data);
            } else if (id.contains('6')) {
              // Đây là nhóm 6 dịch vụ xe đào,cầu nặng, máy khác
              Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6, arguments: data);
            } else if (id.contains('7')) {
              // NHóm 7
              Get.toNamed(
                AppRoutes.V1_CANDICATE,
              );
            } else if (id.contains('8')) {
              // NHóm 7
              Get.toNamed(AppRoutes.V1_QUOTE_RESPONSE, arguments: data);
            } else {
              // Xem thông báo chi tiết admin
              Get.toNamed(AppRoutes.V1_DETAIL_NOTIFICATION,
                  parameters: {'id': notification.id!});
            }
          },
          onError: (onError) {
            print("V1NotificationController onClickItem onError $onError");
          });
    } else {
      Get.toNamed(AppRoutes.V1_DETAIL_NOTIFICATION,
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
    super.onClose();
    refreshController.dispose();
  }
}
