import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_luu_tin_tuyen_dung_request.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/data/repository/danh_sach_luu_tin_tuyen_dung_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_luu_tin_tuyen_dung_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V2ViewRecruitmentNewsController extends GetxController {
  //Provider
  final DanhSachLuuTinTuyenDungProvider danhSachLuuTinTuyenDungProvider =
      GetIt.I.get<DanhSachLuuTinTuyenDungProvider>();
  //Repository
  DanhSachLuuTinTuyenDungRepository danhSachLuuTinTuyenDungRepository =
      DanhSachLuuTinTuyenDungRepository();

  //Request
  DanhSachLuuTinTuyenDungRequest danhSachLuuTinTuyenDungRequest =
      DanhSachLuuTinTuyenDungRequest();

  // Tiêu đề
  final titleController = TextEditingController();
  // Công ty
  final companyController = TextEditingController();
  // địa chỉ
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

  //userId
  String? userId;

  //idTuyenDung
  String? idTuyenDung;

  @override
  void onInit() {
    super.onInit();
    //set data
    request = Get.arguments;
    //load data
    getDataFrist(request: request);
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
    });

    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    titleController.dispose();
    companyController.dispose();
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
  void getDataFrist({required dynamic request}) {
    //get data parameter

    if (request != null) {
      //set value review
      titleController.text = request['TieuDe'].toString();
      companyController.text = request['CongTy'].toString();
      addressController.text = request['TenDiaChiCongTy'].toString();
      chooseSex = int.parse(request['GioiTinh'].toString());
      amountController.text = request['SoLuong'].toString();
      hinhThucLamViecController.text = request['TenHinhThucLamViec'].toString();
      trinhDoHocVanController.text = request['TenTrinhDoHocVan'].toString();
      chuyenNganhChinhController.text =
          request['TenChuyenNganhChinh'].toString();
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
      idTuyenDung = request['idTuyenDung'].toString();
    }

    //isLoading
    isLoading = false;
    update();
  }

  ///
  ///onBtnLuuTinTuyenDung
  ///
  void onBtnLuuTinTuyenDung() {
    EasyLoading.show(status: 'loading...');
    danhSachLuuTinTuyenDungProvider.paginate(
        page: 1,
        limit: 5,
        filter: '&idTaiKhoan=$userId&idTuyenDung=$idTuyenDung',
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.isNotEmpty) {
            Alert.info(message: 'Bạn đã lưu tin tuyển dụng này');
          } else {
            //set value request lưu tuyển dụng
            danhSachLuuTinTuyenDungRequest.idTaiKhoan = userId;
            danhSachLuuTinTuyenDungRequest.idTuyenDung = idTuyenDung;

            //insert db
            danhSachLuuTinTuyenDungRepository
                .add(danhSachLuuTinTuyenDungRequest)
                .then((value) => {
                      if (value.response.data != null)
                        {Alert.success(message: 'Lưu tin thành công')}
                      else
                        {Alert.error(message: 'Vui lòng thử lại')}
                    });
          }
        },
        onError: (error) => print(
            'V2ViewRecruitmentNewsController onBtnLuuTinTuyenDung $error'));
  }

  ///
  /// Nhấn tiếp tục
  ///
  void onClickPostButton() {
    Get.toNamed(AppRoutes.V1_G7_PRICE_LIST, arguments: tuyenDungRequest)!
        .then((value) => {
              if (value != null && value == true)
                {
                  Get.back(result: true),
                }
            });
  }

  ///
  /// Nhán vào nút ứng tuyển
  ///
  void onClickRecuitmentButton() {
    Get.toNamed(AppRoutes.V2_FORM_OF_SUBMITSSION);
  }
}
