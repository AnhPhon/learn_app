import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

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
  List<String> donDichVuFiles = [];

  // Danh sách hình ảnh hien trang
  List<String> currentStatusimages = [];
  // Danh sách hình san pham mau
  List<String> productImages = [];
  // Hinh ảnh bản khối lương
  List<String> massImages = [];
  // Dịch vụ resquest
  DonDichVuRequest? serviceApplication;
  // loading
  bool isLoading = true;
  bool isClicked = false;

  @override
  void onInit() {
    super.onInit();
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
    if (afternoon) {
      afternoonReponse = thoiGianLamViecList
          .firstWhere((element) => element.tieuDe!.contains('13h30 - 17h30'));
    } else {
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

  ///
  /// Pick multi files
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
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
  void onDeleteImage({required String file, required List<String> files}) {
    files.removeWhere((element) => element.hashCode == file.hashCode);
    update();
  }

  ///
  /// Load thời gian làm việc db
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
  Future<void> onClickContinueButton() async {
    if (validate()) {
      onSaveService();
    }
  }

  ///
  /// Check validate
  ///
  bool validate() {
    if (tommorow == false && afternoon == false && tonight == false) {
      Alert.error(message: "Bạn phải chọn thời gian làm việc trong ngày");
      return false;
    } else if (startTime.text.toString().isEmpty) {
      Alert.error(message: "Bạn phải chọn thời gian bắt đầu dự kiến");
      return false;
    } else if (DateConverter.differenceDate(
            startDate: startTime.text.toString(),
            endDate: DateConverter.estimatedDateOnly(DateTime.now())) >
        0) {
      Alert.error(message: "Ngày bắt đầu không được bé hơn ngày hiện tại");
      return false;
    } else if (endTime.text.isEmpty && endTime.text.toString() == "null") {
      if (DateTime.parse(DateFormat('dd-MM-yyyy')
              .parse(endTime.text)
              .toString()
              .substring(0, 10))
          .isBefore(DateTime.parse(DateFormat('dd-MM-yyyy')
              .parse(startTime.text)
              .toString()
              .substring(0, 10)))) {
        Alert.error(message: "Ngày kết thúc không được bé hơn ngày bắt đầu");
        return false;
      }
      return true;
    } else if (workDesc.text.toString().isEmpty) {
      Alert.error(message: "Mô tả công việc không được để trống");
      return false;
    } else if (workDesc.text.toString().isEmpty) {
      Alert.error(message: "Mô tả công việc không được để trống");
      return false;
    } else {
      return true;
    }
  }

  ///
  /// save services
  ///
  Future<void> onSaveService() async {
    if (isClicked) {
      return;
    } else {
      isClicked = true;
      EasyLoading.show(status: "Loading ...");
      final DonDichVuRequest data = request();
      donDichVuProvider.add(
          data: data,
          onSuccess: (data) {
            EasyLoading.dismiss();
            Alert.success(
                message:
                    "Tạo dich đơn thành công. Chúng tôi sẽ phản hồi bạn sơm nhất có thể");
            Get.offAllNamed(AppRoutes.V1_SUCCESSFULLY,
                predicate: ModalRoute.withName(AppRoutes.V1_SUCCESSFULLY));
            //Get.toNamed(AppRoutes.V1_SUCCESSFULLY);
          },
          onError: (onError) {
            EasyLoading.dismiss();
            print("V1G2CreateWorkController onClickContinueButton $onError");
          });
    }
  }

  ///
  /// Tạo đối tượng request
  ///
  DonDichVuRequest request() {
    final List<String> workTime = [];
    DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest = serviceApplication!;
    if (tommorow == true) {
      workTime.add(tommowReponse!.id!);
    }
    if (afternoon == true) {
      workTime.add(afternoonReponse!.id!);
    }
    if (tonight == true) {
      workTime.add(tonightReponse!.id!);
    }
    dichVuRequest.idThoiGianLamViecs = workTime;
    ////////////////////////////////////////////////////////////////
    print(startTime.text.toString());
    dichVuRequest.ngayBatDau =
        DateConverter.formatYYYYMMDD(startTime.text.toString());
    if (endTime.text.toString().isNotEmpty) {
      dichVuRequest.ngayKetThuc =
          DateConverter.formatYYYYMMDD(endTime.text.toString());
    }
    dichVuRequest.moTa = workDesc.text.toString(); // Mô tả công viêc
    dichVuRequest.moTaChiTiet =
        massDesc.text.toString(); // Mô tả khói lượng công việc
    // trạng thái đơn
    dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
    dichVuRequest.idTrangThaiDonDichVu = CHUA_PHAN_HOI;

    // Tải file
    if (donDichVuFiles.isNotEmpty) {
      dichVuRequest.files = donDichVuFiles;
    }

    dichVuRequest.hinhAnhBanKhoiLuongs = massImages;
    dichVuRequest.hinhAnhBanVes =
        productImages; // Hình ảnh bản vẽ là hình ảnh sản phẩm mẫu
    dichVuRequest.hinhAnhThucTes =
        currentStatusimages; // Hình ảnh chi tiết cho là hình ảnh hiện trạng

    dichVuRequest.idLoaiCongViec = serviceApplication!.idLoaiCongViec;
    return dichVuRequest;
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
