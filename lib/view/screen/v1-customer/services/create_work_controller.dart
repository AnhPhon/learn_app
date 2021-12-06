import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import '../../../../di_container.dart';

class CreateWorkController extends GetxController {
  final NhomDichVuProvider nhomDichVuProvider =
      GetIt.I.get<NhomDichVuProvider>();
  final LoaiCongViecProvider loaiCongViecProvider =
      GetIt.I.get<LoaiCongViecProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  // TextEditCOntroller
  final addressController = TextEditingController();

  //Flag
  bool isLoadingNhomDichVu = true;
  bool isLoading = true;
  bool isLoadingWard = true;
  bool isLoadingDistrict = true;

  // Variable
  NhomDichVuResponse? dichvu;
  LoaiCongViecResponse? loaiCongViec;
  int groupTinhTpValue = 0;

  // List
  List<NhomDichVuResponse> nhomDichVuResponseList = [];
  List<LoaiCongViecResponse> loaiCongViecResponseList = [];

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

  //Focus
  final FocusNode focusNode = FocusNode();

  // Id User
  String idUser = '';
  // Get param (idType) nếu là dịch vụ thường xuyên 2 và tạo đơn dich vụ là 1
  SERVICES services = SERVICES.REGULARLY;
  String titleAppBar = 'Tạo đơn dịch vụ';
  @override
  void onInit() {
    super.onInit();
    // Nếu dich vụ thì chỉ có nhóm 3, 4, 5, 6, 7
    // Nếu tạo công việc chỉ có mhóm 1, 2 , 5 ,6
    if (Get.arguments != null) {
      services = Get.arguments as SERVICES;

      /// Change Title App bar
      if (services == SERVICES.REGULARLY) {
        titleAppBar = "Dịch vụ thường xuyên";
      } else if (services == SERVICES.WORK) {
        titleAppBar = 'Tạo đơn công việc';
      }
    }
    getNhomDichVu();
    getTinhThanh();
    getUserId();
  }

  Future<void> getUserId() async {
    await sl.get<SharedPreferenceHelper>().userId.then((value) {
      idUser = value!;
    });
  }

  ///
  /// Thay đổi nhóm công việc
  ///
  void onChangedDichVu(NhomDichVuResponse dichvu) {
    this.dichvu = dichvu;
    getLoaiCongViec(dichvu: dichvu);
    update();
  }

  ///
  /// Thay đổi công việc
  ///
  void onChangedLoaiCongViec(LoaiCongViecResponse loaiCongViec) {
    this.loaiCongViec = loaiCongViec;

    print('Chon loai cong viec $loaiCongViec');
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
      hcmProvinces.clear();
      hcmDistricts.clear();
      hcmWards.clear();
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
  /// Get nhóm dich vụ
  ///
  void getNhomDichVu() {
    nhomDichVuProvider.all(onSuccess: (data) {
      isLoadingNhomDichVu = true;
      nhomDichVuResponseList.clear();
      if (data.isNotEmpty) {
        if (services == SERVICES.WORK) {
          nhomDichVuResponseList.addAll(data.where((element) =>
              element.nhomDichVu!.contains('1') ||
              element.nhomDichVu!.contains('2') ||
              element.nhomDichVu!.contains('5') ||
              element.nhomDichVu!.contains('6')
              // element.nhomDichVu!.contains('7')
            ));
        } else if (services == SERVICES.REGULARLY) {
          nhomDichVuResponseList.addAll(data.where((element) =>
              element.nhomDichVu!.contains('3') ||
              element.nhomDichVu!.contains('4') ||
              element.nhomDichVu!.contains('5') ||
              // element.nhomDichVu!.contains('7') ||
              element.nhomDichVu!.contains('6')));
        }
        nhomDichVuResponseList
            .sort((a, b) => a.nhomDichVu!.compareTo(b.nhomDichVu!));
        dichvu = nhomDichVuResponseList.first;
      }
      isLoadingNhomDichVu = false;
      getLoaiCongViec(dichvu: dichvu!);
      update();
    }, onError: (error) {
      isLoadingNhomDichVu = false;
      update();
      print('getNhomDichVu CreateWorkController $error');
    });
  }

  ///
  /// Load danh sách công việc thuôc nhóm côgn việc
  ///
  void getLoaiCongViec({required NhomDichVuResponse dichvu}) {
    loaiCongViecProvider.paginate(
        page: 1,
        limit: 100,
        filter: "&idNhomDichVu=${dichvu.id}",
        onSuccess: (data) {
          loaiCongViec = null;
          loaiCongViecResponseList.clear();
          loaiCongViecResponseList.addAll(data);
          if (data.isNotEmpty) {
            loaiCongViec = loaiCongViecResponseList.first;
          }
          update();
        },
        onError: (error) {
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
      hcmWards.clear();
      dnWards.clear();
      hnWards.clear();
      otherDistricts.clear();
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
        otherProvinces.addAll(data.where((element) =>
            element.id != DA_NANG &&
            element.id != HA_NOI &&
            element.id != HO_CHI_MINH));
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
            print("Data ${otherwards.length}");
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
  /// Nhấn vào nút tiếp tục
  ///
  Future<void> onClickContinue() async {
    if (dichvu == null) {
      IZIAlert.error(message: "Vui lòng chọn dịch vụ");
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
    if (dnWards.isNotEmpty ||
        hcmWards.isNotEmpty ||
        hnWards.isNotEmpty ||
        otherwards.isNotEmpty) {
      if (hcmPhuong == null &&
          khacPhuong == null &&
          haNoiPhuong == null &&
          daNangPhuong == null) {
        IZIAlert.error(message: "Vui lòng phường xã");
        return;
      }
    }
    if (loaiCongViec == null) {
      IZIAlert.error(message: "Vui lòng chọn công việc");
      return;
    } else if (addressController.text.toString().isEmpty) {
      IZIAlert.error(message: "Vui lòng điền địa chỉ cụ thể");
      return;
    } else {
      if (dichvu!.nhomDichVu! == '1') {
        // Nhóm 1
        Get.toNamed(AppRoutes.V1_G1_CREATE_WORK, arguments: await request());
      } else if (dichvu!.nhomDichVu! == '7') {
        // Nhóm 7
        Get.toNamed(AppRoutes.V1_G7_RECRUITMENT,
            arguments: {'status': false, 'id': await request()});
      } else {
        Get.toNamed(
          "${AppRoutes.V1_REFERENCE_PRICE_TABLE}?id=${dichvu!.nhomDichVu!}&title=${dichvu!.tenDichVu!}&appbar=$titleAppBar",
          arguments: await request(),
        )!
            .then((value) {
          if (value != null) {
            loaiCongViec = loaiCongViecResponseList.firstWhereOrNull(
                    (element) =>
                        element.tenCongViec ==
                        (value as DonDichVuRequest).tieuDe) ??
                loaiCongViecResponseList.first;
          }
        });
      }
    }
  }

  Future<DonDichVuRequest> request() async {
    final DonDichVuRequest serviceApplication = DonDichVuRequest();
    if (groupTinhTpValue == 3) {
      serviceApplication.idTinhTp = otherProvince!.id;
      serviceApplication.idQuanHuyen = khacHuyen!.id;
      if (khacPhuong != null) {
        serviceApplication.idPhuongXa = khacPhuong!.id;
      }
    } else if (groupTinhTpValue == 2) {
      serviceApplication.idTinhTp = daNangProvince!.id;
      serviceApplication.idQuanHuyen = daNangHuyen!.id;
      if (daNangPhuong != null) {
        serviceApplication.idPhuongXa = daNangPhuong!.id;
      }
    } else if (groupTinhTpValue == 1) {
      serviceApplication.idTinhTp = haNoiProvince!.id;
      serviceApplication.idQuanHuyen = haNoiHuyen!.id;
      if (haNoiPhuong != null) {
        serviceApplication.idPhuongXa = haNoiPhuong!.id;
      }
    } else {
      serviceApplication.idTinhTp = hcmProvince!.id;
      serviceApplication.idQuanHuyen = hcmHuyen!.id;
      if (hcmPhuong != null) {
        serviceApplication.idPhuongXa = hcmPhuong!.id;
      }
    }
    print(
        "Tinh: ${serviceApplication.idTinhTp} Huyen: ${serviceApplication.idQuanHuyen} xa: ${serviceApplication.idPhuongXa}");

    serviceApplication.idNhomDichVu = dichvu!.id;
    // serviceApplication.idTaiKhoanNhanDon = idUser;
    serviceApplication.idTaiKhoan = idUser;
    serviceApplication.tieuDe = loaiCongViec!.tenCongViec;
    serviceApplication.idLoaiCongViec= loaiCongViec!.id;
    serviceApplication.diaChiCuThe = addressController.text.toString();
    return serviceApplication;
  }

  @override
  void onClose() {
    super.onClose();
    addressController.dispose();
    focusNode.dispose();
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
