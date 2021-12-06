import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/value_global_notifier.dart';

class V2ShorthandedController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  List<DonDichVuResponse>? donDichVuResponse = [];

  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  List<NhomDichVuResponse>? nhomDichVuResponse;
  NhomDichVuResponse? currentNhomDichVuResponse = NhomDichVuResponse.fromJson({'tenDichVu': 'Chọn nhóm dịch vụ phù hợp'});

  LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  List<LoaiCongViecResponse>? loaiCongViecResponse;
  LoaiCongViecResponse? currentLoaiCongViecResponse = LoaiCongViecResponse.fromJson({'tenCongViec': 'Chọn công việc phù hợp'});
  List<MultiSelectItem<LoaiCongViecResponse?>> loaiCongViecMultiSelectItem = [];

  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  List<TinhTpResponse>? tinhTpResponse = [];
  TinhTpResponse currentTinhTpResponse = TinhTpResponse.fromJson({'id': ''});

  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  List<QuanHuyenResponse>? quanHuyenResponse = [];
  QuanHuyenResponse currentQuanHuyenResponse = QuanHuyenResponse.fromJson({});

  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<PhuongXaResponse>? phuongXaResponse = [];
  PhuongXaResponse currentPhuongXaResponse = PhuongXaResponse.fromJson({});

  int page = 1;
  int limit = 10;

  final valueGlobalNotifier = sl.get<ValueGlobalNotifier>();

  bool initLoading = true;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getNhomDichVu();
    getTinhThanhPho();
    Future.delayed(Duration.zero, () {
      if (checkFilter() == true) {
        getDonDichVu();
      }
    });
  }

  ///
  /// Go to shorthanded group
  ///
  void onShorthandedGroup(int index) {
    Get.toNamed(
      "${AppRoutes.V2_SHORTHANDED}_group${donDichVuResponse![index].idNhomDichVu!.nhomDichVu.toString()}",
      arguments: {'id': donDichVuResponse![index].id.toString(), 'title': 'Công việc đang cần người'},
    );
  }

  ///
  /// Goi api lay tat ca don dich vu
  ///
  Future<void> getDonDichVu() async {
    if (isLoading) return;
    isLoading = true;
    await donDichVuProvider.paginate(
      filter: getFilter(),
      page: page,
      limit: limit,
      onSuccess: (data) {
        isLoading = false;
        if (initLoading) initLoading = false;
        if (data.isEmpty) {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshV2ShorthandedPage', true);
          update();
        } else {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshV2ShorthandedPage', false);
          donDichVuResponse!.addAll(data);
        }
        update();
      },
      onError: (error) {
        print('V2ShorthandedController getDonDichVu onError all $error');
      },
    );
  }

  ///
  /// Goi api lay tat ca nhom dich vu
  ///
  void getNhomDichVu() {
    nhomDichVuProvider.all(
      onSuccess: (data) {
        nhomDichVuResponse = [
          NhomDichVuResponse.fromJson({'tenDichVu': 'Chọn nhóm dịch vụ phù hợp'})
        ];
        if (data.isNotEmpty) {
          // Selectbox khong cho phep init null gia tri, nen chon 1 gia tri dau tien de init
          for (var i = 0; i < data.length; i++) {
            if (data[i].nhomDichVu != '7' && data[i].nhomDichVu != '8') {
              nhomDichVuResponse!.add(data[i]);
            }
          }
          if (nhomDichVuResponse!.isNotEmpty) {
            selectedNhomCongViec(nhomDichVuResponse![0]);
          }
        }
        update();
      },
      onError: (error) {
        print('V2ShorthandedController nhomDichVuProvider onError all $error');
      },
    );
  }

  ///
  /// Chon nhom cong viec
  ///
  void selectedNhomCongViec(NhomDichVuResponse? nhomDichVuResponse) {
    currentNhomDichVuResponse = nhomDichVuResponse;
    currentLoaiCongViecResponse = LoaiCongViecResponse.fromJson({'tenCongViec': 'Chọn công việc phù hợp'});
    updateNhomDichVu();
    update();
  }

  ///
  /// Chon nhom dich vu va lay danh sach cong viec
  ///
  void updateNhomDichVu() {
    if (currentNhomDichVuResponse != null && currentNhomDichVuResponse!.id != null && currentNhomDichVuResponse!.id!.isNotEmpty) {
      loaiCongViecProvider.paginate(
        filter: '&idNhomDichVu=${currentNhomDichVuResponse!.id.toString()}',
        limit: 100,
        page: 1,
        onSuccess: (data) {
          currentLoaiCongViecResponse = null;
          loaiCongViecResponse = [];
          loaiCongViecMultiSelectItem = [];
          loaiCongViecResponse = [
            LoaiCongViecResponse.fromJson({'tenCongViec': 'Chọn công việc phù hợp'})
          ];
          if (data.isNotEmpty) {
            loaiCongViecResponse!.addAll(data);
            loaiCongViecMultiSelectItem = loaiCongViecResponse!.map((e) => MultiSelectItem(e, e.tenCongViec.toString())).toList();
          }

          update();
        },
        onError: (error) {
          print('V2ShorthandedController loaiCongViecProvider onError all $error');
        },
      );
    }
  }

  ///
  /// Chon cac cong viec trong nhom cong viec
  ///
  void selectedCongViecPhuHop(LoaiCongViecResponse? results) {
    currentLoaiCongViecResponse = results as LoaiCongViecResponse;
    update();
  }

  ///
  /// Goi api lay tat ca tnh thanh pho
  ///
  void getTinhThanhPho() {
    tinhTpProvider.all(
      onSuccess: (data) {
        if (data.isNotEmpty) {
          tinhTpResponse = [
            TinhTpResponse.fromJson({'ten': 'Chọn tỉnh/thành phố phù hợp'})
          ];
          tinhTpResponse!.addAll(data);
        }
        currentQuanHuyenResponse = QuanHuyenResponse.fromJson({});
        currentPhuongXaResponse = PhuongXaResponse.fromJson({});
        update();
      },
      onError: (error) {
        print('V2ShorthandedController getTinhThanhPho onError all $error');
      },
    );
  }

  ///
  /// Goi api lay tat ca quan huyen
  ///
  void getQuanHuyen() {
    if (currentTinhTpResponse == null || currentTinhTpResponse.id == null || currentTinhTpResponse.id!.isEmpty) return;
    quanHuyenProvider.paginate(
      filter: '&idTinhTp=${currentTinhTpResponse.id.toString()}',
      limit: 500,
      page: 1,
      onSuccess: (data) {
        if (data.isNotEmpty) {
          quanHuyenResponse = [
            QuanHuyenResponse.fromJson({'ten': 'Chọn quận/huyện phù hợp'})
          ];
          quanHuyenResponse!.addAll(data);
        }
        update();
      },
      onError: (error) {
        print('V2ShorthandedController getTinhThanhPho onError all $error');
      },
    );
  }

  ///
  /// Goi api lay tat ca phuong xa
  ///
  void getPhuongXa() {
    if (currentTinhTpResponse == null || currentTinhTpResponse.id == null || currentTinhTpResponse.id!.isEmpty) return;
    if (currentQuanHuyenResponse == null || currentQuanHuyenResponse.id == null || currentQuanHuyenResponse.id!.isEmpty) return;
    phuongXaProvider.paginate(
      filter: '&idQuanHuyen=${currentQuanHuyenResponse.id.toString()}',
      limit: 500,
      page: 1,
      onSuccess: (data) {
        if (data.isNotEmpty) {
          phuongXaResponse = [
            PhuongXaResponse.fromJson({'ten': 'Chọn phường/xã phù hợp'})
          ];
          phuongXaResponse!.addAll(data);
        }
        update();
      },
      onError: (error) {
        print('V2ShorthandedController getTinhThanhPho onError all $error');
      },
    );
  }

  ///
  /// Chon tinh thanh pho
  ///
  void selectedTinhThanhPho(TinhTpResponse? results) {
    currentTinhTpResponse = results as TinhTpResponse;
    currentQuanHuyenResponse = QuanHuyenResponse.fromJson({});
    currentPhuongXaResponse = PhuongXaResponse.fromJson({});
    quanHuyenResponse = [];
    phuongXaResponse = [];
    update();
    getQuanHuyen();
  }

  ///
  /// Chon quan huyen
  ///
  void selectedQuanHuyen(QuanHuyenResponse? results) {
    currentQuanHuyenResponse = results as QuanHuyenResponse;
    currentPhuongXaResponse = PhuongXaResponse.fromJson({});
    phuongXaResponse = [];
    update();
    getPhuongXa();
  }

  ///
  /// Chon phuong xa
  ///
  void selectedPhuongXa(PhuongXaResponse? results) {
    currentPhuongXaResponse = results as PhuongXaResponse;
    update();
  }

  ///
  /// Filter data
  ///
  void filterData() {
    if (checkFilter() == true) {
      onRefresh();
    }
  }

  ///
  /// Kiem tra cac dieu kien loc du lieu
  ///
  bool checkFilter() {
    return true;
  }

  ///
  /// Tao query filter tu cac dieu kien filter
  ///
  String getFilter() {

    String _s = '&idTrangThaiDonDichVu=$DA_DUYET,$DON_DICH_VU_DA_BAO_GIA&sortBy=created_at:desc';

    if (currentPhuongXaResponse.id != null && currentPhuongXaResponse.id!.isNotEmpty) _s += '&idPhuongXa=${currentPhuongXaResponse.id}';
    if (currentQuanHuyenResponse.id != null && currentQuanHuyenResponse.id!.isNotEmpty) _s += '&idQuanHuyen=${currentQuanHuyenResponse.id}';
    if (currentTinhTpResponse.id != null && currentTinhTpResponse.id!.isNotEmpty) _s += '&idTinhTp=${currentTinhTpResponse.id}';
    if (currentNhomDichVuResponse != null && currentNhomDichVuResponse!.id != null && currentNhomDichVuResponse!.id!.isNotEmpty) {
      _s += '&idNhomDichVu=${currentNhomDichVuResponse!.id}';
    } else {
      _s += '&idNhomDichVuExclude=$NHOM_DICH_VU_7,$NHOM_DICH_VU_8';
    }
    if (currentLoaiCongViecResponse != null && currentLoaiCongViecResponse!.id != null && currentLoaiCongViecResponse!.id!.isNotEmpty) _s += '&idLoaiCongViec=${currentLoaiCongViecResponse!.id}';
    return _s;
  }

  ///
  ///reload
  ///
  Future<void> onRefresh() async {
    donDichVuResponse = [];
    page = 1;
    limit = 10;
    initLoading = true;
    update();
    await getDonDichVu();
  }

  ///
  ///load more
  ///
  Future<void> onLoading() async {
    page += 1;
    await getDonDichVu();
  }
}
