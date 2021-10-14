

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/routes/app_routes.dart';

class CreateWorkController extends GetxController{
  final NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  final LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();

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
  //Tỉnh thành phố
  List<TinhTpResponse> tinhTps = [];
  TinhTpResponse? tinh;
  int groupTinhTpValue = 0;
  List<QuanHuyenResponse> quanHuyenList = [];
  QuanHuyenResponse? quanHuyen;
  List<PhuongXaResponse> phuongXaList = [];
  PhuongXaResponse? phuongXa;

  @override
  void onInit() {
    super.onInit();
    // Nếu dich vụ thì chỉ có nhóm 3, 4, 5, 6, 7
    // Nếu tạo công việc chỉ có mhóm 1, 2 , 5 ,6 
    getNhomDichVu();
    getTinhThanh();
  }

  ///
  /// Thay đổi nhóm công việc
  ///
  void onChangedDichVu(NhomDichVuResponse dichvu){
    this.dichvu = dichvu;
    getLoaiCongViec();
    update();
  }

  ///
  /// Thay đổi công việc
  ///
  void onChangedLoaiCongViec(LoaiCongViecResponse loaiCongViec){
    this.loaiCongViec = loaiCongViec;
    update();
  }


  ///
  /// Thay đổi radio button
  ///
  void onChangedGroup(int val){
    groupTinhTpValue = val;
    getTinhThanh();
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp){
    tinh = tinhTp;
    //getQuanHuyen(filter: '&idTinhTp=615d6a143e28b243e76682e1');
    update();
  }


  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen){
    this.quanHuyen = quanHuyen;
    getPhuongXa(filter: '&idQuanHuyen=615d6a3b3e28b243e76682e4');
    update();
  }
  

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa){
    this.phuongXa = phuongXa;
    update();
  }


  ///
  /// Get nhóm dich vụ
  ///
  void getNhomDichVu(){
    nhomDichVuProvider.all(onSuccess: (data){
      isLoadingNhomDichVu = true;
      if(data.isNotEmpty){
        nhomDichVuResponseList.clear();
        nhomDichVuResponseList.addAll(data);
        dichvu = nhomDichVuResponseList.first;
      }
      isLoadingNhomDichVu = false;
      getLoaiCongViec();
      update();
    }, onError: (error){
      isLoadingNhomDichVu = false;
      update();
      SnackBar(content: Text(error.message.toString()),);
    });
  }


  ///
  /// Lấy danh sách công việc thuôc nhóm côgn việc
  ///
  void getLoaiCongViec(){
    loaiCongViecProvider.paginate(page: 1, limit: 100, filter: "&idNhomDichVu=61614f9c48049a21aa824129" ,onSuccess: (data){
      print(data);
      if(data.isNotEmpty){
        loaiCongViecResponseList.clear();
        loaiCongViecResponseList.addAll(data);
        loaiCongViec = loaiCongViecResponseList.first;
      }
      update();
    }, onError:(error){
      update();
      SnackBar(content: Text(error.message.toString()),);
    });
  }


  ///
  /// Lấy tất cả tỉnh thành phố
  ///
  void getTinhThanh(){
    tinhTpProvider.all(onSuccess: (data){
      isLoadingNhomDichVu = true;
      if(data.isNotEmpty){
        tinhTps.clear();
        tinhTps.addAll(data);
        if(groupTinhTpValue == 0){
          tinh = tinhTps.firstWhere((element) => element.ten!.contains("Hồ Chí Minh"));
          getQuanHuyen(filter: '&idTinhTp=615d6a143e28b243e76682e1');
        }else if(groupTinhTpValue == 1){
          tinh = tinhTps.firstWhere((element) => element.ten!.contains("Hà Nội"));
          getQuanHuyen(filter: '&idTinhTp=615d6a143e28b243e76682e1');
        }else if(groupTinhTpValue == 2){
          tinh = tinhTps.firstWhere((element) => element.ten!.contains("Đà Nẵng"));
          getQuanHuyen(filter: '&idTinhTp=615d6a143e28b243e76682e1');
        }else{
          tinh = tinhTps.first;
          getQuanHuyen();
        }
      }
      
      isLoadingNhomDichVu = false;
      update();
    }, onError: (error){
      isLoadingNhomDichVu = false;
      update();
      SnackBar(content: Text(error.message.toString()),);
    });
  }

  ///
  /// Lấy tất cả quận huyện
  ///
  void getQuanHuyen({String? filter =''}){
    quanHuyenProvider.paginate(
      filter: filter!,
      limit: 100,
      page: 1,
      onSuccess: (data){
      isLoadingNhomDichVu = true;
      if(data.isNotEmpty){
        quanHuyenList.clear();
        quanHuyenList.addAll(data);
        quanHuyen = quanHuyenList.first;
        
      }
      // xã khi chon huỵen
      //getPhuongXa();

      isLoadingNhomDichVu = false;
      update();
    }, onError: (error){
      isLoadingNhomDichVu = false;
      update();
      SnackBar(content: Text(error.message.toString()),);
    });
  }

  ///
  /// Lấy tất cả phường xa
  ///
  void getPhuongXa({String? filter =''}){
    phuongXaProvider.paginate(
      filter: filter!,
      limit: 100,
      page: 1,
      onSuccess: (data){
      isLoadingNhomDichVu = true;
      if(data.isNotEmpty){
        phuongXaList.clear();
        phuongXaList.addAll(data);
        phuongXa = phuongXaList.first;
      }
      isLoadingNhomDichVu = false;
      update();
    }, onError: (error){
      isLoadingNhomDichVu = false;
      update();
      SnackBar(content: Text(error.message.toString()),);
    });
  }


  ///
  /// Nhấn vào nút tiếp tục
  ///
  void onClickContinue(){
    if(dichvu!.tenDichVu! == nhomDichVuResponseList[0].tenDichVu){
      // Nhóm 1
      Get.toNamed(AppRoutes.V1_G1_CREATE_WORK, arguments: {
        "address": addressController.text.isEmpty ? "" : addressController.text.toString(),
        "jobTitle": loaiCongViec!.tenCongViec, 
      });
    }else if(dichvu == 2){
      Get.toNamed(AppRoutes.V1_G2_CREATE_WORK);
    }else if( dichvu == 3){
      // Tạo đơn dịch vụ có gía
      Get.toNamed(AppRoutes.V1_G3_CREATE_SERVICE);
    }else if(dichvu == 4){
      // Tạo đơn dich vụ có giá nhóm 4
      Get.toNamed(AppRoutes.V1_G4_CREATE_SERVICE);
    }else if(dichvu == 5){
      // Tạo đơn công viẹc và dịch nhóm 5
      Get.toNamed(AppRoutes.V1_G5_CREATE_SERVICE);
    }else if(dichvu == 6){
      // Tạo đơn công viẹc và dịch nhóm 5
      Get.toNamed(AppRoutes.V1_G6_CREATE_SERVICE);
    }else if(dichvu == 7){
      // Tạo đơn công viẹc và dịch nhóm 5
      Get.toNamed(AppRoutes.V1_G7_RECRUITMENT);
    }
  }

  @override
  void onClose() {
    super.onClose();
    addressController.dispose();
  }

}