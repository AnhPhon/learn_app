import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/routes/app_routes.dart';

class V1G7ReviewController extends GetxController {
  // Tiêu đề
  final titleController = TextEditingController();
  // Công ty
  final companyController = TextEditingController();
  // Địa điểm làm việc
  final workController = TextEditingController();
  // địa chỉ công ty
  final addressController = TextEditingController();
  // miêu tả
  final descController = TextEditingController();
  //yêu cẩu
  final requiredController = TextEditingController();
  // quyền lợi
  final benifitController = TextEditingController();
  // Ưu tiên
  final prioritizedController = TextEditingController();
  // Hạn nộp
  final endTimeController = TextEditingController();
  // name
  final nameController = TextEditingController();
  //phone
  final phoneController = TextEditingController();
  // contact address
  final contactAddressController = TextEditingController();
  // email
  final emailController = TextEditingController();
  // số người
  final amountController = TextEditingController();
  //hình thức làm việc
  final hinhThucLamViecController = TextEditingController();
  //trình độ học vấn
  final trinhDoHocVanController = TextEditingController();
  //chuyen ngành chính
  final chuyenNganhChinhController = TextEditingController();
  //Số năm kinh nghiệm
  final soNamKinhNghiemController = TextEditingController();
  //mức lương dự kiến
  final mucLuongDuKienController = TextEditingController();
  //Nơi làm việc
  final noiLamViecController = TextEditingController();
  //Thời gian làm việc
  final thoiGianLamViecController = TextEditingController();
  //Thơi gian thử việc
  final thoiGianThucTapController = TextEditingController();
  //Chuyên ngành phụ
  final chuyenNganhPhuController = TextEditingController();

  //Hạn nội hồ sơ
  String? hanNopHoSo;

  //value giới tính
  int chooseSex = 0;

  //value request
  dynamic request;

  //value tuyển dụng
  TuyenDungRequest tuyenDungRequest = TuyenDungRequest();

  //isLoading
  bool isLoading = true;

  //bool isReview
  bool isReview = false;

  @override
  void onInit() {
    super.onInit();

    //check router review tin tuyển dụng
    if (Get.parameters['isReview'] == 'true') {
      isReview = true;
    } else {
      isReview = false;
    }
    //load data
    getDataFrist(isReview: isReview);

    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    titleController.dispose();
    companyController.dispose();
    workController.dispose();
    addressController.dispose();
    descController.dispose();
    requiredController.dispose();
    benifitController.dispose();
    prioritizedController.dispose();
    endTimeController.dispose();
    nameController.dispose();
    phoneController.dispose();
    contactAddressController.dispose();
    emailController.dispose();
    amountController.dispose();
    hinhThucLamViecController.dispose();
    trinhDoHocVanController.dispose();
    chuyenNganhChinhController.dispose();
    soNamKinhNghiemController.dispose();
    mucLuongDuKienController.dispose();
    noiLamViecController.dispose();
    thoiGianLamViecController.dispose();
    thoiGianThucTapController.dispose();
    chuyenNganhPhuController.dispose();
    super.onClose();
  }

  ///
  ///getDataFrist
  ///
  void getDataFrist({required bool isReview}) {
    //set data show page
    //get data parameter
    request = Get.arguments;
    if (request != null) {
      //set value review
      titleController.text = request['TieuDe'].toString();
      companyController.text = request['CongTy'].toString();
      // workController.text = request['DiaDiemLamViec'].toString();
      addressController.text = request['DiaChiCongTy'].toString();
      chooseSex = int.parse(request['GioiTinh'].toString());
      amountController.text = request['SoLuong'].toString();
      hinhThucLamViecController.text = request['TenHinhThucLamViec'].toString();
      trinhDoHocVanController.text = request['TenTrinhDoHocVan'].toString();
      chuyenNganhChinhController.text = request['TenChuyenNganhChinh'].toString();
      soNamKinhNghiemController.text = request['TenSoNamKinhNghiem'].toString();
      mucLuongDuKienController.text = request['TenMucLuongDuKien'].toString();
      noiLamViecController.text = request['TenNoiLamViec'].toString();
      thoiGianLamViecController.text = request['TenThoiGianLamViec'].toString();
      descController.text = request['MoTaCongViec'].toString();
      requiredController.text = request['YeuCauCongViec'].toString();
      benifitController.text = request['QuyenLoi'].toString();
      prioritizedController.text = request['UuTien'].toString();
      hanNopHoSo = request['HanNopHoSo'].toString();
      nameController.text = request['HoTenLienHe'].toString();
      phoneController.text = request['SoDienThoaiLienHe'].toString();
      contactAddressController.text = request['DiaChiLienHe'].toString();
      emailController.text = request['EmailLienHe'].toString();
      thoiGianThucTapController.text = '${request['ThoiGianThuViec']} tháng';
      chuyenNganhPhuController.text = request['TenChuyenNganhPhu'].toString();
    }

    //set data param tuyển dụng
    if (isReview) {
      //set value tuyển dụng
      tuyenDungRequest.idTaiKhoan = request['IdTaiKhoan'].toString();
      tuyenDungRequest.tieuDe = request['TieuDe'].toString();
      tuyenDungRequest.congTy = request['CongTy'].toString();
      // tuyenDungRequest.điaiemLamViec = request['DiaDiemLamViec'].toString();
      tuyenDungRequest.diaChi = request['DiaChiCongTy'].toString() != 'null' ? request['DiaChiCongTy'].toString() : null;
      // tuyenDungRequest.idTinhTp = request['IdTinhTp'].toString();
      // tuyenDungRequest.idQuanHuyen = request['IdQuanHuyen'].toString();
      // tuyenDungRequest.idPhuongXa = request['IdPhuongXa'].toString();
      tuyenDungRequest.gioiTinh = request['GioiTinh'].toString();
      tuyenDungRequest.soLuong = request['SoLuong'].toString();
      tuyenDungRequest.idHinhThucLamViec = request['IdHinhThucLamViec'].toString();
      tuyenDungRequest.idTrinhDoHocVan = request['IdTrinhDoHocVan'].toString();
      tuyenDungRequest.idChuyenNganhChinh = request['IdChuyenNganhChinh'].toString();
      tuyenDungRequest.idSoNamKinhNghiem = request['IdSoNamKinhNghiem'].toString();
      tuyenDungRequest.idMucLuongDuKien = request['IdMucLuongDuKien'].toString();
      tuyenDungRequest.idNoiLamViecs = request['NoiLamViec'] as List<String>;
      // tuyenDungRequest.idThoiGianLamViec =
      //     request['IdThoiGianLamViec'].toString();
      tuyenDungRequest.moTaCongViec = request['MoTaCongViec'].toString();
      tuyenDungRequest.yeuCauCongViec = request['YeuCauCongViec'].toString();
      tuyenDungRequest.quyenLoi = request['QuyenLoi'].toString();
      tuyenDungRequest.uuTien = request['UuTien'].toString();
      tuyenDungRequest.hanNopHoSo = request['HanNopHoSo'].toString();
      tuyenDungRequest.hoTenLienHe = request['HoTenLienHe'].toString();
      tuyenDungRequest.soDienThoaiLienHe = request['SoDienThoaiLienHe'].toString();
      tuyenDungRequest.diaChiLienHe = request['DiaChiLienHe'].toString();
      tuyenDungRequest.emailLienHe = request['EmailLienHe'].toString();
      tuyenDungRequest.thoiGianThuViec = request['ThoiGianThuViec'].toString();
      tuyenDungRequest.idChuyenNganhPhus = request['IdChuyenNganhPhus'] as List;
      tuyenDungRequest.hinhAnhDaiDien = request['HinhAnhDaiDien'].toString();
    }

    //isLoading
    isLoading = false;
    update();
  }

  ///
  /// Nhấn xem danh sách ứng tuyển
  ///
  void onShowCaticate() {
    print("Id: ${request['id'].toString()}");
    Get.toNamed(AppRoutes.V1_SHOW_LIST_CANDICATE, arguments: request['id'].toString());
  }

  ///
  /// Nhấn tiếp tục
  ///
  void onClickPostButton() {
    print(tuyenDungRequest.toJson());
    Get.toNamed(AppRoutes.V1_G7_PRICE_LIST, arguments: tuyenDungRequest)!.then((value) => {
          if (value != null && value == true)
            {
              Get.back(result: true),
            }
        });
  }
}
