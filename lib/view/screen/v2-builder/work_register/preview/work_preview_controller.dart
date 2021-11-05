import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/dang_ky_viec_moi_model.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/request/danh_sach_ung_tuyen_request.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';

import 'package:template/data/repository/dang_ky_viec_moi_repository.dart';
import 'package:template/data/repository/danh_sach_ung_tuyen_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V2WorkPreviewController extends GetxController {
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  TaiKhoanResponse? taiKhoanResponse;
  DangKyViecMoiRequest dangKyViecMoiRequest = DangKyViecMoiRequest();
  final ImageUpdateProvider imageUpdateProvider =
      GetIt.I.get<ImageUpdateProvider>();

  DangKyViecMoiRepository dangKyViecMoiRepository = DangKyViecMoiRepository();
  DanhSachUngTuyenRepository danhSachUngTuyenRepository =
      DanhSachUngTuyenRepository();
  DanhSachUngTuyenProvider danhSachUngTuyenProvider =
      GetIt.I.get<DanhSachUngTuyenProvider>();
  DanhSachUngTuyenRequest danhSachUngTuyenRequest = DanhSachUngTuyenRequest();
  DangKyViecMoiProvider dangKyViecMoiProvider =
      GetIt.I.get<DangKyViecMoiProvider>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadInit();
  }

  ///
  ///Load Init
  ///
  void loadInit() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      print("kiem tra tra id $id");
      taiKhoanProvider.find(
          id: id!,
          onSuccess: (value) {
            taiKhoanResponse = value;
            print(taiKhoanResponse!.toJson());
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          });
    });
  }

  List<String> getAnhBangCap() {
    if (dangKyViecMoiRequest.anhBangCaps != null &&
        dangKyViecMoiRequest.anhBangCaps!.isNotEmpty &&
        dangKyViecMoiRequest.anhBangCaps.toString() != 'null') {
      final arrayNameSplit = dangKyViecMoiRequest.anhBangCaps;
      return arrayNameSplit!;
    }
    return [];
  }

  List<String> getAnhHoSoXinViec() {
    if (dangKyViecMoiRequest.anhHoSoXinViecs != null &&
        dangKyViecMoiRequest.anhHoSoXinViecs!.isNotEmpty &&
        dangKyViecMoiRequest.anhHoSoXinViecs.toString() != 'null') {
      final arrayNameSplit = dangKyViecMoiRequest.anhHoSoXinViecs;
      return arrayNameSplit!;
    }
    return [];
  }

  ///
  /// Pick bằng cấp nếu có
  ///
  Future pickAnhBangCap() async {
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
          print('V2QuotationG1Controller pickImages addImages ${value.files}');
          EasyLoading.dismiss();

          if (value.files != null && value.files!.isNotEmpty) {
            dangKyViecMoiRequest.anhBangCaps = value.files;
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
  /// Pick Ảnh hồ sơ xin việc
  ///
  Future pickAnhHoSoXinViec() async {
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
          print('V2QuotationG1Controller pickImages addImages ${value.files}');
          EasyLoading.dismiss();

          if (value.files != null && value.files!.isNotEmpty) {
            dangKyViecMoiRequest.anhHoSoXinViecs = value.files;
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

  String getFileNameBaoGia() {
    if (dangKyViecMoiRequest.fileHoSoXinViec != null &&
        dangKyViecMoiRequest.fileHoSoXinViec!.isNotEmpty &&
        dangKyViecMoiRequest.fileHoSoXinViec.toString() != 'null') {
      final arrayNameSplit =
          dangKyViecMoiRequest.fileHoSoXinViec.toString().split('/');
      return arrayNameSplit[arrayNameSplit.length - 1];
    }
    return '';
  }

  ///
  /// Pick multi files
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<PlatformFile> files = result.files;

      print('Count files select ${files.length}');
      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          print('V2QuotationG1Controller pickFiles addFiles ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            dangKyViecMoiRequest.fileHoSoXinViec = value.files![0];
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
  /// go to done page
  ///
  void toDonePage(DangKyViecMoiModel dangKiModel) {
    // dangKyViecMoiProvider.update(
    //   data: data,
    //   onSuccess: onSuccess,
    //   onError: onError,
    // );
    Get.toNamed(AppRoutes.V2_REGISTER_DONE);
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToVNDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  // update thông tin
  // void updateThongTin() {
  //   dangKyViecMoiRepository.update(dangKyViecMoiRequest).then((value) => {
  //         if (value.response.data != null)
  //           {
  //             //check xem có lưu chưa
  //             danhSachUngTuyenProvider.paginate(
  //                 page: 1,
  //                 limit: 5,
  //                 filter:
  //                     '&idTuyenDung=$idTuyenDung&idTaiKhoanUngTuyen=$userId',
  //                 onSuccess: (value) {
  //                   if (value.isEmpty) {
  //                     //set data
  //                     danhSachUngTuyenRequest.idTuyenDung = idTuyenDung;
  //                     danhSachUngTuyenRequest.idTaiKhoanUngTuyen = userId;
  //                     danhSachUngTuyenRequest.daXem = '0';
  //                     //insert db
  //                     danhSachUngTuyenRepository
  //                         .add(danhSachUngTuyenRequest)
  //                         .then((value) => {
  //                               if (value.response.data != null)
  //                                 {
  //                                   EasyLoading.dismiss(),
  //                                   Alert.success(
  //                                       message:
  //                                           'Nộp hồ sơ ứng tuyển thành công'),
  //                                   Get.back(),
  //                                   Get.back(result: true)
  //                                 }
  //                               else
  //                                 {
  //                                   EasyLoading.dismiss(),
  //                                   Alert.error(message: 'Vui lòng thử lại')
  //                                 }
  //                             });
  //                   } else {
  //                     EasyLoading.dismiss();
  //                     Get.back();
  //                     Alert.info(
  //                         message: 'Bạn đã ứng tuyển tin tuyển dụng này rồi');
  //                   }
  //                 },
  //                 onError: (error) =>
  //                     print('V2CvController onBtnSummit $error')),
  //           }
  //         else
  //           {EasyLoading.dismiss(), Alert.error(message: 'Vui lòng thử lại')}
  //       });
  // }
}
