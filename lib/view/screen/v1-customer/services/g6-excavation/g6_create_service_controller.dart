


import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
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
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

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
  List<File> productImages = [];

  @override
  void onInit() {
    serviceApplication = Get.arguments as DonDichVuRequest;
    workTitleController.text = serviceApplication!.tieuDe ?? '';
    getWorkTime();
    getAllThongSo();
    super.onInit();
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
      afternoonReponse = thoiGianLamViecList.firstWhereOrNull((element) => element.tieuDe!.contains('1h30 - 5h30'));
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
  /// Chọn nhiều file (Image)
  ///
  Future<void> pickerMuilFile({required List<File> files})async{
    final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      files.addAll(result.paths.map((path) => File(path!)).toList());
      update();
    } else {
      showSnackBar(title: "Lỗi", message: "Thêm file thất bại");
    }
  }

  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required File file, required List<File> files}){
    files.removeWhere((element) => element.hashCode == file.hashCode);
    showSnackBar(title: "Xoá", message: "Xoá ảnh thành công");
    update();
  }

  ///
  /// Nhấn tiếp tục tới trang báo giá đơn hàng
  ///
  Future<void> onClickContinueButton() async{
    if(thongSo.isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng chọn thông số kỹ thuật");
    }else if(tommorow == false && afternoon == false && tonight == false){
      showSnackBar(title: "Lỗi", message: "Vui lòng chọn thời làm việc");
    }else if(amountController.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng nhập số lượng yêu cầu");
    }else if(int.parse(amountController.text.toString()) <= 0){
      showSnackBar(title: "Lỗi", message: "Số lượng không hợp lệ");
    }else if(startTimeController.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng chọn ngày làm việc");
    }else if(endTimeController.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng chọn ngày kết thức dự kiến");
    }else if(DateConverter.differenceDate(startDate: startTimeController.text.toString(), endDate: DateTime.now().toString()) > 0){
      showSnackBar(title: "Lỗi", message: "Ngày bắt đầu không được bé hơn ngày hiện tại");
    }else if(DateConverter.differenceDate(startDate: startTimeController.text.toString(), endDate: endTimeController.text.toString()) <= 0){
      showSnackBar(title: "Lỗi", message: "Ngày kết thúc phải lớn hơn ngày bắt đầu");
    }else if(workDescController.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng mô tả yêu cầu cụ thể");
    }else{
      EasyLoading.show(status: "Loading ...");
      request().then((value){
        donDichVuProvider.add(data: value, onSuccess: (data){
          EasyLoading.dismiss();
          showSnackBar(title: "Tạo đơn dịch vụ thành công", message: "Chúng tối sẽ phản hội lại cho bạn sơm nhất");
          Get.toNamed(AppRoutes.V1_SUCCESSFULLY);
        }, onError: (onError){
          EasyLoading.dismiss();
          print("V1G6CreateServiceController onClickContinueButton $onError");
        });
      });
    }
  }

  ///
  /// Tạo đối tượng request
  ///
  Future<DonDichVuRequest> request(){
      String productImagesLink = '';
      final List<ThoiGianLamViecResponse> workTime = [];
      DonDichVuRequest dichVuRequest = DonDichVuRequest();
      dichVuRequest = serviceApplication!;
      if(tommorow == true){
        workTime.add(tommowReponse!);
      }
      if(afternoon == true){
        workTime.add(afternoonReponse!); 
      }
      if(tonight == true){
        workTime.add(tonightReponse!);
      }
      dichVuRequest.thoiGianLamViec = workTime;
      if(workWidthController.text.toString().isNotEmpty){
        // Thiếu bề rộng mặt đường làm việc
        dichVuRequest.beRongDiemNhan = workWidthController.text.toString();
      }
      // dichVuRequest.idThongSoKyThuat = hiện tại API chưa có
      dichVuRequest.ngayBatDau = startTimeController.text.toString();
      dichVuRequest.soLuongYeuCau = amountController.text.toString();
      dichVuRequest.ngayKetThuc= endTimeController.text.toString();
      dichVuRequest.moTaChiTiet = workDescController.text.toString();
      dichVuRequest.soLuongYeuCau = amountController.text.toString();
      // Updalod image ảnh sản phẩm mẫu nếu có
      if(productImages.isNotEmpty){
        // HỈnh ảnh sản phẩm mẫu
        productImages.forEach((element) {
          imageUpdateProvider.add(file: element,onSuccess: (data){
            productImagesLink = "$productImagesLink${data.data},";
          }, onError: (onError){
            print("V1G2CreateWorkController request ảnh sản phẩm mẫu $onError");
            showSnackBar(title: "Upload hình ảnh thất bại", message: "Vui lòng thử lại");
            EasyLoading.dismiss();
          });
        });
      }

      return Future.delayed(const Duration(milliseconds: 500)).then((value) => dichVuRequest);
  }


  @override
  void onClose() {
    onClose();
    workTitleController.dispose();
    amountController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    workWidthController.dispose();
    workDescController.dispose();
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