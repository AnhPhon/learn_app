import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/gioi_tinh_model.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tim_kiem_ung_vien_model.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chuyen_mon_provider.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/muc_luong_du_kien_provider.dart';
import 'package:template/provider/ngoai_ngu_provider.dart';
import 'package:template/provider/so_nam_kinh_nghiem_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/trinh_do_hoc_van_provider.dart';
import 'package:template/provider/trinh_do_provider.dart';
import 'package:template/provider/tuyen_dung_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/dialog_content.dart';
import 'package:tiengviet/tiengviet.dart';

class V1CandidateController extends GetxController {
  //provider
  final NgoaiNguProvider ngoaiNguProvider = GetIt.I.get<NgoaiNguProvider>();
  final HinhThucLamViecProvider hinhThucLamViecProvider = GetIt.I.get<HinhThucLamViecProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final ChuyenMonProvider chuyenMonProvider = GetIt.I.get<ChuyenMonProvider>();
  final SoNamKinhNghiemProvider soNamKinhNghiemProvider = GetIt.I.get<SoNamKinhNghiemProvider>();
  final TrinhDoProvider trinhDoProvider = GetIt.I.get<TrinhDoProvider>();
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  final DangKyViecMoiProvider dangKyViecMoiProvider = GetIt.I.get<DangKyViecMoiProvider>();
  final TuyenDungProvider tuyenDungProvider = GetIt.I.get<TuyenDungProvider>();
  final MucLuongDuKienProvider mucLuongDuKienProvider = GetIt.I.get<MucLuongDuKienProvider>();
  final LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  final TrinhDoHocVanProvider trinhDoHocVanProvider = GetIt.I.get<TrinhDoHocVanProvider>();

  //index tab
  int currentIndex = 0;

  //refresh
  RefreshController refreshTinTuyenDungController = RefreshController();
  RefreshController refreshTimUngVienController = RefreshController();

  //scrollController
  ScrollController scrollTinTuyenDungController = ScrollController();
  ScrollController scrollTimUngVienController = ScrollController();

  //model value
  List<NgoaiNguResponse> ngoaiNguListModel = [];
  List<HinhThucLamViecResponse> hinhThucLamViecListModel = [];
  List<TinhTpResponse> tinhTpListModel = [];

  // List<ChuyenMonResponse> chuyenMonListModel = [];
  List<LoaiCongViecResponse> chuyenMonListModel = [];
  List<SoNamKinhNghiemResponse> soNamKinhNghiemListModel = [];

  // List<TrinhDoResponse> trinhDoListModel = [];
  List<TrinhDoHocVanResponse> trinhDoListModel = [];
  List<DangKyViecMoiResponse> dangKyViecMoiListModel = [];
  List<TuyenDungResponse> tuyenDungListModel = [];
  List<MucLuongDuKienResponse> mucLuongDuKienListModel = [];

  //set default giới tính
  List<GioiTinhModel> gioiTinhModel = [
    GioiTinhModel(key: '3', value: 'Tất cả'),
    GioiTinhModel(key: '1', value: 'Nam'),
    GioiTinhModel(key: '2', value: 'Nữ'),
  ];

  //model choose
  NgoaiNguResponse? ngoaiNguResponse; //= NgoaiNguResponse();
  HinhThucLamViecResponse? hinhThucLamViecResponse; //= HinhThucLamViecResponse();
  TinhTpResponse? tinhTpResponse; //= TinhTpResponse();
  LoaiCongViecResponse? chuyenMonResponse; //= ChuyenMonResponse();
  SoNamKinhNghiemResponse? soNamKinhNghiemResponse; //= SoNamKinhNghiemResponse();
  TrinhDoHocVanResponse? trinhDoResponse; //= TrinhDoResponse();
  TaiKhoanResponse? taiKhoanResponse; //= TaiKhoanResponse();
  MucLuongDuKienResponse? mucLuongDuKien;

  //sreach
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  //giới tính
  GioiTinhModel? gioiTinh; //GioiTinhModel();

  // Value slider
  double salary = 0;

  //isLoadingCadidate
  bool isLoadingCadidate = true;

  //value tìm kiếm tiêu đề
  String tieuDeSearch = '';

  //conditionFilter
  String conditionFilter = '';
  List<TimKiemUngVienModel> conditions = [];

  //Refresh Page tuyển dụng
  int pageMax = 1;
  int limit = 5;
  int pageMaxSearch = 1;

  //isLoadingTuyenDung
  bool isLoadingTuyenDung = true;

  //tenChuyeNganhPhu
  String tenChuyenNganhPhu = '';

  //isOnChangeSearch
  bool isOnChangeSearch = false;

  // Toán
  String term = '';
  String temp = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //set value frist giới tính
    //gioiTinh = gioiTinhModel.first;
    getDataNgoaiNgu();
    getDataHinhThucLamViec();
    getDataChuyenMon();
    getDataSoNamKinhNghiem();
    getDataTrinhDo();
    getDataTinhTp();
    getDataMucLuongDuKien();
    //get userId
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        // find tai khoan by user id
        taiKhoanProvider.find(
          id: value!,
          onSuccess: (value) {
            // set user
            taiKhoanResponse = value;
            onLoadDataTuyenDung(isRefresh: true);
            //load data frist
          },
          onError: (error) {
            print('V1CandidateController onInit $error');
            update();
            SnackBar(
              content: Text(error.message.toString()),
            );
          },
        );
      },
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    searchController.dispose();
    searchFocusNode.dispose();
    refreshTimUngVienController.dispose();
    refreshTinTuyenDungController.dispose();
    scrollTimUngVienController.dispose();
    scrollTinTuyenDungController.dispose();
    super.onClose();
  }

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab(int index) {
    if (index == 1) {
      isLoadingCadidate = true;
      searchController.text = '';
    } else {
      isLoadingTuyenDung = true;
    }
    pageMax = 1;
    pageMaxSearch = 1;
    currentIndex = index;
    //load data fillter ứng viên
    if (index == 1) {
      //get data ứng viên
      //onLoadDataUngVien(isRefresh: true);
      clearSearch();
      //getDataSearch(textFilter: '', isRefresh: true);
    } else {
      onLoadDataTuyenDung(isRefresh: true);
    }
    update();
  }

  ///
  ///onLoadDataTuyenDung
  ///
  void onLoadDataTuyenDung({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      tuyenDungListModel.clear();
    } else {
      //isLoadingCadidate
      pageMax++;
    }
    //load data tuyen dung
    tuyenDungProvider.paginate(
        page: pageMax,
        limit: limit,
        filter: '&idTaiKhoan=${taiKhoanResponse!.id}&sortBy=created_at:desc',
        onSuccess: (value) {
          //check data empty
          if (value.isEmpty) {
            refreshTinTuyenDungController.loadNoData();
            refreshTinTuyenDungController.refreshCompleted();
          } else if (isRefresh) {
            //check refresh
            tuyenDungListModel = value;
            refreshTinTuyenDungController.refreshCompleted();
          } else {
            tuyenDungListModel = tuyenDungListModel.toList() + value;
            refreshTinTuyenDungController.loadComplete();
          }
          isLoadingTuyenDung = false;
          update();
        },
        onError: (error) => print('V1CandidateController onLoadDataTuyenDung $error'));
  }

  ///
  ///onRefreshTinTuyenDung
  ///
  Future onRefreshTinTuyenDung() async {
    refreshTinTuyenDungController.resetNoData();
    onLoadDataTuyenDung(isRefresh: true);
  }

  ///
  /// Clear data
  ///
  void clearSearch() {
    hinhThucLamViecResponse = null;
    trinhDoResponse = null;
    chuyenMonResponse = null;
    gioiTinh = null;
    mucLuongDuKien = null;
    tinhTpResponse = null;
    soNamKinhNghiemResponse = null;
    ngoaiNguResponse = null;
    term = '';
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : term,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
  }

  ///
  ///onLoadingTinTuyenDung
  ///
  Future onLoadingTinTuyenDung() async {
    onLoadDataTuyenDung(isRefresh: false);
  }

  //onRefreshTimUngVien
  Future<void> onRefresh() async {
    //resetNoData
    onLoadDataUngVien(isRefresh: true);
  }

  //onLoading
  Future<void> onLoading() async {
    print("Load more");
    onLoadDataUngVien(isRefresh: false);
    refreshTimUngVienController.loadComplete();
  }

  ///
  ///onLoadDataUngVien
  ///
  void onLoadDataUngVien({required bool isRefresh}) {
    if (!isLoadingCadidate) {
      onSearch(
        term: term,
        idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
        idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
        idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
        idGioiTinh: gioiTinh == null ? '' : gioiTinh!.key!,
        idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
        idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
        idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
        ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
        isRefresh: isRefresh,
      );
    } else {
      //isRefresh
      onSearch(isRefresh: isRefresh);
    }
  }

  ///
  ///onChangeNameTinhTp
  ///
  String? onChangeNameTinhTp(String id) {
    return tinhTpListModel.firstWhere((element) => element.id == id).ten!;
  }

  ///
  ///onTapViewTuyenDung
  ///
  void onTapViewTuyenDung({required TuyenDungResponse tuyendungModel}) {
    String tenNoiLamViec = '';
    // set tên chuyên ngành phụ
    if (tuyendungModel.idChuyenNganhPhus!.isNotEmpty) {
      for (int i = 0; i < tuyendungModel.idChuyenNganhPhus!.length; i++) {
        if (i == 0) {
          tenChuyenNganhPhu = tuyendungModel.idChuyenNganhPhus![i].tenCongViec.toString();
        } else {
          tenChuyenNganhPhu += ', ${tuyendungModel.idChuyenNganhPhus![i].tenCongViec.toString()}';
        }
      }
    }

    // Nơi làmb việc
    if (tuyendungModel.idNoiLamViecs != null) {
      if (tuyendungModel.idNoiLamViecs!.isNotEmpty) {
        for (int i = 0; i < tuyendungModel.idNoiLamViecs!.length; i++) {
          if (i == 0) {
            tenNoiLamViec = tuyendungModel.idNoiLamViecs![i].ten.toString();
          } else {
            tenNoiLamViec += ', ${tuyendungModel.idNoiLamViecs![i].ten}';
          }
        }
      }
    }

    ///gán data tuyển dụng
    final Map<String, dynamic> param = {
      "id": tuyendungModel.id,
      "TieuDe": tuyendungModel.tieuDe,
      "CongTy": tuyendungModel.congTy,
      'DiaChiCongTy': tuyendungModel.diaChi,
      "GioiTinh": Validate.getGenderValue(tuyendungModel.gioiTinh),
      "SoLuong": tuyendungModel.soLuong,
      "TenHinhThucLamViec": tuyendungModel.idHinhThucLamViec,
      "TenTrinhDoHocVan": tuyendungModel.idTrinhDoHocVan,
      "TenChuyenNganhChinh": tuyendungModel.idChuyenNganhChinh,
      "TenChuyenNganhPhu": tenChuyenNganhPhu,
      "TenSoNamKinhNghiem": tuyendungModel.idSoNamKinhNghiem,
      "TenMucLuongDuKien": tuyendungModel.idMucLuongDuKien,
      "TenNoiLamViec": tenNoiLamViec,
      "TenThoiGianLamViec": tuyendungModel.idThoiGianLamViec,
      "ThoiGianThuViec": tuyendungModel.thoiGianThuViec,
      "MoTaCongViec": tuyendungModel.moTaCongViec,
      "YeuCauCongViec": tuyendungModel.yeuCauCongViec,
      "QuyenLoi": tuyendungModel.quyenLoi,
      "UuTien": tuyendungModel.uuTien,
      "HanNopHoSo": tuyendungModel.hanNopHoSo,
      "HoTenLienHe": tuyendungModel.hoTenLienHe,
      "SoDienThoaiLienHe": tuyendungModel.soDienThoaiLienHe,
      "DiaChiLienHe": tuyendungModel.diaChiLienHe,
      "EmailLienHe": tuyendungModel.emailLienHe,
    };

    Get.toNamed('${AppRoutes.V1_G7_REVIEW}?isReview=false', arguments: param);
  }

  ///
  /// load data ngoại ngữ
  ///
  void getDataNgoaiNgu() {
    //list ngoại ngữ
    ngoaiNguProvider.all(
        onSuccess: (value) {
          //add list
          ngoaiNguListModel = value;

          //set value tất cả
          ngoaiNguListModel.insert(0, NgoaiNguResponse(id: "0", loaiNgoaiNgu: "Tất cả"));

          update();
        },
        onError: (error) => print('V1CandidateController getDataNgoaiNgu $error'));
  }

  ///
  /// load data hình thức làm việc
  ///
  void getDataHinhThucLamViec() {
    //list hinh thuc lam iec
    hinhThucLamViecProvider.all(
        onSuccess: (value) {
          //add list
          hinhThucLamViecListModel = value;

          //set value tất cả
          hinhThucLamViecListModel.insert(0, HinhThucLamViecResponse(id: "0", tieuDe: "Tất cả"));
          update();
        },
        onError: (error) => print('V1CandidateController getDataHinhThucLamViec $error'));
  }

  ///
  /// load data mức lương dự kiến
  ///
  void getDataMucLuongDuKien() {
    //list hinh thuc lam iec
    mucLuongDuKienProvider.all(
        onSuccess: (value) {
          //add list
          mucLuongDuKienListModel = value;
          //set id 0
          mucLuongDuKienListModel.insert(0, MucLuongDuKienResponse(id: '0', tieuDe: 'Tất cả'));
          isLoadingCadidate = false;
          update();
        },
        onError: (error) => print('V2RecruitmentController getDataMucLuongDuKien $error'));
  }

  ///
  /// load data tỉnh tp
  ///
  void getDataTinhTp() {
    tinhTpProvider.all(
        onSuccess: (value) {
          //add list
          tinhTpListModel = value;
          //set value tất cả
          tinhTpListModel.insert(0, TinhTpResponse(id: "0", ten: "Toàn quốc"));
          update();
        },
        onError: (error) => print('V1CandidateController getDataTinhTp $error'));
  }

  ///
  /// load data chuyên môn
  ///
  void getDataChuyenMon() {
    loaiCongViecProvider.all(
        onSuccess: (value) {
          //add list
          chuyenMonListModel = value;
          //set value tất cả
          chuyenMonListModel.insert(0, LoaiCongViecResponse(id: "0", tenCongViec: "Tất cả"));
          update();
        },
        onError: (error) => print('V1CandidateController getDataChuyenMon $error'));
  }

  ///
  /// load data số năm kinh nghiệm
  ///
  void getDataSoNamKinhNghiem() {
    soNamKinhNghiemProvider.all(
        onSuccess: (value) {
          //add list
          soNamKinhNghiemListModel = value;
          //set value tất cả
          soNamKinhNghiemListModel.insert(0, SoNamKinhNghiemResponse(id: "0", tieuDe: "Tất cả"));
          update();
        },
        onError: (error) => print('V1CandidateController getDataSoNamKinhNghiem $error'));
  }

  ///
  /// load data trình độ
  ///
  void getDataTrinhDo() {
    trinhDoHocVanProvider.all(
        onSuccess: (value) {
          //add list
          trinhDoListModel = value;
          //set value tất cả
          trinhDoListModel.insert(0, TrinhDoHocVanResponse(id: "0", tieuDe: "Tất cả"));
          update();
        },
        onError: (error) => print('V1CandidateController getDataTrinhDo $error'));
  }

  /// Lọc

  ///
  ///chọn mức lương dự kiến
  ///
  void onChangeMucLuongDuKien(MucLuongDuKienResponse item) {
    mucLuongDuKien = item;
    isLoadingCadidate = true;

    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : term,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn hình thức làm việc
  ///
  void onChangeHinhThucLamViec(HinhThucLamViecResponse item) {
    hinhThucLamViecResponse = item;
    isLoadingCadidate = true;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn Trình độ
  ///
  void onChangeTrinhDo(TrinhDoHocVanResponse item) {
    trinhDoResponse = item;
    isLoadingCadidate = true;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn chuyên ngành chính
  ///
  void onChangeChuyenMon(LoaiCongViecResponse item) {
    chuyenMonResponse = item;
    isLoadingCadidate = true;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn số năm kinh nghiệm
  ///
  void onChangeSoNamKinhNghiem(SoNamKinhNghiemResponse item) {
    soNamKinhNghiemResponse = item;
    isLoadingCadidate = true;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn tỉnh tp làm việc
  ///
  void onChangeTinhTp(TinhTpResponse item) {
    tinhTpResponse = item;
    isLoadingCadidate = true;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn ngôn ngữ
  ///
  void onChangeNgoaiNgu(NgoaiNguResponse item) {
    ngoaiNguResponse = item;
    //set isOnChangeSearch
    isOnChangeSearch = true;
    //add new conditions
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
  }

  ///
  /// thay đổi giới tính
  ///
  void onChangedSex(GioiTinhModel text) {
    gioiTinh = text;
    isLoadingCadidate = true;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
      idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
      idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
      idGioiTinh: gioiTinh == null ? '' : gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien == null ? '' : mucLuongDuKien!.id!,
      idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
      idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
      ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
      isRefresh: true,
    );
    update();
  }

  ///
  /// Search
  ///
  void onSearch({
    bool isRefresh = false,
    String idHinhThucLamViec = '', // Hình thức làm việc
    String idTrinhDo = '', // Trình độ
    String idChuyenMon = '', // Chuyên ngành
    String idSoNamKinhNghiem = '', // Kinh nghiệm
    String idMucLuongDuKien = '', // Lương
    String idNoiLamViec = '', // Tỉnh thành phố
    String idGioiTinh = '', // Giới tính
    String term = '', // Từ khoá
    String ngoaiNgu = '', // Ngoại ngữ
  }) {
    String condition = '';
    if (idHinhThucLamViec.isNotEmpty && idHinhThucLamViec != '0') {
      condition = '&idHinhThucLamViec=$idHinhThucLamViec';
    }
    if (idTrinhDo.isNotEmpty && idTrinhDo != '0') {
      condition = '$condition&idTrinhDoHocVan=$idTrinhDo';
    }
    if (idChuyenMon.isNotEmpty && idChuyenMon != '0') {
      condition = '$condition&idLoaiCongViec=$idChuyenMon';
    }
    if (idSoNamKinhNghiem.isNotEmpty && idSoNamKinhNghiem != '0') {
      condition = '$condition&idSoNamKinhNghiem=$idSoNamKinhNghiem';
    }
    if (idMucLuongDuKien.isNotEmpty && idMucLuongDuKien != '0') {
      condition = '$condition&idMucLuongDuKien=$idMucLuongDuKien';
    }
    if (idNoiLamViec.isNotEmpty && idNoiLamViec != '0') {
      condition = '$condition&idTinhTp=$idNoiLamViec';
    }
    if (idGioiTinh.isNotEmpty && idGioiTinh != '-1') {
      condition = '$condition&gioiTinh=$idGioiTinh';
    }
    if (term.isNotEmpty) {
      condition = '$condition&tieuDeSearch=$term';
    }
    if (ngoaiNgu.isNotEmpty && ngoaiNgu != '0') {
      condition = '$condition&idNgoaiNgu=$ngoaiNgu';
    }
    //load data tuyen dung
    if (isRefresh) {
      //reset data
      pageMax = 1;
      limit = 5;
      dangKyViecMoiListModel.clear();
    } else {
      //isLoadingCadidate
      pageMax++;
    }
    dangKyViecMoiProvider.paginate(
        page: pageMax,
        limit: limit,
        filter: '&$condition&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}&sortBy=created_at:desc',
        onSuccess: (value) {
          print("Đã chạy và co data: ${value.length}");
          if (value.isEmpty) {
            refreshTimUngVienController.refreshCompleted();
          } else if (isRefresh) {
            //check refresh
            refreshTinTuyenDungController.resetNoData();
            dangKyViecMoiListModel = value;
            refreshTimUngVienController.refreshCompleted();
          } else {
            dangKyViecMoiListModel = dangKyViecMoiListModel.toList() + value;
            refreshTimUngVienController.loadComplete();
          }
          isLoadingCadidate = false;
          update();
        },
        onError: (error) => print('V1CandidateController onLoadDataTuyenDung $error'));
  }

  ///
  ///tìm kiếm theo tiêu đề
  ///
  void onChangeTieuDe(String text, BuildContext context) {
    if (text != '' && text.isNotEmpty) {
      term = TiengViet.parse(text);
      isLoadingCadidate = true;
      //add new conditions
      onSearch(
        term: term,
        idHinhThucLamViec: hinhThucLamViecResponse == null ? '' : hinhThucLamViecResponse!.id!,
        idTrinhDo: trinhDoResponse == null ? '' : trinhDoResponse!.id!,
        idChuyenMon: chuyenMonResponse == null ? '' : chuyenMonResponse!.id!,
        idGioiTinh: gioiTinh == null ? '' : term,
        idMucLuongDuKien: salary.toStringAsFixed(0),
        idNoiLamViec: tinhTpResponse == null ? '' : tinhTpResponse!.id!,
        idSoNamKinhNghiem: soNamKinhNghiemResponse == null ? '' : soNamKinhNghiemResponse!.id!,
        ngoaiNgu: ngoaiNguResponse == null ? '' : ngoaiNguResponse!.id!,
        isRefresh: true,
      );
    } else if (text == '') {
      onSearch(isRefresh: true);
    } else {
      //IZIAlert.error(message: 'Từ khoá không hợp lệ');
      // Từ khó tìm không có
    }
    update();
  }

  ///
  /// Onlick đến đơn tạo tuyển ứng viên
  ///
  void onClickFloatButton() {
    Get.toNamed(AppRoutes.V1_G7_RECRUITMENT)!.then((value) {
      if (value != null && value == true) {
        refreshTinTuyenDungController.resetNoData();
        onLoadDataTuyenDung(isRefresh: true);
      }
    });
  }

  ///
  /// Onlick đến xem thông tin hồ sơ ưng tuyển
  ///
  void onClickProfile({required DangKyViecMoiResponse dangKyViecMoiModel}) {
    Get.toNamed(AppRoutes.V1_CANDICATE_PROFILE, arguments: dangKyViecMoiModel);
  }

  ///
  ///  Hiẻn thị bộ lọc
  ///
  void showDialog() {
    Get.defaultDialog(
        title: "",
        content: const DialogContent(),
        cancel: ElevatedButton(
            onPressed: () {
              Get.back();
              //createConditionFilter(conditions);
            },
            child: const Text("Tìm kiếm")));
  }
}
