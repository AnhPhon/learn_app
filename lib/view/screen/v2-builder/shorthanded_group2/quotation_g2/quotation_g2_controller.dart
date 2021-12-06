import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/chi_tiet_cong_viec_request.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/response/chi_tiet_cong_viec_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chi_tiet_cong_viec_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_vi_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/helper/izi_validate.dart';

class V2QuotationG2Controller extends GetxController {
  String idDonDichVu = "";

  String quotationInfoSelected = '';

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  final ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest = DanhSachBaoGiaDonDichVuRequest.fromJson({});
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  DonViProvider donViProvider = GetIt.I.get<DonViProvider>();

  ChiTietCongViecProvider chiTietCongViecProvider = GetIt.I.get<ChiTietCongViecProvider>();
  List<ChiTietCongViecResponse>? chiTietCongViecResponse = [];
  List<ChiTietCongViecRequest> chiTietCongViecRequest = [ChiTietCongViecRequest.fromJson({})];

  //order value
  final MoneyMaskedTextController orderValueController = MoneyMaskedTextController(
    precision: 0,
    initialValue: 0.0,
    decimalSeparator: '',
  );

  //job name
  List<TextEditingController> jobNameControllers = [TextEditingController()];

  //specifications
  List<TextEditingController> specificationsControllers = [TextEditingController()];

  //weight
  // List<TextEditingController> weightControllers = [TextEditingController(text: '0')];
  List<MoneyMaskedTextController> weightControllers = [
    MoneyMaskedTextController(
      precision: 0,
      initialValue: 0.0,
      decimalSeparator: '',
    )
  ];

  //unit price
  // List<TextEditingController> unitPriceControllers = [TextEditingController()];
  List<MoneyMaskedTextController> unitPriceControllers = [
    MoneyMaskedTextController(
      precision: 0,
      initialValue: 0.0,
      decimalSeparator: '',
    )
  ];

  //unit price string arrray
  List<String> unitPrices = ['0'];

  String title = "Báo giá";

  int orderValue = 0;

  bool allowEdit = false;

  List<String> quotationInfo = [
    "Khách hàng cung cấp thông tin",
    "Đến hiện trường",
  ];

  List<String> unitArray = [];

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['id'] != null) {
      idDonDichVu = arguments!['id'] as String;
      danhSachBaoGiaDonDichVuRequest.idDonDichVu = idDonDichVu;

      quotationInfoSelected = quotationInfo[0];
      update();
    }

    Future.delayed(Duration.zero, () {
      initChiTietCongViecCalc();
    });
  }

  ///
  /// Dinh dang ten file da upload
  ///
  String getFileNameBaoGia() {
    if (danhSachBaoGiaDonDichVuRequest.file != null && danhSachBaoGiaDonDichVuRequest.file!.isNotEmpty && danhSachBaoGiaDonDichVuRequest.file.toString() != 'null') {
      final arrayNameSplit = danhSachBaoGiaDonDichVuRequest.file.toString().split('/');
      return arrayNameSplit[arrayNameSplit.length - 1];
    }
    return '';
  }

  ///
  /// Add first chi tiet cong viec form
  ///
  void initChiTietCongViecCalc() {
    for (var i = 0; i < chiTietCongViecRequest.length; i++) {
      unitPriceControllers[i].addListener(() => calculator());
      weightControllers[i].addListener(() => calculator());
    }
    update();

    donViProvider.paginate(
      page: 1,
      limit: 100,
      filter: '&idNhomDichVu=$NHOM_DICH_VU_2',
      onSuccess: (value) {
        if (value.isNotEmpty) {
          unitArray = value.map((e) => e.ten!).toList();
          update();
        }
      },
      onError: (e) {
        EasyLoading.dismiss();
        IZIAlert.error(message: e.toString());
      },
    );
  }

  ///
  /// Add chi tiet cong viec form
  ///
  void addChiTietCongViecForm() {
    chiTietCongViecRequest.add(ChiTietCongViecRequest.fromJson({}));
    unitPriceControllers.add(MoneyMaskedTextController(
      precision: 0,
      initialValue: 0.0,
      decimalSeparator: '',
    ));
    weightControllers.add(MoneyMaskedTextController(
      precision: 0,
      initialValue: 0.0,
      decimalSeparator: '',
    ));
    // weightControllers.add(TextEditingController(text: '0'));
    jobNameControllers.add(TextEditingController());
    specificationsControllers.add(TextEditingController());
    unitPrices.add('0');
    initChiTietCongViecCalc();
  }

  ///
  /// Add chi tiet cong viec form
  ///
  void deleteCongViec(int index) {
    if (chiTietCongViecRequest.length > 0) {
      chiTietCongViecRequest.removeAt(index);
      unitPriceControllers.removeAt(index);
      weightControllers.removeAt(index);
      jobNameControllers.removeAt(index);
      specificationsControllers.removeAt(index);
      unitPrices.removeAt(index);

      for (var i = 0; i < chiTietCongViecRequest.length; i++) {
        unitPriceControllers[i].addListener(() => calculator());
        weightControllers[i].addListener(() => calculator());
      }

      calculator();

      update();
    }
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
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            danhSachBaoGiaDonDichVuRequest.file = value.files![0];
            allowEdit = true;
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
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            danhSachBaoGiaDonDichVuRequest.hinhAnhBaoGias = value.files;
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
  ///check condition
  ///
  void condition() {
    update();
  }

  ///
  ///calculator
  ///
  void calculator() {
    if (checkGiaTriDonHangIsEmpty() == true) {
      orderValue = 0;
      for (var i = 0; i < unitPriceControllers.length; i++) {
        if (unitPriceControllers[i].text != null && unitPriceControllers[i].text.isNotEmpty && unitPriceControllers[i].text != 'null') {
          orderValue += int.parse(Validate.getValuePriceString(unitPriceControllers[i].text)) * int.parse(Validate.getValuePriceString(chiTietCongViecRequest[i].soLuong.toString()));
        }
      }
    }
    update();
  }

  ///
  ///calculator
  ///
  void setPriceFromInputCustom(val) {
    orderValue = 0;
    if (checkGiaTriDonHangIsEmpty() == false) {
      orderValue += int.parse(Validate.getValuePriceString(val.toString()));
    } else {
      calculator();
    }
    update();
  }

  ///
  ///go to after quotation g2 page
  ///
  Future<void> onAfterQuotationG2PageClick() async {
    try {
      if (await checkForm()) {
        Get.toNamed(
          AppRoutes.V2_AFTER_QUOTATION_GROUP2,
          arguments: {
            'id': idDonDichVu.toString(),
            'danhSachBaoGiaDonDichVuRequest': danhSachBaoGiaDonDichVuRequest,
            'chiTietCongViecRequest': chiTietCongViecRequest,
            'unitPrices': unitPrices,
          },
        );
      }

      // EasyLoading.show(status: 'Loading...');

      // if (await checkForm()) {
      //   danhSachBaoGiaDonDichVuProvider.add(
      //     data: danhSachBaoGiaDonDichVuRequest,
      //     onSuccess: (data) {
      //       EasyLoading.dismiss();
      //       IZIAlert.success(message: 'Báo giá thành công');
      //       Get.back();
      //       Get.back();
      //     },
      //     onError: (error) {
      //       print('V2QuotationG1Controller onDoneClick onError $error');
      //       EasyLoading.dismiss();
      //       IZIAlert.error(message: 'Báo giá thất bại');
      //     },
      //   );
      // } else {
      //   EasyLoading.dismiss();
      // }
    } on PlatformException catch (e) {
      // EasyLoading.dismiss();
      IZIAlert.error(message: e.toString());
    }
  }

  ///
  /// Validate form input
  ///
  Future<bool> checkForm() async {
    print('orderValue $orderValue');
    print('checkFileIsEmpty() ${checkFileIsEmpty()}');
    print('checkFormChiTietCongViecIsEmpty() ${checkFormChiTietCongViecIsEmpty()}');
    print('checkGiaTriDonHangIsEmpty() ${checkGiaTriDonHangIsEmpty()}');
    if ((checkFileIsEmpty() == true && checkFormChiTietCongViecIsEmpty() == true)) {
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Không được bỏ trống dữ liệu báo giá');
      return false;
    // } else if (orderValue <= 0 || (checkFileIsEmpty() == false && checkFormChiTietCongViecIsEmpty() == true && checkGiaTriDonHangIsEmpty())) {
    } else if (orderValue <= 0) {
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Không được bỏ trống giá trị đơn hàng');
      return false;
    } else {
      danhSachBaoGiaDonDichVuRequest.thongTinBaoGia = quotationInfoSelected;
      danhSachBaoGiaDonDichVuRequest.giaCongViecs = [];
      // for (var i = 0; i < chiTietCongViecRequest.length; i++) {
      //   await chiTietCongViecProvider.add(
      //     data: chiTietCongViecRequest[i],
      //     onSuccess: (data) {
      //       danhSachBaoGiaDonDichVuRequest.giaCongViecs!.add(GiaCongViecRequest.fromJson({
      //         'idChiTietCongViec': data.id,
      //         'donGia': unitPrices[i],
      //       }));
      //     },
      //     onError: (error) {
      //       print('V2QuotationG2Controller checkForm onError $error');
      //       IZIAlert.error(message: error.toString());
      //     },
      //   );
      // }
    }

    print('orderValue $orderValue');
    danhSachBaoGiaDonDichVuRequest.idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    danhSachBaoGiaDonDichVuRequest.tongTien = orderValue.toString();
    print('danhSachBaoGiaDonDichVuRequest ${danhSachBaoGiaDonDichVuRequest.tongTien}');
    danhSachBaoGiaDonDichVuRequest.giaVatTus = [];

    return true;
  }

  ///
  /// Return true if has file
  ///
  bool checkFileIsEmpty() {
    return danhSachBaoGiaDonDichVuRequest.file == null || danhSachBaoGiaDonDichVuRequest.file!.isEmpty || danhSachBaoGiaDonDichVuRequest.file.toString() == 'null';
  }

  ///
  /// Return true if has gia tri don hang text
  ///
  bool checkGiaTriDonHangIsEmpty() {
    return orderValueController.text.isEmpty || orderValueController.text.toString() == 'null' || orderValueController.text.toString() == '0';
  }

  ///
  /// Return true if chiTietCongViecRequest length > 0 and chiTietCongViecRequest item has data
  ///
  bool checkFormChiTietCongViecIsEmpty() {
    for (var i = 0; i < chiTietCongViecRequest.length; i++) {
      if (chiTietCongViecRequest[i].tenCongViec == null || chiTietCongViecRequest[i].tenCongViec!.isEmpty || chiTietCongViecRequest[i].tenCongViec! == 'null') {
        return true;
      }
      if (chiTietCongViecRequest[i].quyCach == null || chiTietCongViecRequest[i].quyCach!.isEmpty || chiTietCongViecRequest[i].quyCach! == 'null') {
        return true;
      }
      if (chiTietCongViecRequest[i].soLuong == null || chiTietCongViecRequest[i].soLuong!.isEmpty || chiTietCongViecRequest[i].soLuong! == 'null') {
        return true;
      }
      if (chiTietCongViecRequest[i].donVi == null || chiTietCongViecRequest[i].donVi!.isEmpty || chiTietCongViecRequest[i].donVi! == 'null') {
        return true;
      }
      if (unitPrices[i] == null || unitPrices[i].isEmpty || unitPrices[i] == 'null') {
        return true;
      }
    }

    if (chiTietCongViecRequest.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  ///
  /// Update don vi cho vat tu
  ///
  void updateDonVi(int index, String? val) {
    if (val != null && index >= 0 && index < chiTietCongViecRequest.length) {
      chiTietCongViecRequest[index].donVi = val.toString();
      update();
    }
  }

  ///
  /// Chon thong tin bao gia
  ///
  void updateThongTinBaoGia(String val) {
    quotationInfoSelected = val.toString();
    update();
  }
}
