import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/utils/alert.dart';

class V3ThongTinThanhToanController extends GetxController
    with SingleGetTickerProviderMixin {
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietDonHangProvider =
      GetIt.I.get<ChiTietVatTuProvider>();
  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest =
      DanhSachBaoGiaDonDichVuRequest.fromJson({});

  TextEditingController datetimeController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "");

  String title = "Thông tin thanh toán";
  String nganHangNhan = "MB";
  String soTaiKhoan = "800.000.68.68";
  String nguoiNhan = "Công ty Five Star System";
  double tienToiThieu = 7500;

  String noiDungChuyenKhoan = "DSADSADSADSADSADSA";

  List<List<dynamic>> labels = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    labels = [
      ["Quản lý tài khoản", ""],
      ["Ngân hàng nhận", nganHangNhan],
      ["Số tài khoản", soTaiKhoan],
      ["Người nhận", nguoiNhan],
      ["Số tiền tối thiểu", tienToiThieu],
    ];
    isLoading = false;
    update();
  }

  ///
  /// Load hình ảnh
  ///

  ///
  /// xác nhận
  ///
  void onXacNhanClick() {
    Get.back();
    Get.back();
    Get.back();
    Get.back();
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

      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          print('V2QuotationG1Controller pickFiles addFiles ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            danhSachBaoGiaDonDichVuRequest.file = value.files![0];
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
  /// Dinh dang ten file da upload
  ///
  String getFileNameBaoGia() {
    if (danhSachBaoGiaDonDichVuRequest.file != null &&
        danhSachBaoGiaDonDichVuRequest.file!.isNotEmpty &&
        danhSachBaoGiaDonDichVuRequest.file.toString() != 'null') {
      final arrayNameSplit =
          danhSachBaoGiaDonDichVuRequest.file.toString().split('/');
      return arrayNameSplit[arrayNameSplit.length - 1];
    }
    return '';
  }
}
