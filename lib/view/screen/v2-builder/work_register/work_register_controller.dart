import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
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

class V2WorkRegisterController extends GetxController {
  // provider
  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  LoaiCongViecProvider loaiCongViecProvider =
      GetIt.I.get<LoaiCongViecProvider>();
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  // text editing controller
  TextEditingController tieuDeBaoGiaController = TextEditingController();
  TextEditingController loaiCongTrinhController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController nhomCongViecController = TextEditingController();
  TextEditingController congViecPhuHopController = TextEditingController();
  TextEditingController toanTinhController = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController diaDiemKhacController = TextEditingController();

  // List
  List<String>? currencies;
  List<bool>? checkList;

  List<NhomDichVuResponse> nhomDichVu = [];
  List<DonDichVuResponse> dichVuList = [];

  List<QuanHuyenResponse> quanHCM = [];
  List<PhuongXaResponse> phuongHCM = [];

  List<QuanHuyenResponse> quanHN = [];
  List<PhuongXaResponse> phuongHN = [];

  List<QuanHuyenResponse> quanDN = [];
  List<PhuongXaResponse> phuongDN = [];

  List<TinhTpResponse> tinhKhac = [];
  List<QuanHuyenResponse> quanKhac = [];
  List<PhuongXaResponse> phuongKhac = [];

  // String
  String? firstSelect;
  String title = "Đăng ký việc";

  // value first for checkbox
  String idNhomCongViec = "";
  String idCongViec = "";
  String quanHuyenHCM = "";
  String phuongXaHCM = "";
  String quanHuyenHaNoi = "";
  String phuongXaHaNoi = "";
  String quanHuyenDaNang = "";
  String phuongXaDaNang = "";
  String quanHuyenTinhKhac = "";
  String phuongXaTinhKhac = "";

  // string id tương ứng khi checkbox
  String hoChiMinhId = "61606932763ce5dc10c529f5";
  String haNoiid = "6160f286f58f581ebf6d74f4";
  String daNangId = "615d6a143e28b243e76682e1";
  String tinhKhacId = "";

  // bool
  bool tphcmCheck = false;
  bool hanoiCheck = false;
  bool danangCheck = false;
  bool tinhKhacCheck = false;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    // load nhom cong viec phu hop
    _loadNhomCongViecPhuHop();
  }

  ///
  /// load nhóm công việc phù hợp
  ///
  void _loadNhomCongViecPhuHop() {
    // get all nhóm dịch vụ
    nhomDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "",
      onSuccess: (models) {
        nhomDichVu = models;

        if (nhomDichVu.isNotEmpty) {
          idNhomCongViec = nhomDichVu[0].id!;
          _loadCongViecPhuHop(idNhomCongViec);
          update();
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
    // get all nhóm dịch vụ
    donDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idNhomDichVu=$idNhomCongViec",
      onSuccess: (models) {
        dichVuList = models;
        if (dichVuList.isNotEmpty) {
          idCongViec = dichVuList[0].id!;
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load quận huyện TPHCM
  ///
  void _loadQuanHuyenHCM(String idTpHCM) {
    quanHuyenProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idTinhTp=$idTpHCM&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          quanHuyenHCM = models[0].id!;
          quanHCM = models;
          _loadPhuongXaHCM(quanHuyenHCM);
        } else {
          quanHCM = [];
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load phương xã theo huận huyện TP.HCM
  ///
  void _loadPhuongXaHCM(String idQuanHuyen) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idQuanHuyen=$idQuanHuyen&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          phuongXaHCM = models[0].id!;
          phuongHCM = models;
        } else {
          phuongHCM = [];
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load quận huyện Hà Nội
  ///
  void _loadQuanHuyenHaNoi(String idHaNoi) {
    quanHuyenProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idTinhTp=$idHaNoi&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          quanHuyenHaNoi = models[0].id!;
          quanHN = models;
          _loadPhuongXaHaNoi(quanHuyenHaNoi);
        } else {
          quanHN = [];
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load phương xã theo huận huyện Hà Nội
  ///
  void _loadPhuongXaHaNoi(String idQuanHuyenHaNoi) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idQuanHuyen=$idQuanHuyenHaNoi&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          phuongXaHaNoi = models[0].id!;
          phuongHN = models;
        } else {
          phuongHN = [];
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load quận huyện Đà Nẵng
  ///
  void _loadQuanHuyenDaNang(String idDaNang) {
    quanHuyenProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idTinhTp=$idDaNang&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          quanHuyenDaNang = models[0].id!;
          quanDN = models;
          _loadPhuongXaDaNang(quanHuyenDaNang);
        } else {
          quanDN = [];
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load phương xã theo huận huyện Đà Nẵng
  ///
  void _loadPhuongXaDaNang(String idQuanHuyenDaNang) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idQuanHuyen=$idQuanHuyenDaNang&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          phuongXaDaNang = models[0].id!;
          phuongDN = models;
        } else {
          phuongDN = [];
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load Tỉnh khác (trừ 3 tỉnh trên)
  ///
  void _loadTinhKhac(List<String> _idSubList) {
    tinhTpProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          tinhKhacId = models[0].id!;
          for (final model in models) {
            if (!_idSubList.contains(model.id)) {
              tinhKhac.add(model);
            }
          }
        } else {
          tinhKhac = [];
        }

        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load quận huyện Tỉnh khác
  ///
  void _loadQuanHuyenTinhKhac(String idTinhKhac) {
    quanHuyenProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idTinhTp=$idTinhKhac&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          quanHuyenTinhKhac = models[0].id!;
          quanKhac = models;
        } else {
          quanKhac = [];
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load phương xã theo huận huyện Tỉnh khác
  ///
  void _loadPhuongXaTinhKhac(String idQuanHuyenTinhKhac) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idQuanHuyen=$idQuanHuyenTinhKhac&sortBy=created_by:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          phuongXaTinhKhac = models[0].id!;
          phuongKhac = models;
        } else {
          phuongKhac = [];
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load dia diem khac - loại các tĩnh được chọn
  ///
  void _loadDiaDiemKhac(List<String> _idList) {}

  ///
  /// on nhom cong viec phu hop change
  ///
  void onNhomCongViecChange(String? value) {
    idNhomCongViec = value!;
    _loadCongViecPhuHop(idNhomCongViec);
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
  /// onCheckBoxChange
  ///
  void onCheckBoxChange(int index, {required bool value}) {
    final List<String> subList = [];
    if (value == true) {}
    if (index == 0) {
      tphcmCheck = value;
      subList.add(hoChiMinhId);
      _loadQuanHuyenHCM(hoChiMinhId);

      if (value == false) {
        subList.remove(hoChiMinhId);
        quanHCM = [];
        phuongHCM = [];
        update();
      }
    }

    if (index == 1) {
      hanoiCheck = value;
      subList.add(haNoiid);
      quanHuyenHaNoi = haNoiid;
      _loadQuanHuyenHaNoi(haNoiid);

      if (value == false) {
        subList.remove(haNoiid);
        quanHN = [];
        phuongHN = [];
        update();
      }
    }

    if (index == 2) {
      danangCheck = value;
      subList.add(daNangId);
      quanHuyenDaNang = daNangId;
      _loadQuanHuyenDaNang(daNangId);

      if (value == false) {
        subList.remove(daNangId);
        quanDN = [];
        phuongDN = [];
        update();
      }
    }

    if (index == 3) {
      tinhKhacCheck = value;
      _loadTinhKhac(subList);

      if (value == false) {
        tinhKhac = [];
        quanKhac = [];
        phuongKhac = [];
        update();
      }
    }
  }

  ///
  /// onCheckBoxChange
  ///
  void onQuanHuyenCheckBoxChange(int index, {required String value}) {
    if (index == 0) {
      quanHuyenHCM = value;
      _loadPhuongXaHCM(value);
    } else {
      phuongHCM = [];
    }

    if (index == 1) {
      quanHuyenHaNoi = value;
      _loadQuanHuyenHaNoi(value);
    } else {
      phuongHN = [];
    }

    if (index == 2) {
      quanHuyenDaNang = value;
      _loadQuanHuyenDaNang(value);
    } else {
      phuongDN = [];
    }

    if (index == 3) {
      quanHuyenTinhKhac = value;
      _loadQuanHuyenTinhKhac(value);
    } else {
      phuongKhac = [];
    }
  }

  ///
  /// onCheckBoxChange
  ///
  void onPhuongXaCheckBoxChange(int index, {required String value}) {
    if (index == 0) {
      phuongXaHCM = value;
      _loadPhuongXaHCM(value);
    }

    if (index == 1) {
      phuongXaHaNoi = value;
      _loadPhuongXaHaNoi(value);
    }

    if (index == 2) {
      phuongXaDaNang = value;
      _loadPhuongXaDaNang(value);
    }

    if (index == 3) {
      phuongXaTinhKhac = value;
      _loadPhuongXaTinhKhac(value);
    }
  }

  ///
  /// on register click
  ///
  void onRegisterClick() {
    if (_validate()) {
      EasyLoading.showSuccess("Đăng ký thành công");
    }
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
