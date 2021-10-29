import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/hon_nhan_model.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/repository/dang_ky_viec_moi_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2CvController extends GetxController {
  //Provider
  final dangKyViecMoiProvider = GetIt.I.get<DangKyViecMoiProvider>();
  final hinhThucLamViecProvider = GetIt.I.get<HinhThucLamViecProvider>();
  final tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final phuongXaProvider = GetIt.I.get<PhuongXaProvider>();

  //Repository
  DangKyViecMoiRepository dangKyViecMoiRepository = DangKyViecMoiRepository();

  //Response
  DangKyViecMoiResponse dangKyViecMoiResponse = DangKyViecMoiResponse();

  //request
  DangKyViecMoiRequest dangKyViecMoiRequest = DangKyViecMoiRequest();

  //model value
  List<HinhThucLamViecResponse> hinhThucLamViecListModel = [];
  List<TinhTpResponse> tinhTpListModel = [];
  List<QuanHuyenResponse> quanHuyenListModel = [];
  List<PhuongXaResponse> phuongXaListModel = [];

  //model choose
  HinhThucLamViecResponse? hinhThucLamViec;
  TinhTpResponse? tinhTp;
  QuanHuyenResponse? quanHuyenResponse;
  PhuongXaResponse? phuongXaResponse;

  List<HonNhanModel> honNhanListModel = [
    HonNhanModel(id: '1', tieuDe: 'Độc thân'),
    HonNhanModel(id: '2', tieuDe: 'Đã lập gia đình'),
    HonNhanModel(id: '3', tieuDe: 'Khác'),
  ];

  // Tiêu đề
  final titleController = TextEditingController();
  // địa chỉ
  final addressController = TextEditingController();

  //foscusNode
  final titleFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  //idTuyenDung
  String? idTuyenDung;

  //userId
  String? userId;

  //isLoading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idTuyenDung = Get.parameters['idTuyenDung'];
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getDataUserViecMoi();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///getDataUserViecMoi
  ///
  void getDataUserViecMoi() {
    dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter: '&idTaiKhoan=$userId',
        onSuccess: (value) {
          dangKyViecMoiResponse = value.first;

          //set địa chỉ
          addressController.text = dangKyViecMoiResponse.diaChi.toString();
          print('dangKyViecMoiResponse ${dangKyViecMoiResponse.toJson()}');
          getDataHinhThucLamViec();
          update();
        },
        onError: (error) => print('V2CvController getDataUserViecMoi $error'));
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
          // isLoading = false;
          getDataTinhTp(isLoadFrist: true);
          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataHinhThucLamViec $error'));
  }

  ///
  /// load data tỉnh Tp
  ///
  void getDataTinhTp({required bool isLoadFrist}) {
    //list hinh thuc lam iec
    tinhTpProvider.all(
        onSuccess: (value) {
          //add list
          tinhTpListModel = value;
          // isLoading = false;

          if (isLoadFrist) {
            //set idTinh
            tinhTp = value.firstWhere((element) => element.ten!
                .contains(dangKyViecMoiResponse.idTinhTp.toString()));

            getDataQuanHuyen(idTinh: tinhTp!.id.toString(), isLoadFrist: true);
          }

          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataTinhTp $error'));
  }

  ///
  /// load data quận huyện
  ///
  void getDataQuanHuyen({required String idTinh, required bool isLoadFrist}) {
    quanHuyenProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idTinhTp=$idTinh',
        onSuccess: (value) {
          quanHuyenResponse = null;
          phuongXaResponse = null;
          quanHuyenListModel.clear();
          phuongXaListModel.clear();
          if (value.isNotEmpty) {
            quanHuyenListModel.addAll(value);
            quanHuyenResponse = quanHuyenListModel.first;

            //mapping quận huyện lần đầu
            if (isLoadFrist) {
              quanHuyenResponse = quanHuyenListModel.firstWhere((element) =>
                  element.ten!
                      .contains(dangKyViecMoiResponse.idQuanHuyen.toString()));
              // xã khi chon huỵen
              getDataPhuongXa(
                  idHuyen: quanHuyenResponse!.id.toString(), isLoadFrist: true);
            }
            // xã khi chon huỵen
            getDataPhuongXa(
                idHuyen: quanHuyenResponse!.id.toString(), isLoadFrist: false);
          }

          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataQuanHuyen $error'));
  }

  ///
  /// load data phường xã
  ///
  void getDataPhuongXa({required String idHuyen, required bool isLoadFrist}) {
    phuongXaProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idQuanHuyen=$idHuyen',
        onSuccess: (value) {
          phuongXaResponse = null;
          phuongXaListModel.clear();
          if (value.isNotEmpty) {
            phuongXaListModel.addAll(value);
            phuongXaResponse = phuongXaListModel.first;

            //mapping xã phường lần đầu
            if (isLoadFrist) {
              phuongXaResponse = phuongXaListModel.firstWhere((element) =>
                  element.ten!
                      .contains(dangKyViecMoiResponse.idPhuongXa.toString()));
            }
          }
          //set isLoading
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7RecruitmentController getDataPhuongXa $error'));
  }

  ///
  ///chọn hình thức làm việc
  ///
  void onChangeHinhThucLamViec(HinhThucLamViecResponse item) {
    hinhThucLamViec = item;
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhTp(TinhTpResponse idtinhTp) {
    tinhTp = idtinhTp;
    getDataQuanHuyen(idTinh: idtinhTp.id.toString(), isLoadFrist: false);
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    quanHuyenResponse = quanHuyen;
    getDataPhuongXa(idHuyen: quanHuyen.id.toString(), isLoadFrist: false);
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    phuongXaResponse = phuongXa;
    update();
  }

  ///
  /// Xem trươc
  ///
  void onClickPreviewButton() {
    Get.toNamed(AppRoutes.V2_PREVIEW);
  }
}
