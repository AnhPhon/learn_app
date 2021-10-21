import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

import '../../../../di_container.dart';

class CreateWorkController extends GetxController {
  final NhomDichVuProvider nhomDichVuProvider =
      GetIt.I.get<NhomDichVuProvider>();
  final LoaiCongViecProvider loaiCongViecProvider =
      GetIt.I.get<LoaiCongViecProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  // Địa chỉ cụ thể
  final addressController = TextEditingController();
  // Nhóm dịch vụ
  NhomDichVuResponse? dichvu;
  List<NhomDichVuResponse> nhomDichVuResponseList = [];
  // Công việc
  LoaiCongViecResponse? loaiCongViec;
  List<LoaiCongViecResponse> loaiCongViecResponseList = [];
  // Loading nhóm dich vụ
  bool isLoadingNhomDichVu = true;
  bool isLoading = true;
  //Tỉnh thành phố
  List<TinhTpResponse> tinhTps = [];
  TinhTpResponse? tinh;
  int groupTinhTpValue = 0;
  List<QuanHuyenResponse> quanHuyenList = [];
  QuanHuyenResponse? quanHuyen;
  List<PhuongXaResponse> phuongXaList = [];
  PhuongXaResponse? phuongXa;
  // Id User
  String idUser = '';
  // Get param (idType) nếu là dịch vụ thường xuyên 2 và tạo đơn dich vụ là 1
  SERVICES services = SERVICES.REGULARLY;
  @override
  void onInit() {
    super.onInit();
    // Nếu dich vụ thì chỉ có nhóm 3, 4, 5, 6, 7
    // Nếu tạo công việc chỉ có mhóm 1, 2 , 5 ,6 
    if(Get.arguments != null){
      services = Get.arguments as SERVICES;
    }
    getNhomDichVu();
    getTinhThanh();
    getUserId();
    /// Change Title App bar
    
  }


  Future<void> getUserId()async{
    await sl.get<SharedPreferenceHelper>().userId.then((value){
      idUser = value!;
    });
  }

  ///
  /// Thay đổi nhóm công việc
  ///
  void onChangedDichVu(NhomDichVuResponse dichvu) {
    this.dichvu = dichvu;
    getLoaiCongViec(dichvu: dichvu);
    update();
  }

  ///
  /// Thay đổi công việc
  ///
  void onChangedLoaiCongViec(LoaiCongViecResponse loaiCongViec) {
    this.loaiCongViec = loaiCongViec;
    update();
  }

  ///
  /// Thay đổi radio button
  ///
  void onChangedGroup(int val) {
    groupTinhTpValue = val;
    getTinhThanh();
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    tinh = tinhTp;
    getQuanHuyen(filter: '&idTinhTp=${tinhTp.id}');
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    this.quanHuyen = quanHuyen;
    getPhuongXa(filter: '&idQuanHuyen=${quanHuyen.id}');
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    this.phuongXa = phuongXa;
    update();
  }

  ///
  /// Get nhóm dich vụ
  ///
  void getNhomDichVu() {
    nhomDichVuProvider.all(onSuccess: (data) {
      isLoadingNhomDichVu = true;
      nhomDichVuResponseList.clear();
      if(data.isNotEmpty){
        if(services == SERVICES.WORK){
          nhomDichVuResponseList.addAll(data.where((element) => element.nhomDichVu!.contains('1')|| element.nhomDichVu!.contains('2') || element.nhomDichVu!.contains('5') || element.nhomDichVu!.contains('6')));
        }else if(services == SERVICES.REGULARLY){
          nhomDichVuResponseList.addAll(data.where((element) => element.nhomDichVu!.contains('3')|| element.nhomDichVu!.contains('4') || element.nhomDichVu!.contains('5') || element.nhomDichVu!.contains('6') || element.nhomDichVu!.contains('7')));
        }
        dichvu = nhomDichVuResponseList.first;
      }
      isLoadingNhomDichVu = false;
      getLoaiCongViec(dichvu: dichvu!);
      update();
    }, onError: (error) {
      isLoadingNhomDichVu = false;
      update();
      Get.snackbar(
        "Error",
        error.message.toString(),
      );
    });
  }

  ///
  /// Lấy danh sách công việc thuôc nhóm côgn việc
  ///
  void getLoaiCongViec({required NhomDichVuResponse dichvu}) {
    loaiCongViecProvider.paginate(
        page: 1,
        limit: 100,
        filter: "&idNhomDichVu=${dichvu.id}",
        onSuccess: (data) {
          loaiCongViec = null;
          loaiCongViecResponseList.clear();
          loaiCongViecResponseList.addAll(data);
          if (data.isNotEmpty) {
            loaiCongViec = loaiCongViecResponseList.first;
          }
          update();
        },
        onError: (error) {
          print("CreateWorkController getLoaiCongViec onError $error");
          update();
          Get.snackbar(
            "Error",
            error.message.toString(),
          );
        });
  }

  ///
  /// Lấy tất cả tỉnh thành phố
  ///
  void getTinhThanh() {
    tinhTpProvider.all(onSuccess: (data) {
      tinhTps.clear();
      tinhTps.addAll(data);
      if (groupTinhTpValue == 0) {
        tinh = tinhTps
            .firstWhere((element) => element.ten!.contains("Hồ Chí Minh"));
        getQuanHuyen(filter: '&idTinhTp=${tinh!.id}');
      } else if (groupTinhTpValue == 1) {
        tinh = tinhTps.firstWhere((element) => element.ten!.contains("Hà Nội"));
        getQuanHuyen(filter: '&idTinhTp=${tinh!.id}');
      } else if (groupTinhTpValue == 2) {
        tinh =
            tinhTps.firstWhere((element) => element.ten!.contains("Đà Nẵng"));
        getQuanHuyen(filter: '&idTinhTp=${tinh!.id}');
      } else {
        tinh = null;
      }

      isLoading = false;
      update();
    }, onError: (error) {
      isLoading = false;
      update();
      SnackBar(
        content: Text(error.message.toString()),
      );
      print("CreateWorkController getTinhThanh onError $error");
    });
  }

  ///
  /// Lấy tất cả quận huyện
  ///
  void getQuanHuyen({String? filter = ''}) {
    quanHuyenProvider.paginate(
        filter: filter!,
        limit: 100,
        page: 1,
        onSuccess: (data) {
          quanHuyen = null;
          phuongXa = null;
          quanHuyenList.clear();
          phuongXaList.clear();
          if (data.isNotEmpty) {
            quanHuyenList.addAll(data);
            quanHuyen = quanHuyenList.first;
            // xã khi chon huỵen
            getPhuongXa(filter: '&idQuanHuyen=${quanHuyen!.id}');
          }

          //isLoadingNhomDichVu = false;
          update();
        },
        onError: (error) {
          update();
          SnackBar(
            content: Text(error.message.toString()),
          );
          print("CreateWorkController getQuanHuyen onError $error");
        });
  }

  ///
  /// Lấy tất cả phường xa
  ///
  void getPhuongXa({String? filter = ''}) {
    phuongXaProvider.paginate(
        filter: filter!,
        limit: 100,
        page: 1,
        onSuccess: (data) {
          //isLoadingNhomDichVu = true;
          phuongXa = null;
          phuongXaList.clear();
          if (data.isNotEmpty) {
            phuongXaList.addAll(data);
            phuongXa = phuongXaList.first;
          }
          //isLoadingNhomDichVu = false;
          update();
        },
        onError: (error) {
          update();
          SnackBar(
            content: Text(error.message.toString()),
          );
          print("CreateWorkController getPhuongXa onError $error");
        });
  }

  ///
  /// Nhấn vào nút tiếp tục
  ///
  void onClickContinue() async{
      if(dichvu == null){
        return Get.snackbar("Nhóm dich vụ bắt buộc","Vui lòng chọn dịch vụ");
      }else if(tinh == null){
        return Get.snackbar("Tỉnh","Vui lòng chọn tỉnh");
      }else if(quanHuyen == null){
        return Get.snackbar("Trường quận huyện bắt buộc","Vui lòng quận huyện");
      }else if(phuongXa == null){
        return Get.snackbar("Trường phường xã bắt buộc","Vui lòng phường xã");
      }else if(loaiCongViec == null){
        return  Get.snackbar("Trường công việc bắt buộc","Vui lòng chọn công việc");
      }else if(addressController.text.toString().isEmpty){
        return Get.snackbar("Trường địa chỉ bắt buộc","Vui lòng điền địa chỉ cụ thể");
      }else{
        if(dichvu!.nhomDichVu! == '1'){
         // Nhóm 1
          Get.toNamed(AppRoutes.V1_G1_CREATE_WORK, arguments: await request());
        }else {
          Get.toNamed("${AppRoutes.V1_REFERENCE_PRICE_TABLE}?id=${dichvu!.nhomDichVu!}", arguments: await request(),);
        }
      }
  }

  Future<DonDichVuRequest> request()async {
      final DonDichVuRequest serviceApplication = DonDichVuRequest();
      serviceApplication.idTinhTp = tinh!.id;
      serviceApplication.idQuanHuyen = quanHuyen!.id;
      serviceApplication.idPhuongXa = phuongXa!.id;
      serviceApplication.idNhomDichVu = dichvu!.id;
      serviceApplication.idTaiKhoan = idUser;//await sl.get<SharedPreferenceHelper>().userId;
      serviceApplication.tieuDe = loaiCongViec!.tenCongViec;
      serviceApplication.diaChiCuThe = addressController.text.toString();
      return serviceApplication;
  }

  @override
  void onClose() {
    super.onClose();
    addressController.dispose();
  }
  
}
