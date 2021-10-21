

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1NotificationController extends GetxController{
  final ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();

  List<ThongBaoResponse> notifications = [];
  final ScrollController scrollController = ScrollController();
  int pageMax = 1;
  int limit = 5;
  int status = 1;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
         loadMoreNotification();
      }
    });
    getAll(limit: limit, page: pageMax);
  }

  void getAll({required  int limit, required int page }){
    thongBaoProvider.paginate(page: pageMax, limit: limit, filter: '&doiTuong=2&sortBy=create_at:desc',onSuccess: (data){
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

  Future<void> onRefresh() async {
    reloadNotification();
  }

  Future<void> onLoading() async {
    loadMoreNotification();
  }

  ///
  ///reload
  ///
  Future<void> reloadNotification() async {
    status = 1;
    pageMax = 1;
    limit = 5;
    // Dự án thuộc workspace
    thongBaoProvider.paginate(page: pageMax, limit: limit, filter: '&doiTuong=2&sortBy=create_at:desc',onSuccess: (data){
        notifications.clear();
        notifications = data;
        isLoading = false;
        update();
      }, onError: (onError){
        print("reloadNotification: ${onError.toString()}");
        isLoading = false;
        update();
    });
  }

  ///
  ///load more
  ///
  void loadMoreNotification() {
    pageMax += 1;
    print(pageMax);
    limit = limit;
    // Dự án thuộc workspace
    thongBaoProvider.paginate(page: pageMax, limit: limit, filter: '&doiTuong=2&sortBy=create_at:desc', onSuccess: (data){
      if(data.isEmpty){
        status = 0;
        update();
      }else{
        notifications = notifications.toList() + data;
        Future.delayed(const Duration(seconds: 1)).then((value){
          isLoading = false;
          status = 1;
          update();
        });
      }
    }, onError: (onError){
      isLoading = false;
      update();
      print("loadMoreNotification: $onError");
    });
  }

  void onClickItem(ThongBaoResponse notification){
    String id = notification.idDonDichVu!.idNhomDichVu!.nhomDichVu!;
    if(id.contains('1')){
      // phản hồi nhóm 1
      Get.toNamed(AppRoutes.V1_BUILD_ORDER_FEEDBACK, arguments: notification.idDonDichVu);
    }else if(id.contains('2')){
      // Đây là nhóm 2 Công việc DVTX khảo sát báo giá
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK5,arguments: notification.idDonDichVu);
    }else if(id.contains("3")){
      // Đây là nhóm 3 không có trang thông báo phản hồi
      Get.toNamed(AppRoutes.V1_ORDER_FEEDBACK_CONTRACTORS,arguments: notification.idDonDichVu);
    }else if(id.contains('4')){
      // Đây là nhóm 4 Không có trang thông báo phản hồi
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6,arguments: notification.idDonDichVu);
    }else if(id.contains('5')){
      // Đây là nhóm 5 phản hồi dịch vụ xe tải, xe ben, cầu thùng
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6,arguments: notification.idDonDichVu);
    }else if(id.contains('6')){
      // Đây là nhóm 6 dịch vụ xe đào,cầu nặng, máy khác
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6,arguments: notification.idDonDichVu);
    }else if(id.contains('7')){
      // Phản hồi tuyển dụng thành viên
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6,arguments: notification.idDonDichVu);
    }else{
      // Phản hồi đơn hàng
       Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6,arguments: notification.idDonDichVu);
    }
  }
  

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }


}