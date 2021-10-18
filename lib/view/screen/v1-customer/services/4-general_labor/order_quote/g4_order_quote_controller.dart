import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/bang_gia_don_hang_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bang_gia_don_hang_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1G4OrderQuoteController extends GetxController{

  final BangGiaDonHangProvider bangGiaDonHangProvider = GetIt.I.get<BangGiaDonHangProvider>();

  BangGiaDonHangResponse? currentSelected;
  final ScrollController scrollController = ScrollController();

  // Danh sách bản giá đơn hàng
  List<BangGiaDonHangResponse> priceTable = [];


  // Đối tương request truyền từ màn hình trước qua
  DonDichVuRequest? request;

  int page = 1;
  int limit = 15;
  bool reload = false;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    request = Get.arguments as DonDichVuRequest;
    // Lắng nghe cuộn
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
          if(limit >= 99){
            limit = 15;
          }
          limit += 15;
          getAllBangGia(limit: limit,page: page);
      }
    });

    getAllBangGia(limit: limit,page: page);
  }

  void loadData() {
      priceTable.clear();
      limit = 15;
      page = 1;
      getAllBangGia(limit: limit,page: page);
      update();
  }


  ////////////////////////////////
  ///Lấy bảng giá đơn hàng
  ///
  void getAllBangGia({required int limit, required int page}){
    bangGiaDonHangProvider.paginate(page: page, limit: limit, filter:'', onSuccess: (data){
      priceTable = data;
      if(priceTable.isNotEmpty){
        currentSelected = priceTable.first;
      }
      isLoading = false;
      update();
    }, onError: (onError){
      isLoading = false;
      update();
      print("V1G3OrderQuoteController getAllBangGia Error $onError");
    });
  }

  ///
  /// Chọn item
  ///
  void onSelectedItem({required BangGiaDonHangResponse item}){
    // Get item position index 
    currentSelected = item;
    update();
  }

  ///
  /// Tiếp tục
  ///
  void onNextPage(){
    request!.soTien = currentSelected!.giaTien;
    request!.phiDichVu = '0';
    request!.khuyenMai = '0';
    request!.soNgay = DateConverter.differenceDate(startDate: request!.ngayKetThuc!, endDate: request!.ngayKetThuc!).toString();
    request!.tongDon = currentSelected!.giaTien;
    request!.tieuDe = currentSelected!.tieuDe;
    Get.toNamed(AppRoutes.V1_G4_ORDER_DETAIL, arguments: request);
  }

}