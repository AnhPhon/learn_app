

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1NotificationController extends GetxController{
  final ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  List<ThongBaoResponse> notifications = [];
  int pageMax = 1;
  int limit = 5;
  bool isLoading = true;

  // refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  void getNotifications(){
    thongBaoProvider.paginate(page: pageMax, limit: limit, filter: '&doiTuong=1&idTaiKhoan=616d99dd7e28e22b158543bb&sortBy=created_at:desc',onSuccess: (data){
      notifications.clear();
      notifications = data;
      isLoading = false;
      update();
    }, onError: (onError){
      print("Notification: ${onError.toString()}");
      isLoading = false;
      update();
    });
  }

  Future<void> onRefresh() async{
    pageMax = 1;
    limit = 5;
    refreshNotification();
  }

  Future<void> moreData()async{
    getMoreNotification();
  }

  ///
  /// lấy danh sách thông báo
  ///
  void refreshNotification(){
    thongBaoProvider.paginate(page: pageMax, limit: limit, filter: '&doiTuong=1&idTaiKhoan=616d99dd7e28e22b158543bb&sortBy=created_at:desc',onSuccess: (data){
      notifications.clear();
      notifications = data;
      refreshController.resetNoData();
      refreshController.refreshCompleted();
      isLoading = false;
      update();
    }, onError: (onError){
      print("Notification: ${onError.toString()}");
      isLoading = false;
      update();
    });
  }


  ///
  /// more data
  ///
  void getMoreNotification(){
    pageMax += 1;
    limit = 5;
    thongBaoProvider.paginate(page: pageMax, limit: limit, filter: '&doiTuong=1&idTaiKhoan=616d99dd7e28e22b158543bb&sortBy=created_at:desc',onSuccess: (data){
      print("Dài: ${data.length}");
      if(data.isEmpty){
        refreshController.loadNoData();
      }else{
        notifications.addAll(data);
        refreshController.loadComplete();
      }
      isLoading = false;
      update();
    }, onError: (onError){
      print("Notification: ${onError.toString()}");
      isLoading = false;
      update();
    });
  }

  void onClickItem(ThongBaoResponse notification){
    print(notification.idPhanHoiDonDichVu!.idDonDichVu!.toJson());

    donDichVuProvider.find(id: notification.idPhanHoiDonDichVu!.idDonDichVu!.id!, onSuccess: (data){
      print("Data: $data");
      String id = data.idNhomDichVu!.nhomDichVu!;
      print("Nhóm dịch vụ : $id");
      if(id.contains('1')){
        // phản hồi nhóm 1
        Get.toNamed(AppRoutes.V1_BUILD_ORDER_FEEDBACK, arguments: notification.idPhanHoiDonDichVu);
      }else if(id.contains('2')){
        // Đây là nhóm 2 Công việc DVTX khảo sát báo giá
        Get.toNamed(AppRoutes.V1_ORDER_FEEDBACK_CONTRACTORS,arguments: notification.idPhanHoiDonDichVu);
      }else if(id.contains('5')){
        // Đây là nhóm 5 phản hồi dịch vụ xe tải, xe ben, cầu thùng
        Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK5,arguments: notification.idPhanHoiDonDichVu);
      }else if(id.contains('6')){
        // Đây là nhóm 6 dịch vụ xe đào,cầu nặng, máy khác
        Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6,arguments: notification.idPhanHoiDonDichVu);
      }else if(id.contains('7')){
        // Phản hồi tuyển dụng thành viên
        Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6,arguments: notification.idPhanHoiDonDichVu);
      }else{
        // Phản hồi vật tư
        Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6,arguments: notification.idPhanHoiDonDichVu);
      }
    }, onError: (onError){
      print("V1NotificationController onClickItem onError $onError");
    });
    
  }
  

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

}