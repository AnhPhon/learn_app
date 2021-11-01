import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
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

  // String
  String title = "Đăng ký việc";

  // string id tương ứng khi checkbox
  String hoChiMinhId = "61606932763ce5dc10c529f5";
  String haNoiid = "6160f286f58f581ebf6d74f4";
  String daNangId = "615d6a143e28b243e76682e1";
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
        hoChiMinhId = element.id!;
        haNoiid = element.id!;
        daNangId = element.id!;
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
    getQuanHuyenKhac(filter: "&idTinhTp=${tinhTpKhac!.id}");
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
          btnLabel = btnNote2;
          noteLabel = note2;
          isRegister = false;
        } else {
          btnLabel = btnNote1;
          noteLabel = note1;
          isRegister = true;
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
  /// on nhom cong viec phu hop change
  ///
  void onCongViecChange(String? value) {
    idCongViec = value!;
    update();
  }

  ///
  /// on register click
  ///
  void onRegisterClick() {
    if (_validate()) {
      if (isRegister) {
        // get user id
        sl.get<SharedPreferenceHelper>().userId.then((userId) {
          // đăng ký việc mới
          dangKyViecMoiProvider.add(
            data: DangKyViecMoiRequest(
              idTaiKhoan: userId,
            ),
            onSuccess: (data) {
              EasyLoading.showSuccess("Thêm thành công");
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
      } else {
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
      } else {
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
      } else {
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

    return true;
  }
}
