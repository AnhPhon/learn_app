import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/request/dia_diem_dang_ky_lam_viec_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/dia_diem_dang_ky_lam_viec_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
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
import 'package:template/utils/app_constants.dart' as constant;

class V2WorkRegisterController extends GetxController {
  //Provider nhóm dịch vụ
  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();

  //Provider Loại công việc
  LoaiCongViecProvider loaiCongViecProvider =
      GetIt.I.get<LoaiCongViecProvider>();

  //Provider Tỉnh TP
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();

  //Provider Quận/Huyện
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();

  //Provider Phường/Xã
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();

  //Đơn dịch vụ
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  //Provider địa điểm đăng ký làm việc
  DiaDiemDangKyLamViecProvider diaDiemDangKyLamViecProvider =
      GetIt.I.get<DiaDiemDangKyLamViecProvider>();

  //Provider Đăng ký việc mới
  DangKyViecMoiProvider dangKyViecMoiProvider =
      GetIt.I.get<DangKyViecMoiProvider>();
  DangKyViecMoiResponse? dangKyViecMoiResponse;
  DangKyViecMoiResponse? checkDangKyViecMoiResponse;
  DangKyViecMoiResponse? checkDangKyViecMoiResponseNHOM_1;
  DangKyViecMoiResponse? checkDangKyViecMoiResponseNHOM_2;
  DangKyViecMoiResponse? checkDangKyViecMoiResponseNHOM_3;
  DangKyViecMoiResponse? checkDangKyViecMoiResponseNHOM_4;
  DangKyViecMoiResponse? checkDangKyViecMoiResponseNHOM_5;
  DangKyViecMoiResponse? checkDangKyViecMoiResponseNHOM_6;

  //Provider tài khoản
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  // text editing controller
  TextEditingController nhomCongViecController = TextEditingController();
  TextEditingController congViecPhuHopController = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();

  // list
  List<NhomDichVuResponse> nhomDichVu = [];
  List<LoaiCongViecResponse> congViecList = [];
  List<QuanHuyenResponse> quanHuyenHCMList = [];
  List<PhuongXaResponse>? phuongXaHCMList = [];
  List<QuanHuyenResponse>? quanHuyenHaNoiList = [];
  List<PhuongXaResponse>? phuongXaHaNoiList = [];
  List<QuanHuyenResponse>? quanHuyenDaNangList = [];
  List<PhuongXaResponse>? phuongXaDaNangList = [];
  List<QuanHuyenResponse>? quanHuyenKhacList = [];
  List<PhuongXaResponse>? phuongXaKhacList = [];
  List<TinhTpResponse>? tinhTpsKhac = [];
  List<TinhTpResponse> tinhTps = [];
  List<String?> tinhTpsSelected = [];
  List<String?> tinhTpsMultiSelected = [];

  // địa điểm đăng ký làm việc
  List<String> idDiaDiemDangKyLamViecs = [];

  // response
  QuanHuyenResponse? quanHuyenHCM;
  PhuongXaResponse? phuongXaHCM;
  QuanHuyenResponse? quanHuyenHaNoi;
  PhuongXaResponse? phuongXaHaNoi;
  QuanHuyenResponse? quanHuyenDaNang;
  PhuongXaResponse? phuongXaDaNang;
  QuanHuyenResponse? quanHuyenKhac;
  PhuongXaResponse? phuongXaKhac;
  TinhTpResponse? tinhTpKhac;
  TinhTpResponse? tinhTp;

  //Thêm model Toàn quốc, Tất cả quận/huyện, phường/xã
  TinhTpResponse toanQuoc = TinhTpResponse(id: "0", ten: "Toàn quốc");
  QuanHuyenResponse tatCaQuanHuyen = QuanHuyenResponse(ten: "Tất cả");
  PhuongXaResponse tatCaPhuongXa = PhuongXaResponse(ten: "Tất cả");

  //Id User
  String idUser = "";

  // String
  String title = "Đăng ký việc";

  final List<String> ids = [];

  // string id tương ứng khi checkbox
  String hoChiMinhId = constant.HO_CHI_MINH;
  String haNoiid = constant.HA_NOI;
  String daNangId = constant.DA_NANG;

  NhomDichVuResponse? idNhomCongViec;
  LoaiCongViecResponse? idCongViec;

  String note1 = "Nếu bạn là thầu thợ thì hãy nhấn nút đăng ký";
  String note2 =
      "Nếu bạn là ứng viên kỹ sư, cử nhân, kế toán, kinh doanh, sinh viên mới ra trường, ... thì tạo hồ sơ ứng viên dưới đây";

  String btnNote1 = 'Đăng ký';
  String btnNote2 = 'Cập nhật thông tin';

  String? btnLabel;
  String? noteLabel;

  // bool
  bool tphcmCheck = false;
  bool hanoiCheck = false;
  bool danangCheck = false;
  bool tinhKhacCheck = false;
  bool isLoading = false;
  bool isRegister = true;
  bool isLoadNhom7 = false;
  bool justOnceClick = false;

  bool isLoadingNhomDichVu = true;

  //Id mapping HCM
  String? idQuanHuyenHCMMapping;
  String? idPhuongXaHCMMapping;
  QuanHuyenResponse? idQuanHuyenHCMMappingResponse;
  PhuongXaResponse? idPhuongXaHCMMappingResponse;

  //Id mapping HN
  String? idQuanHuyenHNMapping;
  String? idPhuongXaHNMapping;
  QuanHuyenResponse? idQuanHuyenHNMappingResponse;
  PhuongXaResponse? idPhuongXaHNMappingResponse;

  //Id mapping DN
  String? idQuanHuyenDNMapping;
  String? idPhuongXaDNMapping;
  QuanHuyenResponse? idQuanHuyenDNMappingResponse;
  PhuongXaResponse? idPhuongXaDNMappingResponse;

  //Id mapping địa điểm khác
  String? idTinhKhacMapping;
  String? idQuanKhacMapping;
  String? idPhuongKhacMapping;
  TinhTpResponse? idTinhKhacMappingResponse;
  QuanHuyenResponse? idQuanKhacMappingResponse;
  PhuongXaResponse? idPhuongKhacMappingResponse;

  //Khai báo id String
  String? idCheckNhomDangKyViecMoi;
  String? idCongViecNhom;

  List<String> idDiaDiemDangKyLamViecsListPush = [];
  List<String> idDiaDiemDangKyLamViecsListSelected = [];

  //Kiểm tra nhóm 7
  bool isNhom7 = false;

  String? soLuong;
  DateTime? timeStartRegister;
  DateTime? timeEndRegister;

  bool isSortLoaiCongViec = true;
  bool stopMapping = false;
  bool firstTimeRegistered7Group = true;

  //Set const Tỉnh/Tp, Quận/Huyện, Phường/Xã
  String idHoChiMinh = "618b9df6c7817bd7985b9a07";
  String idHaNoi = "618b9e05c7817bd7985b9cc5";
  String idDaNang = "618b9e21c7817bd7985ba199";
  String idTinhToanQuoc = "61a8445b58935e5fc0cfec49";
  String idQuanHuyenTatCa = "61a8451258935e5fc0cfef9c";
  String idPhuongXaTatCa = "61a8452c58935e5fc0cfefbc";
  TinhTpResponse tinhToanQuoc = TinhTpResponse(
    id: "61a8445b58935e5fc0cfec49",
    ten: "Toàn quốc",
  );
  QuanHuyenResponse quanHuyenTatCa = QuanHuyenResponse(
    id: "61a8451258935e5fc0cfef9c",
    ten: "Tất cả",
  );
  PhuongXaResponse phuongXaTatCa = PhuongXaResponse(
    id: "61a8452c58935e5fc0cfefbc",
    ten: "Tất cả",
  );

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      idUser = value!;

      //checkDangKyViec
      checkDangKyViec();

      //Kiểm tra trạng thái đăng ky
      checkRegisterNhom7();

      //getTinhThanhBottom
      getTinhThanhBottom();
      update();
    });

    btnLabel = btnNote1;
    noteLabel = "";
    isSelected = false;
    stopMapping = false;
    firstTimeRegistered7Group = true;
  }

  ///
  ///Kiểm tra trạng thái đăng ký việc mới nhóm 7
  ///
  void checkDangKyViec() {
    EasyLoading.show(status: "Loading...");
    dangKyViecMoiProvider.paginate(
      page: 1,
      limit: 1,
      filter: "&idTaiKhoan=$idUser",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          isRegister = false;

          checkDangKyViecMoiResponse = models.first;

          if (checkDangKyViecMoiResponse!.idNhomDichVu!.id.toString() ==
              constant.NHOM_DICH_VU_7) {
            isNhom7 = true;

            //Save id Đăng ký việc mới
            sl
                .get<SharedPreferenceHelper>()
                .saveViecMoi(id: checkDangKyViecMoiResponse!.id.toString());
            btnLabel = btnNote2;
            noteLabel = "";
          } else {
            isNhom7 = false;
            //Save id Đăng ký việc mới
            sl
                .get<SharedPreferenceHelper>()
                .saveViecMoi(id: checkDangKyViecMoiResponse!.id.toString());

            btnLabel = btnNote1;
            noteLabel = "";
          }

          //Mapping thời gian bắt đầu
          if (checkDangKyViecMoiResponse!.thoiGianBatDau != null &&
              checkDangKyViecMoiResponse!.thoiGianBatDau.toString() != "null") {
            timeStartController = TextEditingController(
                text: DateConverter.formatDateTime(
                    checkDangKyViecMoiResponse!.thoiGianBatDau.toString()));
          } else {
            timeStartController = TextEditingController();
          }

          //Mapping thời gian kết thúc
          if (checkDangKyViecMoiResponse!.thoiGianKetThuc != null &&
              checkDangKyViecMoiResponse!.thoiGianKetThuc.toString() !=
                  "null") {
            timeEndController = TextEditingController(
                text: DateConverter.formatDateTime(
                    checkDangKyViecMoiResponse!.thoiGianKetThuc.toString()));
          } else {
            timeEndController = TextEditingController();
          }

          //Mapping số lượng
          if (checkDangKyViecMoiResponse!.soLuong != null &&
              checkDangKyViecMoiResponse!.soLuong.toString() != "null") {
            soLuongController = TextEditingController(
                text: checkDangKyViecMoiResponse!.soLuong);
          } else {
            soLuongController = TextEditingController();
          }

          ///
          ///Địa điểm đăng ký làm Việc
          ///

          if (checkDangKyViecMoiResponse!.idDiaDiemDangKyLamViecs!.isNotEmpty) {
            for (final idDiaDiemDangKyLamViecs in checkDangKyViecMoiResponse!
                .idDiaDiemDangKyLamViecs!
                .toList()) {
              diaDiemDangKyLamViecProvider.find(
                id: idDiaDiemDangKyLamViecs.id.toString(),
                onSuccess: (models) {
                  if (models.idTinhTp!.id.toString() == hoChiMinhId) {
                    tphcmCheck = true;
                    isEnableHCM = true;

                    //Gán Id quận huyện HCM để Mapping

                    idQuanHuyenHCMMappingResponse = models.idQuanHuyen;

                    //Gán Id phường xã HCM để Mapping
                    idPhuongXaHCMMappingResponse = models.idPhuongXa;

                    getQuanHuyenHCM();
                  } else if (models.idTinhTp!.id.toString() == haNoiid) {
                    hanoiCheck = true;
                    isEnableHN = true;

                    //Gán Id quận huyện HN để Mapping
                    idQuanHuyenHNMappingResponse = models.idQuanHuyen;

                    //Gán Id phường xã HN để Mapping
                    idPhuongXaHNMappingResponse = models.idPhuongXa;

                    getQuanHuyenHaNoi();
                  } else if (models.idTinhTp!.id.toString() == daNangId) {
                    danangCheck = true;
                    isEnableDN = true;

                    //Gán Id quận huyện DN để Mapping
                    idQuanHuyenDNMappingResponse = models.idQuanHuyen;

                    //Gán Id phường xã DN để Mapping
                    if (models.idPhuongXa != null) {
                      if (models.idQuanHuyen!.ten.toString().toLowerCase() !=
                          "hoàng sa") {
                        idPhuongXaDNMappingResponse = models.idPhuongXa;
                      }
                    }

                    getQuanHuyenDaNang();
                  } else if (models.idTinhTp!.id.toString().toLowerCase() !=
                          hoChiMinhId &&
                      models.idTinhTp!.id.toString() != haNoiid &&
                      models.idTinhTp!.id.toString().toLowerCase() !=
                          daNangId &&
                      models.idQuanHuyen != null &&
                      models.idPhuongXa != null) {
                    tinhKhacCheck = true;
                    isEnableTK = true;

                    //Gán Id Tỉnh/Tp KHÁC để Mapping
                    idTinhKhacMappingResponse = models.idTinhTp;

                    //Gán Id Quận/Huyện KHÁC để Mapping
                    idQuanKhacMappingResponse = models.idQuanHuyen;

                    //Gán Id phường xã KHÁC để Mapping
                    if (models.idPhuongXa != null) {
                      if (models.idQuanHuyen!.ten.toString().toLowerCase() !=
                          "hoàng sa") {
                        idPhuongKhacMappingResponse = models.idPhuongXa;
                      }
                    }
                    getTinhThanh();
                  } else if (models.idTinhTp!.id.toString().toLowerCase() !=
                          hoChiMinhId &&
                      models.idTinhTp!.id.toString() != haNoiid &&
                      models.idTinhTp!.id.toString().toLowerCase() !=
                          daNangId &&
                      models.idQuanHuyen == null &&
                      models.idPhuongXa == null &&
                      models.idTinhTp != idTinhKhacMappingResponse) {
                    tinhTpsSelected.add(models.idTinhTp!.id.toString());

                    tinhKhacCheck = false;
                  }

                  // update();
                },
                onError: (error) {
                  print(
                      "TermsAndPolicyController getTermsAndPolicy onError $error");
                },
              );
            }
          }
        } else {
          //Set thời gian bắt đầu mặc định
          timeStartController = TextEditingController();

          //Set thời gian kết thúc mặc định
          timeEndController = TextEditingController();

          //Set số lượng mặc định
          soLuongController = TextEditingController();
        }

        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    update();
  }

  ///
  /// Get nhóm dich vụ
  ///
  void getNhomDichVu() {
    isLoadingNhomDichVu = true;
    // load tất cả các nhóm công việc có thể có
    nhomDichVuProvider.all(onSuccess: (data) {
      // xét trạng thái đã load xong nhóm công việc
      nhomDichVu.clear();

      // check data có rỗng không
      if (data.isNotEmpty) {
        for (final nhomDichVuModel in data) {
          if (nhomDichVuModel.id != constant.NHOM_DICH_VU_8) {
            nhomDichVu.add(nhomDichVuModel);
          }
        }

        //Mapping đăng ký việc Mới
        if (checkDangKyViecMoiResponse != null) {
          if (checkDangKyViecMoiResponse!.idNhomDichVu != null) {
            idNhomCongViec = nhomDichVu[nhomDichVu.indexWhere(
                (e) => e.id == checkDangKyViecMoiResponse!.idNhomDichVu!.id)];
          } else {
            idNhomCongViec = nhomDichVu.first;
          }
        } else {
          idNhomCongViec = nhomDichVu.first;
        }
      }
      isLoadingNhomDichVu = false;

      //getLoaiCongViec
      getLoaiCongViec(dichvu: idNhomCongViec!);
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
        congViecList.clear();
        if (dichvu.id == constant.NHOM_DICH_VU_1) {
          isSortLoaiCongViec = false;
        } else {
          isSortLoaiCongViec = true;
        }
        if (data.isNotEmpty) {
          // load all data

          congViecList = data;

          //Mapping đăng ký việc Mới
          if (dichvu.id.toString() == constant.NHOM_DICH_VU_7 &&
              stopMapping == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (checkDangKyViecMoiResponse!.idLoaiCongViec != null) {
                idCongViec = congViecList[congViecList.indexWhere((e) =>
                    e.id == checkDangKyViecMoiResponse!.idLoaiCongViec!.id)];
              } else {
                idCongViec = congViecList.first;
              }
            } else {
              idCongViec = congViecList.first;
            }
          } else if (dichvu.id.toString() == constant.NHOM_DICH_VU_1 &&
              stopMapping == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (checkDangKyViecMoiResponse!.idLoaiCongViec != null) {
                idCongViec = congViecList[congViecList.indexWhere((e) =>
                    e.id == checkDangKyViecMoiResponse!.idLoaiCongViec!.id)];
              } else {
                idCongViec = congViecList.first;
              }
            } else {
              idCongViec = congViecList.first;
            }
          } else if (dichvu.id.toString() == constant.NHOM_DICH_VU_2 &&
              stopMapping == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (checkDangKyViecMoiResponse!.idLoaiCongViec != null) {
                idCongViec = congViecList[congViecList.indexWhere((e) =>
                    e.id == checkDangKyViecMoiResponse!.idLoaiCongViec!.id)];
              } else {
                idCongViec = congViecList.first;
              }
            } else {
              idCongViec = congViecList.first;
            }
          } else if (dichvu.id.toString() == constant.NHOM_DICH_VU_3 &&
              stopMapping == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (checkDangKyViecMoiResponse!.idLoaiCongViec != null) {
                idCongViec = congViecList[congViecList.indexWhere((e) =>
                    e.id == checkDangKyViecMoiResponse!.idLoaiCongViec!.id)];
              } else {
                idCongViec = congViecList.first;
              }
            } else {
              idCongViec = congViecList.first;
            }
          } else if (dichvu.id.toString() == constant.NHOM_DICH_VU_4 &&
              stopMapping == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (checkDangKyViecMoiResponse!.idLoaiCongViec != null) {
                idCongViec = congViecList[congViecList.indexWhere((e) =>
                    e.id == checkDangKyViecMoiResponse!.idLoaiCongViec!.id)];
              } else {
                idCongViec = congViecList.first;
              }
            } else {
              idCongViec = congViecList.first;
            }
          } else if (dichvu.id.toString() == constant.NHOM_DICH_VU_5 &&
              stopMapping == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (checkDangKyViecMoiResponse!.idLoaiCongViec != null) {
                idCongViec = congViecList[congViecList.indexWhere((e) =>
                    e.id == checkDangKyViecMoiResponse!.idLoaiCongViec!.id)];
              } else {
                idCongViec = congViecList.first;
              }
            } else {
              idCongViec = congViecList.first;
            }
          } else if (dichvu.id.toString() == constant.NHOM_DICH_VU_6 &&
              stopMapping == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (checkDangKyViecMoiResponse!.idLoaiCongViec != null) {
                idCongViec = congViecList[congViecList.indexWhere((e) =>
                    e.id == checkDangKyViecMoiResponse!.idLoaiCongViec!.id)];
              } else {
                idCongViec = congViecList.first;
              }
            } else {
              idCongViec = congViecList.first;
            }
          } else {
            idCongViec = congViecList.first;
          }
        }
        if (tinhTpKhac != null) {
          if (tinhTpKhac!.ten.toString().toLowerCase() != "toàn quốc") {
            getTinhThanhBottom();
          } else {
            tinhTps.clear();
          }
        } else {
          getTinhThanhBottom();
        }
        EasyLoading.dismiss();
        update();
      },
      onError: (error) {
        print("CreateWorkController getLoaiCongViec onError $error");
        update();
      },
    );
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    tinhTpKhac = tinhTp;
    quanHuyenKhac = null;
    phuongXaKhac = null;
    phuongXaKhacList!.clear();
    quanHuyenKhacList!.clear();
    getQuanHuyenKhac(
        filter: "&idTinhTp=${tinhTpKhac!.id.toString()}",
        tinhTpResponseToanQuoc: tinhTpKhac!.ten.toString().toLowerCase());

    idDiaDiemDangKyLamViecs.clear();
    if (tinhKhacCheck == true) {
      idDiaDiemDangKyLamViecs.add(tinhTpKhac!.id!);
    }
    if (tphcmCheck == true) {
      idDiaDiemDangKyLamViecs.add(hoChiMinhId);
    }
    if (hanoiCheck == true) {
      idDiaDiemDangKyLamViecs.add(haNoiid);
    }
    if (danangCheck == true) {
      idDiaDiemDangKyLamViecs.add(daNangId);
    }
    if (tinhTpKhac!.ten.toString().toLowerCase() != "toàn quốc") {
      getTinhThanhBottomRemoveTinhTPKhac(tinhTpsRemove: tinhTpKhac!);
    } else {
      tinhTps.clear();
      getQuanHuyenKhac(
          filter: "&idTinhTp=${tinhTpKhac!.id.toString()}",
          tinhTpResponseToanQuoc: tinhTpKhac!.ten.toString().toLowerCase());
    }
    isSelected = true;
    tinhTpKhacParam = tinhTpKhac!.id.toString();
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanhBottom(TinhTpResponse tinhTp) {
    tinhTpKhac = tinhTp;
    quanHuyenKhac = null;
    phuongXaKhac = null;
    phuongXaKhacList!.clear();
    quanHuyenKhacList!.clear();
    isSelected = true;
    update();
  }

  ///
  ///Thay đổi quận huyện hồ chí minh
  ///
  void onChangedQuanHuyenHCM(QuanHuyenResponse huyen) {
    quanHuyenHCM = huyen;
    phuongXaHCMList!.clear();
    phuongXaHCM = null;
    getPhuongXa(1, filter: "&idQuanHuyen=${quanHuyenHCM!.id}");
    isSelected = true;
    isEnableHCM = true;
    quanHuyenHoChiMinhParam = quanHuyenHCM!.id.toString();
    update();
  }

  ///
  ///Thay đổi quận huyện hà nội
  ///
  void onChangedQuanHuyenHaNoi(QuanHuyenResponse huyen) {
    quanHuyenHaNoi = huyen;
    phuongXaHaNoiList!.clear();
    phuongXaHaNoi = null;
    getPhuongXa(2, filter: "&idQuanHuyen=${quanHuyenHaNoi!.id}");
    isSelected = true;
    isEnableHN = true;
    quanHuyenHaNoiParam = quanHuyenHaNoi!.id.toString();
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyenDaNang(QuanHuyenResponse huyen) {
    quanHuyenDaNang = huyen;
    phuongXaDaNangList!.clear();
    phuongXaDaNang = null;
    getPhuongXa(3, filter: "&idQuanHuyen=${quanHuyenDaNang!.id}");
    isSelected = true;
    isEnableDN = true;
    quanHuyenDaNangParam = quanHuyenDaNang!.id.toString();
    update();
  }

  ///
  ///Thay đổi phường xã khác
  ///
  void onChangedQuanHuyenKhac(QuanHuyenResponse huyen) {
    quanHuyenKhac = huyen;
    phuongXaKhacList!.clear();
    phuongXaKhac = null;
    getPhuongXa(4,
        filter: "&idQuanHuyen=${quanHuyenKhac!.id}",
        quanHuyenTatCa: quanHuyenKhac!.ten.toString().toLowerCase());
    isSelected = true;
    isEnableTK = true;
    quanHuyenKhacParam = quanHuyenKhac!.id.toString();
    update();
  }

  ///
  ///Thay đổi phường xã hồ chí minh
  ///
  void onChangedPhuongXaHCM(PhuongXaResponse phuong) {
    phuongXaHCM = phuong;
    isSelected = true;
    isEnableHCM = true;
    phuongXaHoChiMinhParam = phuongXaHCM!.id.toString();
    update();
  }

  ///
  ///Thay đổi phường xã hà nội
  ///
  void onChangedPhuongXaHaNoi(PhuongXaResponse phuong) {
    phuongXaHaNoi = phuong;
    isSelected = true;
    isEnableHN = true;
    phuongXaHaNoiParam = phuongXaHaNoi!.id.toString();
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedPhuongXaDaNang(PhuongXaResponse phuong) {
    phuongXaDaNang = phuong;
    isSelected = true;
    isEnableDN = true;
    phuongXaDaNangParam = phuongXaDaNang!.id.toString();
    update();
  }

  ///
  ///Thay đổi phường xã khác
  ///
  void onChangedPhuongXaKhac(PhuongXaResponse phuong) {
    phuongXaKhac = phuong;
    isSelected = true;
    isEnableTK = true;
    phuongXaKhacParam = phuongXaKhac!.id.toString();
    update();
  }

  ///
  /// check is register
  ///
  void checkRegisterNhom7() {
    // get đăng ký việc kiểm tra đã có đăng ký chưa
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 30,
        filter: "&idTaiKhoan=$userId&idNhomDichVu=${constant.NHOM_DICH_VU_7}",
        onSuccess: (data) {
          if (data.isNotEmpty) {
            firstTimeRegistered7Group = true;
          } else {
            firstTimeRegistered7Group = false;
          }

          // load nhom cong viec phu hop
          getNhomDichVu();
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController checkRegister onError $error");
        },
      );
    });
  }

  ///
  /// on nhom cong viec phu hop change
  ///
  void onNhomCongViecChange(NhomDichVuResponse? value) {
    idNhomCongViec = value;
    stopMapping = true;
    getLoaiCongViec(dichvu: value!);
    idNhomCongViecParam = idNhomCongViec!.id.toString();
    if (value.id.toString() == constant.NHOM_DICH_VU_7) {
      btnLabel = btnNote2;
      noteLabel = "";
      sl.get<SharedPreferenceHelper>().saveNhom7(id: true);
      isNhom7 = true;

      // check với userid và nhomDichVu la 7 tồn tại data không
      // tồn tại là cập nhật ngược lại là đăng ký
      sl.get<SharedPreferenceHelper>().userId.then((userId) {
        dangKyViecMoiProvider.paginate(
          page: 1,
          limit: 30,
          filter: "&idTaiKhoan=$idUser&idNhomDichVu=${constant.NHOM_DICH_VU_7}",
          onSuccess: (data) {
            if (data.isNotEmpty) {
              sl.get<SharedPreferenceHelper>().saveViecMoi(id: data.first.id!);
              update();
            }
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      });
    } else {
      btnLabel = btnNote1;
      noteLabel = "";
      isNhom7 = false;
      update();
    }
    update();
  }

  ///
  /// on nhom cong viec phu hop change
  ///
  void onCongViecChange(LoaiCongViecResponse? value) {
    idCongViec = value;
    stopMapping = true;
    idLoaiCongViecParam = idCongViec!.id.toString();
    update();
  }

  ///
  /// Load tất cả tỉnh thành phố
  ///
  void getTinhThanh() {
    tinhTpsKhac = [];
    tinhTpProvider.all(onSuccess: (responses) {
      if (tinhKhacCheck == true) {
        tinhTpsKhac = responses;
        tinhTpsKhac!.removeAt(tinhTpsKhac!.length - 1);
        tinhTpsKhac!.removeWhere((e) => e.id == idHoChiMinh);
        tinhTpsKhac!.removeWhere((e) => e.id == idHaNoi);
        tinhTpsKhac!.removeWhere((e) => e.id == idDaNang);
        tinhTpsKhac!.insert(0, tinhToanQuoc);
        if (tinhTpsKhac!.isNotEmpty) {
          if (checkDangKyViecMoiResponse != null) {
            if (idTinhKhacMappingResponse != null) {
              tinhTpKhac = tinhTpsKhac!.firstWhere(
                  (e) => e.id == idTinhKhacMappingResponse!.id.toString());
              idDiaDiemDangKyLamViecs.add(tinhTpKhac!.id!);
              getQuanHuyenKhac(
                  filter: "&idTinhTp=${tinhTpKhac!.id}",
                  tinhTpResponseToanQuoc:
                      tinhTpKhac!.ten.toString().toLowerCase());
            }
          }
        }
      }

      update();
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
    });
  }

  ///
  /// Load tất cả tỉnh thành phố
  ///
  void getTinhThanhBottom() {
    tinhTps.clear();
    tinhTpProvider.all(onSuccess: (responses) {
      for (final model in responses) {
        if (model.id.toString() != hoChiMinhId &&
            model.id.toString() != haNoiid &&
            model.id.toString() != daNangId) {
          tinhTps.add(model);
        }
      }

      isLoading = false;
      update();
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
    });
  }

  ///
  /// Load tất cả tỉnh thành phố
  ///
  void getTinhThanhBottomRemoveTinhTPKhac(
      {required TinhTpResponse tinhTpsRemove}) {
    EasyLoading.show(status: 'Loading...');
    tinhTps.clear();
    tinhTpProvider.all(onSuccess: (responses) {
      for (final model in responses) {
        if (model.id.toString() != hoChiMinhId &&
            model.id.toString() != haNoiid &&
            model.id.toString() != daNangId &&
            model.id.toString() != tinhTpsRemove.id) {
          tinhTps.add(model);
        }
      }

      EasyLoading.dismiss();
      update();
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
    });
  }

  ///
  /// Load tất cả quận huyện của hồ chí minh
  ///
  void getQuanHuyenHCM() {
    quanHuyenHCMList.clear();
    quanHuyenProvider.paginate(
      page: 1,
      limit: 30,
      filter: '&idTinhTp=$hoChiMinhId',
      onSuccess: (responses) {
        quanHuyenHCMList = responses;
        if (quanHuyenHCMList.isNotEmpty) {
          if (isSelected == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (idQuanHuyenHCMMappingResponse != null) {
                quanHuyenHCM = quanHuyenHCMList.firstWhere((e) =>
                    e.id == idQuanHuyenHCMMappingResponse!.id.toString());
                getPhuongXa(1, filter: "&idQuanHuyen=${quanHuyenHCM!.id!}");
              }
            }
          }
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Load tất cả quận huyện của hồ chí minh
  ///
  void getQuanHuyenHaNoi() {
    quanHuyenHaNoiList!.clear();
    quanHuyenProvider.paginate(
      page: 1,
      limit: 30,
      filter: '&idTinhTp=$HA_NOI',
      onSuccess: (responses) {
        quanHuyenHaNoiList = responses;
        if (quanHuyenHaNoiList!.isNotEmpty) {
          if (isSelected == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (idQuanHuyenHNMappingResponse != null) {
                quanHuyenHaNoi = quanHuyenHaNoiList!.firstWhere(
                    (e) => e.id == idQuanHuyenHNMappingResponse!.id.toString());

                getPhuongXa(2, filter: "&idQuanHuyen=${quanHuyenHaNoi!.id!}");
              }
            }
          }
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Load tất cả quận huyện của hồ chí minh
  ///
  void getQuanHuyenDaNang() {
    quanHuyenDaNangList!.clear();
    quanHuyenProvider.paginate(
      page: 1,
      limit: 30,
      filter: '&idTinhTp=$daNangId',
      onSuccess: (responses) {
        quanHuyenDaNangList = responses;
        if (quanHuyenDaNangList!.isNotEmpty) {
          if (isSelected == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (idQuanHuyenDNMappingResponse != null) {
                quanHuyenDaNang = quanHuyenDaNangList!.firstWhere(
                    (e) => e.id == idQuanHuyenDNMappingResponse!.id.toString());
                getPhuongXa(3, filter: "&idQuanHuyen=${quanHuyenDaNang!.id!}");
              }
            }
          }
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Load tất cả quận huyện của hồ chí minh
  ///
  void getQuanHuyenKhac(
      {String? filter = '', required String tinhTpResponseToanQuoc}) {
    quanHuyenKhacList!.clear();
    quanHuyenProvider.paginate(
      page: 1,
      limit: 30,
      filter: filter!,
      onSuccess: (responses) {
        quanHuyenKhacList!.addAll(responses);
        if (tinhTpResponseToanQuoc.toLowerCase() != "toàn quốc") {
          quanHuyenKhacList!.insert(0, quanHuyenTatCa);
        }

        if (quanHuyenKhacList!.isNotEmpty) {
          if (isSelected == false) {
            if (checkDangKyViecMoiResponse != null) {
              if (idQuanKhacMappingResponse != null) {
                quanHuyenKhac = quanHuyenKhacList!.firstWhere(
                    (e) => e.id == idQuanKhacMappingResponse!.id.toString());
                getPhuongXa(4,
                    filter: "&idQuanHuyen=${quanHuyenKhac!.id}",
                    quanHuyenTatCa:
                        quanHuyenKhac!.ten.toString().toLowerCase());
              }
            }
          }
        }
        if (tinhTpResponseToanQuoc.toLowerCase() == "toàn quốc") {
          quanHuyenKhac = quanHuyenKhacList!.first;
          getPhuongXa(4,
              filter: "&idQuanHuyen=${quanHuyenKhac!.id}",
              quanHuyenTatCa: quanHuyenKhac!.ten.toString().toLowerCase());
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Load tất cả phường xa
  ///
  void getPhuongXa(int index, {String? filter = '', String? quanHuyenTatCa}) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 30,
      filter: filter!,
      onSuccess: (responses) {
        if (index == 1) {
          phuongXaHCMList = responses;
          if (isSelected == false) {
            if (phuongXaHCMList!.isNotEmpty) {
              if (checkDangKyViecMoiResponse != null) {
                if (idPhuongXaHCMMappingResponse != null) {
                  phuongXaHCM = phuongXaHCMList!.firstWhere((e) =>
                      e.id == idPhuongXaHCMMappingResponse!.id.toString());
                }
              }
            }
          }
        }

        if (index == 2) {
          phuongXaHaNoiList = responses;
          if (phuongXaHaNoiList!.isNotEmpty) {
            if (isSelected == false) {
              if (checkDangKyViecMoiResponse != null) {
                if (idPhuongXaHNMappingResponse != null) {
                  phuongXaHaNoi = phuongXaHaNoiList!.firstWhere((e) =>
                      e.id == idPhuongXaHNMappingResponse!.id.toString());
                }
              }
            }
          }
        }

        if (index == 3) {
          phuongXaDaNangList = responses;
          if (phuongXaDaNangList!.isNotEmpty) {
            if (isSelected == false) {
              if (checkDangKyViecMoiResponse != null) {
                if (idPhuongXaDNMappingResponse != null) {
                  phuongXaDaNang = phuongXaDaNangList!.firstWhere((e) =>
                      e.id == idPhuongXaDNMappingResponse!.id.toString());
                }
              }
            }
          }
        }

        if (index == 4) {
          phuongXaKhacList = responses;
          if (quanHuyenTatCa!.toLowerCase() != "tất cả") {
            phuongXaKhacList!.insert(0, phuongXaTatCa);
          } else {
            phuongXaKhac = phuongXaKhacList!.first;
          }
          if (phuongXaKhacList!.isNotEmpty) {
            if (isSelected == false) {
              if (checkDangKyViecMoiResponse != null) {
                if (idPhuongKhacMappingResponse != null) {
                  phuongXaKhac = phuongXaKhacList!.firstWhere((e) =>
                      e.id == idPhuongKhacMappingResponse!.id.toString());
                }
              }
            }
          }
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  bool isSelected = false;
  bool isEnableHCM = false;
  bool isEnableHN = false;
  bool isEnableDN = false;
  bool isEnableTK = false;

  ///
  /// change checkbox
  ///
  void checkboxChange(int index, {required bool val}) {
    if (index == 1) {
      isSelected = true;
      update();
      tphcmCheck = val;
      if (val == false) {
        isEnableHCM = false;
        quanHuyenHCMList = [];
        phuongXaHCMList = [];
        quanHuyenHCM = null;
        phuongXaHCM = null;
        idDiaDiemDangKyLamViecs.remove(hoChiMinhId);
      } else {
        idDiaDiemDangKyLamViecs.add(hoChiMinhId);

        getQuanHuyenHCM();
        isEnableHCM = true;
      }

      if (tinhKhacCheck == true) {
        idDiaDiemDangKyLamViecs.remove(tinhTpKhac!.id);
      }
    }

    if (index == 2) {
      hanoiCheck = val;
      isSelected = true;
      update();
      if (val == false) {
        isEnableHN = false;
        quanHuyenHaNoiList = [];
        phuongXaHaNoiList = [];
        quanHuyenHaNoi = null;
        phuongXaHaNoi = null;
        idDiaDiemDangKyLamViecs.remove(haNoiid);
      } else {
        isEnableHN = true;
        idDiaDiemDangKyLamViecs.add(haNoiid);
        getQuanHuyenHaNoi();
      }

      if (tinhKhacCheck == true) {
        idDiaDiemDangKyLamViecs.remove(tinhTpKhac!.id);
      }
    }

    if (index == 3) {
      danangCheck = val;
      isSelected = true;
      update();
      if (val == false) {
        isEnableDN = false;
        quanHuyenDaNangList = [];
        phuongXaDaNangList = [];
        quanHuyenDaNang = null;
        phuongXaDaNang = null;
        idDiaDiemDangKyLamViecs.remove(daNangId);
      } else {
        isEnableDN = true;
        idDiaDiemDangKyLamViecs.add(daNangId);
        getQuanHuyenDaNang();
      }

      if (tinhKhacCheck == true) {
        idDiaDiemDangKyLamViecs.remove(tinhTpKhac!.id);
      }
    }

    if (index == 4) {
      tinhKhacCheck = val;
      isSelected = true;
      update();
      if (val == false) {
        isEnableTK = false;
        tinhTpsKhac = [];
        quanHuyenKhacList = [];
        phuongXaKhacList = [];
        phuongXaKhac = null;
        quanHuyenKhac = null;
        if (tinhTpKhac != null) {
          idDiaDiemDangKyLamViecs.remove(tinhTpKhac!.id);
        }

        tinhTpKhac = null;
      } else {
        isEnableTK = true;
        getTinhThanh();
      }
    }

    update();
  }

  //Khai báo để truyền param HoChiMinh
  String? quanHuyenHoChiMinhParam;
  String? phuongXaHoChiMinhParam;

  //Khai báo để truyền param HaNoi
  String? quanHuyenHaNoiParam;
  String? phuongXaHaNoiParam;

  //Khai báo để truyền param DaNang
  String? quanHuyenDaNangParam;
  String? phuongXaDaNangParam;

  //Khai báo để truyền param Tinh/Tp khác
  String? tinhTpKhacParam;
  String? quanHuyenKhacParam;
  String? phuongXaKhacParam;

  String? idNhomCongViecParam;
  String? idLoaiCongViecParam;

  ///
  /// on register click
  ///
  void onRegisterClick() {
    if (_validate() && justOnceClick == false) {
      timeStartRegister = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(timeStartController.text)
          .toString()
          .substring(0, 10));
      if (timeEndController.text != null && timeEndController.text.isNotEmpty) {
        timeEndRegister = DateTime.parse(DateFormat('dd-MM-yyyy')
            .parse(timeEndController.text)
            .toString()
            .substring(0, 10));
      } else {
        timeEndRegister = null;
      }

      if (soLuongController.text.isNotEmpty) {
        soLuong = soLuongController.text;
      } else {
        soLuong = null;
      }
      if (firstTimeRegistered7Group == false) {
        // Gán data để truyền
        final Map<String, dynamic> param = {
          "idNhomDichVuParam": idNhomCongViecParam,
          "idLoaiCongViecVuParam": idLoaiCongViecParam,
          "thoiGianBatDauParam": timeStartRegister.toString(),
          "thoiKetThucDauParam": timeEndRegister.toString(),
          "soLuongParam": soLuong,

          //Hồ chí minh
          "isCheckHCM": tphcmCheck,
          "quanHuyenHoChiMinhParam": quanHuyenHoChiMinhParam,
          "phuongXaHoChiMinhParam": phuongXaHoChiMinhParam,

          // //Hà nội
          "isCheckHN": hanoiCheck,
          "quanHuyenHaNoiParam": quanHuyenHaNoiParam,
          "phuongXaHaNoiParam": phuongXaHaNoiParam,

          // //Đà nẵng
          "isCheckDN": danangCheck,
          "quanHuyenDaNangParam": quanHuyenDaNangParam,
          "phuongXaDaNangParam": phuongXaDaNangParam,

          // //Tỉnh Tp/khác
          "isCheckTinhTPKhac": tinhKhacCheck,
          "tinhTpKhacParam": tinhTpKhacParam,
          "quanHuyenKhacParam": quanHuyenKhacParam,
          "phuongXaKhacParam": phuongXaKhacParam,

          //List địa điểm khác
          "listDiaDiemKhac": tinhTpsSelected,
        };

        Get.toNamed(AppRoutes.V2_WORK_CREATE, arguments: param)!.then((value) {
          if (value != null && value == true) {
            Get.back();
            update();
          }
        });
      } else {
        if (isRegister == true) {
// get user id
          sl.get<SharedPreferenceHelper>().userId.then((userId) {
            taiKhoanProvider.find(
              id: userId!,
              onSuccess: (taiKhoan) {
                final dangKyViecMoiRequest = DangKyViecMoiRequest(
                  idTaiKhoan: userId,
                  idNhomDichVu: idNhomCongViec!.id.toString(),
                  idLoaiCongViec: idCongViec!.id.toString(),
                  soLuong: soLuong,
                  thoiGianBatDau: timeStartRegister.toString(),
                  tenUngVien: taiKhoan.hoTen,
                  gioiTinh: taiKhoan.gioiTinh,
                  ngaySinh: taiKhoan.ngaySinh,
                  email: taiKhoan.email,
                  diaChi: taiKhoan.diaChi,
                );
                if (timeEndController.text != null &&
                    timeEndController.text.isNotEmpty) {
                  dangKyViecMoiRequest.thoiGianKetThuc =
                      timeEndRegister.toString();
                }
                // đăng ký việc mới
                dangKyViecMoiProvider.add(
                  data: dangKyViecMoiRequest,
                  onSuccess: (data) {
                    themDiaDiemDangKyLamViec(data.id!);

                    // save id
                    sl
                        .get<SharedPreferenceHelper>()
                        .saveViecMoi(id: data.id.toString());

                    // update thông tin địa điểm sau khi tạo
                    Future.delayed(const Duration(milliseconds: 500))
                        .then((value) {
                      updateDiaDiem(data.id!);

                      IZIAlert.success(message: "Thêm thành công!");

                      if (isNhom7 == true) {
                        Get.toNamed(AppRoutes.V2_WORK_CREATE)!.then((value) {
                          if (value != null && value == true) {
                            Get.back();
                            update();
                          }
                        });
                      } else {
                        Get.back();
                      }
                    });
                    update();
                  },
                  onError: (error) {
                    print(
                        "TermsAndPolicyController getTermsAndPolicy onError $error");
                  },
                );
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
          });
        } else {
          // get user id
          sl.get<SharedPreferenceHelper>().userId.then((userId) {
            taiKhoanProvider.find(
              id: userId!,
              onSuccess: (taiKhoan) async {
                idCheckNhomDangKyViecMoi =
                    await sl.get<SharedPreferenceHelper>().viecMoi;

                dangKyViecMoiProvider.find(
                  id: idCheckNhomDangKyViecMoi!,
                  onSuccess: (model) async {
                    dangKyViecMoiResponse = model;
                    final dangKyViecMoiRequest = DangKyViecMoiRequest(
                      id: idCheckNhomDangKyViecMoi,
                      idTaiKhoan: userId,
                      idNhomDichVu: idNhomCongViec!.id.toString(),
                      idLoaiCongViec: idCongViec!.id.toString(),
                      soLuong: soLuong,
                      thoiGianBatDau: timeStartRegister.toString(),
                      tieuDe: dangKyViecMoiResponse!.tieuDe,
                      tenUngVien: taiKhoan.hoTen,
                      gioiTinh: taiKhoan.gioiTinh,
                      ngaySinh: taiKhoan.ngaySinh,
                      email: taiKhoan.email,
                    );
                    if (timeEndController.text != null &&
                        timeEndController.text.isNotEmpty) {
                      dangKyViecMoiRequest.thoiGianKetThuc =
                          timeEndRegister.toString();
                    }
                    // đăng ký việc mới
                    dangKyViecMoiProvider.update(
                      data: dangKyViecMoiRequest,
                      onSuccess: (data) {
                        themDiaDiemDangKyLamViec(data.id!);
                        // save id
                        sl
                            .get<SharedPreferenceHelper>()
                            .saveViecMoi(id: data.id.toString());

                        // update thông tin địa điểm sau khi tạo
                        Future.delayed(const Duration(milliseconds: 500))
                            .then((value) {
                          updateDiaDiem(data.id!);
                          IZIAlert.success(message: "Cập nhập thành công!");
                          if (isNhom7 == true) {
                            Get.toNamed(AppRoutes.V2_WORK_CREATE)!
                                .then((value) {
                              if (value != null && value == true) {
                                Get.back();

                                update();
                              }
                            });
                          } else {
                            Get.back();
                          }
                        });
                        update();
                      },
                      onError: (error) {
                        print(
                            "TermsAndPolicyController getTermsAndPolicy onError $error");
                      },
                    );
                    update();
                  },
                  onError: (error) {
                    print(
                        "TermsAndPolicyController getTermsAndPolicy onError $error");
                  },
                );
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
          });
        }
      }

      justOnceClick = true;
      update();
    }
  }

  ///
  /// thêm địa điểm đăng ký làm việc
  ///
  void themDiaDiemDangKyLamViec(String viecMoiId) {
    // validate ít nhất phải chọn một nơi làm việc
    if (checkProvince()) {
      IZIAlert.error(message: "Cần ít nhất một nơi làm việc!");
    } else {
      if (tphcmCheck) {
        diaDiemDangKyLamViecProvider.add(
          data: DiaDiemDangKyLamViecRequest(
            idQuanHuyen: quanHuyenHCM != null
                ? quanHuyenHCM!.id!
                : "616a5d88000118120619cb91",
            idPhuongXa: phuongXaHCM != null
                ? phuongXaHCM!.id
                : "61694d453391622ae9202d81",
            idTinhTp: hoChiMinhId,
          ),
          onSuccess: (data) {
            idDiaDiemDangKyLamViecsListPush.add(data.id.toString());

            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }

      if (hanoiCheck) {
        diaDiemDangKyLamViecProvider.add(
          data: DiaDiemDangKyLamViecRequest(
            idQuanHuyen: quanHuyenHaNoi!.id,
            idPhuongXa: phuongXaHaNoi!.id,
            idTinhTp: haNoiid,
          ),
          onSuccess: (data) {
            idDiaDiemDangKyLamViecsListPush.add(data.id.toString());

            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }

      if (danangCheck) {
        //Check null Phường/Xã của quận Hoàng sa
        String? idCheckPhuongXa;
        if (phuongXaDaNang != null) {
          idCheckPhuongXa = phuongXaDaNang!.id;
        } else {
          idCheckPhuongXa = null;
        }

        diaDiemDangKyLamViecProvider.add(
          data: DiaDiemDangKyLamViecRequest(
            idQuanHuyen: quanHuyenDaNang!.id,
            idPhuongXa: idCheckPhuongXa,
            idTinhTp: daNangId,
          ),
          onSuccess: (data) {
            idDiaDiemDangKyLamViecsListPush.add(data.id.toString());

            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }

      if (tinhKhacCheck) {
        diaDiemDangKyLamViecProvider.add(
          data: DiaDiemDangKyLamViecRequest(
            idQuanHuyen: quanHuyenKhac!.id,
            idPhuongXa: phuongXaKhac!.id,
            idTinhTp: tinhTpKhac!.id,
          ),
          onSuccess: (data) {
            idDiaDiemDangKyLamViecsListPush.add(data.id.toString());

            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }

      for (final idModel in tinhTpsSelected) {
        diaDiemDangKyLamViecProvider.add(
          data: DiaDiemDangKyLamViecRequest(
            idTinhTp: idModel.toString(),
          ),
          onSuccess: (data) {
            idDiaDiemDangKyLamViecsListPush.add(data.id.toString());

            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }
    }
  }

  ///
  /// update dia diem
  ///
  void updateDiaDiem(String viecMoiId) {
    diaDiemDangKyLamViecProvider.paginate(
      page: 1,
      limit: 30,
      filter: "",
      onSuccess: (data) {
        dangKyViecMoiProvider.update(
          data: DangKyViecMoiRequest(
            id: viecMoiId,
            idDiaDiemDangKyLamViecs: idDiaDiemDangKyLamViecsListPush,
          ),
          onSuccess: (data) {
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// validate
  ///
  bool _validate() {
    // validate nhom cong viec
    if (idNhomCongViec!.id != null && idNhomCongViec!.id.toString().isEmpty) {
      IZIAlert.error(message: "Nhóm công việc không được để trống!");
      return false;
    }

    if (idCongViec == null) {
      IZIAlert.error(message: "Loại công việc không được để trống!");
      return false;
    }

    // validate thời gian bắt đầu
    if (timeStartController.text.isEmpty) {
      IZIAlert.error(message: "Thời gian bắt đầu không được để trống!");
      return false;
    }

    // //validation thời gian
    if (timeEndController.text != null && timeEndController.text.isNotEmpty) {
      final DateTime timeStartRegister = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(timeStartController.text)
          .toString()
          .substring(0, 10));
      final DateTime timeEndRegister = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(timeEndController.text)
          .toString()
          .substring(0, 10));
      if (timeEndRegister.isBefore(timeStartRegister)) {
        IZIAlert.error(
            message: "Ngày kết thúc không được phép sớm hơn ngày bắt đầu!");
        return false;
      }
    }

    if (quanHuyenHCM == null && tphcmCheck == true) {
      IZIAlert.error(message: "Vui lòng chọn Quận/Huyện của TP Hồ Chí Minh!");
      return false;
    }

    if (phuongXaHCM == null && tphcmCheck == true) {
      IZIAlert.error(message: "Vui lòng chọn Phường/Xã của TP Hồ Chí Minh!");
      return false;
    }

    if (quanHuyenHaNoi == null && hanoiCheck == true) {
      IZIAlert.error(message: "Vui lòng chọn Quận/Huyện của TP Hà Nội!");
      return false;
    }

    if (phuongXaHaNoi == null && hanoiCheck == true) {
      IZIAlert.error(message: "Vui lòng chọn Phường/Xã của TP Hà Nội!");
      return false;
    }

    if (quanHuyenDaNang == null && danangCheck == true) {
      IZIAlert.error(message: "Vui lòng chọn Quận/Huyện của TP Đà Nẵng!");
      return false;
    }

    if (quanHuyenDaNang != null) {
      if (phuongXaDaNang == null &&
          quanHuyenDaNang!.ten.toString().toLowerCase() != "hoàng sa" &&
          danangCheck == true) {
        IZIAlert.error(message: "Vui lòng chọn Phường/Xã của TP Đà Nẵng!");
        return false;
      }
    }

    if (quanHuyenKhac == null && tinhKhacCheck == true) {
      IZIAlert.error(message: "Vui lòng chọn Quận/Huyện của Tỉnh/Tp khác!");
      return false;
    }

    if (phuongXaKhac == null && tinhKhacCheck == true) {
      IZIAlert.error(message: "Vui lòng chọn Phường/Xã của Tỉnh/Tp khác!");
      return false;
    }

    // validate ít nhất phải chọn một nơi làm việc
    if (checkProvince()) {
      IZIAlert.error(message: "Cần ít nhất một nơi làm việc!");
      return false;
    }

    return true;
  }

  ///
  /// check exist province selected
  ///
  bool checkProvince() {
    return tphcmCheck == false &&
        hanoiCheck == false &&
        danangCheck == false &&
        tinhKhacCheck == false &&
        tinhTpsSelected.isEmpty;
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalDateHMS(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }
}
