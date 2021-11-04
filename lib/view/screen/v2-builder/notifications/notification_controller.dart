import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2NotificationController extends GetxController {
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
  /// lấy danh sách thông báo
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
    limit = 5;
    thongBaoProvider.paginate(
        page: pageMax,
        limit: limit,
        filter: '&doiTuong=2&idTaiKhoan=$userId&sortBy=created_at:desc',
        onSuccess: (data) {
          print("Dài: ${data.length}");
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
    if(notification.idDonDichVu != null){
      donDichVuProvider.find(
        id: notification.idDonDichVu!.id!,
        onSuccess: (data) {
          final String id = data.idNhomDichVu!.nhomDichVu!;
          if (id.contains('1')) {
            // link to page kết quả báo giá
            Get.toNamed(AppRoutes.V1_BUILD_ORDER_FEEDBACK, arguments: data.idNhomDichVu!.id);
          } else if (id.contains('2')) {
            // link to page kết quả báo giá
            Get.toNamed(AppRoutes.V1_ORDER_FEEDBACK_CONTRACTORS,
                arguments: data);
          } else if (id.contains('3')){
            // Nhóm 3
            Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP2, arguments: data.idNhomDichVu!.id);
          }else if (id.contains('4')){
            // Nhóm 4
            Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP2, arguments: data.idNhomDichVu!.id);
          }else if (id.contains('5')) {
            // link to page kết quả báo giá
            Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK5, arguments: data.idNhomDichVu!.id);
          } else if (id.contains('6')) {
            // Link to page kết quả báo giá
            Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6, arguments: data.idNhomDichVu!.id);
          }else if (id.contains('7')) {
            // Nhóm 7 tuyển dụng ứng viên
            Get.toNamed(AppRoutes.V2_CANDIDATE_RECRUITMENT);
          } else {
            // Xem thông báo chi tiết admin
            Get.toNamed(AppRoutes.V2_DETAIL_NOTIFICATION, parameters: {'id':notification.id!});
          }
        },
        onError: (onError) {
          print("V1NotificationController onClickItem onError $onError");
        }
      );
    }else{
      Get.toNamed(AppRoutes.V2_DETAIL_NOTIFICATION, parameters: {'id':notification.id!});
    }
    
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
