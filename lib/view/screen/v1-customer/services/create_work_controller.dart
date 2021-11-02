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
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/snack_bar.dart';
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
  List<TinhTpResponse> otherProvinces = [];

  TinhTpResponse? hcmProvince;
  TinhTpResponse? otherProvince;
  TinhTpResponse? daNangProvince;
  TinhTpResponse? haNoiProvince;

  int groupTinhTpValue = 0;
  List<QuanHuyenResponse> quanHuyenList = [];
  List<QuanHuyenResponse> otherDistricts = [];
  QuanHuyenResponse? hcmHuyen;
  QuanHuyenResponse? daNangHuyen;
  QuanHuyenResponse? haNoiHuyen;
  QuanHuyenResponse? khacHuyen;
  List<PhuongXaResponse> phuongXaList = [];
  List<PhuongXaResponse> otherwards = [];
  PhuongXaResponse? hcmPhuong;
  PhuongXaResponse? daNangPhuong;
  PhuongXaResponse? haNoiPhuong;
  PhuongXaResponse? khacPhuong;
  // Id User
  String idUser = '';
  // Get param (idType) nếu là dịch vụ thường xuyên 2 và tạo đơn dich vụ là 1
  SERVICES services = SERVICES.REGULARLY;
  String titleAppBar = 'Tạo đơn dịch vụ';
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
    if(services == SERVICES.REGULARLY){
      titleAppBar = "Dịch vụ thường xuyên";
    }else if(services == SERVICES.WORK){
      titleAppBar = 'Tạo đơn công việc';
    }
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
    if(groupTinhTpValue == 3){
      khacHuyen = null;
      khacPhuong = null;
      otherDistricts.clear();
      otherwards.clear();
    }
    getTinhThanh();
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    if(groupTinhTpValue == 3){
      otherProvince = tinhTp;
    }else if(groupTinhTpValue == 2){
      daNangProvince = tinhTp;
    }else if(groupTinhTpValue == 1){
      haNoiProvince = tinhTp;
    }else{
      hcmProvince = tinhTp;
    }
    getQuanHuyen(filter: '&idTinhTp=${tinhTp.id}');
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse huyen) {
    if(groupTinhTpValue == 3){
      khacHuyen= huyen;
    }else if(groupTinhTpValue == 2){
      daNangHuyen = huyen;
    }else if(groupTinhTpValue == 1){
      haNoiHuyen = huyen;
    }else{
      hcmHuyen = huyen;
    }
    getPhuongXa(filter: '&idQuanHuyen=${huyen.id}');
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedPhuongXa(PhuongXaResponse phuong) {
    if(groupTinhTpValue == 3){
      khacPhuong = phuong;
    }else if(groupTinhTpValue == 2){
      daNangPhuong = phuong;
    }else if(groupTinhTpValue == 1){
      haNoiPhuong = phuong;
    }else{
      hcmPhuong = phuong;
    }
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
      print('getNhomDichVu CreateWorkController $error');
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
        });
  }

  ///
  /// Lấy tất cả tỉnh thành phố
  ///
  void getTinhThanh() {
    tinhTpProvider.all(onSuccess: (data) {
      tinhTps.clear();
      tinhTps.addAll(data);
      otherProvinces.addAll(data);
      if (groupTinhTpValue == 0) {
        hcmProvince = tinhTps
            .firstWhere((element) => element.ten!.contains("Hồ Chí Minh"));
        getQuanHuyen(filter: '&idTinhTp=${hcmProvince!.id}');
      } else if (groupTinhTpValue == 1) {
        haNoiProvince= tinhTps.firstWhere((element) => element.ten!.contains("Hà Nội"));
        getQuanHuyen(filter: '&idTinhTp=${haNoiProvince!.id}');
      } else if (groupTinhTpValue == 2) {
        daNangProvince =
            tinhTps.firstWhere((element) => element.ten!.contains("Đà Nẵng"));
        getQuanHuyen(filter: '&idTinhTp=${daNangProvince!.id}');
      } else {
        otherProvince = null;
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
          if(groupTinhTpValue != 3){
            hcmHuyen = null;
            hcmPhuong = null;
            quanHuyenList.clear();
            phuongXaList.clear();
            if (data.isNotEmpty) {
              quanHuyenList.addAll(data);
              hcmHuyen = quanHuyenList.first;
              // xã khi chon huỵen
              getPhuongXa(filter: '&idQuanHuyen=${hcmHuyen!.id}');
            }

            //isLoadingNhomDichVu = false;
            update();
          }else{
            khacHuyen = null;
            khacPhuong = null;
            otherDistricts.clear();
            otherDistricts.addAll(data);
            update();
          }
          
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
          if(groupTinhTpValue != 3){
             hcmPhuong = null;
            phuongXaList.clear();
            if (data.isNotEmpty) {
              phuongXaList.addAll(data);
              hcmPhuong = phuongXaList.first;
            }
            //isLoadingNhomDichVu = false;
            update();
          }else{
            khacPhuong = null;
            otherwards.clear();
            otherwards.addAll(data);
            update();
          }
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
        Alert.info(message:"Vui lòng chọn dịch vụ");
        return; 
      }else if(hcmProvince == null && otherProvince == null && haNoiProvince == null && daNangProvince == null){
        Alert.info(message:"Vui lòng chọn tỉnh");
        return; 
      }else if(hcmHuyen == null && khacHuyen == null && haNoiHuyen == null && daNangHuyen == null){
        Alert.info(message:"Vui lòng chọn quận huyện");
        return; 
      }else if(hcmPhuong == null && khacPhuong == null && haNoiPhuong == null && daNangPhuong == null){
        Alert.info(message:"Vui lòng phường xã");
        return; 
      }else if(loaiCongViec == null){
         Alert.info(message:"Vui lòng chọn công việc");
        return; 
      }else if(addressController.text.toString().isEmpty){
        Alert.info(message:"Vui lòng điền địa chỉ cụ thể");
        return; 
      }else{
        if(dichvu!.nhomDichVu! == '1'){
         // Nhóm 1
          Get.toNamed(AppRoutes.V1_G1_CREATE_WORK, arguments: await request());
        }else if(dichvu!.nhomDichVu! == '7'){
         // Nhóm 7
          Get.toNamed(AppRoutes.V1_G7_RECRUITMENT, arguments: await request());
        }else {
          Get.toNamed("${AppRoutes.V1_REFERENCE_PRICE_TABLE}?id=${dichvu!.nhomDichVu!}&title=${dichvu!.tenDichVu!}&appbar=$titleAppBar", arguments: await request(),);
        }
      }
  }

  Future<DonDichVuRequest> request()async {
      final DonDichVuRequest serviceApplication = DonDichVuRequest();
      if(groupTinhTpValue == 3){
        serviceApplication.idTinhTp = otherProvince!.id;
        serviceApplication.idQuanHuyen = khacHuyen!.id;
        serviceApplication.idPhuongXa = khacPhuong!.id;
      }else if(groupTinhTpValue == 2){
        serviceApplication.idTinhTp = daNangProvince!.id;
        serviceApplication.idQuanHuyen = daNangHuyen!.id;
        serviceApplication.idPhuongXa = daNangPhuong!.id;
      }else if(groupTinhTpValue == 1){
        serviceApplication.idTinhTp = haNoiProvince!.id;
        serviceApplication.idQuanHuyen = haNoiHuyen!.id;
        serviceApplication.idPhuongXa = haNoiPhuong!.id;
      }else{
        serviceApplication.idTinhTp = hcmProvince!.id;
        serviceApplication.idQuanHuyen = hcmHuyen!.id;
        serviceApplication.idPhuongXa = hcmPhuong!.id;
      }
      print("Tinh: ${serviceApplication.idTinhTp} Huyen: ${serviceApplication.idQuanHuyen} xa: ${serviceApplication.idPhuongXa}");
      
      serviceApplication.idNhomDichVu = dichvu!.id;
      serviceApplication.idTaiKhoanNhanDon = idUser;
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
