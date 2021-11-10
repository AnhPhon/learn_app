import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedController extends GetxController {

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  List<DonDichVuResponse>? donDichVuResponse = [];

  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  List<NhomDichVuResponse>? nhomDichVuResponse;
  NhomDichVuResponse? currentNhomDichVuResponse = NhomDichVuResponse.fromJson({'tenDichVu': '-- Không có --'});

  LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  List<LoaiCongViecResponse>? loaiCongViecResponse;
  LoaiCongViecResponse? currentLoaiCongViecResponse;
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

  @override
  void onClose() {
    super.onClose();
  }

  ///
  ///go to shorthanded group
  ///
  void onShorthandedGroup(int index) {
    print('donDichVuResponse ${donDichVuResponse![index].toJson()}');
    Get.toNamed(
      "${AppRoutes.V2_SHORTHANDED}_group${donDichVuResponse![index].idNhomDichVu!.nhomDichVu.toString()}",
      arguments: {'id': donDichVuResponse![index].id.toString(), 'title': 'Công việc đang cần người'},
    );
  }

  /// Goi api lay tat ca don dich vu
  void getDonDichVu() {
    donDichVuProvider.paginate(
      filter: getFilter(),
      page: page,
      limit: limit,
      onSuccess: (data) {

        // donDichVuResponse = [
        //   DonDichVuResponse.fromJson({'tieuDe': '-- Không có --'})
        // ];
        donDichVuResponse!.addAll(data);

        print('donDichVuResponse $donDichVuResponse');
        update();
      },
      onError: (error) {
        print('V2ShorthandedController getDonDichVu onError all $error');
      },
    );
  }

  /// Goi api lay tat ca nhom dich vu
  void getNhomDichVu() {
    nhomDichVuProvider.all(
      onSuccess: (data) {
        nhomDichVuResponse = [
          NhomDichVuResponse.fromJson({'tenDichVu': '-- Không có --'})
        ];
        if (data.isNotEmpty) {
          /// Selectbox khong cho phep init null gia tri, nen chon 1 gia tri dau tien de init
          for(var i = 0; i < data.length; i++){
            if(data[i].nhomDichVu != '7' && data[i].nhomDichVu != '8'){
              nhomDichVuResponse!.add(data[i]);
            }
          }
          if(nhomDichVuResponse!.length > 0){
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

  /// Chon nhom cong viec
  void selectedNhomCongViec(NhomDichVuResponse? nhomDichVuResponse) {
    currentNhomDichVuResponse = nhomDichVuResponse!;
    updateNhomDichVu();
    update();
  }

  /// Chon nhom dich vu va lay danh sach cong viec
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
            LoaiCongViecResponse.fromJson({'tenCongViec': '-- Không có --'})
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

  /// Chon cac cong viec trong nhom cong viec
  void selectedCongViecPhuHop(LoaiCongViecResponse? results) {
    currentLoaiCongViecResponse = results as LoaiCongViecResponse;
    update();
  }

  /// Goi api lay tat ca tnh thanh pho
  void getTinhThanhPho() {
    tinhTpProvider.all(
      onSuccess: (data) {
        if (data.isNotEmpty) {
          tinhTpResponse = [
            TinhTpResponse.fromJson({'ten': '-- Không có --'})
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

  /// Goi api lay tat ca quan huyen
  void getQuanHuyen() {
    if (currentTinhTpResponse == null || currentTinhTpResponse.id == null || currentTinhTpResponse.id!.isEmpty) return;
    quanHuyenProvider.paginate(
      filter: '&idTinhTp=${currentTinhTpResponse.id.toString()}',
      limit: 500,
      page: 1,
      onSuccess: (data) {
        if (data.isNotEmpty) {
          quanHuyenResponse = [
            QuanHuyenResponse.fromJson({'ten': '-- Không có --'})
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

  /// Goi api lay tat ca phuong xa
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
            PhuongXaResponse.fromJson({'ten': '-- Không có --'})
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

  /// Chon tinh thanh pho
  void selectedTinhThanhPho(TinhTpResponse? results) {
    currentTinhTpResponse = results as TinhTpResponse;
    currentQuanHuyenResponse = QuanHuyenResponse.fromJson({});
    currentPhuongXaResponse = PhuongXaResponse.fromJson({});
    quanHuyenResponse = [];
    phuongXaResponse = [];
    update();
    getQuanHuyen();
  }

  /// Chon quan huyen
  void selectedQuanHuyen(QuanHuyenResponse? results) {
    currentQuanHuyenResponse = results as QuanHuyenResponse;
    currentPhuongXaResponse = PhuongXaResponse.fromJson({});
    phuongXaResponse = [];
    update();
    getPhuongXa();
  }

  /// Chon phuong xa
  void selectedPhuongXa(PhuongXaResponse? results) {
    currentPhuongXaResponse = results as PhuongXaResponse;
    update();
  }

  /// Filter data
  void filterData() {
    print('filterData');
    if (checkFilter() == true) {
      onRefresh();
    }
  }

  /// Kiem tra cac dieu kien loc du lieu
  bool checkFilter() {
    // if (currentPhuongXaResponse.id == null || currentPhuongXaResponse.id!.isEmpty) {
    //   Alert.error(message: 'Bắt buộc chọn 1 phường/xã');
    //   return false;
    // }
    // if (currentQuanHuyenResponse.id == null || currentQuanHuyenResponse.id!.isEmpty) {
    //   Alert.error(message: 'Bắt buộc chọn 1 quận/huyện');
    //   return false;
    // }
    // if (currentTinhTpResponse.id == null || currentTinhTpResponse.id!.isEmpty) {
    //   Alert.error(message: 'Bắt buộc chọn 1 tỉnh/thành phố');
    //   return false;
    // }
    // if (currentNhomDichVuResponse == null || currentNhomDichVuResponse!.id == null || currentNhomDichVuResponse!.id!.isEmpty) {
    //   Alert.error(message: 'Bắt buộc chọn 1 nhóm công việc');
    //   return false;
    // }
    // if (currentLoaiCongViecResponse == null || currentLoaiCongViecResponse!.id == null || currentLoaiCongViecResponse!.id!.isEmpty) {
    //   Alert.error(message: 'Bắt buộc chọn 1 công việc');
    //   return false;
    // }

    return true;
  }

  String getFilter() {
    String _s = '';
    if (currentPhuongXaResponse.id != null && currentPhuongXaResponse.id!.isNotEmpty) _s += '&idPhuongXa=${currentPhuongXaResponse.id}';
    if (currentQuanHuyenResponse.id != null && currentQuanHuyenResponse.id!.isNotEmpty) _s += '&idQuanHuyen=${currentQuanHuyenResponse.id}';
    if (currentTinhTpResponse.id != null && currentTinhTpResponse.id!.isNotEmpty) _s += '&idTinhTp=${currentTinhTpResponse.id}';
    if (currentNhomDichVuResponse != null && currentNhomDichVuResponse!.id != null && currentNhomDichVuResponse!.id!.isNotEmpty) _s += '&idNhomDichVu=${currentNhomDichVuResponse!.id}';
    if (currentLoaiCongViecResponse != null && currentLoaiCongViecResponse!.id != null && currentLoaiCongViecResponse!.id!.isNotEmpty) _s += '&idLoaiCongViec=${currentLoaiCongViecResponse!.id}';
    return _s;
  }


  ///
  ///reload
  ///
  Future<void> onRefresh() async {
    print('V2ShorthandedController onRefresh');
    // await getListDuAnKhachHang(currentIndex.value);
    donDichVuResponse = [];
    page = 1;
    limit = 10;
    getDonDichVu();
  }

  ///
  ///load more
  ///
  Future<void> onLoading() async {
    print('V2ShorthandedController onLoading');
    // await getListLoadMoreDuAnKhachHang(currentIndex.value);
    page += 1;
    getDonDichVu();
  }
}
