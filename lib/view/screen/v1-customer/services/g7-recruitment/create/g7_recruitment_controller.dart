import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
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
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/muc_luong_du_kien_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/so_nam_kinh_nghiem_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/trinh_do_hoc_van_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/helper/izi_validate.dart';

class V1G7RecruitmentController extends GetxController {
  //Providers
  final hinhThucLamViecProvider = GetIt.I.get<HinhThucLamViecProvider>();
  final trinhDoHocVanProvider = GetIt.I.get<TrinhDoHocVanProvider>();
  final chuyenNganhChinhProvider = GetIt.I.get<ChuyenNganhChinhProvider>();
  final soNamKinhNghiemProvider = GetIt.I.get<SoNamKinhNghiemProvider>();
  final mucLuongDuKienProvider = GetIt.I.get<MucLuongDuKienProvider>();
  final tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final thoiGianLamViecProvider = GetIt.I.get<ThoiGianLamViecProvider>();
  final taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  final quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final phuongXaProvider = GetIt.I.get<PhuongXaProvider>();

  final imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  final LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();

  //model value
  List<HinhThucLamViecResponse> hinhThucLamViecModel = [];
  List<TrinhDoHocVanResponse> trinhDoHocVanModel = [];
  // List<ChuyenNganhChinhResponse> chuyenNganhChinhModel = [];
  List<LoaiCongViecResponse> chuyenNganhChinhModel = [];
  List<SoNamKinhNghiemResponse> soNamKinhNghiemModel = [];
  List<MucLuongDuKienResponse> mucLuongDuKienModel = [];
  List<ThoiGianLamViecResponse> thoiGianLamViecModel = [];
  List<TinhTpResponse> tinhTpModel = [];
  List<QuanHuyenResponse> quanHuyenModel = [];
  List<PhuongXaResponse> phuongXaModel = [];

  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  List<MultiSelectItem<TinhTpResponse?>> noiLamViecList = [];
  List<TinhTpResponse?> noiLamViecs = [];

  //model choose
  HinhThucLamViecResponse? hinhThucLamViec;
  TrinhDoHocVanResponse? trinhDoHocVan;
  // ChuyenNganhChinhResponse? chuyenNgangChinh;
  LoaiCongViecResponse? chuyenNgangChinh;
  SoNamKinhNghiemResponse? soNamKinhNghiem;
  MucLuongDuKienResponse? mucLuongDuKien;
  ThoiGianLamViecResponse? thoiGianLamViec;
  TinhTpResponse? tinhTp;
  TinhTpResponse? tinhTpDiaChi;
  QuanHuyenResponse? quanHuyenResponse;
  PhuongXaResponse? phuongXaResponse;

  //value giới tính
  int chooseSex = 1;

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
  // Địa điểm công ty
  // final workController = TextEditingController();
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

  //Thời gian thử việc
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
  // FocusNode workFocusNode = FocusNode();

  //chọn ngày nộp hồ sơ
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  // isloading
  bool isLoading = true;

  //value listChuyenNganhPhu
  List chuyenNganhPhus = [];
  List<LoaiCongViecResponse> chuyenNganhPhuModel = [];

  // Nới làm việc
  // List noiLamViecs = [];

  //hình ảnh
  String? hinhAnhDaiDien;

  // Check từ tạo đơn sang hay từ tin tuyển dụng sang
  bool isEdit = true;
  DonDichVuRequest? idTinhTp;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (Get.arguments != null) {
      isEdit = Get.arguments['status'] as bool;
      idTinhTp = Get.arguments['id'] as DonDichVuRequest;
    }

    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        // find tai khoan by user id
        taiKhoanProvider.find(
          id: value!,
          onSuccess: (value) {
            // set user
            taiKhoanResponse = value;

            //set data công ty
            // companyController.text = Validate.nullOrEmpty(taiKhoanResponse.tenPhapLy) ? '' : taiKhoanResponse.tenPhapLy.toString();

            // if (isEdit == false) {
            //   addressController.text = idTinhTp!.diaChiCuThe!;
            // } else {
            //   //set địa chỉ
            //   addressController.text = taiKhoanResponse.diaChi.toString();
            // }

            //set thông tin người liên hệ
            nameController.text = taiKhoanResponse.hoTen.toString();
            phoneController.text = taiKhoanResponse.soDienThoai.toString();
            contactAddressController.text = '${taiKhoanResponse.diaChi}, ${taiKhoanResponse.idPhuongXa}, ${taiKhoanResponse.idQuanHuyen}, ${taiKhoanResponse.idTinhTp}';
            emailController.text = taiKhoanResponse.email.toString();

            //load data frist
            getDataHinhThucLamViec();
            getDataTrinhDoHocVan();
            getDataChuyenNganhChinh();
            getDataChuyenNganhPhu();
            getDataSoNamKinhNghiem();
            getDataMucLuongDuKien();
            getDataTinhTp(isLoadFrist: true);
            // getDataThoiGianLamViec();
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
    // workController.dispose();

    //focusNode
    titleFocusNode.dispose();
    companyFocusNode.dispose();
    // workFocusNode.dispose();
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
        onError: (error) => print('V1G7RecruitmentController getDataHinhThucLamViec $error'));
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
        onError: (error) => print('V1G7RecruitmentController getDataTrinhDoHocVan $error'));
  }

  ///
  /// load data chuyên ngành chính
  ///
  void getDataChuyenNganhChinh() {
    //list hinh thuc lam iec
    loaiCongViecProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idNhomDichVu=$NHOM_DICH_VU_7',
        onSuccess: (value) {
          //add list
          chuyenNganhChinhModel = value;
          // isLoading = false;
          update();
        },
        onError: (error) => print('V1G7RecruitmentController getDataChuyenNganhChinh $error'));
  }

  ///
  /// Load data chuyên ngành phu
  ///
  void getDataChuyenNganhPhu() {
    loaiCongViecProvider.all(
        onSuccess: (data) {
          chuyenNganhPhuModel = data;
          update();
        },
        onError: (onError) {});
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
        onError: (error) => print('V1G7RecruitmentController getDataSoNamKinhNghiem $error'));
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
        onError: (error) => print('V1G7RecruitmentController getDataMucLuongDuKien $error'));
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
            if (idTinhTp != null) {
              tinhTpDiaChi = value.firstWhere((element) => element.id!.contains(idTinhTp!.idTinhTp.toString()));
            } else {
              tinhTpDiaChi = value.firstWhere((element) => element.ten!.contains(taiKhoanResponse.idTinhTp.toString()));
            }

            getDataQuanHuyen(idTinh: tinhTpDiaChi!.id.toString(), isLoadFrist: true);
          }

          // Thông số kỹ thuật
          noiLamViecList.clear();
          if (value.isNotEmpty) {
            noiLamViecList = value.map((e) => MultiSelectItem(e, e.ten!)).toList();
          }
          // End

          update();
        },
        onError: (error) => print('V1G7RecruitmentController getDataTinhTp $error'));
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
              if (idTinhTp != null) {
                quanHuyenResponse = quanHuyenModel.firstWhere((element) => element.id!.contains(idTinhTp!.idQuanHuyen!.toString()));
              } else {
                quanHuyenResponse = quanHuyenModel.firstWhere((element) => element.ten!.contains(taiKhoanResponse.idQuanHuyen.toString()));
              }
              // xã khi chon huỵen
              getDataPhuongXa(idHuyen: quanHuyenResponse!.id.toString(), isLoadFrist: true);
            }
            // xã khi chon huỵen
            getDataPhuongXa(idHuyen: quanHuyenResponse!.id.toString(), isLoadFrist: false);
          }

          update();
        },
        onError: (error) => print('V1G7RecruitmentController getDataQuanHuyen $error'));
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
              if (idTinhTp != null) {
                phuongXaResponse = phuongXaModel.firstWhere((element) => element.id!.contains(idTinhTp!.idPhuongXa!.toString()));
              } else {
                phuongXaResponse = phuongXaModel.firstWhere((element) => element.ten!.contains(taiKhoanResponse.idPhuongXa.toString()));
              }
            }
          }
          isLoading = false;
          update();
        },
        onError: (error) => print('V1G7RecruitmentController getDataPhuongXa $error'));
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
        onError: (error) => print('V1G7RecruitmentController getDataThoiGianLamViec $error'));
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
  void onChangeChuyenNganhChinh(LoaiCongViecResponse item) {
    chuyenNganhPhuModel.where((element) => item.id != element.id);
    chuyenNgangChinh = item;
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
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
  ///xóa chip nơi làm việc
  ///
  void removerNoiLamViec(dynamic value) {
    noiLamViecs.remove(value);
    update();
  }

  ///
  /// Pick HinhDaiDien
  ///
  Future pickHinhDaiDien() async {
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
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            hinhAnhDaiDien = value.files![0];
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
  /// Nhấn tiếp tục
  ///
  void onClickContinueButton() {
    final List chuyenNganhPhuSend = [];
    String tenChuyenNganhPhu = '';
    String tenNoiLamViec = '';
    List<String> idNoiLamViecs = [];
    if (chuyenNganhPhus.isNotEmpty) {
      for (int i = 0; i < chuyenNganhPhus.length; i++) {
        chuyenNganhPhuSend.add(chuyenNganhPhus[i].id);
        if (i == 0) {
          tenChuyenNganhPhu = chuyenNganhPhus[i].tenCongViec.toString();
        } else {
          tenChuyenNganhPhu += ', ${chuyenNganhPhus[i].tenCongViec.toString()}';
        }
      }
    }

    if (noiLamViecs.isNotEmpty) {
      idNoiLamViecs = noiLamViecs.map((e) => e!.id!).toList();

      if (noiLamViecs.isNotEmpty) {
        for (int i = 0; i < noiLamViecs.length; i++) {
          if (i == 0) {
            tenNoiLamViec = noiLamViecs[i]!.ten.toString();
          } else {
            tenNoiLamViec += ', ${noiLamViecs[i]!.ten}';
          }
        }
      }
    }

    //check validate
    if (titleController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập tiêu đề");
    } else if (companyController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập tên công ty");
      // } else if (workController.text.isEmpty) {
      //   return IZIAlert.error(message: "Vui lòng nhập địa chỉ công ty");
      // } else if (tinhTpDiaChi == null) {
      //   return IZIAlert.error(message: "Vui lòng chọn tỉnh/tp");
      // } else if (quanHuyenResponse == null) {
      //   return IZIAlert.error(message: "Vui lòng chọn quận/huyện");
      // } else if (phuongXaResponse == null) {
      //   return IZIAlert.error(message: "Vui lòng chọn phường/xã");
      // } else if (addressController.text.isEmpty) {
      //   return IZIAlert.error(message: "Vui lòng nhập địa chỉ công ty");
    } else if (chooseSex == 0) {
      return IZIAlert.error(message: "Vui lòng chọn giới tính");
    } else if (amountController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập số lượng ứng tuyển");
    } else if (hinhThucLamViec == null) {
      return IZIAlert.error(message: "Vui lòng chọn hình thức làm việc");
    } else if (trinhDoHocVan == null) {
      return IZIAlert.error(message: "Vui lòng chọn trình độ học vấn");
    } else if (chuyenNgangChinh == null) {
      return IZIAlert.error(message: "Vui lòng chọn chuyên ngành chính");
    } else if (soNamKinhNghiem == null) {
      return IZIAlert.error(message: "Vui lòng chọn số năm kinh nghiệm");
    } else if (mucLuongDuKien == null) {
      return IZIAlert.error(message: "Vui lòng chọn mức lương dự kiến");
    } else if (noiLamViecs.isEmpty) {
      return IZIAlert.error(message: "Vui lòng chọn nơi làm việc");
    } else if (thoiGianThucTapController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập thời gian thử việc");
    } else if (descController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập mô tả công việc");
    } else if (requiredController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập yêu cầu công việc");
    } else if (benifitController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập chế đô quyền lợi công việc");
      // } else if (prioritizedController.text.isEmpty) {
      //   return IZIAlert.error(message: "Vui lòng nhập ưu tiên");
    } else if (daysBetween(DateTime.now(), selectedDate) < 0) {
      return IZIAlert.error(message: "Vui lòng chọn hạn nộp");
    } else if (nameController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập tên người liên hệ");
    } else if (phoneController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập số điện thoại");
    } else if (contactAddressController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập địa chỉ");
    } else if (emailController.text.isEmpty) {
      return IZIAlert.error(message: "Vui lòng nhập email");
    } else {
      ///gán data tuyển dụng
      final Map<String, dynamic> param = {
        "IdTaiKhoan": taiKhoanResponse.id,
        "TieuDe": titleController.text.trim(),
        "CongTy": companyController.text,
        // 'TenDiaChiCongTy': '${addressController.text}, ${phuongXaResponse!.ten}, ${quanHuyenResponse!.ten}, ${tinhTpDiaChi!.ten}',
        // 'DiaChiCongTy': workController.text,
        "DiaChiCongTy": addressController.text,
        // "IdTinhTp": tinhTpDiaChi!.id,
        // "IdQuanHuyen": quanHuyenResponse!.id,
        // "IdPhuongXa": phuongXaResponse!.id,
        "GioiTinh": chooseSex,
        "SoLuong": amountController.text,
        "IdHinhThucLamViec": hinhThucLamViec!.id,
        "TenHinhThucLamViec": hinhThucLamViec!.tieuDe,
        "IdTrinhDoHocVan": trinhDoHocVan!.id,
        "TenTrinhDoHocVan": trinhDoHocVan!.tieuDe,
        // Loại công việc thành id chuyên ngành chính
        "IdChuyenNganhChinh": chuyenNgangChinh!.id,
        "TenChuyenNganhChinh": chuyenNgangChinh!.tenCongViec,
        "IdChuyenNganhPhus": chuyenNganhPhuSend,
        "TenChuyenNganhPhu": tenChuyenNganhPhu,
        "IdSoNamKinhNghiem": soNamKinhNghiem!.id,
        "TenSoNamKinhNghiem": soNamKinhNghiem!.tieuDe,
        "IdMucLuongDuKien": mucLuongDuKien!.id,
        "TenMucLuongDuKien": mucLuongDuKien!.tieuDe,
        "NoiLamViec": idNoiLamViecs, //tinhTp!.id,
        "TenNoiLamViec": tenNoiLamViec,
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
        "HinhAnhDaiDien": hinhAnhDaiDien ?? ANH_NHOM_7
      };

      print("Param: $param");

      Get.toNamed('${AppRoutes.V1_G7_REVIEW}?isReview=true', arguments: param)!.then((value) => {
            if (value != null && value == true) {Get.back(result: true)}
          });
    }
  }
}
