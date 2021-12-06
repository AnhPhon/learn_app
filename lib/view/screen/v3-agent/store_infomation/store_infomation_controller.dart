import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/kho_hang_dai_ly_request.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/kho_hang_model.dart';
import 'package:template/data/model/response/mat_hang_dac_trung_response.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/kho_hang_dai_ly_provider.dart';
import 'package:template/provider/mat_hang_dac_trung_provider.dart';
import 'package:template/provider/nhap_kho_hang_dai_ly_provider.dart';
import 'package:template/provider/nhom_cua_hang_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/helper/izi_validate.dart';

class V3StoreInfomationController extends GetxController {
  //image
  File? image;

  //name of company
  final nameController = TextEditingController();
  //legal Representative
  final legalRepresentativeController = TextEditingController();
  //phone
  final phoneController = TextEditingController();
  //email
  final emailController = TextEditingController();
  //address
  final addressController = TextEditingController();
  //start time range
  final startController = TextEditingController();
  //end time range
  final endController = TextEditingController();

  //user idd
  String userId = "";

  //TaiKhoan
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();
  TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();

  //NhomCuaHang
  NhomCuaHangProvider nhomCuaHangProvider = GetIt.I.get<NhomCuaHangProvider>();
  List<NhomCuaHangResponse> nhomCuaHangList = [];
  NhomCuaHangResponse? nhomCuaHangResponse;

  //MatHangDacTrung
  MatHangDacTrungProvider matHangDacTrungProvider = GetIt.I.get<MatHangDacTrungProvider>();
  List<MatHangDacTrungResponse?> matHangDacTrungList = [];
  List<String?> matHangDacTrungResponse = [];

  //TinhTp
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  List<TinhTpResponse> tinhTpsList = [];
  List<TinhTpResponse> otherProvinces = [];

  //isWarehouse
  TinhTpResponse? hcmProvince;
  TinhTpResponse? otherProvince;
  TinhTpResponse? daNangProvince;
  TinhTpResponse? haNoiProvince;

  //rad address index
  int groupTinhTpValue = 0;

  //QuanHuyen
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  List<QuanHuyenResponse> quanHuyensList = [];
  List<QuanHuyenResponse> otherDistricts = [];
  QuanHuyenResponse? hcmHuyen;
  QuanHuyenResponse? daNangHuyen;
  QuanHuyenResponse? haNoiHuyen;
  QuanHuyenResponse? khacHuyen;

  //PhuongXa
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<PhuongXaResponse> phuongXasList = [];
  List<PhuongXaResponse> otherwards = [];
  PhuongXaResponse? hcmPhuong;
  PhuongXaResponse? daNangPhuong;
  PhuongXaResponse? haNoiPhuong;
  PhuongXaResponse? khacPhuong;

  //KhoHangDaiLy
  KhoHangDaiLyProvider khoHangDaiLyProvider = GetIt.I.get<KhoHangDaiLyProvider>();
  List<KhoHangDaiLyResponse> khoHangDaiLyList = [];
  KhoHangDaiLyResponse? khoHangDaiLyResponse;
  KhoHangDaiLyRequest khoHangDaiLyRequest = KhoHangDaiLyRequest();

  //nhapkho
  NhapKhoHangDaiLyProvider nhapKhoHangDaiLyProvider = GetIt.I.get<NhapKhoHangDaiLyProvider>();

  //list khohang model
  List<KhoHangModel> khoHangModelList = [];

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //accept
  Map<String, String> boolAccept = {
    "0": "Không",
    "1": "Có",
  };

  //title appbar
  String title = "Thông tin cửa hàng";

  //note
  String note = "Nếu địa điểm kho hàng nằm ở vị trí khác (hoặc tỉnh khác) cửa hàng chính thì cập nhật thêm địa chỉ để tính toán cước vận chuyển";

  //CircularProgressIndicator
  bool isLoading = true;
  bool isLoadingAdd = false;
  bool isLoadingWarehouse = false;

  //warehouse list
  List<Widget> warehouseList = [];
  List<String> diaDiemCuaHangChinhList = [];

  @override
  void onInit() {
    super.onInit();
    //get load data
    getUserInfomation();
  }

  @override
  void onClose() {
    nameController.dispose();
    legalRepresentativeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    startController.dispose();
    endController.dispose();
    super.onClose();
  }

  ///
  ///get user infomation
  ///
  Future<void> getUserInfomation() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    taiKhoanProvider.find(
      id: userId,
      onSuccess: (data) {
        taiKhoanResponse = data;

        //mapping hinhAnhCuaHang
        if (data.hinhAnhCuaHangs!.isNotEmpty) {
          taiKhoanRequest.hinhAnhCuaHangs = data.hinhAnhCuaHangs;
        }

        //mapping thoi gian lam viec
        if (data.thoiGianLamViec != "null") {
          final thoiGianLamViecList = data.thoiGianLamViec!.split("-");
          startController.text = thoiGianLamViecList[0].trim();
          endController.text = thoiGianLamViecList[1].trim();
        }

        //mapping dia diem cua hang chinh
        if (data.diaDiemCuaHangChinh != "null") {
          //mapping tinhTp
          diaDiemCuaHangChinhList = data.diaDiemCuaHangChinh!.split(",");
          if (diaDiemCuaHangChinhList[2].trim().contains("Hồ Chí Minh")) {
            groupTinhTpValue = 0;

            //getTinhTp
            getTinhTp();
          } else if (diaDiemCuaHangChinhList[2].trim().contains("Hà Nội")) {
            groupTinhTpValue = 1;

            //getTinhTp
            getTinhTp();
          } else if (diaDiemCuaHangChinhList[2].trim().contains("Đà Nẵng")) {
            groupTinhTpValue = 2;

            //getTinhTp
            getTinhTp();
          } else {
            groupTinhTpValue = 3;

            //getTinhTp
            getTinhTp();
          }
        } else {
          //getTinhTp
          getTinhTp();
        }

        //getNhomCuaHang
        getNhomCuaHang();

        //getMatHangDacTrung
        getMatHangDacTrung();

        //getKhoHang
        getKhoHangDaiLy();

        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getUserInfomation onError $error");
      },
    );
  }

  ///
  ///get kho hang
  ///
  void getKhoHangDaiLy() {
    khoHangDaiLyProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (value) {
        if (value.isNotEmpty) {
          isLoadingWarehouse = true;
          khoHangDaiLyList = value;
          khoHangModelList = List<KhoHangModel>.generate(
            khoHangDaiLyList.length,
            (index) => KhoHangModel(
              idKhoHang: khoHangDaiLyList[index].id,
              warehouseAddress: TextEditingController(),
              warehouseName: TextEditingController(),
              tinhTpList: [],
              quanHuyenList: [],
              phuongXaList: [],
            ),
          );
          for (var i = 0; i < value.length; i++) {
            //mapping tinhTpWarehouse
            khoHangModelList[i].tinhTpResponse = tinhTpsList[tinhTpsList.indexWhere((element) => element.id == value[i].idTinhTp!.id)];
            khoHangModelList[i].tinhTpList = tinhTpsList;

            //mapping name & address
            khoHangModelList[i].warehouseAddress!.text = value[i].diaChi.toString();
            khoHangModelList[i].warehouseName!.text = value[i].ten.toString();

            //mapping quanHuyenWareHouse
            getQuanHuyen(
              idTinhTp: value[i].idTinhTp!.id.toString(),
              indexWarehouse: i,
              isWarehouse: true,
            );

            if (value[i].idPhuongXa != null) {
              //mapping phuongXaWareHouse
              getPhuongXa(
                idQuanHuyen: value[i].idQuanHuyen!.id.toString(),
                indexWarehouse: i,
                isWarehouse: true,
              );
            }
          }
        }
        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getKhoHangDaiLy onError $error");
      },
    );
  }

  ///
  ///get NhomCuaHang
  ///
  void getNhomCuaHang() {
    nhomCuaHangProvider.all(
      onSuccess: (value) {
        nhomCuaHangList = value;

        //check nhomCuaHangResponse already exits
        if (value.isNotEmpty && taiKhoanResponse.idNhomCuaHang != null) {
          if (value.indexWhere((element) => element.id == taiKhoanResponse.idNhomCuaHang!.id) != -1) {
            //binding nhomCuaHangResponse
            nhomCuaHangResponse = value[value.indexWhere((element) => element.id == taiKhoanResponse.idNhomCuaHang!.id)];
          }
        }

        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getNhomCuaHang onError $error");
      },
    );
  }

  ///
  ///get MatHangDacTrung
  ///
  void getMatHangDacTrung() {
    matHangDacTrungProvider.all(
      onSuccess: (value) {
        matHangDacTrungList = value;

        //binding data TextEditingController
        nameController.text = taiKhoanResponse.hoTen.toString();
        if (taiKhoanResponse.tenPhapLy != "null") {
          legalRepresentativeController.text = taiKhoanResponse.tenPhapLy.toString();
        }
        phoneController.text = taiKhoanResponse.soDienThoai.toString();

        if (taiKhoanResponse.email != "null") {
          emailController.text = taiKhoanResponse.email.toString();
        }

        if (taiKhoanResponse.diaChi != 'null') {
          addressController.text = taiKhoanResponse.diaChi.toString();
        }

        taiKhoanResponse.idMatHangDacTrungs!.map((e) => matHangDacTrungResponse.add(e.id)).toList();

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getMatHangDacTrung onError $error");
      },
    );
  }

  ///
  ///get TinhTp
  ///
  void getTinhTp() {
    tinhTpProvider.all(
      onSuccess: (value) {
        tinhTpsList = value;
        otherProvinces = value;
        update();

        if (groupTinhTpValue == 0) {
          hcmProvince = tinhTpsList.firstWhere((element) => element.id!.contains(HO_CHI_MINH));
          getQuanHuyen(idTinhTp: hcmProvince!.id!);
        } else if (groupTinhTpValue == 1) {
          haNoiProvince = tinhTpsList.firstWhere((element) => element.id!.contains(HA_NOI));
          getQuanHuyen(idTinhTp: haNoiProvince!.id!);
        } else if (groupTinhTpValue == 2) {
          daNangProvince = tinhTpsList.firstWhere((element) => element.id!.contains(DA_NANG));
          getQuanHuyen(idTinhTp: daNangProvince!.id!);
        } else {
          if (taiKhoanResponse.diaDiemCuaHangChinh != "null") {
            otherProvince = otherProvinces.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[2].trim()));
            getQuanHuyen(idTinhTp: otherProvince!.id.toString());
          } else {
            otherProvince = null;
          }
        }

        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getTinhTp onError $error");
      },
    );
  }

  ///
  ///get QuanHuyen
  ///
  void getQuanHuyen({
    required String idTinhTp,
    bool? isWarehouse = false,
    int? index = -1,
    int? indexWarehouse = -1,
    bool? isFirst = false,
  }) {
    quanHuyenProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTinhTp=$idTinhTp",
      onSuccess: (value) {
        //is not Warehouse
        if (isWarehouse == false) {
          if (groupTinhTpValue != 3) {
            quanHuyensList.clear();
            phuongXasList.clear();
            if (value.isNotEmpty) {
              quanHuyensList.addAll(value);
              //mapping huyen
              if (taiKhoanResponse.diaDiemCuaHangChinh != "null") {
                if (groupTinhTpValue == 0) {
                  hcmHuyen = quanHuyensList.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[1].trim()));
                  //get phuong xa
                  getPhuongXa(idQuanHuyen: hcmHuyen!.id.toString());
                } else if (groupTinhTpValue == 1) {
                  haNoiHuyen = quanHuyensList.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[1].trim()));
                  //get phuong xa
                  getPhuongXa(idQuanHuyen: haNoiHuyen!.id.toString());
                } else if (groupTinhTpValue == 2) {
                  daNangHuyen = quanHuyensList.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[1].trim()));
                  //get phuong xa
                  getPhuongXa(idQuanHuyen: daNangHuyen!.id.toString());
                }
              }
            }
            update();
          } else {
            khacHuyen = null;
            khacPhuong = null;
            otherDistricts.clear();
            otherDistricts.addAll(value);
            if (taiKhoanResponse.diaDiemCuaHangChinh != "null") {
              //mapping huyen
              khacHuyen = otherDistricts.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[1].trim()));
              //get phuong xa
              getPhuongXa(idQuanHuyen: khacHuyen!.id.toString());
            }
            update();
          }
        } else {
          if (index != -1) {
            //isWarehouse
            khoHangModelList[index!].quanHuyenList = value;
          }
        }
        if (indexWarehouse != -1) {
          //mapping warehouse quanHUyen
          khoHangModelList[indexWarehouse!].quanHuyenList = value;
          khoHangModelList[indexWarehouse].quanHuyenResponse = khoHangModelList[indexWarehouse].quanHuyenList![khoHangModelList[indexWarehouse].quanHuyenList!.indexWhere((element) => element.id == khoHangDaiLyList[indexWarehouse].idQuanHuyen!.id)];
        }

        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getQuanHuyen onError $error");
      },
    );
  }

  ///
  ///get PhuongXa
  ///
  void getPhuongXa({
    required String idQuanHuyen,
    bool? isWarehouse = false,
    int? index = -1,
    int? indexWarehouse = -1,
  }) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idQuanHuyen=$idQuanHuyen",
      onSuccess: (value) {
        if (value.isNotEmpty) {
          //is not Warehouse
          if (isWarehouse == false) {
            if (groupTinhTpValue != 3) {
              phuongXasList.clear();
              if (value.isNotEmpty) {
                phuongXasList.addAll(value);
                //mapping phuong xa
                if (taiKhoanResponse.diaDiemCuaHangChinh != "null" && diaDiemCuaHangChinhList[0] != '') {
                  if (groupTinhTpValue == 0) {
                    hcmPhuong = phuongXasList.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[0].trim()));
                  } else if (groupTinhTpValue == 1) {
                    haNoiPhuong = phuongXasList.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[0].trim()));
                  } else if (groupTinhTpValue == 2) {
                    daNangPhuong = phuongXasList.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[0].trim()));
                  }
                }
              }
              update();
            } else {
              khacPhuong = null;
              otherwards.clear();
              otherwards.addAll(value);
              //mapping phuong xa
              if (taiKhoanResponse.diaDiemCuaHangChinh != "null" && diaDiemCuaHangChinhList[0] != '') {
                khacPhuong = otherwards.firstWhere((element) => element.ten!.trim().contains(diaDiemCuaHangChinhList[0].trim()));
              }
              update();
            }
          } else {
            if (index != -1) {
              //isWarehouse
              khoHangModelList[index!].phuongXaList = value;
            }
          }
          if (indexWarehouse != -1) {
            if (khoHangDaiLyList[indexWarehouse!].idPhuongXa != null) {
              //mapping warehouse phuongXa
              khoHangModelList[indexWarehouse].phuongXaList = value;
              khoHangModelList[indexWarehouse].phuongXaResponse = khoHangModelList[indexWarehouse].phuongXaList![khoHangModelList[indexWarehouse].phuongXaList!.indexWhere((element) => element.id == khoHangDaiLyList[indexWarehouse].idPhuongXa!.id)];
            }
          }
          if (indexWarehouse == khoHangDaiLyList.length - 1) {
            isLoadingWarehouse = false;
          }
          update();
        } else {
          isLoadingWarehouse = false;
          update();
        }
      },
      onError: (error) {
        print("V3StoreInfomationController getPhuongXa onError $error");
      },
    );
  }

  ///
  ///get KhoHang
  ///
  void getKhoHang() {
    khoHangDaiLyProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (value) {
        khoHangDaiLyList = value;
      },
      onError: (error) {
        print("V3StoreInfomationController getKhoHang onError $error");
      },
    );
  }

  ///
  ///on selected NhomCuaHang
  ///
  void onSelectedNhomCuaHang({required NhomCuaHangResponse value}) {
    nhomCuaHangResponse = value;
    update();
  }

  ///
  ///on selected lamChieuThuBay
  ///
  void onSelectedLamChieuThuBay({required String value}) {
    taiKhoanResponse.lamChieuThuBay = value;
    update();
  }

  ///
  ///on selected lamNgayChuNhat
  ///
  void onSelectedLamNgayChuNhat({required String value}) {
    taiKhoanResponse.lamNgayChuNhat = value;
    update();
  }

  ///
  /// Thay đổi radio button
  ///
  void onChangedGroup(int val) {
    taiKhoanResponse.diaDiemCuaHangChinh = "null";
    otherProvince = null;
    khacHuyen = null;
    khacPhuong = null;
    haNoiHuyen = null;
    haNoiPhuong = null;
    daNangHuyen = null;
    daNangPhuong = null;
    hcmHuyen = null;
    hcmPhuong = null;
    quanHuyensList.clear();
    otherDistricts.clear();
    phuongXasList.clear();
    otherwards.clear();
    groupTinhTpValue = val;
    getTinhTp();
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    taiKhoanResponse.diaDiemCuaHangChinh = "null";
    khacHuyen = null;
    khacPhuong = null;
    haNoiHuyen = null;
    haNoiPhuong = null;
    daNangHuyen = null;
    daNangPhuong = null;
    hcmHuyen = null;
    hcmPhuong = null;
    quanHuyensList.clear();
    otherDistricts.clear();
    phuongXasList.clear();
    otherwards.clear();
    if (groupTinhTpValue == 3) {
      otherProvince = tinhTp;
    } else if (groupTinhTpValue == 2) {
      daNangProvince = tinhTp;
    } else if (groupTinhTpValue == 1) {
      haNoiProvince = tinhTp;
    } else {
      hcmProvince = tinhTp;
    }

    getQuanHuyen(idTinhTp: tinhTp.id!);
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    taiKhoanResponse.diaDiemCuaHangChinh = "null";
    khacPhuong = null;
    haNoiPhuong = null;
    daNangPhuong = null;
    hcmPhuong = null;
    phuongXasList.clear();
    otherwards.clear();
    if (groupTinhTpValue == 3) {
      khacHuyen = quanHuyen;
    } else if (groupTinhTpValue == 2) {
      daNangHuyen = quanHuyen;
    } else if (groupTinhTpValue == 1) {
      haNoiHuyen = quanHuyen;
    } else {
      hcmHuyen = quanHuyen;
    }

    getPhuongXa(idQuanHuyen: quanHuyen.id!);
    update();
  }

  ///
  ///Thay đổi PhuongXa
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    if (groupTinhTpValue == 3) {
      khacPhuong = phuongXa;
    } else if (groupTinhTpValue == 2) {
      daNangPhuong = phuongXa;
    } else if (groupTinhTpValue == 1) {
      haNoiPhuong = phuongXa;
    } else {
      hcmPhuong = phuongXa;
    }

    update();
  }

  ///
  ///btn click add warehouse address
  ///
  void onClickWareHouseAdd() {
    isLoadingAdd = true;
    khoHangModelList.add(KhoHangModel(
      tinhTpList: tinhTpsList,
      quanHuyenList: [],
      phuongXaList: [],
      warehouseAddress: TextEditingController(),
      warehouseName: TextEditingController(),
    ));
    isLoadingAdd = false;
    update();
  }

  ///
  ///Thay đổi tỉnh thành IsWarehouse
  ///
  void onChangedTinhThanhIsWarehouse(TinhTpResponse tinhTp, int index) {
    //clear data
    khoHangModelList[index].quanHuyenResponse = null;
    khoHangModelList[index].quanHuyenList!.clear();
    khoHangModelList[index].phuongXaResponse = null;
    khoHangModelList[index].phuongXaList!.clear();

    //set data
    khoHangModelList[index].tinhTpResponse = tinhTp;
    update();

    //getQuanHuyen
    getQuanHuyen(idTinhTp: tinhTp.id!, isWarehouse: true, index: index);
    update();
  }

  ///
  ///Thay đổi quận huyện IsWarehouse
  ///
  void onChangedQuanHuyenIsWarehouse(QuanHuyenResponse quanHuyen, int index) {
    //clear data
    khoHangModelList[index].phuongXaResponse = null;
    khoHangModelList[index].phuongXaList!.clear();

    //set data
    khoHangModelList[index].quanHuyenResponse = quanHuyen;
    update();

    //getPhuongXa
    getPhuongXa(idQuanHuyen: quanHuyen.id!, isWarehouse: true, index: index);
    update();
  }

  ///
  ///Thay đổi PhuongXa IsWarehouse
  ///
  void onChangedPhuongXaIsWarehouse(PhuongXaResponse phuongXa, int index) {
    //set data
    khoHangModelList[index].phuongXaResponse = phuongXa;
    update();
  }

  ///
  ///on delete warehouse
  ///
  void onDeleteWarehouse({required int index}) {
    //check is not empty
    if (khoHangModelList[index].idKhoHang != null) {
      //loading
      EasyLoading.show(status: 'Loading...');

      //find product in warehouse
      nhapKhoHangDaiLyProvider.paginate(
        page: 1,
        limit: 100,
        filter: "&idKhoHangDaiLy=${khoHangModelList[index].idKhoHang}",
        onSuccess: (nhapKho) {
          //check is not empty
          if (nhapKho.isNotEmpty) {
            //delete product in warehouse
            for (final item in nhapKho) {
              nhapKhoHangDaiLyProvider.delete(
                id: item.id.toString(),
                onSuccess: (deleted) {
                  //success
                  if (item.id == nhapKho.last.id) {
                    print("xoá sản phẩm trong kho thành công");
                    //delete kho hang
                    khoHangDaiLyProvider.delete(
                      id: khoHangModelList[index].idKhoHang.toString(),
                      onSuccess: (data) {
                        khoHangModelList.removeAt(index);
                        EasyLoading.dismiss();
                        IZIAlert.success(message: "Xoá kho hàng thành công");
                        print("Xoá kho hàng thành công");
                        update();
                      },
                      onError: (error) {
                        print("V3StoreInfomationController onDeleteWarehouse onError $error");
                      },
                    );
                  }
                },
                onError: (error) {
                  EasyLoading.dismiss();
                  print("V3StoreInfomationController delete kho onError $error");
                },
              );
            }
          } else {
            //delete kho hang
            khoHangDaiLyProvider.delete(
              id: khoHangModelList[index].idKhoHang.toString(),
              onSuccess: (data) {
                khoHangModelList.removeAt(index);
                EasyLoading.dismiss();
                print("Xoá kho hàng thành công");
                update();
              },
              onError: (error) {
                print("V3StoreInfomationController onDeleteWarehouse onError $error");
              },
            );
          }
        },
        onError: (error) {
          print("V3StoreInfomationController onDeleteWarehouse onError $error");
        },
      );
    } else {
      //remove from list
      khoHangModelList.removeAt(index);
      update();
    }
  }

  ///
  ///pick image
  ///
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');
      //uploadImage
      uploadImage(images: files);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required List<File> images}) {
    imageUpdateProvider.addImages(
      files: images,
      onSuccess: (value) {
        EasyLoading.dismiss();
        if (value.files != null && value.files!.isNotEmpty) {
          taiKhoanRequest.hinhAnhCuaHangs = value.files;
        }
        update();
      },
      onError: (error) {
        EasyLoading.dismiss();
        print("V3StoreInfomationController uploadImage onError $error");
      },
    );
  }

  ///
  ///btn update
  ///
  void btnUpdate(BuildContext context) {
    //validate
    if (nameController.text.isEmpty) {
      IZIAlert.error(message: 'Tên không được để trống');
      return;
    } else if (legalRepresentativeController.text.isEmpty) {
      IZIAlert.error(message: 'Tên đại diện pháp lý');
      return;
    } else
    // if (phoneController.text.isEmpty) {
    //   IZIAlert.error(message: 'Trường số điện thoại không được để trống');
    //   return;
    // } else
    if (nhomCuaHangResponse == null) {
      IZIAlert.error(message: 'Nhóm cửa hàng không được để trống');
      return;
    } else if (emailController.text.isNotEmpty && Validate.email(emailController.text) == false) {
      IZIAlert.error(message: "Email không hợp lệ");
      return;
    } else if (matHangDacTrungResponse.isEmpty) {
      IZIAlert.error(message: 'Mặt hàng đặc trưng không được để trống');
      return;
    } else if (hcmProvince == null && otherProvince == null && haNoiProvince == null && daNangProvince == null) {
      IZIAlert.error(message: 'Địa điểm cửa hàng chính không được để trống');
      return;
    } else if (hcmHuyen == null && khacHuyen == null && haNoiHuyen == null && daNangHuyen == null) {
      IZIAlert.error(message: 'Địa điểm cửa hàng chính không được để trống');
      return;
    } else if (hcmPhuong == null && khacPhuong == null && haNoiPhuong == null && daNangPhuong == null && phuongXasList.isNotEmpty && otherwards.isNotEmpty) {
      IZIAlert.error(message: 'Địa điểm cửa hàng chính không được để trống');
      return;
    } else if (addressController.text.isEmpty) {
      IZIAlert.error(message: 'Địa chỉ cụ thể không được để trống');
      return;
    } else if (startController.text.isEmpty || endController.text.isEmpty) {
      IZIAlert.error(message: 'Thời gian làm việc trong ngày không được để trống');
      return;
    } else if (double.parse(timeDiff(startController.text, endController.text)) < 0) {
      IZIAlert.error(message: 'Thời gian kết thúc phải lớn hơn thời gian bắt đầu');
      return;
    } else {
      //set data
      taiKhoanRequest.id = userId;
      taiKhoanRequest.hoTen = nameController.text;
      taiKhoanRequest.tenPhapLy = legalRepresentativeController.text;
      taiKhoanRequest.soDienThoai = phoneController.text;
      taiKhoanRequest.email = (emailController.text.isNotEmpty) ? emailController.text : "";
      taiKhoanRequest.idNhomCuaHang = nhomCuaHangResponse!.id;
      taiKhoanRequest.idMatHangDacTrungs = matHangDacTrungResponse.map((e) => e.toString()).toList();

      taiKhoanRequest.diaDiemCuThe = addressController.text;
      taiKhoanRequest.thoiGianLamViec = "${startController.text} - ${endController.text}";

      taiKhoanRequest.lamChieuThuBay = taiKhoanResponse.lamChieuThuBay;
      taiKhoanRequest.lamNgayChuNhat = taiKhoanResponse.lamNgayChuNhat;

      //set data store address
      if (groupTinhTpValue == 3) {
        taiKhoanRequest.diaDiemCuaHangChinh = "${khacPhuong ?? ''}, $khacHuyen, $otherProvince";
      } else if (groupTinhTpValue == 2) {
        taiKhoanRequest.diaDiemCuaHangChinh = "${daNangPhuong ?? ''}, $daNangHuyen, $daNangProvince";
      } else if (groupTinhTpValue == 1) {
        taiKhoanRequest.diaDiemCuaHangChinh = "${haNoiPhuong ?? ''}, $haNoiHuyen, $haNoiProvince";
      } else {
        taiKhoanRequest.diaDiemCuaHangChinh = "${hcmPhuong ?? ''}, $hcmHuyen, $hcmProvince";
      }

      if (khoHangModelList.isNotEmpty) {
        //show loading
        EasyLoading.show(status: 'loading...');

        //set data
        khoHangDaiLyRequest.idTaiKhoan = userId;

        for (var i = 0; i < khoHangModelList.length; i++) {
          //validate warehouse
          if (khoHangModelList[i].tinhTpResponse == null || khoHangModelList[i].quanHuyenResponse == null || (khoHangModelList[i].phuongXaResponse == null && khoHangModelList[i].phuongXaList!.isNotEmpty) || khoHangModelList[i].warehouseAddress!.text.isEmpty || khoHangModelList[i].warehouseName!.text.isEmpty) {
            EasyLoading.dismiss();
            IZIAlert.error(message: 'Trường địa điểm kho hàng ${i + 1} không được để trống');
            return;
          }
          //set data
          khoHangDaiLyRequest.idTinhTp = khoHangModelList[i].tinhTpResponse!.id;
          khoHangDaiLyRequest.idQuanHuyen = khoHangModelList[i].quanHuyenResponse!.id;
          if (khoHangModelList[i].phuongXaResponse != null) {
            khoHangDaiLyRequest.idPhuongXa = khoHangModelList[i].phuongXaResponse!.id;
          }
          khoHangDaiLyRequest.diaChi = khoHangModelList[i].warehouseAddress!.text;
          khoHangDaiLyRequest.ten = khoHangModelList[i].warehouseName!.text;
          khoHangDaiLyRequest.id = khoHangModelList[i].idKhoHang;
          //if warehouse already exits
          if (khoHangModelList[i].idKhoHang != null) {
            //update warehouse already exits
            khoHangDaiLyProvider.update(
              data: khoHangDaiLyRequest,
              onSuccess: (khoHangDaiLyUpdate) {
                ////show dialog
                if (khoHangModelList[i] == khoHangModelList.last) {
                  //update taiKhoan
                  taiKhoanProvider.update(
                    data: taiKhoanRequest,
                    onSuccess: (value) {},
                    onError: (error) {
                      EasyLoading.dismiss();
                      print("V3StoreInfomationController btnUpdate onError $error");
                    },
                  );
                  EasyLoading.dismiss();
                  Get.back();
                  IZIAlert.success(message: 'Cập nhật thông tin thành công');
                }
              },
              onError: (error) {
                EasyLoading.dismiss();
                print("V3StoreInfomationController khoHangDaiLyUpdate onError $error");
              },
            );
          } else {
            //add khoHang
            khoHangDaiLyProvider.add(
              data: khoHangDaiLyRequest,
              onSuccess: (khoHang) {
                ////show dialog
                if (khoHangModelList[i] == khoHangModelList.last) {
                  //update taiKhoan
                  taiKhoanProvider.update(
                    data: taiKhoanRequest,
                    onSuccess: (value) {},
                    onError: (error) {
                      EasyLoading.dismiss();
                      print("V3StoreInfomationController btnUpdate onError $error");
                    },
                  );
                  EasyLoading.dismiss();
                  Get.back();
                  IZIAlert.success(message: 'Cập nhật thông tin thành công');
                }
              },
              onError: (error) {
                EasyLoading.dismiss();
                print("V3StoreInfomationController btnUpdate onError $error");
              },
            );
          }
        }
      } else {
        //show loading
        EasyLoading.show(status: 'loading...');
        //update taiKhoan
        taiKhoanProvider.update(
          data: taiKhoanRequest,
          onSuccess: (value) {
            EasyLoading.dismiss();
            Get.back();
            IZIAlert.success(message: "Cập nhật thông tin thành công");
          },
          onError: (error) {
            EasyLoading.dismiss();
            print("V3StoreInfomationController btnUpdate onError $error");
          },
        );
      }
    }
  }

  ///
  ///convert string to timeOfDay
  ///
  String timeDiff(String tod0, String tod1) {
    final format = DateFormat.jm();
    final TimeOfDay _startTime = !tod0.contains('M') ? TimeOfDay(hour: int.parse(tod0.split(":")[0]), minute: int.parse(tod0.split(":")[1])) : TimeOfDay.fromDateTime(format.parse(tod0));
    final TimeOfDay _endTime = !tod1.contains('M') ? TimeOfDay(hour: int.parse(tod1.split(":")[0]), minute: int.parse(tod1.split(":")[1])) : TimeOfDay.fromDateTime(format.parse(tod1));
    return ((abc(_endTime) - abc(_startTime)).toStringAsFixed(2)).toString();
  }

  double abc(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
}
