import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_sach_ung_tuyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_luu_tin_tuyen_dung_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/tuyen_dung_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/device_utils.dart';
import 'package:tiengviet/tiengviet.dart';

class V2HistoryRecruitmentNewsController extends GetxController {
  //Provider
  final danhSachLuuTinTuyenDungProvider =
      GetIt.I.get<DanhSachLuuTinTuyenDungProvider>();
  final danhSachUngTuyenProvider = GetIt.I.get<DanhSachUngTuyenProvider>();
  final tuyenDungProvider = GetIt.I.get<TuyenDungProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();

  //search controller
  final searchController = TextEditingController();
  //Reposion
  List<TuyenDungResponse> tuyenDungListSearch = [];
  List<DanhSachUngTuyenResponse> danhSachUngTuyenList = [];
  List<TinhTpResponse> tinhTpListModel = [];

  //userId
  String? userId;

  //value tìm kiếm tiêu đề
  String tieuDeSearch = '';

  //refresh
  RefreshController refreshController = RefreshController();

  //ScrollController
  ScrollController scrollController = ScrollController();

  //Refresh Page tuyển dụng
  int pageMax = 1;
  int limit = 5;

  //isLoading
  bool isLoading = true;

  bool isSearch = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get data tỉnh tp
    getDataTinhTp();

    //find userID
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getDataUngTuyen();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    searchController.dispose();
    refreshController.dispose();
    super.onClose();
  }

  ///
  ///onRefresh
  ///
  Future onRefresh() async {
    refreshController.resetNoData();
    tieuDeSearch = '';
    getDataTuyenDung(isRefresh: true);
  }

  ///
  ///onLoading
  ///
  Future onLoading() async {
    getDataTuyenDung(isRefresh: false);
  }

  void onChangedStatus() {
    isSearch = !isSearch;
    update();
  }

  ///
  ///tìm kiếm theo tiêu đề
  ///
  void onChangeTieuDe(BuildContext context) {
    isLoading = true;
    refreshController.resetNoData();
    //check tìm kiếm
    if (searchController.text.isEmpty) {
      tieuDeSearch = '';
    } else {
      tieuDeSearch = TiengViet.parse(searchController.text);
    }
    //tắt keyboard
    DeviceUtils.hideKeyboard(context);
    //load data
    getDataTuyenDung(isRefresh: true);

    update();
  }

  ///
  ///getDataUngTuyen
  ///
  void getDataUngTuyen() {
    danhSachUngTuyenProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idTaiKhoanUngTuyen=$userId',
        onSuccess: (value) {
          danhSachUngTuyenList.addAll(value);

          getDataTuyenDung(isRefresh: true);
        },
        onError: (error) =>
            print('V2HistoryRecruitmentNewsController getDataUngTuyen $error'));
  }

  ///
  ///getDataTuyenDung
  ///
  void getDataTuyenDung({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      tuyenDungListSearch.clear();
    } else {
      //isLoading
      pageMax++;
    }

    ///check tiêu đề
    if (tieuDeSearch == '') {
      tieuDeSearch = '';
      searchController.text = '';
    } else {
      tieuDeSearch = '&tieuDe=$tieuDeSearch';
    }

    tuyenDungProvider.paginate(
        page: pageMax,
        limit: limit,
        filter: '&typeSearch=1&idTaiKhoan=$userId$tieuDeSearch',
        onSuccess: (value) {
          //check data empty
          if (value.isEmpty) {
            refreshController.loadNoData();
          } else if (isRefresh) {
            //check refresh
            tuyenDungListSearch = value;
            refreshController.refreshCompleted();
            //check đã ứng tuyển
            for (int i = 0; i < danhSachUngTuyenList.length; i++) {
              for (int j = 0; j < tuyenDungListSearch.length; j++) {
                if (danhSachUngTuyenList[i].idTuyenDung!.id.toString() ==
                    tuyenDungListSearch[j].id.toString()) {
                  tuyenDungListSearch[j].isUngTuyen = true;
                } else {
                  tuyenDungListSearch[j].isUngTuyen = false;
                }
              }
            }
          } else {
            tuyenDungListSearch = tuyenDungListSearch.toList() + value;
            //check đã ứng tuyển
            for (int i = 0; i < danhSachUngTuyenList.length; i++) {
              for (int j = 0; j < tuyenDungListSearch.length; j++) {
                if (danhSachUngTuyenList[i].idTuyenDung!.id.toString() ==
                    tuyenDungListSearch[j].id.toString()) {
                  tuyenDungListSearch[j].isUngTuyen = true;
                } else {
                  tuyenDungListSearch[j].isUngTuyen = false;
                }
              }
            }
            refreshController.loadComplete();
          }
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2HistoryRecruitmentNewsController getDataUngTuyen $error'));
  }

  ///
  /// load data tỉnh tp
  ///
  void getDataTinhTp() {
    tinhTpProvider.all(
        onSuccess: (value) {
          //add list
          tinhTpListModel = value;

          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataTinhTp $error'));
  }

  ///
  ///onChangeNameTinhTp
  ///
  String? onChangeNameTinhTp(String id) {
    return tinhTpListModel.firstWhere((element) => element.id == id).ten;
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

    Get.toNamed(
        '${AppRoutes.V2_VIEW_RECRUITMENT_NEWS}?isUngTuyen=${tuyendung.isUngTuyen}',
        arguments: param);
  }
}
