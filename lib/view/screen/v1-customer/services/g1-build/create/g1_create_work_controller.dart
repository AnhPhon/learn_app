import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/data/model/response/chi_tiet_cong_viec_response.dart';
import 'package:template/data/model/response/don_vi_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/don_vi_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';

class V1G1CreateWorkController extends GetxController {
  final ImageUpdateProvider imageUpdateProvider =
      GetIt.I.get<ImageUpdateProvider>();
  final DonViProvider donViProvider = GetIt.I.get<DonViProvider>();

  final worKTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final nameTitleController = TextEditingController();
  final specificationController = TextEditingController();
  final massController = TextEditingController();
  final unitController = TextEditingController();

  // Scroll
  final scrollController = ScrollController();

  // List
  List<String> donDichVuFiles = [];
  // File name
  // Dach sách bảng khối lượng công việc
  List<ChiTietCongViecResponse> workList = [];
  // Danh sách hình ảnh bảng khối lượng
  List<String> anhKhoiLuong = [];
  // Danh sách hình ảnh bản vẽ
  List<String> drawingImages = [];
  List<DonViResponse>? donVis = [];

  //Variable
  DonViResponse? unit;
  DonDichVuRequest? serviceApplication;

  //Flag
  bool isLoadingVatTu = true;

  @override
  void onInit() {
    super.onInit();
    serviceApplication = Get.arguments as DonDichVuRequest;
    worKTitleController.text = serviceApplication!.tieuDe ?? '';
    getAllDonVi();
  }

  ///
  /// Nhấn tiếp tục qua trang xem lại đơn tạo
  ///
  void onClickContinueButton() {
    if (descController.text.toString().isEmpty) {
      IZIAlert.error(message: "Mô tả công việc không được để trống");
      return;
    } else if (startTimeController.text.toString().isEmpty) {
      IZIAlert.error(message: "Thời gian bắt đầu không được để trống");
      return;
    } else if (DateConverter.differenceDate(
            startDate: startTimeController.text.toString(),
            endDate: DateConverter.estimatedDateOnly(DateTime.now())) >
        0) {
      IZIAlert.error(message: "Ngày bắt đầu không được nhỏ hơn ngày hiện tại");
      return;
    }

    if (endTimeController.text.isEmpty &&
        endTimeController.text.toString() == "null") {
      if (DateTime.parse(DateFormat('dd-MM-yyyy')
              .parse(endTimeController.text)
              .toString()
              .substring(0, 10))
          .isBefore(DateTime.parse(DateFormat('dd-MM-yyyy')
              .parse(startTimeController.text)
              .toString()
              .substring(0, 10)))) {
        IZIAlert.error(message: "Ngày kết thúc không được bé hơn ngày bắt đầu");
        return;
      }
    }

    // Lưu dich vụ
    saveServices();
  }

  void getAllDonVi() {
    donViProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idNhomDichVu=$NHOM_DICH_VU_1',
        onSuccess: (data) {
          donVis = data;
          isLoadingVatTu = false;
          update();
        },
        onError: (onError) {
          print("Vật tư");
        });
  }

  void saveServices() {
    final PreviewServiceRequest previewServiceRequest = PreviewServiceRequest();
    previewServiceRequest.moTa = descController.text.toString();
    previewServiceRequest.ngayBatDau = startTimeController.text.toString();
    if (endTimeController.text.toString().isNotEmpty) {
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
    previewServiceRequest.bangKhoiLuongCongViec = workList;
    previewServiceRequest.idTaiKhoanNhanDon =
        serviceApplication!.idTaiKhoanNhanDon;
    previewServiceRequest.hinhAnhBanVes = drawingImages;
    previewServiceRequest.idLoaiCongViec = serviceApplication!.idLoaiCongViec;
    if (donDichVuFiles.isNotEmpty) {
      previewServiceRequest.files = donDichVuFiles;
    }
    Get.toNamed(AppRoutes.V1_G1_REVIEW, arguments: previewServiceRequest);
  }

  ///
  /// Thay đổi đơn vị
  ///
  void onChangedUnit(DonViResponse unit) {
    this.unit = unit;
    update();
  }

  ///
  /// Thêm khối lượng công việc
  ///
  void onClickAddMass() {
    if (nameTitleController.text.toString().isEmpty) {
      return IZIAlert.error(message: "Tên công việc không được để trống");
    } else if (specificationController.text.toString().isEmpty) {
      return IZIAlert.error(message: "Quy cách không được để trống");
    } else if (unit == null) {
      return IZIAlert.error(message: 'Đơn vị không được để trống');
    } else if (massController.text.toString().isEmpty) {
      return IZIAlert.error(message: "Khối lượng không được để trống");
    } else {
      final ChiTietCongViecResponse supplies = ChiTietCongViecResponse(
        soLuong: massController.text.toString(),
        donVi: unit!.ten,
        quyCach: specificationController.text.toString(),
        tenCongViec: nameTitleController.text.toString(),
      );
      workList.add(supplies);
      nameTitleController.text = '';
      specificationController.text = '';
      massController.text = '';
      unit = null;
      IZIAlert.success(
          message:
              "Thêm khối lượng công việc thành công. Bạn có thêm khối lượng công việc khác");

      update();
    }
  }

  ///
  /// Xoá vật liệu
  ///
  void deleteSupplies(ChiTietCongViecResponse supplies) {
    workList.removeWhere((element) => element.hashCode == supplies.hashCode);
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
          IZIAlert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: e.toString());
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
          IZIAlert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: e.toString());
    }
  }

  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required String file, required List<String> files}) {
    files.removeWhere((element) => element.hashCode == file.hashCode);
    //IZIAlert.error(title: "Xoá hình ảnh", message: "Hình ảnh đã được xoá thành công",backgroundColor: ColorResources.PRIMARYCOLOR);
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
    scrollController.dispose();
  }
}
