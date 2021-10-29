import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/gioi_tinh_model.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_tin_tuyen_dung_model.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/provider/chuyen_nganh_chinh_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/muc_luong_du_kien_provider.dart';
import 'package:template/provider/so_nam_kinh_nghiem_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/trinh_do_hoc_van_provider.dart';
import 'package:template/provider/tuyen_dung_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/dialog_content.dart';

class V2SearchRecruitmentController extends GetxController {
  // refresh controller for load more refresh
  List<RefreshController>? refreshControllerList;

  //Providers
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final ChuyenNganhChinhProvider chuyenNganhChinhProvider =
      GetIt.I.get<ChuyenNganhChinhProvider>();
  final MucLuongDuKienProvider mucLuongDuKienProvider =
      GetIt.I.get<MucLuongDuKienProvider>();
  final TrinhDoHocVanProvider trinhDoHocVanProvider =
      GetIt.I.get<TrinhDoHocVanProvider>();
  final SoNamKinhNghiemProvider soNamKinhNghiemProvider =
      GetIt.I.get<SoNamKinhNghiemProvider>();
  final HinhThucLamViecProvider hinhThucLamViecProvider =
      GetIt.I.get<HinhThucLamViecProvider>();
  final TuyenDungProvider tuyenDungProvider = GetIt.I.get<TuyenDungProvider>();

  //model value
  List<HinhThucLamViecResponse> hinhThucLamViecListModel = [];
  List<TrinhDoHocVanResponse> trinhDoHocVanListModel = [];
  List<ChuyenNganhChinhResponse> chuyenNganhChinhListModel = [];
  List<SoNamKinhNghiemResponse> soNamKinhNghiemListModel = [];
  List<MucLuongDuKienResponse> mucLuongDuKienListModel = [];
  List<TinhTpResponse> tinhTpListModel = [];
   List<TuyenDungResponse> tuyenDungListModel = [];

  //model choose
  HinhThucLamViecResponse? hinhThucLamViec;
  TrinhDoHocVanResponse? trinhDoHocVan;
  ChuyenNganhChinhResponse? chuyenNganhChinh;
  SoNamKinhNghiemResponse? soNamKinhNghiem;
  MucLuongDuKienResponse? mucLuongDuKien;
  TinhTpResponse? noiLamViec;

  // Refresh
  RefreshController refreshTinTuyenDungController = RefreshController();

  final searchController = TextEditingController();
  bool isSearch = false;

  //currentIndex
  int currentIndex = 0;
  // Value slider
  double salary = 0;

  //controller search
  final tieuDeController = TextEditingController();
  final tieuDeFocusNode = FocusNode();
  final congTyController = TextEditingController();
  final congTyFocusNode = FocusNode();
  
  //loại tin tuyển dụng
  List<LoaiTinTuyenDungModel> loaiTinTuyenDung = [
    LoaiTinTuyenDungModel(id: '1', tieuDe: 'Tin hot'),
    LoaiTinTuyenDungModel(id: '2', tieuDe: 'Mới nhất'),
    LoaiTinTuyenDungModel(id: '3', tieuDe: 'Tuyển dụng'),
  ];

  //set default giới tính
  List<GioiTinhModel> gioiTinhModel = [
    GioiTinhModel(key: '0', value: 'Giới tính'),
    GioiTinhModel(key: 'gioiTinh', value: 'Nam'),
    GioiTinhModel(key: 'gioiTinh', value: 'Nữ'),
  ];

  GioiTinhModel? gioiTinh;

  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //isLoading
  bool isLoading = true;

  //isShowSearch
  bool isShowSearch = false;
    //conditionFilter
  String conditionFilter = '';
  //isLoadingTuyenDung
  bool isLoadingTuyenDung = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //binding refresh controller
    // refreshControllerList =
    //     List.generate(loaiTinTuyenDung.length, (_) => RefreshController());

    //loadDataFiltter
    getDataHinhThucLamViec();
    getDataTrinhDoHocVan();
    getDataChuyenNganhChinh();
    getDataTrinhDoHocVan();
    getDataSoNamKinhNghiem();
    getDataMucLuongDuKien();
    getDataTinhTp();
    gioiTinh = gioiTinhModel.first;
    onLoadDataTuyenDung(isRefresh: true);
  }

  

  //onRefresh
  Future<void> onRefresh() async {
    //resetNoData
    refreshControllerList![currentIndex].resetNoData();
    onLoadDataTuyenDung(isRefresh: true);

  }

  //onLoading
  Future<void> onLoading() async {
    onLoadDataTuyenDung(isRefresh: false);
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
      //isLoading
      pageMax++;
    }
    //load data tuyen dung
    tuyenDungProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&sortBy=created_at:desc',
        onSuccess: (value) {
          print(value);
          //check data empty
          if (value.isEmpty) {
            print('1 nodata');
            refreshTinTuyenDungController.loadNoData();
          } else if (isRefresh) {
            //check refresh
            tuyenDungListModel = value;
            refreshTinTuyenDungController.refreshCompleted();
            print('2 isRefresh');
          } else {
            tuyenDungListModel = tuyenDungListModel.toList() + value;
            refreshTinTuyenDungController.loadComplete();
            print('3 loading');
          }
          isLoadingTuyenDung = false;
          update();
        },
        onError: (error) =>
            print('V1CandidateController onLoadDataTuyenDung $error'));
  }

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  /// thay đổi lương
  ///
  void onChangedSalary(double salary) {
    this.salary = salary;
    update();
  }

  ///
  /// Thay đồi trạng thái là tìm kiếm
  ///
  void onChangedSearch() {
    isShowSearch = !isShowSearch;
    update();
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
          //set id 0
          hinhThucLamViecListModel.insert(
              0, HinhThucLamViecResponse(id: '0', tieuDe: 'Hình thức'));
          hinhThucLamViec = hinhThucLamViecListModel.first;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2RecruitmentController getDataHinhThucLamViec $error'));
  }

  ///
  /// load data trình độ học vấn
  ///
  void getDataTrinhDoHocVan() {
    //list hinh thuc lam iec
    trinhDoHocVanProvider.all(
        onSuccess: (value) {
          //add list
          trinhDoHocVanListModel = value;
          //set id 0
          trinhDoHocVanListModel.insert(
              0, TrinhDoHocVanResponse(id: '0', tieuDe: 'Trình độ'));
          trinhDoHocVan = trinhDoHocVanListModel.first;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2RecruitmentController getDataTrinhDoHocVan $error'));
  }

  ///
  /// load data chuyên ngành chính
  ///
  void getDataChuyenNganhChinh() {
    //list hinh thuc lam iec
    chuyenNganhChinhProvider.all(
        onSuccess: (value) {
          //add list
          chuyenNganhChinhListModel = value;
          //set id 0
          chuyenNganhChinhListModel.insert(
              0, ChuyenNganhChinhResponse(id: '0', tieuDe: 'Chuyên ngành'));
          chuyenNganhChinh = chuyenNganhChinhListModel.first;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2RecruitmentController getDataChuyenNangChinh $error'));
  }

  ///
  /// load data số năm kinh nghiệm
  ///
  void getDataSoNamKinhNghiem() {
    //list hinh thuc lam iec
    soNamKinhNghiemProvider.all(
        onSuccess: (value) {
          //add list
          soNamKinhNghiemListModel = value;
          //set id 0
          soNamKinhNghiemListModel.insert(
              0, SoNamKinhNghiemResponse(id: '0', tieuDe: 'Kinh nghiệm'));
          soNamKinhNghiem = soNamKinhNghiemListModel.first;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2RecruitmentController getDataSoNamKinhNghiem $error'));
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
          mucLuongDuKienListModel.insert(
              0, MucLuongDuKienResponse(id: '0', tieuDe: 'Mức lương'));
          mucLuongDuKien = mucLuongDuKienListModel.first;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2RecruitmentController getDataMucLuongDuKien $error'));
  }

  ///
  /// load data tỉnh Tp
  ///
  void getDataTinhTp() {
    //list tỉnh tp
    tinhTpProvider.all(
        onSuccess: (value) {
          //add list
          tinhTpListModel = value;
          //set id 0
          tinhTpListModel.insert(0, TinhTpResponse(id: '0', ten: 'Tỉnh/Tp'));
          noiLamViec = tinhTpListModel.first;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2RecruitmentController getDataTinhTp $error'));
  }


/// Lọc

  ///
  ///chọn hình thức làm việc
  ///
  void onChangeHinhThucLamViec(HinhThucLamViecResponse item) {
    hinhThucLamViec = item;
    update();
  }

  ///
  ///chọn hình thức làm việc
  ///
  void onChangeTrinhDoHocVan(TrinhDoHocVanResponse item) {
    trinhDoHocVan = item;
    update();
  }

  ///
  ///chọn chuyên ngành chính
  ///
  void onChangeChuyenNganhChinh(ChuyenNganhChinhResponse item) {
    chuyenNganhChinh = item;
    update();
  }

  ///
  ///chọn số năm kinh nghiệm
  ///
  void onChangeSoNamKinhNghiem(SoNamKinhNghiemResponse item) {
    soNamKinhNghiem = item;
    update();
  }

  ///
  ///chọn mức lương dự kiến
  ///
  void onChangeMucLuongDuKien(MucLuongDuKienResponse item) {
    mucLuongDuKien = item;
    update();
  }

  ///
  ///chọn tỉnh tp làm việc
  ///
  void onChangeTinhTp(TinhTpResponse item) {
    noiLamViec = item;
    update();
  }

  ///
  /// thay đổi giới tính
  ///
  void onChangedSex(GioiTinhModel text) {
    gioiTinh = text;

    update();
  }

  ///
  /// Nhấn vào tin tuyển dụng thì xem thông tin của tin
  ///
  void onClickRecruitmentNews() {
    Get.toNamed(AppRoutes.V2_VIEW_RECRUITMENT_NEWS);
  }

  ///
  /// Nhấn vào icon lịch sử trên appbar
  ///
  void onClickHistory() {
    Get.toNamed(AppRoutes.V2_HISTORY_RECRUITMENT_NEWS);
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
              Navigator.of(Get.context!).pop();
            },
            child: const Text("Tìm kiếm")));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    tieuDeController.dispose();
    congTyController.dispose();
    tieuDeFocusNode.dispose();
    congTyFocusNode.dispose();
    refreshTinTuyenDungController.dispose();
    super.onClose();
  }
}
