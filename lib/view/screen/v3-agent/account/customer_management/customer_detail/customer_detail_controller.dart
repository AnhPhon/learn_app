import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/lien_he_rieng_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/lien_he_rieng_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/lien_he_rieng_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
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

  //LienHeRieng
  LienHeRiengProvider lienHeRiengProvider = GetIt.I.get<LienHeRiengProvider>();
  List<LienHeRiengResponse> lienHeRiengList = [];
  LienHeRiengRequest lienHeRiengRequest = LienHeRiengRequest();

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
  bool isLoadingLienHe = false;

  //visible
  bool visible = false;

  //userId
  String userId = '';

  //title appbar
  String title = "Quản lý khách hàng";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      taiKhoanResponse = Get.arguments as TaiKhoanResponse;
      getUserId().then((value) {
        getLienHeRieng();
        getDonDichVu();
      });
    } else {
      isLoading = false;
    }
  }

  ///
  ///get user id
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///get don dich vu
  ///
  void getDonDichVu() {
    donDichVuProvider.paginate(
      page: 1,
      limit: 100,
      filter:
          "&idTaiKhoanNhanDon=$userId&idTaiKhoan=${taiKhoanResponse.id}&idNhomDichVu=$NHOM_DICH_VU_8&idTrangThaiDonDichVu=$TRUNG_THAU&sortBy=updated_at:desc",
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          donDichVuList = data;
          for (final item in data) {
            if (item.tongDon == "null") {
              item.tongDon = "0";
            }
            totalQuaApp += int.parse(item.tongDon.toString());
            if (item.id == data.last.id) {
              isLoading = false;
              update();
            }
          }
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
  ///get lien he rieng
  ///
  void getLienHeRieng() {
    lienHeRiengProvider.paginate(
      page: 1,
      limit: 100,
      filter:
          "&idTaiKhoan=$userId&idTaiKhoanLienHe=${taiKhoanResponse.id}&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isNotEmpty) {
          lienHeRiengList = data;
          totalLienHe = 0;
          totalController.clear();
          dateController.clear();
          contentController.clear();
          for (final item in data) {
            totalLienHe += int.parse(item.giaTriGiaoDich.toString());
          }
          isLoadingLienHe = false;
          update();
        }
      },
      onError: (error) {
        print("V3CustomerDetailController getLienHeRieng onError $error");
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
      //set data
      lienHeRiengRequest.idTaiKhoan = userId;
      lienHeRiengRequest.idTaiKhoanLienHe = taiKhoanResponse.id;
      lienHeRiengRequest.giaTriGiaoDich =
          totalController.text.replaceAllMapped(".", (match) => "");
      lienHeRiengRequest.ngayGiaoDich =
          DateConverter.convertStringToDate(dateController.text).toString();
      lienHeRiengRequest.noiDung = contentController.text;

      //add
      lienHeRiengProvider.add(
        data: lienHeRiengRequest,
        onSuccess: (data) {
          isLoadingLienHe = true;
          visibleOnChanged();
          update();
          getLienHeRieng();
        },
        onError: (error) {
          print("V3CustomerDetailController getLienHeRieng onError $error");
        },
      );
    }
  }
}
