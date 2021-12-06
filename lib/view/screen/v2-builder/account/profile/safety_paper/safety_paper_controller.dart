import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/giay_chung_nhan_suc_khoe_request.dart';
import 'package:template/data/model/response/giay_chung_nhan_suc_khoe_response.dart';
import 'package:template/data/model/response/thong_tin_f_s_s_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/giay_chung_nhan_suc_khoe_provider.dart';
import 'package:template/provider/thong_tin_f_s_s_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class V2SafetyPaperController extends GetxController {
  //file upload
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //GiayChungNhanSucKhoe
  GiayChungNhanSucKhoeProvider giayChungNhanSucKhoeProvider =
      GetIt.I.get<GiayChungNhanSucKhoeProvider>();
  GiayChungNhanSucKhoeResponse? giayChungNhanSucKhoeResponse;
  GiayChungNhanSucKhoeRequest giayChungNhanSucKhoeRequest =
      GiayChungNhanSucKhoeRequest();

  //thong tin ffs
  ThongTinFSSProvider thongTinFSSProvider = GetIt.I.get<ThongTinFSSProvider>();
  ThongTinFSSResponse thongTinFSSResponse = ThongTinFSSResponse();

  //userId
  String userId = "";

  //loading
  bool isLoading = true;

  //update
  bool isUpdate = true;

  //title appbar
  String title = "Giấy khám sức khoẻ";

  @override
  void onInit() {
    super.onInit();
    getUserId().then((value) {
      getContent();
      getGiayChungNhanSucKhoe();
    });
  }

  ///
  ///get userId
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///get content
  ///
  void getContent() {
    thongTinFSSProvider.all(
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          thongTinFSSResponse = data.first;
        }
        update();
      },
      onError: (error) {
        print("V2HelpController getHelp onError $error");
      },
    );
  }

  ///
  ///get GiayChungNhanSucKhoe
  ///
  void getGiayChungNhanSucKhoe() {
    giayChungNhanSucKhoeProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          giayChungNhanSucKhoeResponse = data.first;
          giayChungNhanSucKhoeRequest.file = data.first.file;
          isUpdate = false;
          IZIAlert.success(message: "Bạn đã cập nhật giấy khám sức khoẻ");
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print('V2SafetyPaperController getGiayChungNhanSucKhoe $error');
      },
    );
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
          print('V2SafetyPaperController pickFiles addFiles ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            giayChungNhanSucKhoeRequest.file = value.files![0];
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
  ///download file
  ///
  Future<void> downloadFile() async {
    if (await canLaunch(giayChungNhanSucKhoeRequest.file.toString())) {
      await launch(giayChungNhanSucKhoeRequest.file.toString());
    } else {
      throw 'V2SafetyPaperController downloadFile Could not launch ${giayChungNhanSucKhoeRequest.file}';
    }
  }

  ///
  ///on btn done
  ///
  void onBtnDone() {
    EasyLoading.show(status: 'Loading...');
    giayChungNhanSucKhoeRequest.idTaiKhoan = userId;
    giayChungNhanSucKhoeRequest.trangThai = "0";
    giayChungNhanSucKhoeProvider.add(
      data: giayChungNhanSucKhoeRequest,
      onSuccess: (data) {
        EasyLoading.dismiss();
        Get.back();
        IZIAlert.success(message: "Cập nhật giấy khám sức khoẻ thành công");
      },
      onError: (error) {
        print('V2SafetyPaperController onBtnDone $error');
      },
    );
  }

  ///
  ///on btn update
  ///
  void onBtnUpdate() {
    if (isUpdate) {
      giayChungNhanSucKhoeRequest.id = giayChungNhanSucKhoeResponse!.id;
      giayChungNhanSucKhoeRequest.idTaiKhoan = userId;
      giayChungNhanSucKhoeProvider.update(
        data: giayChungNhanSucKhoeRequest,
        onSuccess: (data) {
          Get.back();
          IZIAlert.success(message: "Chỉnh sửa giấy khám sức khoẻ thành công");
        },
        onError: (error) {
          print('V2SafetyPaperController onBtnUpdate $error');
        },
      );
    } else {
      giayChungNhanSucKhoeRequest.file = null;
      isUpdate = true;
      IZIAlert.info(message: "Cho phép chỉnh sửa");
      update();
    }
  }
}
