import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/loai_cong_trinh_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/loai_cong_trinh_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';

class V1VatLieuXayDungController extends GetxController {
  final NhomDichVuProvider nhomDichVuProvider =
      GetIt.I.get<NhomDichVuProvider>();
  final LoaiCongTrinhProvider loaiCongTrinhProvider =
      GetIt.I.get<LoaiCongTrinhProvider>();
  final ImageUpdateProvider imageUpdateProvider =
      GetIt.I.get<ImageUpdateProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  final VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();

  // EditTextController
  final addressController = TextEditingController();
  final titleController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final requireContent = TextEditingController();
  final massController = TextEditingController();
  final unitController = TextEditingController();
  final quyCachController = TextEditingController();

  // List
  List<LoaiCongTrinhResponse> LoaiCongTrinhResponseList = [];
  List<ChiTietVatTuResponse> supplies = [];
  List<String> quyCachs = [];
  // List<String> vatTus = [];
  List<String> donVi = [];

  List<String> fileDonDichVu = [];
  List<String> anhKhoiLuong = [];
  List<VatTuResponse> vatTuList = [];

  List<TinhTpResponse> hcmProvinces = [];
  List<QuanHuyenResponse> hcmDistricts = [];
  List<PhuongXaResponse> hcmWards = [];

  List<TinhTpResponse> hnProvinces = [];
  List<QuanHuyenResponse> hnDistricts = [];
  List<PhuongXaResponse> hnWards = [];

  List<TinhTpResponse> dnProvinces = [];
  List<QuanHuyenResponse> dnDistricts = [];
  List<PhuongXaResponse> dnWards = [];

  List<TinhTpResponse> otherProvinces = [];
  List<PhuongXaResponse> otherwards = [];
  List<QuanHuyenResponse> otherDistricts = [];

  //Response
  TinhTpResponse? hcmProvince;
  TinhTpResponse? otherProvince;
  TinhTpResponse? daNangProvince;
  TinhTpResponse? haNoiProvince;

  PhuongXaResponse? hcmPhuong;
  PhuongXaResponse? daNangPhuong;
  PhuongXaResponse? haNoiPhuong;
  PhuongXaResponse? khacPhuong;

  QuanHuyenResponse? hcmHuyen;
  QuanHuyenResponse? daNangHuyen;
  QuanHuyenResponse? haNoiHuyen;
  QuanHuyenResponse? khacHuyen;

  // Công trinh
  LoaiCongTrinhResponse? loaiCongTrinh;
  String idUser = '';

  VatTuResponse? vatTu;

  // Tiến độ Giao hàng
  int progress = 1;
  int groupTinhTpValue = 0;
  // Get param (idType) nếu là dịch vụ thường xuyên 2 và tạo đơn dich vụ là 1

  //Flag
  bool isLoading = true;
  bool isLoadingVatTu = true;
  bool isLoadingCongTrinh = true;
  bool isLoadingWard = true;
  bool isLoadingDistrict = true;

  @override
  void onInit() {
    super.onInit();
    getVatTu();
    getLoaiCongTrinh();
    getTinhThanh();
    getUserId();
  }

  Future<void> getUserId() async {
    await sl.get<SharedPreferenceHelper>().userId.then((value) {
      idUser = value!;
    });
  }

  ///
  /// Thay đổi công việc
  ///
  void onChangedLoaiCongTrinh(LoaiCongTrinhResponse loaiCongTrinh) {
    this.loaiCongTrinh = loaiCongTrinh;
    update();
  }

  ///
  /// Thay đổi vât tư
  ///
  void onChangedVatTu(VatTuResponse vatTu) {
    this.vatTu = vatTu;
    unitController.text = vatTu.donVi!;
    quyCachController.text = vatTu.quyCach!;
    update();
  }

  ///
  /// Thay đổi radio button
  ///
  void onChangedGroup(int val) {
    groupTinhTpValue = val;
    hcmWards.clear();
    otherwards.clear();
    dnWards.clear();
    hcmWards.clear(); 
    if (groupTinhTpValue == 3) {
      khacHuyen = null;
      khacPhuong = null;
      otherDistricts.clear();
      otherwards.clear();
    } else {
      otherProvince = null;
      khacHuyen = null;
      khacPhuong = null;
    }
    getTinhThanh();
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    if (groupTinhTpValue == 3) {
      otherProvince = tinhTp;
    } else if (groupTinhTpValue == 2) {
      daNangProvince = tinhTp;
    } else if (groupTinhTpValue == 1) {
      haNoiProvince = tinhTp;
    } else {
      hcmProvince = tinhTp;
    }
    getQuanHuyen(filter: '&idTinhTp=${tinhTp.id}');
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse huyen) {
    if (groupTinhTpValue == 3) {
      khacHuyen = huyen;
    } else if (groupTinhTpValue == 2) {
      daNangHuyen = huyen;
    } else if (groupTinhTpValue == 1) {
      haNoiHuyen = huyen;
    } else {
      hcmHuyen = huyen;
    }
    getPhuongXa(filter: '&idQuanHuyen=${huyen.id}');
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedPhuongXa(PhuongXaResponse phuong) {
    if (groupTinhTpValue == 3) {
      khacPhuong = phuong;
    } else if (groupTinhTpValue == 2) {
      daNangPhuong = phuong;
    } else if (groupTinhTpValue == 1) {
      haNoiPhuong = phuong;
    } else {
      hcmPhuong = phuong;
    }
    update();
  }

  ///
  /// Load danh sách công trinh
  ///
  void getLoaiCongTrinh() {
    loaiCongTrinhProvider.all(onSuccess: (data) {
      LoaiCongTrinhResponseList.clear();
      LoaiCongTrinhResponseList.addAll(data);
      isLoadingCongTrinh = false;
      update();
    }, onError: (error) {
      print("CreateWorkController getLoaiCongViec onError $error");
      update();
    });
  }

  ///
  /// Load tất cả tỉnh thành phố
  ///
  void getTinhThanh() {
    tinhTpProvider.all(onSuccess: (data) {
      hcmDistricts.clear();
      hnDistricts.clear();
      dnDistricts.clear();
      otherDistricts.clear();
      hcmWards.clear();
      dnWards.clear();
      hnWards.clear();
      otherwards.clear();
      hcmHuyen = null;
      daNangHuyen = null;
      haNoiHuyen = null;
      khacHuyen = null;
      if (groupTinhTpValue == 0) {
        hcmProvince = data.firstWhere((element) => element.id! == HO_CHI_MINH);
        getQuanHuyen(filter: '&idTinhTp=${hcmProvince!.id}');
      } else if (groupTinhTpValue == 1) {
        haNoiProvince = data.firstWhere((element) => element.id == HA_NOI);
        getQuanHuyen(filter: '&idTinhTp=${haNoiProvince!.id}');
      } else if (groupTinhTpValue == 2) {
        daNangProvince = data.firstWhere((element) => element.id == DA_NANG);
        getQuanHuyen(filter: '&idTinhTp=${daNangProvince!.id}');
      } else {
        otherProvinces.clear();
        otherProvince = null;
        otherProvinces.addAll(data.where((element) => element.id != DA_NANG && element.id != HA_NOI && element.id != HO_CHI_MINH));
        otherProvince = otherProvinces.first;
        getQuanHuyen(filter: '&idTinhTp=${otherProvince!.id}');
      }

      isLoading = false;
      update();
    }, onError: (error) {
      isLoading = false;
      update();
      SnackBar(
        content: Text(error.message.toString()),
      );
      print("CreateWorkController getTinhThanh onError $error");
    });
  }

  ///
  /// Load tất cả quận huyện
  ///
  void getQuanHuyen({String? filter = '', bool isFrirst = false}) {
    isLoadingDistrict = true;
    quanHuyenProvider.paginate(
        filter: filter!,
        limit: 100,
        page: 1,
        onSuccess: (data) {
          hcmWards.clear();
          dnWards.clear();
          hnWards.clear();
          otherwards.clear();
          haNoiPhuong = null;
          hcmPhuong = null;
          daNangPhuong = null;
          khacPhuong = null;
          if (groupTinhTpValue == 0) {
            hcmHuyen = null;
            hcmDistricts.clear();
            hcmDistricts.addAll(data);
            // hcmHuyen = hcmDistricts.first;
            update();
          } else if (groupTinhTpValue == 1) {
            haNoiHuyen = null;
            hnDistricts.clear();
            hnDistricts.addAll(data);
            // haNoiHuyen = hnDistricts.first;
          } else if (groupTinhTpValue == 2) {
            daNangHuyen = null;
            dnDistricts.clear();
            dnDistricts.addAll(data);
            // daNangHuyen = dnDistricts.first;
          } else {
            khacHuyen = null;
            otherDistricts.clear();
            otherDistricts.addAll(data);
            // khacHuyen = otherDistricts.first;
            update();
          }
          isLoadingDistrict = false;
          update();
        },
        onError: (error) {
          update();
          SnackBar(
            content: Text(error.message.toString()),
          );
          print("CreateWorkController getQuanHuyen onError $error");
        });
  }

  ///
  /// Load tất cả phường xa
  ///
  void getPhuongXa({String? filter = ''}) {
    isLoadingWard = true;
    phuongXaProvider.paginate(
        filter: filter!,
        limit: 100,
        page: 1,
        onSuccess: (data) {
          if (groupTinhTpValue == 0) {
            hcmPhuong = null;
            hcmWards.clear();
            hcmWards.addAll(data);
          } else if (groupTinhTpValue == 1) {
            haNoiPhuong = null;
            hnWards.clear();
            hnWards.addAll(data);
          } else if (groupTinhTpValue == 2) {
            daNangPhuong = null;
            dnWards.clear();
            dnWards.addAll(data);
          } else {
            khacPhuong = null;
            otherwards.clear();
            otherwards.addAll(data);
          }
          isLoadingWard = false;
          update();
        },
        onError: (error) {
          update();
          SnackBar(
            content: Text(error.message.toString()),
          );
          print("CreateWorkController getPhuongXa onError $error");
        });
  }

  ///
  /// Get all Vạt tu
  ///
  void getVatTu() {
    vatTuProvider.all(onSuccess: (data) {
      vatTuList.clear();
      vatTuList.addAll(data);
      quyCachs.addAll(vatTuList.map((e) => e.quyCach!).toList());
      // vatTus.addAll(vatTuList.map((e) => e.tenVatTu!).toList());
      donVi.addAll(vatTuList.map((e) => e.donVi!).toList());
      isLoadingVatTu = false;
      update();
    }, onError: (onError) {
      print("GetVatTu getVatTu onError $onError");
    });
  }

  ///
  /// Thêm khối lượng công việc
  ///
  void onClickAddMass() {
    if (vatTu == null) {
      return IZIAlert.error(message: "Tên vật tư không được để trống");
    } else if (quyCachController.text.isEmpty) {
      return IZIAlert.error(message: "Quy cách không được để trống");
    } else if (unitController.text.isEmpty) {
      return IZIAlert.error(message: 'Đơn vị không được để trống');
    } else if (massController.text.toString().isEmpty) {
      return IZIAlert.error(message: "Khối lượng không được để trống");
    } else {
      // Vât tư
      final VatTuResponse vatTuResponse = vatTu!;

      // Chi tiết vật tư
      final ChiTietVatTuResponse chiTietVatTuResponse = ChiTietVatTuResponse();
      chiTietVatTuResponse.idVatTu = vatTuResponse;
      chiTietVatTuResponse.soLuong = massController.text.toString();

      // Thêm vật tư vào danh sách
      supplies.add(chiTietVatTuResponse);

      // Sau khi thêm vật tư làm trống form
      massController.text = '';
      unitController.text = '';
      quyCachController.text = '';
      vatTu = null;

      IZIAlert.success(message: "Thêm vật tư thành công. Bạn có thêm vật tư khác");

      // Cập nhật lại ui
      update();
    }
  }

  ///
  /// Thay đổi tiến độ giao hàng
  ///
  void changeProgress(int val) {
    progress = val;
    update();
  }

  ///
  /// Nhấn vào nút tiếp tục
  ///
  Future<void> onClickContinue() async {
    if (titleController.text.isEmpty) {
      IZIAlert.error(message: "Vui lòng nhập tiêu đề báo giá");
      return;
    } else if (loaiCongTrinh == null) {
      IZIAlert.error(message: "Vui lòng chọn loại công trình");
      return;
    } else if (hcmProvince == null &&
        otherProvince == null &&
        haNoiProvince == null &&
        daNangProvince == null) {
      IZIAlert.error(message: "Vui lòng chọn tỉnh");
      return;
    } else if (hcmHuyen == null &&
        khacHuyen == null &&
        haNoiHuyen == null &&
        daNangHuyen == null) {
      IZIAlert.error(message: "Vui lòng chọn quận huyện");
      return;
    } 
    if(dnWards.isNotEmpty || hcmWards.isNotEmpty || hnWards.isNotEmpty || otherwards.isNotEmpty){
      if (hcmPhuong == null &&
          khacPhuong == null &&
          haNoiPhuong == null &&
          daNangPhuong == null) {
        IZIAlert.error(message: "Vui lòng phường xã");
        return;
      }  
    }
    if (addressController.text.toString().isEmpty) {
      IZIAlert.error(message: "Vui lòng điền địa chỉ cụ thể");
      return;
    } else if (startTimeController.text.toString().isEmpty) {
      IZIAlert.error(message: "Ngày nhận vật tư dự kiến không được để trống");
    } else if (DateConverter.differenceDate(
            startDate: startTimeController.text.toString(),
            endDate: DateConverter.estimatedDateOnly(DateTime.now())) >
        0) {
      IZIAlert.error(message: "Ngày bắt đầu không được nhỏ hơn ngày hiện tại");
    } else if (endTimeController.text.toString().isEmpty) {
      IZIAlert.error(
          message: "Ngày kết thúc nhận vật tư dự kiến không được để trống");
    } else if (DateConverter.differenceDate(
            startDate: startTimeController.text.toString(),
            endDate: endTimeController.text.toString()) <
        0) {
      IZIAlert.error(message: "Ngày kết thúc phải lớn hơn ngày bắt đầu");
    } else {
      Get.toNamed(AppRoutes.V1_PREVIEW_VAT_TU, arguments: request());
    }
  }

  PreviewServiceRequest request() {
    final PreviewServiceRequest serviceApplication = PreviewServiceRequest();
    if (groupTinhTpValue == 3) {
      serviceApplication.idTinhTp = otherProvince!.id;
      serviceApplication.idQuanHuyen = khacHuyen!.id;
      if(khacPhuong != null){
        serviceApplication.idPhuongXa = khacPhuong!.id;
      }
      // Địa điểm nhận
      serviceApplication.diaDiemNhan =
          "${khacPhuong != null ? "${khacPhuong!.ten} -" : ""} ${khacHuyen!.ten} - ${otherProvince!.ten}";
    } else if (groupTinhTpValue == 2) {
      serviceApplication.idTinhTp = daNangProvince!.id;
      serviceApplication.idQuanHuyen = daNangHuyen!.id;
      if(daNangPhuong != null){
        serviceApplication.idPhuongXa = daNangPhuong!.id;
      }
      //Địa điểm nhận hàng
      serviceApplication.diaDiemNhan =
          "${daNangPhuong != null ? '${daNangPhuong!.ten} -' : ''} ${daNangHuyen!.ten} - ${daNangProvince!.ten}";
    } else if (groupTinhTpValue == 1) {
      serviceApplication.idTinhTp = haNoiProvince!.id;
      serviceApplication.idQuanHuyen = haNoiHuyen!.id;
      if(haNoiPhuong != null){
        serviceApplication.idPhuongXa = haNoiPhuong!.id;
      }
      //Địa điểm nhận hàng
      serviceApplication.diaDiemNhan =
          "${haNoiPhuong != null ? '${haNoiPhuong!.ten} -' : ''} ${haNoiHuyen!.ten} - ${haNoiProvince!.ten}";
    } else {
      serviceApplication.idTinhTp = hcmProvince!.id;
      serviceApplication.idQuanHuyen = hcmHuyen!.id;
      if(hcmPhuong != null){
        serviceApplication.idPhuongXa = hcmPhuong!.id;
      }
      //Địa điểm nhận hàng
      serviceApplication.diaDiemNhan =
          "${hcmPhuong != null ? '${hcmPhuong!.ten} -' : ''} ${hcmHuyen!.ten} - ${hcmProvince!.ten}";
    }
    serviceApplication.idNhomDichVu = NHOM_DICH_VU_8;
    // serviceApplication.idTaiKhoanNhanDon = idUser;
    serviceApplication.idTaiKhoan =
        idUser; //await sl.get<SharedPreferenceHelper>().userId;
    serviceApplication.tieuDe =
        titleController.text.toString(); // Tiêu đề báo giá
    serviceApplication.idLoaiCongTrinh = loaiCongTrinh;
    serviceApplication.diaChiCuThe = addressController.text.toString();
    serviceApplication.ngayBatDau = startTimeController.text.toString();
    serviceApplication.ngayKetThuc = endTimeController.text.toString();
    serviceApplication.chiTietVatTus = supplies;
    serviceApplication.hinhAnhBanKhoiLuongs = anhKhoiLuong;
    serviceApplication.files = fileDonDichVu;
    serviceApplication.tienDoGiaoHang = progress;
    serviceApplication.moTa = requireContent.text.toString();

    return serviceApplication;
  }

  ///
  /// Xoá vật liệu
  ///
  void deleteSupplies(ChiTietVatTuResponse item) {
    supplies.removeWhere((element) => element.hashCode == item.hashCode);
    update();
  }

  ///
  /// Pick multi files
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result =
          await FilePicker.platform.pickFiles();
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
            fileDonDichVu.add(value.files!.first);
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
    addressController.dispose();
    titleController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    requireContent.dispose();
    massController.dispose();
    unitController.dispose();
    quyCachController.dispose();
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
