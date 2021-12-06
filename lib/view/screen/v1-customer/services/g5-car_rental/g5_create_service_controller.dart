import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_vi_response.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/data/model/response/thong_so_ky_thuat_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/don_vi_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/provider/thong_so_ky_thuat_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';

class V1G5CreateServiceController extends GetxController {
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final ThoiGianLamViecProvider thoiGianLamViecProvider =
      GetIt.I.get<ThoiGianLamViecProvider>();
  final ThongSoKyThuatProvider thongSoKyThuatProvider =
      GetIt.I.get<ThongSoKyThuatProvider>();
  final VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  final DonViProvider donViProvider = GetIt.I.get<DonViProvider>();


  final workTitleController = TextEditingController();
  final amountController = TextEditingController();
  final startWorkController = TextEditingController();
  final estimatedPickUpLocation = TextEditingController();
  final estimatedDeliveryLocation = TextEditingController();
  final distanceController = TextEditingController();
  final workDescController = TextEditingController();
  final returnWidthController = TextEditingController();
  final receivingWidthController = TextEditingController();

  // Chọn thời gian làm việc
  bool tommorow = false;
  bool afternoon = false;
  bool tonight = false;
  ThoiGianLamViecResponse? tommowReponse;
  ThoiGianLamViecResponse? afternoonReponse;
  ThoiGianLamViecResponse? tonightReponse;
  List<ThoiGianLamViecResponse> thoiGianLamViecList = [];
  List<DonViResponse>? donVis = [];
  DonViResponse? unit;
  // loading
  bool isLoading = true;
  bool isThongSo = true;
  bool isLoadingVatTu = true;
  bool isClicked = false;
  // Dịch vụ resquest
  DonDichVuRequest? serviceApplication;
  // Thông số kỹ thuât
  List<MultiSelectItem<ThongSoKyThuatResponse?>> thongSoKyThuatList = [];
  List<ThongSoKyThuatResponse?> thongSo = [];
  // app bar title
  String appBarTitle = 'Tạo đơn công việc';

  @override
  void onInit() {
    serviceApplication = Get.arguments as DonDichVuRequest;
    workTitleController.text = serviceApplication!.tieuDe ?? '';
    appBarTitle = Get.parameters['appbar'].toString();
    getAllDonVi();
    getWorkTime();
    getAllThongSo();
    super.onInit();
  }

  ///
  ///// Chọn thời gian làm việc
  ///
  void onSelectedTommorow({required bool val}) {
    tommorow = val;
    if (tommorow) {
      tommowReponse = thoiGianLamViecList.firstWhereOrNull(
          (element) => element.tieuDe!.contains('7h30 - 11h30'));
    } else {
      tommowReponse = null;
    }
    update();
  }

  void onSelectedAfternoon({required bool val}) {
    afternoon = val;
    if (afternoon) {
      afternoonReponse = thoiGianLamViecList.firstWhereOrNull(
          (element) => element.tieuDe!.contains('13h30 - 17h30'));
    } else {
      afternoonReponse = null;
    }
    update();
  }

  void onSelectedTonight({required bool val}) {
    tonight = val;
    if (tonight) {
      tonightReponse = thoiGianLamViecList.firstWhereOrNull(
          (element) => element.tieuDe!.contains('18h30 - 22h30'));
    } else {
      tonightReponse = null;
    }
    update();
  }

  ///
  /// Load thời gian làm việc
  ///
  void getWorkTime() {
    thoiGianLamViecProvider.all(onSuccess: (data) {
      thoiGianLamViecList.clear();
      thoiGianLamViecList.addAll(data);
      isLoading = false;
      update();
    }, onError: (error) {
      isLoading = false;
      update();
      print("V1G5CreateServiceController getWorkTime Error $error");
    });
  }

  ///
  /// onChangedUnit
  ///
  void onChangedUnit(DonViResponse unit) {
    this.unit = unit;
    update();
  }

  void getAllDonVi(){
    donViProvider.paginate(limit: 100, page: 1, filter: '&idNhomDichVu=$NHOM_DICH_VU_5', onSuccess: (data){
      donVis = data;
      isLoadingVatTu = false;
      update();
    }, onError: (onError){
      print("Vật tư");
    });
  }

  ///
  /// Get thông số kỹ thuật
  ///
  void getAllThongSo() {
    thongSoKyThuatProvider.paginate(page: 1, limit: 100, filter: '&idNhomDichVu=$NHOM_DICH_VU_5', onSuccess: (data) {
      thongSoKyThuatList.clear();
      if (data.isNotEmpty) {
        thongSoKyThuatList =
            data.map((e) => MultiSelectItem(e, e.tieuDe!)).toList();
      }
      isThongSo = false;
      update();
    }, onError: (onError) {
      print("V1G5CreateServiceController getAllThongSo $onError");
      isThongSo = false;
      update();
    });
  }

  ///
  /// Tạo đơn
  ///
  void onClickContinueButton() {
    if (isClicked) {
      return;
    } else {
      if (thongSo.isEmpty) {
        IZIAlert.error(message: "Bản phải chọn thông số kỹ thuật");
      } else if (tommorow == false && afternoon == false && tonight == false) {
        IZIAlert.error(message: "Thời gian làm việc không được để trống");
      } else if (amountController.text.toString().isEmpty) {
        IZIAlert.error(message: "Số lượng yêu cầu không được để trống");
      } else if (int.parse(amountController.text.toString()) <= 0) {
        IZIAlert.error(message: "Số lượng không hợp lệ");
      } else if (unit == null) {
        IZIAlert.error(message: "Vui lòng chọn đơn vị");
      } else if (startWorkController.text.toString().isEmpty) {
        IZIAlert.error(message: "Ngày làm việc không được để trống");
      } else if (DateConverter.differenceDate(
              startDate: startWorkController.text.toString(),
              endDate: DateConverter.estimatedDateOnly(DateTime.now())) >
          0) {
        IZIAlert.error(message: "Ngày bắt đầu không được nhỏ hơn ngày hiện tại");
      } else if (estimatedPickUpLocation.text.toString().isEmpty) {
        IZIAlert.error(message: "Địa điểm bốc hàng dự kiến không được để trống");
      } else if (estimatedDeliveryLocation.text.toString().isEmpty) {
        IZIAlert.error(message: "Địa điểm trả hàng dự kiến không được để trống");
      } else if (distanceController.text.toString().isEmpty) {
        IZIAlert.error(message: "Cự ly vận chuyển tương đối không được để trống");
      } else if (workDescController.text.toString().isEmpty) {
        IZIAlert.error(message: "Mô tả yêu cầu cụ thể không được để trống");
      } else {
        isClicked = true;
        EasyLoading.show(status: "Loading ...");
        donDichVuProvider.add(
            data: request(),
            onSuccess: (data) {
              EasyLoading.dismiss();
              IZIAlert.success(
                  message:
                      "Tạo đơn dịch vụ thành công. Chúng tối sẽ phản hội lại cho bạn sơm nhất");
              Get.offAllNamed(AppRoutes.V1_SUCCESSFULLY,
                  predicate: ModalRoute.withName(AppRoutes.V1_SUCCESSFULLY),
                  arguments: request());
              //Get.toNamed(AppRoutes.V1_SUCCESSFULLY, arguments: request());
            },
            onError: (onError) {
              EasyLoading.dismiss();
              print(
                  "V1G5CreateServiceController onClickContinueButton $onError");
            });
      }
    }
  }

  ///
  /// Tạo đối tượng request
  ///
  DonDichVuRequest request() {
    final List<String> workTime = [];
    DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest = serviceApplication!;
    if (tommorow == true) {
      workTime.add(tommowReponse!.id!);
    }
    if (afternoon == true) {
      workTime.add(afternoonReponse!.id!);
    }
    if (tonight == true) {
      workTime.add(tonightReponse!.id!);
    }
    dichVuRequest.idThoiGianLamViecs = workTime;
    if (receivingWidthController.text.toString().isNotEmpty) {
      dichVuRequest.beRongDiemNhan = receivingWidthController.text.toString();
    }
    if (returnWidthController.text.toString().isNotEmpty) {
      dichVuRequest.beRongDiemTra = returnWidthController.text.toString();
    }
    if (thongSo.isNotEmpty) {
      dichVuRequest.idThongSoKyThuats = thongSo.map((e) => e!.id!).toList();
    }
    dichVuRequest.ngayBatDau =
        DateConverter.formatYYYYMMDD(startWorkController.text.toString());
    dichVuRequest.soLuongYeuCau = amountController.text.toString();
    dichVuRequest.diaDiemBocHang = estimatedPickUpLocation.text.toString();
    dichVuRequest.diaDiemTraHang = estimatedDeliveryLocation.text.toString();
    dichVuRequest.cuLyVanChuyen = distanceController.text.toString();
    dichVuRequest.moTaChiTiet = workDescController.text.toString();
    dichVuRequest.donVi = unit!.ten;
    // trạng thái đơn
    dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
    dichVuRequest.idTrangThaiDonDichVu = CHUA_PHAN_HOI;

    if (amountController.text.toString().isNotEmpty) {
      dichVuRequest.soLuongYeuCau = amountController.text.toString();
    }
    return dichVuRequest;
  }

  @override
  void onClose() {
    workTitleController.dispose();
    amountController.dispose();
    startWorkController.dispose();
    estimatedPickUpLocation.dispose();
    estimatedDeliveryLocation.dispose();
    distanceController.dispose();
    workDescController.dispose();
    returnWidthController.dispose();
    receivingWidthController.dispose();
    super.onClose();
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
