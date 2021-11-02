import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G1CreateWorkController extends GetxController{
  final worKTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final nameTitleController = TextEditingController();
  final specificationController = TextEditingController();
  final massController = TextEditingController();
  final unitController = TextEditingController();

  // File
  File? file;
  // File name
  String? fileName;

  // Dach sách bảng khối lượng công việc
  List<VatTuResponse> massList = [];
  // Danh sách hình ảnh bảng khối lượng
  List<File> images = [];
  // Danh sách hình ảnh bản vẽ
  List<File> drawingImages = [];
  // Đơn vi
  String? unit;
  // Dịch vụ resquest
  DonDichVuRequest? serviceApplication;
  // Xem trươc đon dich vụ
  

  @override
  void onInit() {
    serviceApplication = Get.arguments as DonDichVuRequest;
    worKTitleController.text = serviceApplication!.tieuDe ?? '';
  }
  ///
  /// Nhấn tiếp tục qua trang xem lại đơn tạo
  ///
  void onClickContinueButton(){
    if(descController.text.toString().isEmpty){
      Alert.info(message:"Trường mô công việc không được để trống");
      return;
    }else if(startTimeController.text.toString().isEmpty){
      Alert.info(message:"Trường thời gian bắt đầu không được để trống");
      return;
    }else if(DateConverter.differenceDate(startDate: startTimeController.text.toString(), endDate: DateConverter.estimatedDateOnly(DateTime.now())) > 0){
      Alert.info(message: "Ngày bắt đầu không được bé hơn ngày hiện tại");
      return;
    } 
    if(endTimeController.text.toString().isNotEmpty){
      if(DateConverter.differenceDate(startDate: startTimeController.text.toString(), endDate: endTimeController.text.toString()) < 0){
        Alert.info(message: "Ngày kết thúc không được nhỏ hơn ngày bắt đầu");
        return;
      }
    }
    
    // Lưu dich vụ
    saveServices();
  }

  void saveServices(){
    final PreviewServiceRequest previewServiceRequest = PreviewServiceRequest();
    previewServiceRequest.moTa = descController.text.toString();
    previewServiceRequest.ngayBatDau = startTimeController.text.toString();
    if(endTimeController.text.toString().isNotEmpty){
      previewServiceRequest.ngayKetThuc = endTimeController.text.toString();
    }
    previewServiceRequest.idTinhTp = serviceApplication!.idTinhTp;
    previewServiceRequest.idQuanHuyen = serviceApplication!.idQuanHuyen;
    previewServiceRequest.idPhuongXa = serviceApplication!.idPhuongXa;
    previewServiceRequest.idNhomDichVu = serviceApplication!.idNhomDichVu;
    previewServiceRequest.idTaiKhoan = serviceApplication!.idTaiKhoan;
    previewServiceRequest.tieuDe = serviceApplication!.tieuDe;
    previewServiceRequest.diaChiCuThe = serviceApplication!.diaChiCuThe;
    previewServiceRequest.hinhAnhBanKhoiLuong = images;
    previewServiceRequest.bangKhoiLuong = massList;
    previewServiceRequest.idTaiKhoanNhanDon = serviceApplication!.idTaiKhoanNhanDon;
    previewServiceRequest.hinhAnhBanVe  = drawingImages;
    if(file != null){
      previewServiceRequest.file = file ;
    }
    Get.toNamed(AppRoutes.V1_G1_REVIEW, arguments: previewServiceRequest);
  }

  ///
  /// Thay đổi đơn vị
  ///
  void onChangedUnit(String unit){
    this.unit = unit;
    update();
  }


  ///
  /// Thêm khối lượng công việc
  ///
  void onClickAddMass(){
    if(nameTitleController.text.toString().isEmpty){
      return Alert.info(message: "Tên công việc không được để trống");
    }else if(specificationController.text.toString().isEmpty){
      return Alert.info(message:"Quy cách không được để trống");
    }else if(unit == null || unit!.isEmpty){
      return Alert.info(message: 'Đơn vị không được để trống');
    }else if(massController.text.toString().isEmpty){
      return Alert.info(message: "Khối lượng không được để trống");
    }else{
      final VatTuResponse supplies = VatTuResponse(
        khoiLuong: massController.text.toString(),
        donVi: unit,
        quyCach: specificationController.text.toString(),
        tenVatTu: nameTitleController.text.toString(),
      );
      massList.add(supplies);
      update();
    }
  }

  ///
  /// Xoá vật liệu
  ///
  void deleteSupplies(VatTuResponse supplies){
    massList.removeWhere((element) => element.hashCode == supplies.hashCode);
    update();
  }
  ///
  /// Chon file
  ///
  Future<void> pickerFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
      fileName = result.files.first.name;
      update();
      // return fileName;
    } else {
      Alert.error(message: "Thêm file thất bại");
      print("Thêm file thất bại pickerFile V1G1CreateWorkController");
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
      Alert.error(message: "Thêm file thất bại pickerMuilFile V1G1CreateWorkController");
    }
  }
  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required File file, required List<File> files}){
    files.removeWhere((element) => element.hashCode == file.hashCode);
    //Alert.info(title: "Xoá hình ảnh", message: "Hình ảnh đã được xoá thành công",backgroundColor: ColorResources.PRIMARYCOLOR);
    update();
  }

  @override
  void onClose() {
    super.onClose();
    worKTitleController.dispose();
    descController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    nameTitleController.dispose();
    specificationController.dispose();
    massController.dispose();
    unitController.dispose();
  }

}