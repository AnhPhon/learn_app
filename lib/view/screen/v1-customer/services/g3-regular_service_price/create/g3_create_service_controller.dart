


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G3CreateServiceController extends GetxController{
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final ThoiGianLamViecProvider thoiGianLamViecProvider = GetIt.I.get<ThoiGianLamViecProvider>();
  
  final workTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final amountController = TextEditingController();
  final valueController = TextEditingController();

  // 1 nam 2 nữ 3 khác
  int gender = 1;
  // Chọn thời gian làm việc
  bool tommorow = false;
  bool afternoon = false;
  bool tonight = false;
  ThoiGianLamViecResponse? tommowReponse;
  ThoiGianLamViecResponse? afternoonReponse;
  ThoiGianLamViecResponse? tonightReponse;
  List<ThoiGianLamViecResponse> thoiGianLamViecList = [];
  // loading 
  bool isLoading = true;  
  // Dịch vụ resquest
  DonDichVuRequest? serviceApplication;

  @override
  void onInit() {
    serviceApplication = Get.arguments as DonDichVuRequest;
    workTitleController.text = serviceApplication!.tieuDe ?? '';
    getWorkTime();
    super.onInit();
  }

  ///
  /// Thay đổi giới tính
  ///
  void onChangedGender(int gender){
    this.gender = gender;
    update();
  }

  ///
  ///// Chọn thời gian làm việc
  ///
  void onSelectedTommorow({required bool val}){
    tommorow = val;
    if(tommorow){
      tommowReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('7h30 - 11h30'));
    }else{
      tommowReponse = null;
    }
    update();
  }

  void onSelectedAfternoon({required bool val}){
    afternoon = val;
    if(tommorow){
      afternoonReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('1h30 - 5h30'));
    }else{
      afternoonReponse = null;
    }
    update();
  }

  void onSelectedTonight({required bool val}){
    tonight = val;
    if(tommorow){
      tonightReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('18h30 - 22h30'));
    }else{
      tonightReponse = null;
    }
    update();
  }

  /// 
  /// lấy thời gian làm việc db
  /// 
  void getWorkTime(){
    thoiGianLamViecProvider.all(onSuccess: (data){
      thoiGianLamViecList.clear();
      thoiGianLamViecList.addAll(data);
      isLoading = false;
      update();
    }, onError: (error){
      isLoading = false;
      update();
    });
  }

  ///
  /// Nhấn tiếp tục tới trang báo giá đơn hàng
  ///
  void onClickContinueButton(){
    if(tommorow == false & afternoon & false || tonight & false){
      showSnackBar(title: "Lỗi", message: "Vui lòng chọn thời gian làm việc trong ngày");
    }else if(startTime.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng chọn thời gian bắt đầu dự kiến");
    }else if(descController.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng mô tả công việc");
    }else{
      
    }
    Get.toNamed(AppRoutes.V1_G3_ORDER_QUOTE);
  }

  ///
  /// Tạo đối tượng request
  ///
  DonDichVuRequest request(){
    String? workTime = '';
      DonDichVuRequest dichVuRequest = DonDichVuRequest();
      dichVuRequest = serviceApplication!;
      if(tommorow == true){
        workTime = tommowReponse!.id;
      }
      if(afternoon == true){
        workTime = '${workTime!},${afternoonReponse!.id}'; 
      }
      if(tonight == true){
        workTime = '${workTime!},${tonightReponse!.id}';
      }
      dichVuRequest.idThoiGianLamViec = workTime;
      dichVuRequest.ngayBatDau = startTime.text.toString();
      dichVuRequest.ngayKetThuc = startTime.text.toString().isEmpty ? startTime.text.toString() : '';
      dichVuRequest.giaTriKhachDeXuat = valueController.text.toString();
      dichVuRequest.moTa = descController.text.toString();
      return dichVuRequest;
  }

  @override
  void onClose() {
    onClose();
    workTitleController.dispose();
    descController.dispose();
    startTime.dispose();
    endTime.dispose();
    amountController.dispose();
    valueController.dispose();
  }

}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}