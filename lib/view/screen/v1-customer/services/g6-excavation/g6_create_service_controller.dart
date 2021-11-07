


import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/data/model/response/thong_so_ky_thuat_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thoi_gian_lam_viec_provider.dart';
import 'package:template/provider/thong_so_ky_thuat_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/snack_bar.dart';

class V1G6CreateServiceController extends GetxController{
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final ThoiGianLamViecProvider thoiGianLamViecProvider = GetIt.I.get<ThoiGianLamViecProvider>();
  final ThongSoKyThuatProvider thongSoKyThuatProvider = GetIt.I.get<ThongSoKyThuatProvider>();
  final ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  
  final workTitleController = TextEditingController();
  final amountController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final workWidthController = TextEditingController();
  final workDescController = TextEditingController();


  // Chọn thời gian làm việc
  bool tommorow = false;
  bool afternoon = false;
  bool tonight = false;
  ThoiGianLamViecResponse? tommowReponse;
  ThoiGianLamViecResponse? afternoonReponse;
  ThoiGianLamViecResponse? tonightReponse;
  List<ThoiGianLamViecResponse> thoiGianLamViecList = [];
  // loading 
  bool isLoading = true;  
  bool isThongSo = true;
  // Dịch vụ resquest
  DonDichVuRequest? serviceApplication;
  // Thông số kỹ thuât
  List<MultiSelectItem<ThongSoKyThuatResponse?>> thongSoKyThuatList = [];
  List<ThongSoKyThuatResponse?> thongSo = [];

  // Danh sách hình san pham mau
  List<String> productImages = [];
  // app bar title
  String appBarTitle = 'Tạo đơn công việc';

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null){
      serviceApplication = Get.arguments as DonDichVuRequest;
      print("Tiêu đề: ${serviceApplication!.tieuDe!}");
      workTitleController.text = serviceApplication!.tieuDe ?? '';
      appBarTitle = Get.parameters['appbar'].toString();
      getWorkTime();
      getAllThongSo();
    }
  }


  ///
  ///// Chọn thời gian làm việc
  ///
  void onSelectedTommorow({required bool val}){
    tommorow = val;
    if(tommorow){
      tommowReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('7h30 - 11h30'));
    }else{
      tommowReponse = null;
    }
    update();
  }

  void onSelectedAfternoon({required bool val}){
    afternoon = val;
    if(afternoon){
      afternoonReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('13h30 - 17h30'));
    }else{
      afternoonReponse = null;
    }
    update();
  }
  
  void onSelectedTonight({required bool val}){
    tonight = val;
    if(tonight){
      tonightReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('18h30 - 22h30'));
    }else{
      tonightReponse = null;
    }
    update();
  }

  /// 
  /// lấy thời gian làm việc
  /// 
  void getWorkTime(){
    thoiGianLamViecProvider.all(onSuccess: (data){
      thoiGianLamViecList.clear();
      thoiGianLamViecList.addAll(data);
      isLoading = false;
      update();
    }, onError: (error){
      isLoading = false;
      update();
      print("V1G6CreateServiceController getWorkTime Error $error");
    });
  }

  ///
  /// Get thông số kỹ thuật
  ///
  void getAllThongSo(){
    appBarTitle = Get.parameters['appbar'].toString();
    print("Running");
    thongSoKyThuatProvider.all(onSuccess: (data){
      thongSoKyThuatList.clear();
      if(data.isNotEmpty){
        thongSoKyThuatList = data.map((e) => MultiSelectItem(e, e.tieuDe!)).toList();
      }
      isThongSo = false;
      update();
    }, onError: (onError){
      print("V1G6CreateServiceController getAllThongSo $onError");
      isThongSo = false;
      update();
    });
  }


  ///
  /// Pick multi images
  ///
  Future pickImages({required List<String> data}) async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');
      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          print('V1G1CreateWorkController pickImages addImages ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            data.addAll(value.files!);
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }
  
  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required String file, required List<String> files}){
    files.removeWhere((element) => element.hashCode == file.hashCode);
    update();
  }

  ///
  /// Nhấn tiếp tục tới trang báo giá đơn hàng
  ///
  Future<void> onClickContinueButton() async{
    if(thongSo.isEmpty){
      Alert.error(message: "Bản phải chọn thông số kỹ thuật");
    }else if(tommorow == false && afternoon == false && tonight == false){
      Alert.error(message: "Bạn phải chọn thời làm việc");
    }else if(amountController.text.toString().isEmpty){
      Alert.error(message: "Số lượng yêu cầu không được để trống");
    }else if(int.parse(amountController.text.toString()) <= 0){
      Alert.error(message: "Số lượng yêu cầu không hợp lệ");
    }else if(startTimeController.text.toString().isEmpty){
      Alert.error(message: "Ngày làm việc không được để trống");
    }else if(DateConverter.differenceDate(startDate: startTimeController.text.toString(), endDate: DateConverter.estimatedDateOnly(DateTime.now())) > 0){
      Alert.error(message: "Ngày bắt đầu không được nhỏ hơn ngày hiện tại");
    }else if(endTimeController.text.toString().isEmpty){
      Alert.error(message: "Ngày kết thức dự kiến không được để trống");
    }else if(DateConverter.differenceDate(startDate: startTimeController.text.toString(), endDate: endTimeController.text.toString()) <= 0){
      Alert.error(message: "Ngày kết thúc phải lớn hơn ngày bắt đầu");
    }else if(workDescController.text.toString().isEmpty){
      Alert.error(message: "Mô tả yêu cầu cụ thể không được để trống");
    }else{
     donDichVuProvider.add(data: request(), onSuccess: (data){
        EasyLoading.dismiss();
        Alert.success(message:"Tạo đơn dịch vụ thành công. Chúng tối sẽ phản hội lại cho bạn sơm nhất");
        Get.offAllNamed(AppRoutes.V1_SUCCESSFULLY, predicate: ModalRoute.withName(AppRoutes.V1_SUCCESSFULLY));
      }, onError: (onError){
        EasyLoading.dismiss();
        print("V1G6CreateServiceController onClickContinueButton $onError");
      });
    }
  }

  ///
  /// Tạo đối tượng request
  ///
  DonDichVuRequest request(){
      final List<String> workTime = [];
      DonDichVuRequest dichVuRequest = DonDichVuRequest();
      dichVuRequest = serviceApplication!;
      if(tommorow == true){
        workTime.add(tommowReponse!.id!);
      }
      if(afternoon == true){
        workTime.add(afternoonReponse!.id!); 
      }
      if(tonight == true){
        workTime.add(tonightReponse!.id!);
      }
      dichVuRequest.idThoiGianLamViecs = workTime;
      if(workWidthController.text.toString().isNotEmpty){
        dichVuRequest.beRongMatDuong = workWidthController.text.toString();
      }
      if(thongSo.isNotEmpty){
        dichVuRequest.idThongSoKyThuats = thongSo.map((e) => e!.id!).toList();
      }
      dichVuRequest.ngayBatDau = DateConverter.formatYYYYMMDD(startTimeController.text.toString());
      dichVuRequest.soLuongYeuCau = amountController.text.toString();
      dichVuRequest.ngayKetThuc= DateConverter.formatYYYYMMDD(endTimeController.text.toString());
      dichVuRequest.moTaChiTiet = workDescController.text.toString();
      dichVuRequest.soLuongYeuCau = amountController.text.toString();
      // trạng thái đơn
      dichVuRequest.idTrangThaiThanhToan= CHUA_THANH_TOAN;
      dichVuRequest.idTrangThaiDonDichVu = CHUA_PHAN_HOI;
      // Updalod image ảnh sản phẩm mẫu nếu có
      dichVuRequest.hinhAnhBanVes = productImages;

      return dichVuRequest;
  }


  @override
  void onClose() {
    workTitleController.dispose();
    amountController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    workWidthController.dispose();
    workDescController.dispose();
    super.onClose();
  }
}


extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}