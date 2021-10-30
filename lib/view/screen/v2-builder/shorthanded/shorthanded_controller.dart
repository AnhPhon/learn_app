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
  List<Map<String, dynamic>> shorthandedGroupList = [
    {
      "group": "1",
      "status": "Đang tuyển",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "6",
      "status": "Khảo sát báo giá",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "2",
      "status": "Khảo sát báo giá",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "5",
      "status": "Đang tuyển",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "2",
      "status": "Khảo sát báo giá",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "6",
      "status": "Khảo sát báo giá",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
  ];

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  List<DonDichVuResponse>? donDichVuResponse;

  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  List<NhomDichVuResponse>? nhomDichVuResponse;
  NhomDichVuResponse currentNhomDichVuResponse = NhomDichVuResponse.fromJson({});

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
    getDonDichVu();
    getNhomDichVu();
    getTinhThanhPho();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///
  ///go to shorthanded group
  ///
  void onShorthandedGroup(int index) {
    Get.toNamed(
        "${AppRoutes.V2_SHORTHANDED}_group${shorthandedGroupList[index]['group']}");
  }

  /// Goi api lay tat ca don dich vu
  void getDonDichVu() {
    donDichVuProvider.paginate(
      filter: getFilter(),
      page: page,
      limit: limit,
      onSuccess: (data) {
        donDichVuResponse = data;
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
        if (data.isNotEmpty) {
          /// Selectbox khong cho phep init null gia tri, nen chon 1 gia tri dau tien de init
          selectedNhomCongViec(data[0]);
        }
        nhomDichVuResponse = data;
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
    loaiCongViecProvider.paginate(
      filter: '&idNhomDichVu=${currentNhomDichVuResponse.id.toString()}',
      limit: 100,
      page: 1,
      onSuccess: (data) {
        currentLoaiCongViecResponse = null;
        loaiCongViecResponse = [];
        loaiCongViecMultiSelectItem = [];
        if (data.isNotEmpty) {
          loaiCongViecResponse = data;
          loaiCongViecMultiSelectItem = loaiCongViecResponse!.map((e) => MultiSelectItem(e, e.tenCongViec.toString())).toList();
        }

        update();
      },
      onError: (error) {
        print('V2ShorthandedController loaiCongViecProvider onError all $error');
      },
    );
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
          tinhTpResponse = [TinhTpResponse.fromJson({'ten': '-- Không có --'})];
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
    if(currentTinhTpResponse == null || currentTinhTpResponse.id == null || currentTinhTpResponse.id!.isEmpty) return;
    quanHuyenProvider.paginate(
      filter: '&idTinhTp=${currentTinhTpResponse.id.toString()}',
      limit: 500,
      page: 1,
      onSuccess: (data) {
        if (data.isNotEmpty) {
          quanHuyenResponse = [QuanHuyenResponse.fromJson({'ten': '-- Không có --'})];
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
    if(currentTinhTpResponse == null || currentTinhTpResponse.id == null || currentTinhTpResponse.id!.isEmpty) return;
    if(currentQuanHuyenResponse == null || currentQuanHuyenResponse.id == null || currentQuanHuyenResponse.id!.isEmpty) return;
    phuongXaProvider.paginate(
      filter: '&idQuanHuyen=${currentQuanHuyenResponse.id.toString()}',
      limit: 500,
      page: 1,
      onSuccess: (data) {
        if (data.isNotEmpty) {
          phuongXaResponse = [PhuongXaResponse.fromJson({'ten': '-- Không có --'})];
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
    update();
  }

  String getFilter() {
    String _s = '';
    if(currentPhuongXaResponse.id != null && currentPhuongXaResponse.id!.isEmpty) _s += '&idPhuongXa=${currentPhuongXaResponse.id}';
    if(currentQuanHuyenResponse.id != null && currentQuanHuyenResponse.id!.isEmpty) _s += '&idQuanHuyen=${currentQuanHuyenResponse.id}';
    if(currentTinhTpResponse.id != null && currentTinhTpResponse.id!.isEmpty) _s += '&idTinhTp=${currentTinhTpResponse.id}';
    if(currentNhomDichVuResponse.id != null && currentNhomDichVuResponse.id!.isEmpty) _s += '&idNhomDichVu=${currentNhomDichVuResponse.id}';
    if(currentLoaiCongViecResponse != null && currentLoaiCongViecResponse!.id != null && currentLoaiCongViecResponse!.id!.isEmpty) _s += '&idLoaiCongViec=${currentLoaiCongViecResponse!.id}';
    return _s;
  }


}
