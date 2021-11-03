import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G2CreateWorkController extends GetxController {
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final ThoiGianLamViecProvider thoiGianLamViecProvider =
      GetIt.I.get<ThoiGianLamViecProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  final workTitleController = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
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
  void onSelectedTommorow({required bool val}) {
    tommorow = val;
    if (tommorow) {
      tommowReponse = thoiGianLamViecList
          .firstWhere((element) => element.tieuDe!.contains('7h30 - 11h30'));
    } else {
      tommowReponse = null;
    }
    update();
  }

  void onSelectedAfternoon({required bool val}) {
    afternoon = val;
    if(afternoon){
      afternoonReponse = thoiGianLamViecList.firstWhere((element) => element.tieuDe!.contains('13h30 - 17h30'));
    }else{
      afternoonReponse = null;
    }
    update();
  }

  void onSelectedTonight({required bool val}) {
    tonight = val;
    if (tonight) {
      tonightReponse = thoiGianLamViecList
          .firstWhere((element) => element.tieuDe!.contains('18h30 - 22h30'));
    } else {
      tonightReponse = null;
    }
    update();
  }

  void pickerFile()async{
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
      fileName = result.files.first.name;
      update();
      // return fileName;
    } else {
      print("Thêm file thất bại V1G2CreateWorkController PickerFile");
      Alert.error(message: "Thêm file thất bại");
    }
  }

  ///
  /// Chọn nhiều file (Image)
  ///
  Future<void> pickerMuilFile({required List<File> files}) async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      files.addAll(result.paths.map((path) => File(path!)).toList());
      update();
    } else {
      print("Thêm file thất bại V1G2CreateWorkController");
      Alert.error( message: "Thêm file thất bại");
    }
  }

  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required File file, required List<File> files}) {
    files.removeWhere((element) => element.hashCode == file.hashCode);
    Alert.success( message: "Xoá ảnh thành công");
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
      print("V1G2CreateWorkController getWorkTime $error");
    });
  }

  ///
  /// Nhấn tiếp tục hoàn thành tạo đơn
  ///
  void onClickContinueButton()async{
    if(validate()){
      onSaveService();
    }
  }


  ///
  /// Check validate
  ///
  bool validate(){
    if(tommorow == false && afternoon == false && tonight == false){
      Alert.info(message: "Bạn phải chọn thời gian làm việc trong ngày");
      return false;
    }else if(startTime.text.toString().isEmpty){
      Alert.info(message: "Bạn phải chọn thời gian bắt đầu dự kiến");
      return false;
    }else if(DateConverter.differenceDate(startDate: startTime.text.toString(), endDate: DateConverter.estimatedDateOnly(DateTime.now())) > 0){
      Alert.info(message: "Ngày bắt đầu không được bé hơn ngày hiện tại");
      return false;
    }else if(endTime.text.toString().isNotEmpty){
      if(DateConverter.differenceDate(startDate: startTime.text.toString(), endDate: endTime.text.toString()) <= 0){
        Alert.info(message: "Ngày kết thúc phải lớn hơn ngày bắt đầu");
        return false;
      }else if(workDesc.text.toString().isEmpty){
        Alert.info(message: "Mô tả công việc không được để trống");
        return false;
      }
      return true;
    }else if(workDesc.text.toString().isEmpty){
      Alert.info(message: "Mô tả công việc không được để trống");
      return false;
    }else{
      return true;
    }
  }

  ///
  /// save services
  ///
  Future<void> onSaveService() async{
    EasyLoading.show(status:"Loading ...");
      final DonDichVuRequest data = await request();
      donDichVuProvider.add(data: data, onSuccess: (data){
        EasyLoading.dismiss();
        Alert.success(message: "Tạo dich đơn thành công. Chúng tôi sẽ phản hồi bạn sơm nhất có thể");
        Get.offAllNamed(AppRoutes.V1_SUCCESSFULLY, predicate: ModalRoute.withName(AppRoutes.V1_SUCCESSFULLY));
        //Get.toNamed(AppRoutes.V1_SUCCESSFULLY);
      }, onError: (onError){
        EasyLoading.dismiss();
        print("V1G2CreateWorkController onClickContinueButton $onError");
      });
  }

  ///
  /// Tạo đối tượng request
  ///
  Future<DonDichVuRequest> request(){
      final List<String> workTime = [];
      final List<String> massImagesLink = [];
      final List<String> productImagesLink = [];
      final List<String> currentStatusimages = [];
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
      dichVuRequest.idThoiGianLamViecs = workTime;
      ////////////////////////////////////////////////////////////////
      print(startTime.text.toString());
      dichVuRequest.ngayBatDau = DateConverter.formatYYYYMMDD(startTime.text.toString());
      if(endTime.text.toString().isNotEmpty){
        dichVuRequest.ngayKetThuc = DateConverter.formatYYYYMMDD(endTime.text.toString());
      }
      dichVuRequest.moTa = workDesc.text.toString(); // Mô tả công viêc
      dichVuRequest.moTaChiTiet = massDesc.text.toString();// Mô tả khói lượng công việc
      // trạng thái đơn
      dichVuRequest.idTrangThaiDonDichVu = CHUA_THANH_TOAN;
      dichVuRequest.idTrangThaiDonDichVu = CHUA_PHAN_HOI;

    // Tải hình ảnh hiên trạng
    images.forEach((element) {
      imageUpdateProvider.add(
          file: element,
          onSuccess: (data) {
            currentStatusimages.add(data.data!);
          },
          onError: (onError) {
            print("V1G2CreateWorkController request hiện trạng $onError");
            EasyLoading.dismiss();
          });
    });

    // HỈnh ảnh sản phẩm mẫu
    productImages.forEach((element) {
      imageUpdateProvider.add(
          file: element,
          onSuccess: (data) {
            productImagesLink.add(data.data!);
          },
          onError: (onError) {
            print("V1G2CreateWorkController request ảnh sản phẩm mẫu $onError");
            EasyLoading.dismiss();
          });
    });

    // HÌnh ảnh khối lượng
    massImages.forEach((element) {
      imageUpdateProvider.add(
          file: element,
          onSuccess: (data) {
            massImagesLink.add(data.data!);// = "$massImagesLink${data.data},";
          },
          onError: (onError) {
            print("V1G2CreateWorkController request khối lượng $onError");
            EasyLoading.dismiss();
          });
    });

    // Tải file
    if (file != null) {
      imageUpdateProvider.add(
          file: file!,
          onSuccess: (data) {
            dichVuRequest.file = data.data;
          },
          onError: (onError) {
            EasyLoading.dismiss();
            print("V1G2CreateWorkController request tải file $onError");
          });
    }

    return Future.delayed(const Duration(seconds: 1), () {
      dichVuRequest.hinhAnhBanKhoiLuongs = massImagesLink;
      dichVuRequest.hinhAnhBanVes =
          productImagesLink; // Hình ảnh bản vẽ là hình ảnh sản phẩm mẫu
      dichVuRequest.hinhAnhThucTes =
          currentStatusimages; // Hình ảnh chi tiết cho là hình ảnh hiện trạng
      return dichVuRequest;
    });
    //return dichVuRequest;
  }

  @override
  void onClose() {
    workTitleController.dispose();
    startTime.dispose();
    endTime.dispose();
    massDesc.dispose();
    workDesc.dispose();
  }
}
