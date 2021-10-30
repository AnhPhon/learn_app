import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/gioi_tinh_model.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
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
import 'package:tiengviet/tiengviet.dart';

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
  String term = '';
  String termCompany ='';

  // Refresh
  RefreshController refreshTinTuyenDungController = RefreshController();

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
  

  //set default giới tính
  List<GioiTinhModel> gioiTinhModel = [
    GioiTinhModel(key: '0', value: 'Giới tính'),
    GioiTinhModel(key: '1', value: 'Nam'),
    GioiTinhModel(key: '2', value: 'Nữ'),
  ];

  GioiTinhModel? gioiTinh;

  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //isLoading
  bool isLoading = true;

  //isShowSearch
  //bool isShowSearch = false;
    //conditionFilter
  //isLoadingTuyenDung
  bool isLoadingTuyenDung = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

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
    if(!isLoading){
      if(
        hinhThucLamViec!.id.toString() == '0' &&
        trinhDoHocVan!.id.toString() == '0'  &&
        chuyenNganhChinh!.id.toString() == '0'  &&
        gioiTinh!.key.toString() == '0' &&
        mucLuongDuKien!.id.toString() == '0' &&
        noiLamViec!.id.toString() == '0'  &&
        soNamKinhNghiem!.id.toString() == '0'  &&
        term.isEmpty && termCompany.isEmpty
      ){
        onSearch(isRefresh: isRefresh);
      }else{
        onSearch(
          term: term,
          idHinhThucLamViec: hinhThucLamViec!.id!,
          idTrinhDoHocVan: trinhDoHocVan!.id!, 
          idChuyenNganhChinh: chuyenNganhChinh!.id!, 
          idGioiTinh: gioiTinh!.key!,
          idMucLuongDuKien: mucLuongDuKien!.id!,
          idNoiLamViec: noiLamViec!.id!,
          idSoNamKinhNghiem: soNamKinhNghiem!.id!,
          termCompany: termCompany,
          isRefresh: isRefresh
        );
      }
    }else{
      //isRefresh
      onSearch(isRefresh: isRefresh);
    }
  }


  

  // ///
  // /// Thay đồi trạng thái là tìm kiếm
  // ///
  // void onChangedSearch() {
  //   isShowSearch = !isShowSearch;
  //   update();
  // }

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
    onSearch(
      term: term,
      idHinhThucLamViec: item.id!,
      idTrinhDoHocVan: trinhDoHocVan!.id!, 
      idChuyenNganhChinh: chuyenNganhChinh!.id!, 
      idGioiTinh: gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien!.id!,
      idNoiLamViec: noiLamViec!.id!,
      idSoNamKinhNghiem: soNamKinhNghiem!.id!,
      termCompany: termCompany,
      isRefresh: true,
    );
    update();
  }


  ///
  ///chọn hình thức làm việc
  ///
  void onChangeTrinhDoHocVan(TrinhDoHocVanResponse item) {
    trinhDoHocVan = item;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViec!.id!,
      idTrinhDoHocVan: item.id!, 
      idChuyenNganhChinh: chuyenNganhChinh!.id!, 
      idGioiTinh: gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien!.id!,
      idNoiLamViec: noiLamViec!.id!,
      idSoNamKinhNghiem: soNamKinhNghiem!.id!,
      termCompany: termCompany,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn chuyên ngành chính
  ///
  void onChangeChuyenNganhChinh(ChuyenNganhChinhResponse item) {
    chuyenNganhChinh = item;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViec!.id!,
      idTrinhDoHocVan: trinhDoHocVan!.id!, 
      idChuyenNganhChinh: chuyenNganhChinh!.id!, 
      idGioiTinh: gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien!.id!,
      idNoiLamViec: noiLamViec!.id!,
      idSoNamKinhNghiem: soNamKinhNghiem!.id!,
      termCompany: termCompany,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn số năm kinh nghiệm
  ///
  void onChangeSoNamKinhNghiem(SoNamKinhNghiemResponse item) {
    soNamKinhNghiem = item;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViec!.id!,
      idTrinhDoHocVan: trinhDoHocVan!.id!, 
      idChuyenNganhChinh: chuyenNganhChinh!.id!, 
      idGioiTinh: gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien!.id!,
      idNoiLamViec: noiLamViec!.id!,
      idSoNamKinhNghiem: soNamKinhNghiem!.id!,
      termCompany: termCompany,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn mức lương dự kiến
  ///
  void onChangeMucLuongDuKien(MucLuongDuKienResponse item) {
    mucLuongDuKien = item;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViec!.id!,
      idTrinhDoHocVan: trinhDoHocVan!.id!, 
      idChuyenNganhChinh: chuyenNganhChinh!.id!, 
      idGioiTinh: gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien!.id!,
      idNoiLamViec: noiLamViec!.id!,
      idSoNamKinhNghiem: soNamKinhNghiem!.id!,
      termCompany: termCompany,
      isRefresh: true,
    );
    update();
  }

  ///
  ///chọn tỉnh tp làm việc
  ///
  void onChangeTinhTp(TinhTpResponse item) {
    noiLamViec = item;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViec!.id!,
      idTrinhDoHocVan: trinhDoHocVan!.id!, 
      idChuyenNganhChinh: chuyenNganhChinh!.id!, 
      idGioiTinh: gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien!.id!,
      idNoiLamViec: noiLamViec!.id!,
      idSoNamKinhNghiem: soNamKinhNghiem!.id!,
      termCompany: termCompany,
      isRefresh: true,
    );
    update();
  }

  ///
  /// thay đổi giới tính
  ///
  void onChangedSex(GioiTinhModel text) {
    gioiTinh = text;
    onSearch(
      term: term,
      idHinhThucLamViec: hinhThucLamViec!.id!,
      idTrinhDoHocVan: trinhDoHocVan!.id!, 
      idChuyenNganhChinh: chuyenNganhChinh!.id!, 
      idGioiTinh: gioiTinh!.key!,
      idMucLuongDuKien: mucLuongDuKien!.id!,
      idNoiLamViec: noiLamViec!.id!,
      idSoNamKinhNghiem: soNamKinhNghiem!.id!,
      termCompany: termCompany,
      isRefresh: true,
    );
    update();
  }



  ///
  /// Search
  ///
  void onSearch({ bool isRefresh = false,
                  String idHinhThucLamViec='', // Hình thức làm việc
                  String idTrinhDoHocVan= '',  // Trình độ
                  String idChuyenNganhChinh = '', // Chuyên ngành
                  String idSoNamKinhNghiem = '', // Kinh nghiệm
                  String idMucLuongDuKien = '', // Lương
                  String idNoiLamViec = '', // Tỉnh thành phố
                  String idGioiTinh = '', // Giới tính
                  String term = '', // Từ khoá
                  String termCompany = '', // Công ty

  }){
    String condition = '';
    print('Noid dung 2 $term');
    if(idHinhThucLamViec.isNotEmpty && idHinhThucLamViec != '0'){
      condition = '&idHinhThucLamViec=$idHinhThucLamViec';
    } 
    if(idTrinhDoHocVan.isNotEmpty && idTrinhDoHocVan != '0'){
      condition = '$condition&idTrinhDoHocVan=$idTrinhDoHocVan';
    }
    if(idChuyenNganhChinh.isNotEmpty && idChuyenNganhChinh != '0'){
      condition = '$condition&idChuyenNganhChinh=$idChuyenNganhChinh';
    }
    if(idSoNamKinhNghiem.isNotEmpty && idSoNamKinhNghiem != '0'){
      condition = '$condition&idSoNamKinhNghiem=$idSoNamKinhNghiem';
    }
    if(idMucLuongDuKien.isNotEmpty && idMucLuongDuKien != '0'){
      condition = '$condition&idMucLuongDuKien=$idMucLuongDuKien';
    }
    if(idNoiLamViec.isNotEmpty && idNoiLamViec != '0'){
      condition = '$condition&idNoiLamViec=$idNoiLamViec';
    }
    if(idGioiTinh.isNotEmpty && idGioiTinh != '0'){
      condition = '$condition&gioiTinh=$idGioiTinh';
    }
    if(term.isNotEmpty){
      condition = '$condition&tieuDe=$term';
    }
    if(termCompany.isNotEmpty){
      condition = '$condition&congTy=$termCompany';
    }
    //load data tuyen dung
    print('DK $condition $term' );
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
        filter: '&sortBy=created_at:desc$condition',
        onSuccess: (value) {
          print(value.length);
          if (value.isEmpty) {
            print('1 nodata');
            refreshTinTuyenDungController.loadNoData();
          } else if (isRefresh) {
            //check refresh
            refreshTinTuyenDungController.resetNoData();
            tuyenDungListModel = value;
            refreshTinTuyenDungController.refreshCompleted();
            print('2 isRefresh');
          } else {
            tuyenDungListModel = tuyenDungListModel.toList() + value;
            refreshTinTuyenDungController.loadComplete();
            print('3 loading');
          }
          //tuyenDungListModel = value;
          update();
        },
        onError: (error) =>
            print('V1CandidateController onLoadDataTuyenDung $error'));
  }


  ///
  ///tìm kiếm theo tiêu đề
  ///
  void onChangeTieuDe(String text, BuildContext context) {
    if (text != '' && text.isNotEmpty) {
      term = TiengViet.parse(text);
      //add new conditions
      onSearch(
        term: term,
        idHinhThucLamViec: hinhThucLamViec!.id!,
        idTrinhDoHocVan: trinhDoHocVan!.id!, 
        idChuyenNganhChinh: chuyenNganhChinh!.id!, 
        idGioiTinh: gioiTinh!.key!,
        idMucLuongDuKien: mucLuongDuKien!.id!,
        idNoiLamViec: noiLamViec!.id!,
        idSoNamKinhNghiem: soNamKinhNghiem!.id!,
        termCompany: termCompany,
        isRefresh: true,
      );
    } else if (text == '') {
      onSearch(isRefresh: true);
    } else {
      //Alert.error(message: 'Từ khoá không hợp lệ');
      // Từ khó tìm không có
    }
    update();
  }
  ///
  ///tìm kiếm theo công ty
  ///
  void onChangeCompany(String text, BuildContext context) {
    if (text != '' && text.isNotEmpty) {
      termCompany = TiengViet.parse(text);
      //add new conditions
      onSearch(
        term: term,
        idHinhThucLamViec: hinhThucLamViec!.id!,
        idTrinhDoHocVan: trinhDoHocVan!.id!, 
        idChuyenNganhChinh: chuyenNganhChinh!.id!, 
        idGioiTinh: gioiTinh!.key!,
        idMucLuongDuKien: mucLuongDuKien!.id!,
        idNoiLamViec: noiLamViec!.id!,
        idSoNamKinhNghiem: soNamKinhNghiem!.id!,
        termCompany: termCompany,
        isRefresh: true,
      );
    } else if (text == '') {
      onSearch(isRefresh: true);
    } else {
      //Alert.error(message: 'Từ khoá không hợp lệ');
      // Từ khó tìm không có
    }
    update();
  }

  ///
  ///onChangeNameTinhTp
  ///
  String? onChangeNameTinhTp(String id) {
    return tinhTpListModel.firstWhere((element) => element.id == id).ten;
  }
  ///
  /// Nhấn vào tin tuyển dụng thì xem thông tin của tin
  ///
  void onClickRecruitmentNews(TuyenDungResponse tuyendung) {
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
