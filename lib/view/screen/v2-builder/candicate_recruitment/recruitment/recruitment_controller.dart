import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/loai_tin_tuyen_dung_model.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/tuyen_dung_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/dialog_content.dart';

class V2RecruitmentController extends GetxController {
  // refresh controller for load more refresh
  List<RefreshController>? refreshControllerList;

  //Providers
  final TuyenDungProvider tuyenDungProvider = GetIt.I.get<TuyenDungProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();

  //value model
  List<TuyenDungResponse> tuyenDungListModel = [];
  List<TinhTpResponse> tinhTpListModel = [];

  final searchController = TextEditingController();
  bool isSearch = false;

  //currentIndex
  int currentIndex = 0;
  // Value slider
  double salary = 0;

  //loại tin tuyển dụng
  List<LoaiTinTuyenDungModel> loaiTinTuyenDung = [
    LoaiTinTuyenDungModel(id: '1', tieuDe: 'Tin hot'),
    LoaiTinTuyenDungModel(id: '2', tieuDe: 'Mới nhất'),
    LoaiTinTuyenDungModel(id: '3', tieuDe: 'Tuyển dụng'),
  ];

  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //isLoading
  bool isLoading = true;

  //isShowSearch
  bool isShowSearch = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //binding refresh controller
    refreshControllerList =
        List.generate(loaiTinTuyenDung.length, (_) => RefreshController());

    //get data tỉnh Tp
    getDataTinhTp();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  //onRefresh
  Future<void> onRefresh() async {
    //resetNoData
    refreshControllerList![currentIndex].resetNoData();
    //get order isRefresh
    getDataTuyenDung(
        loaiTin: loaiTinTuyenDung[currentIndex].id.toString(), isRefresh: true);
  }

  //onLoading
  Future<void> onLoading() async {
    //get order isLoading
    getDataTuyenDung(
        loaiTin: loaiTinTuyenDung[currentIndex].id.toString(),
        isRefresh: false);
  }

  ///
  /// load data tỉnh tp
  ///
  void getDataTinhTp() {
    tinhTpProvider.all(
        onSuccess: (value) {
          //add list
          tinhTpListModel = value;
          //getDataTuyenDung
          getDataTuyenDung(
              loaiTin: loaiTinTuyenDung.first.id.toString(), isRefresh: true);
          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataTinhTp $error'));
  }

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab({required int index}) {
    isLoading = true;
    currentIndex = index;
    getDataTuyenDung(
        loaiTin: loaiTinTuyenDung[currentIndex].id.toString(), isRefresh: true);
    update();
  }

  ///
  ///onChangeNameTinhTp
  ///
  String? onChangeNameTinhTp(String id) {
    return tinhTpListModel.firstWhere((element) => element.id == id).ten;
  }

  ///
  ///getDataSeach
  ///
  void getDataTuyenDung({required String loaiTin, required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      tuyenDungListModel.clear();
    } else {
      //isLoading
      pageMax++;
    }

    tuyenDungProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&loaiTin=$loaiTin',
        onSuccess: (value) {
          print('conditionFilter value ${value.length}');
          //check data empty
          if (value.isEmpty) {
            refreshControllerList![currentIndex].loadNoData();
          } else if (isRefresh) {
            //check refresh
            tuyenDungListModel = value;
            refreshControllerList![currentIndex].refreshCompleted();
          } else {
            tuyenDungListModel.addAll(value);
            refreshControllerList![currentIndex].loadComplete();
          }

          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2RecruitmentController getDataTuyenDung $error'));
  }

  ///
  /// thay đổi lương
  ///
  void onChangedSalary(double salary) {
    this.salary = salary;
    update();
  }

  ///
  /// chuyển sang trang tìm kiếm
  ///
  void onChangedSearch() {
    Get.toNamed(AppRoutes.V2_SEARCH_RECRUITMENT_NEWS);
  }

  ///
  ///
  /// Nhấn vào tin tuyển dụng thì xem thông tin của tin
  ///
  void onClickRecruitmentNews({required TuyenDungResponse tuyendung}) {
    ///set tên chuyên ngành phụ
    String tenChuyenNganhPhu = '';
    // set tên chuyên ngành phụ
    if (tuyendung.idChuyenNganhPhus!.isNotEmpty) {
      for (int i = 0; i < tuyendung.idChuyenNganhPhus!.length; i++) {
        if (i == 0) {
          tenChuyenNganhPhu = tuyendung.idChuyenNganhPhus![i].tieuDe.toString();
        } else {
          tenChuyenNganhPhu +=
              ', ${tuyendung.idChuyenNganhPhus![i].tieuDe.toString()}';
        }
      }
    }

    ///gán data tuyển dụng
    Map<String, dynamic> param = {
      "idTuyenDung": tuyendung.id,
      "TieuDe": tuyendung.tieuDe,
      "CongTy": tuyendung.congTy,
      'TenDiaChiCongTy':
          '${tuyendung.diaChi}, ${tuyendung.idPhuongXa}, ${tuyendung.idQuanHuyen}, ${tuyendung.idTinhTp}',
      "GioiTinh": tuyendung.gioiTinh == 'Nam' ? '1' : '2',
      "SoLuong": tuyendung.soLuong,
      "TenHinhThucLamViec": tuyendung.idHinhThucLamViec,
      "TenTrinhDoHocVan": tuyendung.idTrinhDoHocVan,
      "TenChuyenNganhChinh": tuyendung.idChuyenNganhChinh,
      "TenChuyenNganhPhu": tenChuyenNganhPhu,
      "TenSoNamKinhNghiem": tuyendung.idSoNamKinhNghiem,
      "TenMucLuongDuKien": tuyendung.idMucLuongDuKien,
      "TenNoiLamViec": onChangeNameTinhTp(tuyendung.noiLamViec.toString()),
      "TenThoiGianLamViec": tuyendung.idThoiGianLamViec,
      "ThoiGianThuViec": tuyendung.thoiGianThuViec,
      "MoTaCongViec": tuyendung.moTaCongViec,
      "YeuCauCongViec": tuyendung.yeuCauCongViec,
      "QuyenLoi": tuyendung.quyenLoi,
      "UuTien": tuyendung.uuTien,
      "HanNopHoSo": tuyendung.hanNopHoSo,
      "HoTenLienHe": tuyendung.hoTenLienHe,
      "SoDienThoaiLienHe": tuyendung.soDienThoaiLienHe,
      "DiaChiLienHe": tuyendung.diaChiLienHe,
      "EmailLienHe": tuyendung.emailLienHe,
    };

    Get.toNamed(AppRoutes.V2_VIEW_RECRUITMENT_NEWS, arguments: param);
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
}
