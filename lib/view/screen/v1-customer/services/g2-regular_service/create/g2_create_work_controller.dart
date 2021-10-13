import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G2CreateWorkController extends GetxController{

  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final ThoiGianLamViecProvider thoiGianLamViecProvider = GetIt.I.get<ThoiGianLamViecProvider>();

  final workTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final valueController = TextEditingController();
  final massDesc = TextEditingController();
  final workDesc = TextEditingController();

  // Chọn thời gian làm việc
  bool tommorow = false;
  bool afternoon = false;
  bool tonight = false;
  ThoiGianLamViecResponse? tommowReponse;
  ThoiGianLamViecResponse? afternoonReponse;
  ThoiGianLamViecResponse? tonightReponse;
  List<ThoiGianLamViecResponse> thoiGianLamViecList = [];

  // Thời gian làm việc trong ngày

  // File
  File? file;
  // File name
  String? fileName;

  // Danh sách hình ảnh hien trang
  List<File> images = [];
  // Danh sách hình san pham mau
  List<File> productImages = [];
  // Hinh ảnh bản khối lương
  List<File> massImages = [];
  // Dịch vụ resquest
  DonDichVuRequest? serviceApplication;
  // loading 
  bool isLoading = true;  

  @override
  void onInit() {
    serviceApplication = Get.arguments as DonDichVuRequest;
    workTitleController.text = serviceApplication!.tieuDe ?? '';
    getWorkTime();
  }

  ///
  ///// Chọn thời gian làm việc
  ///
  void onSelectedTommorow({required bool val}){
    tommorow = val;
    if(tommorow){
      tommowReponse = thoiGianLamViecList.firstWhere((element) => element.tieuDe!.contains('7h30 - 11h30'));
    }else{
      tommowReponse = null;
    }
    update();
  }

  void onSelectedAfternoon({required bool val}){
    afternoon = val;
    if(tommorow){
      afternoonReponse = thoiGianLamViecList.firstWhere((element) => element.tieuDe!.contains('1h30 - 5h30'));
    }else{
      afternoonReponse = null;
    }
    update();
  }

  void onSelectedTonight({required bool val}){
    tonight = val;
    if(tommorow){
      tonightReponse = thoiGianLamViecList.firstWhere((element) => element.tieuDe!.contains('18h30 - 22h30'));
    }else{
      tonightReponse = null;
    }
    update();
  }

  Future<void> pickerFile() async{
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
      fileName = result.files.first.name;
      update();
      // return fileName;
    } else {
      showSnackBar(title: "Lỗi", message: "Thêm file thất bại");
    }
  }

  ///
  /// Chọn nhiều file (Image)
  ///
  Future<void> pickerMuilFile({required List<File> files})async{
    final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      files.addAll(result.paths.map((path) => File(path!)).toList());
      update();
    } else {
      showSnackBar(title: "Lỗi", message: "Thêm file thất bại");
    }
  }
  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required File file, required List<File> files}){
    files.removeWhere((element) => element.hashCode == file.hashCode);
    showSnackBar(title: "Xoá", message: "Xoá ảnh thành công");
    update();
  }

  /// 
  /// Thêm thời gian làm việc db
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
  /// Nhấn tiếp tục 
  ///
  void onClickContinueButton(){

    if(tommorow == false || afternoon == false || tonight == false){
      showSnackBar(title: "Lỗi", message: "Vui lòng chọn thời gian làm việc trong ngày");
    }else if(startTime.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng chọn thời gian bắt đầu dự kiến");
    }else if(descController.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng mô tả công việc");
    }else{
      EasyLoading.show(status:"Loading ...");
      DonDichVuRequest dichVuRequest = DonDichVuRequest();
      dichVuRequest = serviceApplication!;
      dichVuRequest.idThoiGianLamViec = afternoonReponse!.id;
      dichVuRequest.ngayBatDau = startTime.text.toString();
      dichVuRequest.ngayKetThuc = startTime.text.toString().isEmpty ? startTime.text.toString() : '';
      dichVuRequest.giaTriKhachDeXuat = valueController.text.toString();
      dichVuRequest.moTa = descController.text.toString();
      dichVuRequest.moTaChiTiet = workDesc.text.toString();
      donDichVuProvider.add(data: dichVuRequest, onSuccess: (data){
        Get.toNamed(AppRoutes.V1_SUCCESSFULLY);
      }, onError: (onError){
        showSnackBar(title: "Lỗi", message: onError.toString());
      });
    }
  }

  @override
  void onClose() {
     workTitleController.dispose();
     descController.dispose();
     startTime.dispose();
     endTime.dispose();
     valueController.dispose();
     massDesc.dispose();
     workDesc.dispose();
  }

}