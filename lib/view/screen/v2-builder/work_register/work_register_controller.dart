import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/request/dia_diem_dang_ky_lam_viec_request.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/dia_diem_dang_ky_lam_viec_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2WorkRegisterController extends GetxController {
  // provider
  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  LoaiCongViecProvider loaiCongViecProvider =
      GetIt.I.get<LoaiCongViecProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DangKyViecMoiProvider dangKyViecMoiProvider =
      GetIt.I.get<DangKyViecMoiProvider>();
  DiaDiemDangKyLamViecProvider diaDiemDangKyLamViecProvider =
      GetIt.I.get<DiaDiemDangKyLamViecProvider>();
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  // text editing controller
  TextEditingController nhomCongViecController = TextEditingController();
  TextEditingController congViecPhuHopController = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController soLuongController = TextEditingController(text: "0");

  List<NhomDichVuResponse> nhomDichVu = [];
  List<LoaiCongViecResponse> congViecList = [];

  List<QuanHuyenResponse>? quanHuyenHCMList = [];
  List<PhuongXaResponse>? phuongXaHCMList = [];

  List<QuanHuyenResponse>? quanHuyenHaNoiList = [];
  List<PhuongXaResponse>? phuongXaHaNoiList = [];

  List<QuanHuyenResponse>? quanHuyenDaNangList = [];
  List<PhuongXaResponse>? phuongXaDaNangList = [];

  List<QuanHuyenResponse>? quanHuyenKhacList = [];
  List<PhuongXaResponse>? phuongXaKhacList = [];
  List<TinhTpResponse>? tinhTpsKhac = [];
  List<TinhTpResponse>? tinhTps = [];
  List<TinhTpResponse?> tinhTpsSelected = [];

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

  List<String> idDiaDiemDangKyLamViecs = [];

  // String
  String title = "Đăng ký việc";

  final List<String> ids = [];

  // string id tương ứng khi checkbox
  String hoChiMinhId = "";
  String haNoiid = "";
  String daNangId = "";
  String idNhomCongViec = "";
  String idCongViec = "";

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

  @override
  void onInit() {
    super.onInit();

    // set value default into time end field
    timeStartController = TextEditingController(
      text: DateConverter.estimatedDateMonthYear(
        DateTime.now(),
      ),
    );

    // set value default into time end field
    timeEndController = TextEditingController(
      text: DateConverter.estimatedDateMonthYear(
        DateTime.now(),
      ),
    );

    btnLabel = btnNote1;
    noteLabel = note1;

    // get id avaiable for hcm, hanoi, danang
    getIdAvaliable();

    // load nhom cong viec phu hop
    _loadNhomCongViecPhuHop();

    // load tỉnh thành ở dưới cùng
    getTinhThanhBottom();
  }

  ///
  /// get id avaliable
  ///
  void getIdAvaliable() {
    tinhTpProvider.all(onSuccess: (data) {
      for (final element in data) {
        final String ten = element.ten.toString().toLowerCase();

        // get id hochiminh
        if (ten.contains("hồ chí minh")) {
          hoChiMinhId = element.id!;
        }

        // get id ha noi
        if (ten.contains("hà nội")) {
          haNoiid = element.id!;
        }

        // get id da nang
        if (ten.contains("đà nẵng")) {
          daNangId = element.id!;
        }
      }

      update();
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
    });
  }

  ///
  /// load nhóm công việc phù hợp
  ///
  void _loadNhomCongViecPhuHop() {
    nhomDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: '',
      onSuccess: (models) {
        nhomDichVu = models;
        if (nhomDichVu.isNotEmpty) {
          idNhomCongViec = nhomDichVu.first.id!;
          if (nhomDichVu.first.tenDichVu
              .toString()
              .toLowerCase()
              .contains("nhóm 7")) {
            sl.get<SharedPreferenceHelper>().saveNhom7(id: true);
          } else {
            sl.get<SharedPreferenceHelper>().saveNhom7(id: false);
          }
          // load công việc phù hợp theo nhóm công việc
          _loadCongViecPhuHop(nhomDichVu.first.id!);
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load công việc phù hợp - load theo nhóm công việc
  ///
  void _loadCongViecPhuHop(String idNhomCongViec) {
    loaiCongViecProvider.paginate(
      page: 1,
      limit: 30,
      filter: '&idNhomDichVu=$idNhomCongViec',
      onSuccess: (models) {
        congViecList = models;
        if (congViecList.isNotEmpty) {
          idCongViec = congViecList.first.id!;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
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
    idDiaDiemDangKyLamViecs.remove(tinhTpKhac!.id);

    getQuanHuyenKhac(filter: "&idTinhTp=${tinhTpKhac!.id}");
    idDiaDiemDangKyLamViecs.add(tinhTpKhac!.id!);

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
    update();
  }

  ///
  ///Thay đổi quận huyện hồ chí minh
  ///
  void onChangedQuanHuyenHCM(QuanHuyenResponse huyen) {
    quanHuyenHCM = huyen;
    getPhuongXa(1, filter: "&idQuanHuyen=${quanHuyenHCM!.id}");
    update();
  }

  ///
  ///Thay đổi quận huyện hà nội
  ///
  void onChangedQuanHuyenHaNoi(QuanHuyenResponse huyen) {
    quanHuyenHaNoi = huyen;
    getPhuongXa(2, filter: "&idQuanHuyen=${quanHuyenHaNoi!.id}");

    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyenDaNang(QuanHuyenResponse huyen) {
    quanHuyenDaNang = huyen;
    getPhuongXa(3, filter: "&idQuanHuyen=${quanHuyenDaNang!.id}");
    update();
  }

  ///
  ///Thay đổi phường xã khác
  ///
  void onChangedQuanHuyenKhac(QuanHuyenResponse huyen) {
    quanHuyenKhac = huyen;
    getPhuongXa(4, filter: "&idQuanHuyen=${quanHuyenKhac!.id}");
    update();
  }

  ///
  ///Thay đổi phường xã hồ chí minh
  ///
  void onChangedPhuongXaHCM(PhuongXaResponse phuong) {
    phuongXaHCM = phuong;
    update();
  }

  ///
  ///Thay đổi phường xã hà nội
  ///
  void onChangedPhuongXaHaNoi(PhuongXaResponse phuong) {
    phuongXaHaNoi = phuong;

    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedPhuongXaDaNang(PhuongXaResponse phuong) {
    phuongXaDaNang = phuong;
    update();
  }

  ///
  ///Thay đổi phường xã khác
  ///
  void onChangedPhuongXaKhac(PhuongXaResponse phuong) {
    phuongXaKhac = phuong;
    update();
  }

  ///
  /// on nhom cong viec phu hop change
  ///
  void onNhomCongViecChange(String? value) {
    idNhomCongViec = value!;
    _loadCongViecPhuHop(value);

    nhomDichVuProvider.find(
      id: idNhomCongViec,
      onSuccess: (data) {
        if (data.tenDichVu.toString().toLowerCase().contains("nhóm 7")) {
          sl.get<SharedPreferenceHelper>().saveNhom7(id: true);
          btnLabel = btnNote2;
          noteLabel = note2;

          // check với userid và nhomDichVu la 7 tồn tại data không
          // tồn tại là cập nhật ngược lại là đăng ký
          sl.get<SharedPreferenceHelper>().userId.then((userId) {
            print("&idNhomDichVu=${data.id}&idTaiKhoan=$userId");
            dangKyViecMoiProvider.paginate(
              page: 1,
              limit: 30,
              filter: "&idNhomDichVu=${data.id}&idTaiKhoan=$userId",
              onSuccess: (data) {
                if (data.isNotEmpty) {
                  sl
                      .get<SharedPreferenceHelper>()
                      .saveViecMoi(id: data.first.id!);
                  isRegister = false;
                  update();
                }
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
          });
        } else {
          sl.get<SharedPreferenceHelper>().saveNhom7(id: false);
          btnLabel = btnNote1;
          noteLabel = note1;
          isRegister = true;
          update();
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
    update();
  }

  ///
  /// on nhom cong viec phu hop change
  ///
  void onCongViecChange(String? value) {
    idCongViec = value!;
    update();
  }

  ///
  /// Lấy tất cả tỉnh thành phố
  ///
  void getTinhThanh() {
    tinhTpsKhac = [];
    tinhTpProvider.all(onSuccess: (responses) {
      for (final response in responses) {
        if (tinhKhacCheck) {
          tinhTpsKhac!.add(response);
        }

        if (tphcmCheck && response.ten!.toLowerCase().contains('hồ chí minh')) {
          tinhTpsKhac!.remove(response);
        }

        if (hanoiCheck && response.ten!.toLowerCase().contains('hà nội')) {
          tinhTpsKhac!.remove(response);
        }

        if (danangCheck && response.ten!.toLowerCase().contains('đà nẵng')) {
          tinhTpsKhac!.remove(response);
        }
      }

      if (tinhTpsKhac!.isNotEmpty) {
        tinhTpKhac = tinhTpsKhac!.first;
        idDiaDiemDangKyLamViecs.add(tinhTpKhac!.id!);
      }

      update();
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
    });
  }

  ///
  /// Lấy tất cả tỉnh thành phố
  ///
  void getTinhThanhBottom() {
    tinhTps = [];
    tinhTpProvider.all(onSuccess: (responses) {
      for (final response in responses) {
        tinhTps!.add(response);

        if (tphcmCheck && response.ten!.toLowerCase().contains('hồ chí minh')) {
          tinhTps!.remove(response);
        }

        if (hanoiCheck && response.ten!.toLowerCase().contains('hà nội')) {
          tinhTps!.remove(response);
        }

        if (danangCheck && response.ten!.toLowerCase().contains('đà nẵng')) {
          tinhTps!.remove(response);
        }
      }

      if (tinhTpsKhac!.isNotEmpty) {
        tinhTp = tinhTps!.first;
      }
      isLoading = false;
      update();
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
    });
  }

  ///
  /// Lấy tất cả quận huyện của hồ chí minh
  ///
  void getQuanHuyenHCM() {
    quanHuyenHCMList!.clear();
    quanHuyenProvider.paginate(
      page: 1,
      limit: 30,
      filter: '&idTinhTp=$hoChiMinhId',
      onSuccess: (responses) {
        quanHuyenHCMList = responses;
        if (quanHuyenHCMList!.isNotEmpty) {
          quanHuyenHCM = responses[0];
          getPhuongXa(1, filter: "&idQuanHuyen=${quanHuyenHCM!.id!}");
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Lấy tất cả quận huyện của hồ chí minh
  ///
  void getQuanHuyenHaNoi() {
    quanHuyenHaNoiList!.clear();
    quanHuyenProvider.paginate(
      page: 1,
      limit: 30,
      filter: '&idTinhTp=$haNoiid',
      onSuccess: (responses) {
        quanHuyenHaNoiList = responses;
        if (quanHuyenHaNoiList!.isNotEmpty) {
          quanHuyenHaNoi = responses[0];
          getPhuongXa(2, filter: "&idQuanHuyen=${quanHuyenHaNoi!.id!}");
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Lấy tất cả quận huyện của hồ chí minh
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
          quanHuyenDaNang = responses[0];
          getPhuongXa(3, filter: "&idQuanHuyen=${quanHuyenDaNang!.id!}");
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Lấy tất cả quận huyện của hồ chí minh
  ///
  void getQuanHuyenKhac({String? filter = ''}) {
    quanHuyenProvider.paginate(
      page: 1,
      limit: 30,
      filter: filter!,
      onSuccess: (responses) {
        quanHuyenKhacList = responses;
        if (quanHuyenKhacList!.isNotEmpty) {
          quanHuyenKhac = responses[0];
          getPhuongXa(4, filter: "&idQuanHuyen=${quanHuyenKhac!.id}");
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Lấy tất cả phường xa
  ///
  void getPhuongXa(int index, {String? filter = ''}) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 30,
      filter: filter!,
      onSuccess: (responses) {
        if (index == 1) {
          phuongXaHCMList!.clear();
          phuongXaHCMList = responses;
          if (phuongXaHCMList!.isNotEmpty) {
            phuongXaHCM = phuongXaHCMList!.first;
          } else {
            phuongXaHCM = null;
          }
        }

        if (index == 2) {
          phuongXaHaNoiList!.clear();
          phuongXaHaNoiList = responses;
          if (phuongXaHaNoiList!.isNotEmpty) {
            phuongXaHaNoi = phuongXaHaNoiList!.first;
          } else {
            phuongXaHaNoi = null;
          }
        }

        if (index == 3) {
          phuongXaDaNangList!.clear();
          phuongXaDaNangList = responses;
          if (phuongXaDaNangList!.isNotEmpty) {
            phuongXaDaNang = phuongXaDaNangList!.first;
          } else {
            phuongXaDaNang = null;
          }
        }

        if (index == 4) {
          phuongXaKhacList = responses;
          if (phuongXaKhacList!.isNotEmpty) {
            phuongXaKhac = phuongXaKhacList!.first;
          } else {
            phuongXaKhac = null;
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
  /// change checkbox
  ///
  void checkboxChange(int index, {required bool val}) {
    if (index == 1) {
      tphcmCheck = val;
      if (val == false) {
        quanHuyenHCMList = [];
        phuongXaHCMList = [];
        quanHuyenHCM = null;
        phuongXaHCM = null;
        idDiaDiemDangKyLamViecs.remove(hoChiMinhId);
      } else {
        idDiaDiemDangKyLamViecs.add(hoChiMinhId);
        getQuanHuyenHCM();
      }
    }

    if (index == 2) {
      hanoiCheck = val;
      if (val == false) {
        quanHuyenHaNoiList = [];
        phuongXaHaNoiList = [];
        quanHuyenHaNoi = null;
        phuongXaHaNoi = null;
        idDiaDiemDangKyLamViecs.remove(haNoiid);
      } else {
        idDiaDiemDangKyLamViecs.add(haNoiid);
        getQuanHuyenHaNoi();
      }
    }

    if (index == 3) {
      danangCheck = val;
      if (val == false) {
        quanHuyenDaNangList = [];
        phuongXaDaNangList = [];
        quanHuyenDaNang = null;
        phuongXaDaNang = null;
        idDiaDiemDangKyLamViecs.remove(haNoiid);
      } else {
        idDiaDiemDangKyLamViecs.add(haNoiid);
        getQuanHuyenDaNang();
      }
    }

    if (index == 4) {
      tinhKhacCheck = val;
      if (val == false) {
        tinhTpsKhac = [];
        quanHuyenKhacList = [];
        phuongXaKhacList = [];
        phuongXaKhac = null;
        quanHuyenKhac = null;
        tinhTpKhac = null;
      } else {
        getTinhThanh();
      }
    }

    getTinhThanhBottom();
    update();
  }

  ///
  /// on register click
  ///
  void onRegisterClick() {
    if (_validate()) {
      if (isRegister == true) {
        // get user id
        sl.get<SharedPreferenceHelper>().userId.then((userId) {
          final List<String> split1 = timeStartController.text.split("/");
          final List<String> split2 = timeEndController.text.split("/");

          final List<String> timeStart = [];
          for (int i = split1.length - 1; i >= 0; i--) {
            timeStart.add(split1[i]);
          }

          final List<String> timeEnd = [];
          for (int i = split2.length - 1; i >= 0; i--) {
            timeEnd.add(split2[i]);
          }

          taiKhoanProvider.find(
            id: userId!,
            onSuccess: (taiKhoan) {
              // đăng ký việc mới
              dangKyViecMoiProvider.add(
                data: DangKyViecMoiRequest(
                  idTaiKhoan: userId,
                  idNhomDichVu: idNhomCongViec,
                  idLoaiCongViec: idCongViec,
                  soLuong: soLuongController.text,
                  thoiGianBatDau: timeStart.join("-"),
                  thoiGianKetThuc: timeEnd.join("-"),
                  tieuDe: '...',
                  tenUngVien: taiKhoan.hoTen ?? "",
                  gioiTinh: taiKhoan.gioiTinh ?? "",
                  ngaySinh: taiKhoan.ngaySinh ?? "",
                  email: taiKhoan.email ?? "",
                  diaChi: taiKhoan.diaChi ?? "",
                  idDiaDiemDangKyLamViecs: [],
                ),
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
                    EasyLoading.showSuccess("Thêm thành công");
                    sl.get<SharedPreferenceHelper>().nhom7.then((nhom7) {
                      if (nhom7 == true) {
                        Get.toNamed(AppRoutes.V2_WORK_CREATE);
                      } else {
                        Get.back();
                      }
                    });
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
        Get.toNamed(AppRoutes.V2_WORK_CREATE);
      }
    }
  }

  ///
  /// thêm địa điểm đăng ký làm việc
  ///
  void themDiaDiemDangKyLamViec(String viecMoiId) {
    // validate ít nhất phải chọn một nơi làm việc
    if (checkProvince()) {
      Get.snackbar("Thông báo", "Cần ít nhất một nơi làm việc");
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
            sl.get<SharedPreferenceHelper>().ids.then((value) {
              String vals = value.toString().replaceAll("null", "");
              vals += "${data.id!},";
              sl.get<SharedPreferenceHelper>().saveIds(id: vals);
            });
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
            idQuanHuyen: quanHuyenHaNoi != null
                ? quanHuyenHaNoi!.id
                : "616a5d88000118120619cb91",
            idPhuongXa: phuongXaHaNoi != null
                ? phuongXaHaNoi!.id
                : "61694d453391622ae9202d81",
            idTinhTp: haNoiid,
          ),
          onSuccess: (data) {
            sl.get<SharedPreferenceHelper>().ids.then((value) {
              String vals = value.toString().replaceAll("null", "");
              vals += "${data.id!},";
              sl.get<SharedPreferenceHelper>().saveIds(id: vals);
            });
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }

      if (danangCheck) {
        diaDiemDangKyLamViecProvider.add(
          data: DiaDiemDangKyLamViecRequest(
            idQuanHuyen: quanHuyenDaNang != null
                ? quanHuyenDaNang!.id
                : "616a5d88000118120619cb91",
            idPhuongXa: phuongXaDaNang != null
                ? phuongXaDaNang!.id
                : "61694d453391622ae9202d81",
            idTinhTp: daNangId,
          ),
          onSuccess: (data) {
            sl.get<SharedPreferenceHelper>().ids.then((value) {
              String vals = value.toString().replaceAll("null", "");
              vals += "${data.id!},";
              sl.get<SharedPreferenceHelper>().saveIds(id: vals);
            });
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
            idQuanHuyen: quanHuyenKhac != null
                ? quanHuyenKhac!.id
                : "616a5d88000118120619cb91",
            idPhuongXa: phuongXaKhac != null
                ? phuongXaKhac!.id
                : "61694d453391622ae9202d81",
            idTinhTp: tinhTpKhac != null
                ? tinhTpKhac!.id
                : "6160f286f58f581ebf6d74e1",
          ),
          onSuccess: (data) {
            sl.get<SharedPreferenceHelper>().ids.then((value) {
              String vals = value.toString().replaceAll("null", "");
              vals += "${data.id!},";
              sl.get<SharedPreferenceHelper>().saveIds(id: vals);
            });
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
        sl.get<SharedPreferenceHelper>().ids.then((value) {
          final List<String> ids = value!
              .replaceAll(",", " ")
              .replaceAll("[]", "")
              .trim()
              .split(" ");
          dangKyViecMoiProvider.update(
            data: DangKyViecMoiRequest(
              id: viecMoiId,
              idDiaDiemDangKyLamViecs: ids,
            ),
            onSuccess: (data) {
              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
        });

        sl.get<SharedPreferenceHelper>().saveIds(id: "");
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
    if (idNhomCongViec.isEmpty) {
      Get.snackbar("Thông báo", "Nhóm công việc không được rỗng");
      return false;
    }

    // validate thời gian bắt đầu
    if (timeStartController.text.isEmpty) {
      Get.snackbar("Thông báo", "Thời gian bắt đầu không được rỗng");
      return false;
    }

    // validate thời gian kết thúc
    if (timeEndController.text.isEmpty) {
      Get.snackbar("Thông báo", "Thời gian kết thúc không được rỗng");
      return false;
    }

    // validate số lượng
    if (soLuongController.text.isEmpty) {
      Get.snackbar("Thông báo", "Số lượng không được rỗng");
      return false;
    }

    // validate ít nhất phải chọn một nơi làm việc
    if (checkProvince()) {
      Get.snackbar("Thông báo", "Cần ít nhất một nơi làm việc");
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
}
