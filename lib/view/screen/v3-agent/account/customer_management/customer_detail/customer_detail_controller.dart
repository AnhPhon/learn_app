import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

class V3CustomerDetailController extends GetxController {
  //TextEditingController
  final dateController = TextEditingController();
  final totalController = TextEditingController();
  final contentController = TextEditingController();

  //tai khoan
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  //donDichVu
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  List<DonDichVuResponse> donDichVuList = [];

  //ChiTietVatTu
  // ChiTietVatTuProvider chiTietVatTuProvider =
  //     GetIt.I.get<ChiTietVatTuProvider>();
  // List<ChiTietVatTuResponse> chiTietVatTuList = [];

  //tab
  List titleTabBar = [
    "Qua app",
    "Liên hệ riêng",
  ];

  //curent index
  int currentIndex = 0;

  //total
  int totalQuaApp = 0;
  int totalLienHe = 0;

  //loading
  bool isLoading = true;

  //visible
  bool visible = false;

  //title appbar
  String title = "Quản lý khách hàng";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      taiKhoanResponse = Get.arguments as TaiKhoanResponse;
      getDonDichVu();
    } else {
      isLoading = false;
    }
  }

  ///
  ///get don dich vu
  ///
  void getDonDichVu() {
    donDichVuProvider.paginate(
      page: 1,
      limit: 100,
      filter:
          "&idTaiKhoanNhanDon=${taiKhoanResponse.id}&idNhomDichVu=$NHOM_DICH_VU_8&idTrangThaiDonDichVu=$TRUNG_THAU&sortBy=created_at:desc",
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          donDichVuList = data;
          for (final item in data) {
            totalQuaApp += int.parse(item.tongDon.toString());
            if (item.id == data.last.id) {
              isLoading = false;
              update();
            }
          }
          // for (final item in data) {
          //   chiTietVatTuProvider.paginate(
          //     page: 1,
          //     limit: 100,
          //     filter: "&idDonDichVu=${item.id}&sortBy=created_at:desc",
          //     onSuccess: (value) {
          //       chiTietVatTuList.addAll(value);
          //       if (item.id == data.last.id) {
          //         chiTietVatTuList
          //             .map((e) => totalQuaApp +=
          //                 int.parse(e.idVatTu!.donGia.toString()))
          //             .toList();
          //         isLoading = false;
          //         update();
          //       }
          //     },
          //     onError: (error) {
          //       print("V3CustomerDetailController getVatTu onError $error");
          //     },
          //   );
          // }
        } else {
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print("V3CustomerDetailController getDonDichVu onError $error");
      },
    );
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  ///visible
  ///
  void visibleOnChanged() {
    visible = !visible;
    update();
  }

  ///
  ///on btn update
  ///
  void onBtnUpdate() {
    //validate
    if (dateController.text.isEmpty) {
      Alert.error(message: "Ngày giao dịch không được để trống");
    } else if (totalController.text.isEmpty) {
      Alert.error(message: "Giá trị giao dịch không được để trống");
    } else if (contentController.text.isEmpty) {
      Alert.error(message: "Nội dung không được để trống");
    } else {
      visibleOnChanged();
      //set data
      DateConverter.convertStringToDate(dateController.text);
    }
  }
}
