import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';

class V1G1CreateWorkController extends GetxController{
  final ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  final worKTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final nameTitleController = TextEditingController();
  final specificationController = TextEditingController();
  final massController = TextEditingController();
  final unitController = TextEditingController();

  // File
  List<String> donDichVuFiles = [];
  // File name
  String? fileName;

  // Dach sách bảng khối lượng công việc
  List<VatTuResponse> massList = [];
  // Danh sách hình ảnh bảng khối lượng
  List<String> anhKhoiLuong = [];
  // Danh sách hình ảnh bản vẽ
  List<String> drawingImages = [];
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
      Alert.error(message:"Trường mô công việc không được để trống");
      return;
    }else if(startTimeController.text.toString().isEmpty){
      Alert.error(message:"Trường thời gian bắt đầu không được để trống");
      return;
    }else if(DateConverter.differenceDate(startDate: startTimeController.text.toString(), endDate: DateConverter.estimatedDateOnly(DateTime.now())) > 0){
      Alert.error(message: "Ngày bắt đầu không được nhỏ hơn ngày hiện tại");
      return;
    } 
    if(endTimeController.text.toString().isNotEmpty){
      if(DateConverter.differenceDate(startDate: startTimeController.text.toString(), endDate: endTimeController.text.toString()) <= 0){
        Alert.error(message: "Ngày kết thúc phải lớn hơn ngày bắt đầu");
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
    previewServiceRequest.hinhAnhBanKhoiLuongs = anhKhoiLuong;
    previewServiceRequest.bangKhoiLuong = massList;
    previewServiceRequest.idTaiKhoanNhanDon = serviceApplication!.idTaiKhoanNhanDon;
    previewServiceRequest.hinhAnhBanVes  = drawingImages;
    if(donDichVuFiles.isNotEmpty){
      previewServiceRequest.files = donDichVuFiles;
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
      return Alert.error(message: "Tên công việc không được để trống");
    }else if(specificationController.text.toString().isEmpty){
      return Alert.error(message:"Quy cách không được để trống");
    }else if(unit == null || unit!.isEmpty){
      return Alert.error(message: 'Đơn vị không được để trống');
    }else if(massController.text.toString().isEmpty){
      return Alert.error(message: "Khối lượng không được để trống");
    }else{
      final VatTuResponse supplies = VatTuResponse(
        khoiLuong: massController.text.toString(),
        donVi: unit,
        quyCach: specificationController.text.toString(),
        tenVatTu: nameTitleController.text.toString(),
      );
      massList.add(supplies);
      nameTitleController.text = '';
      specificationController.text = '';
      massController.text = '';
      unit = null;
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
  /// Pick multi files
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<PlatformFile> files = result.files;

      print('Count files select ${files.length}');
      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          print('V1G1CreateWorkController pickFiles addFiles ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            donDichVuFiles.add(value.files!.first);
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Pick multi images
  ///
  Future pickImages({required List<String> data}) async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');
      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          print('V1G1CreateWorkController pickImages addImages ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            data.addAll(value.files!);
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }
  
  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required String file, required List<String> files}){
    files.removeWhere((element) => element.hashCode == file.hashCode);
    //Alert.error(title: "Xoá hình ảnh", message: "Hình ảnh đã được xoá thành công",backgroundColor: ColorResources.PRIMARYCOLOR);
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