import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/constants/enum_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G3CreateServiceController extends GetxController {
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final ThoiGianLamViecProvider thoiGianLamViecProvider =
      GetIt.I.get<ThoiGianLamViecProvider>();

  final workTitleController = TextEditingController();
  // final descController = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  // final valueController = TextEditingController();

  // 1 nam 2 nữ 3 khác
  GENDER gender = GENDER.Nam;
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
  void onChangedGender(GENDER gender) {
    this.gender = gender;
    update();
  }

  ///
  ///// Chọn thời gian làm việc
  ///
  void onSelectedTommorow({required bool val}) {
    tommorow = val;
    if (tommorow) {
      tommowReponse = thoiGianLamViecList.firstWhereOrNull(
          (element) => element.tieuDe!.contains('7h30 - 11h30'));
    } else {
      tommowReponse = null;
    }
    update();
  }

  void onSelectedAfternoon({required bool val}) {
    afternoon = val;
    if(afternoon){
      afternoonReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('13h30 - 17h30'));
    }else{
      afternoonReponse = null;
    }
    update();
  }

  void onSelectedTonight({required bool val}) {
    tonight = val;
    if(tonight){
      tonightReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('18h30 - 22h30'));
    }else{
      tonightReponse = null;
    }
    update();
  }

  ///
  /// lấy thời gian làm việc db
  ///
  void getWorkTime() {
    thoiGianLamViecProvider.all(onSuccess: (data) {
      thoiGianLamViecList.clear();
      thoiGianLamViecList.addAll(data);
      isLoading = false;
      update();
    }, onError: (error) {
      isLoading = false;
      update();
      print("V1G3CreateServiceController getWorkTime Error $error");
    });
  }

  ///
  /// Nhấn tiếp tục tới trang báo giá đơn hàng
  ///
  void onClickContinueButton(){
    if(tommorow == false && afternoon == false && tonight == false){
      Alert.error(message: "Bạn phải chọn thời gian làm việc");
      return;
    } else if(startTime.text.toString().isEmpty){
      Alert.error(message: "Bạn phải chọn thời gian bắt đầu");
      return;
    }else if(DateConverter.differenceDate(startDate: startTime.text.toString(), endDate: DateConverter.estimatedDateOnly(DateTime.now())) > 0){
      Alert.error(message: "Ngày bắt đầu lớn hơn ngày hiện tại");
      return;
    }else if(endTime.text.toString().isEmpty){
      Alert.error(message: "Thời gian kết thúc không được để trống");
      return;
    }else if(DateConverter.differenceDate(startDate: startTime.text.toString(), endDate: endTime.text.toString()) < 0){
      Alert.error(message: "Ngày kết thúc không được bé hơn ngày bắt đầu");
      return;
    }else{
       Get.toNamed(AppRoutes.V1_G3_ORDER_QUOTE, arguments: request())!.then((value){
         if(value != null){
           serviceApplication!.tieuDe = (value as DonDichVuRequest).tieuDe ?? '';
           workTitleController.text = value.tieuDe ?? '';
         }
       });
    }
  }

  ///
  /// on Back
  ///
  void onBack(){
    Get.back(result: serviceApplication);
  }

  ///
  /// Tạo đối tượng request
  ///
  DonDichVuRequest request(){
      final List<String> workTime = [];
      DonDichVuRequest dichVuRequest = DonDichVuRequest();
      dichVuRequest = serviceApplication!;
      if(tommorow == true){
        workTime.add(tommowReponse!.id!);
      }
      if(afternoon == true){
        workTime.add(afternoonReponse!.id!); 
      }
      if(tonight == true){
        workTime.add(tonightReponse!.id!);
      }
      dichVuRequest.idThoiGianLamViecs= workTime;
      dichVuRequest.ngayBatDau = DateConverter.formatYYYYMMDD(startTime.text.toString());
      if(endTime.text.toString().isNotEmpty){
        dichVuRequest.ngayKetThuc = DateConverter.formatYYYYMMDD(endTime.text.toString());
      }
      dichVuRequest.gioiTinh = getGender();
      return dichVuRequest;
  }

  ///
  /// Get giới tính
  ///
  String getGender() {
    if (GENDER.Nam == gender) {
      return "Nam";
    } else if (GENDER.Nu == gender) {
      return "Nữ";
    }
    return 'Không yêu cầu';
  }

  @override
  void onClose() {
    workTitleController.dispose();
    startTime.dispose();
    endTime.dispose();
    super.onClose();
  }
}

// Kế thừa extension để tạo hàm firstWhereOrNull
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
