import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chuyen_nganh_chinh_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/muc_luong_du_kien_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/so_nam_kinh_nghiem_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/trinh_do_hoc_van_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V1G7RecruitmentController extends GetxController {
  //Providers
  final HinhThucLamViecProvider hinhThucLamViecProvider =
      GetIt.I.get<HinhThucLamViecProvider>();
  final TrinhDoHocVanProvider trinhDoHocVanProvider =
      GetIt.I.get<TrinhDoHocVanProvider>();
  final ChuyenNganhChinhProvider chuyenNganhChinhProvider =
      GetIt.I.get<ChuyenNganhChinhProvider>();
  final SoNamKinhNghiemProvider soNamKinhNghiemProvider =
      GetIt.I.get<SoNamKinhNghiemProvider>();
  final MucLuongDuKienProvider mucLuongDuKienProvider =
      GetIt.I.get<MucLuongDuKienProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final ThoiGianLamViecProvider thoiGianLamViecProvider =
      GetIt.I.get<ThoiGianLamViecProvider>();
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  final QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();

  final imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //model value
  List<HinhThucLamViecResponse> hinhThucLamViecModel = [];
  List<TrinhDoHocVanResponse> trinhDoHocVanModel = [];
  List<ChuyenNganhChinhResponse> chuyenNganhChinhModel = [];
  List<SoNamKinhNghiemResponse> soNamKinhNghiemModel = [];
  List<MucLuongDuKienResponse> mucLuongDuKienModel = [];
  List<ThoiGianLamViecResponse> thoiGianLamViecModel = [];
  List<TinhTpResponse> tinhTpModel = [];
  List<QuanHuyenResponse> quanHuyenModel = [];
  List<PhuongXaResponse> phuongXaModel = [];

  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  //model choose
  HinhThucLamViecResponse? hinhThucLamViec;
  TrinhDoHocVanResponse? trinhDoHocVan;
  ChuyenNganhChinhResponse? chuyenNgangChinh;
  SoNamKinhNghiemResponse? soNamKinhNghiem;
  MucLuongDuKienResponse? mucLuongDuKien;
  ThoiGianLamViecResponse? thoiGianLamViec;
  TinhTpResponse? tinhTp;
  TinhTpResponse? tinhTpDiaChi;
  QuanHuyenResponse? quanHuyenResponse;
  PhuongXaResponse? phuongXaResponse;

  //value giới tính
  int chooseSex = 0;

  //value tuyển dụng
  TuyenDungRequest tuyenDungRequest = TuyenDungRequest();

  //value tìm kiếm id tỉnh, quận , huyện
  String? idTinhFind;
  String? idHuyenFind;
  String? idXaFind;

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

  //thời gian thực tập
  final thoiGianThucTapController = TextEditingController();

  //focusNode
  FocusNode titleFocusNode = FocusNode();
  FocusNode companyFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode requiredFocusNode = FocusNode();
  FocusNode benifitFocusNode = FocusNode();
  FocusNode prioritizedFocusNode = FocusNode();
  FocusNode endTimeFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode contactFocusNodetroller = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  FocusNode thoiGianThucTapFocusNode = FocusNode();

  //chọn ngày nộp hồ sơ
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  // isloading
  bool isLoading = true;

  //value listChuyenNganhPhu
  List chuyenNganhPhus = [];
  List<ChuyenNganhChinhResponse> chuyenNganhPhuModel = [];

  //hình ảnh
  File? image;
  String? hinhAnhDaiDien;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        // find tai khoan by user id
        taiKhoanProvider.find(
          id: value!,
          onSuccess: (value) {
            // set user
            taiKhoanResponse = value;

            //set data công ty
            companyController.text = taiKhoanResponse.tenPhapLy.toString();

            //set địa chỉ
            addressController.text = taiKhoanResponse.diaChi.toString();

            //set thông tin người liên hệ
            nameController.text = taiKhoanResponse.hoTen.toString();
            phoneController.text = taiKhoanResponse.soDienThoai.toString();
            contactAddressController.text =
                '${taiKhoanResponse.diaChi}, ${taiKhoanResponse.idPhuongXa}, ${taiKhoanResponse.idQuanHuyen}, ${taiKhoanResponse.idTinhTp}';
            emailController.text = taiKhoanResponse.email.toString();

            //load data frist
            getDataHinhThucLamViec();
            getDataTrinhDoHocVan();
            getDataChuyenNangChinh();
            getDataSoNamKinhNghiem();
            getDataMucLuongDuKien();
            getDataTinhTp(isLoadFrist: true);
            getDataThoiGianLamViec();
          },
          onError: (error) {
            print('V1G7RecruitmentController onInit $error');
            update();
            SnackBar(
              content: Text(error.message.toString()),
            );
          },
        );
      },
    );
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
    thoiGianThucTapController.dispose();

    //focusNode
    titleFocusNode.dispose();
    companyFocusNode.dispose();
    addressFocusNode.dispose();
    descFocusNode.dispose();
    requiredFocusNode.dispose();
    benifitFocusNode.dispose();
    prioritizedFocusNode.dispose();
    endTimeFocusNode.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    contactFocusNodetroller.dispose();
    emailFocusNode.dispose();
    amountFocusNode.dispose();
    thoiGianThucTapFocusNode.dispose();
    super.onClose();
  }

  ///
  /// load data hình thức làm việc
  ///
  void getDataHinhThucLamViec() {
    //list hinh thuc lam iec
    hinhThucLamViecProvider.all(
        onSuccess: (value) {
          //add list
          hinhThucLamViecModel = value;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataHinhThucLamViec $error'));
  }

  ///
  /// load data trình độ học vấn
  ///
  void getDataTrinhDoHocVan() {
    //list hinh thuc lam iec
    trinhDoHocVanProvider.all(
        onSuccess: (value) {
          //add list
          trinhDoHocVanModel = value;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataTrinhDoHocVan $error'));
  }

  ///
  /// load data chuyên ngành chính
  ///
  void getDataChuyenNangChinh() {
    //list hinh thuc lam iec
    chuyenNganhChinhProvider.all(
        onSuccess: (value) {
          //add list
          chuyenNganhChinhModel = value;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataChuyenNangChinh $error'));
  }

  ///
  /// load data số năm kinh nghiệm
  ///
  void getDataSoNamKinhNghiem() {
    //list hinh thuc lam iec
    soNamKinhNghiemProvider.all(
        onSuccess: (value) {
          //add list
          soNamKinhNghiemModel = value;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataSoNamKinhNghiem $error'));
  }

  ///
  /// load data mức lương dự kiến
  ///
  void getDataMucLuongDuKien() {
    //list hinh thuc lam iec
    mucLuongDuKienProvider.all(
        onSuccess: (value) {
          //add list
          mucLuongDuKienModel = value;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataMucLuongDuKien $error'));
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    tinhTpDiaChi = tinhTp;
    getDataQuanHuyen(idTinh: tinhTp.id.toString(), isLoadFrist: false);
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    quanHuyenResponse = quanHuyen;
    getDataPhuongXa(idHuyen: quanHuyen.id.toString(), isLoadFrist: false);
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    phuongXaResponse = phuongXa;
    update();
  }

  ///
  /// load data tỉnh Tp
  ///
  void getDataTinhTp({required bool isLoadFrist}) {
    //list hinh thuc lam iec
    tinhTpProvider.all(
        onSuccess: (value) {
          //add list
          tinhTpModel = value;
          // isLoading = false;

          if (isLoadFrist) {
            //set idTinh
            tinhTpDiaChi = value.firstWhere((element) =>
                element.ten!.contains(taiKhoanResponse.idTinhTp.toString()));

            getDataQuanHuyen(
                idTinh: tinhTpDiaChi!.id.toString(), isLoadFrist: true);
          }

          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataTinhTp $error'));
  }

  ///
  /// load data quận huyện
  ///
  void getDataQuanHuyen({required String idTinh, required bool isLoadFrist}) {
    quanHuyenProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idTinhTp=$idTinh',
        onSuccess: (value) {
          quanHuyenResponse = null;
          phuongXaResponse = null;
          quanHuyenModel.clear();
          phuongXaModel.clear();
          if (value.isNotEmpty) {
            quanHuyenModel.addAll(value);
            quanHuyenResponse = quanHuyenModel.first;

            //mapping quận huyện lần đầu
            if (isLoadFrist) {
              quanHuyenResponse = quanHuyenModel.firstWhere((element) => element
                  .ten!
                  .contains(taiKhoanResponse.idQuanHuyen.toString()));
              // xã khi chon huỵen
              getDataPhuongXa(
                  idHuyen: quanHuyenResponse!.id.toString(), isLoadFrist: true);
            }
            // xã khi chon huỵen
            getDataPhuongXa(
                idHuyen: quanHuyenResponse!.id.toString(), isLoadFrist: false);
          }

          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataQuanHuyen $error'));
  }

  ///
  /// load data phường xã
  ///
  void getDataPhuongXa({required String idHuyen, required bool isLoadFrist}) {
    phuongXaProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idQuanHuyen=$idHuyen',
        onSuccess: (value) {
          phuongXaResponse = null;
          phuongXaModel.clear();
          if (value.isNotEmpty) {
            phuongXaModel.addAll(value);
            phuongXaResponse = phuongXaModel.first;

            //mapping xã phường lần đầu
            if (isLoadFrist) {
              phuongXaResponse = phuongXaModel.firstWhere((element) => element
                  .ten!
                  .contains(taiKhoanResponse.idPhuongXa.toString()));
            }
          }

          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataPhuongXa $error'));
  }

  ///
  /// load data thời gian làm việc
  ///
  void getDataThoiGianLamViec() {
    //list hinh thuc lam iec
    thoiGianLamViecProvider.all(
        onSuccess: (value) {
          //add list
          thoiGianLamViecModel = value;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataThoiGianLamViec $error'));
  }

  ///
  ///Chọn giới tính
  ///
  void getChangeSex(int val) {
    chooseSex = val;
    update();
  }

  ///
  ///chọn hình thức làm việc
  ///
  void onChangeHinhThucLamViec(HinhThucLamViecResponse item) {
    hinhThucLamViec = item;
    update();
  }

  ///
  ///chọn hình thức làm việc
  ///
  void onChangeTrinhDoHocVan(TrinhDoHocVanResponse item) {
    trinhDoHocVan = item;
    update();
  }

  ///
  ///chọn chuyên ngành chính
  ///
  void onChangeChuyenNganhChinh(ChuyenNganhChinhResponse item) {
    chuyenNganhPhuModel = [];
    chuyenNgangChinh = item;
    chuyenNganhPhuModel = chuyenNganhChinhModel
        .where((element) => element.id != item.id)
        .toList();
    update();
  }

  ///
  ///chọn số năm kinh nghiệm
  ///
  void onChangeSoNamKinhNghiem(SoNamKinhNghiemResponse item) {
    soNamKinhNghiem = item;
    update();
  }

  ///
  ///chọn mức lương dự kiến
  ///
  void onChangeMucLuongDuKien(MucLuongDuKienResponse item) {
    mucLuongDuKien = item;
    update();
  }

  ///
  ///chọn tỉnh tp làm việc
  ///
  void onChangeTinhTp(TinhTpResponse item) {
    tinhTp = item;
    update();
  }

  ///
  ///chọn tỉnh tp làm việc
  ///
  void onChangeThoiGianLamViec(ThoiGianLamViecResponse item) {
    thoiGianLamViec = item;
    update();
  }

  /// Chọn hạn nộp hồ sơ
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: 'Chọn hạn nộp hồ sơ',
        cancelText: 'Hủy',
        confirmText: "Chọn",
        fieldLabelText: 'Chọn ngày',
        fieldHintText: 'Month/Date/Year',
        errorFormatText: 'Vui lòng chọn ngày đúng.',
        errorInvalidText: 'Vui lòng chọn ngày đúng.',
        context: context,
        locale: const Locale("vi", "VI"),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }

  ///
  ///So sánh ngày
  ///
  int daysBetween(DateTime from, DateTime to) {
    // ignore: parameter_assignments
    from = DateTime(from.year, from.month, from.day);
    // ignore: parameter_assignments
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  ///
  ///xóa chip chuyên ngành phụ
  ///
  void removerChuyenNganhPhu(dynamic value) {
    chuyenNganhPhus.remove(value);
    update();
  }

  ///
  ///pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// Nhấn tiếp tục
  ///
  void onClickContinueButton() {
    final List chuyenNganhPhuSend = [];
    String tenChuyenNganhPhu = '';

    if (chuyenNganhPhus.isNotEmpty) {
      for (int i = 0; i < chuyenNganhPhus.length; i++) {
        chuyenNganhPhuSend.add(chuyenNganhPhus[i].id);
        if (i == 0) {
          tenChuyenNganhPhu = chuyenNganhPhus[i].tieuDe.toString();
        } else {
          tenChuyenNganhPhu += ', ${chuyenNganhPhus[i].tieuDe}';
        }
      }
    }

    //check validate
    if (titleController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập tiêu đề");
    } else if (companyController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập tên công ty");
    } else if (tinhTpDiaChi == null) {
      return Alert.error(message: "Vui lòng chọn tỉnh/tp");
    } else if (quanHuyenResponse == null) {
      return Alert.error(message: "Vui lòng chọn quận/huyện");
    } else if (phuongXaResponse == null) {
      return Alert.error(message: "Vui lòng chọn phường/xã");
    } else if (addressController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập địa chỉ");
    } else if (chooseSex == 0) {
      return Alert.error(message: "Vui lòng chọn giới tính");
    } else if (amountController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập số lượng");
    } else if (hinhThucLamViec == null) {
      return Alert.error(message: "Vui lòng chọn hình thức làm việc");
    } else if (trinhDoHocVan == null) {
      return Alert.error(message: "Vui lòng chọn trình độ học vấn");
    } else if (chuyenNgangChinh == null) {
      return Alert.error(message: "Vui lòng chọn chuyên ngành chính");
    } else if (chuyenNganhPhuSend.isEmpty) {
      return Alert.error(message: "Vui lòng chọn chuyên ngành phụ");
    } else if (soNamKinhNghiem == null) {
      return Alert.error(message: "Vui lòng chọn số năm kinh nghiệm");
    } else if (mucLuongDuKien == null) {
      return Alert.error(message: "Vui lòng chọn mức lương dự kiến");
    } else if (tinhTp == null) {
      return Alert.error(message: "Vui lòng chọn nơi làm việc");
    } else if (thoiGianLamViec == null) {
      return Alert.error(message: "Vui lòng chọn thời gian làm việc");
    } else if (descController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập mô tả công việc");
    } else if (requiredController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập yêu cầu công việc");
    } else if (benifitController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập chế đô quyền lợi công việc");
    } else if (prioritizedController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập ưu tiên");
    } else if (daysBetween(DateTime.now(), selectedDate) < 0) {
      return Alert.error(message: "Vui lòng chọn hạn nộp");
    } else if (thoiGianThucTapController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập thời gian thực tập");
    } else if (nameController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập tên người liên hệ");
    } else if (phoneController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập số điện thoại");
    } else if (contactAddressController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập địa chỉ");
    } else if (emailController.text.isEmpty) {
      return Alert.error(message: "Vui lòng nhập email");
    } else if (image == null) {
      return Alert.error(message: "Vui lòng chọn ảnh đại diện");
    } else {
      //upload ảnh
      imageUpdateProvider.add(
          file: image!,
          onSuccess: (value) {
            hinhAnhDaiDien = value.data;

            ///gán data tuyển dụng
            Map<String, dynamic> param = {
              "IdTaiKhoan": taiKhoanResponse.id,
              "TieuDe": titleController.text.trim(),
              "CongTy": companyController.text,
              'TenDiaChiCongTy':
                  '${addressController.text}, ${phuongXaResponse!.ten}, ${quanHuyenResponse!.ten}, ${tinhTpDiaChi!.ten}',
              "DiaChi": addressController.text,
              "IdTinhTp": tinhTpDiaChi!.id,
              "IdQuanHuyen": quanHuyenResponse!.id,
              "IdPhuongXa": phuongXaResponse!.id,
              "GioiTinh": chooseSex,
              "SoLuong": amountController.text,
              "IdHinhThucLamViec": hinhThucLamViec!.id,
              "TenHinhThucLamViec": hinhThucLamViec!.tieuDe,
              "IdTrinhDoHocVan": trinhDoHocVan!.id,
              "TenTrinhDoHocVan": trinhDoHocVan!.tieuDe,
              "IdChuyenNganhChinh": chuyenNgangChinh!.id,
              "TenChuyenNganhChinh": chuyenNgangChinh!.tieuDe,
              "IdChuyenNganhPhus": chuyenNganhPhuSend,
              "TenChuyenNganhPhu": tenChuyenNganhPhu,
              "IdSoNamKinhNghiem": soNamKinhNghiem!.id,
              "TenSoNamKinhNghiem": soNamKinhNghiem!.tieuDe,
              "IdMucLuongDuKien": mucLuongDuKien!.id,
              "TenMucLuongDuKien": mucLuongDuKien!.tieuDe,
              "NoiLamViec": tinhTp!.id,
              "TenNoiLamViec": tinhTp!.ten,
              "IdThoiGianLamViec": thoiGianLamViec!.id,
              "TenThoiGianLamViec": thoiGianLamViec!.tieuDe,
              "ThoiGianThuViec": thoiGianThucTapController.text,
              "MoTaCongViec": descController.text.trim(),
              "YeuCauCongViec": requiredController.text.trim(),
              "QuyenLoi": benifitController.text.trim(),
              "UuTien": prioritizedController.text.trim(),
              "HanNopHoSo": dateFormat.format(selectedDate).toString(),
              "HoTenLienHe": nameController.text.trim(),
              "SoDienThoaiLienHe": phoneController.text.trim(),
              "DiaChiLienHe": contactAddressController.text.trim(),
              "EmailLienHe": emailController.text.trim(),
              "HinhAnhDaiDien": hinhAnhDaiDien
            };

            Get.toNamed('${AppRoutes.V1_G7_REVIEW}?isReview=true',
                arguments: param);
          },
          onError: (error) {
            print('V1G7RecruitmentController onClickContinueButton $error');
            Alert.error(message: "Vui lòng thực hiện lại");
          });
    }
  }
}
