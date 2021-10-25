import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/cong_viec_nhan_vien_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V4WorkProgressController extends GetxController
    with SingleGetTickerProviderMixin {
  GetIt sl = GetIt.instance;

  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  // refresher controller
  RefreshController? refreshMoiTaoController;
  RefreshController? refreshDangLamController;
  RefreshController? refreshHoanThanhController;
  RefreshController? refreshChamTreController;

  List<CongViecNhanVienResponse> moiTaoModelList = [];
  List<CongViecNhanVienResponse> dangLamModelList = [];
  List<CongViecNhanVienResponse> hoanThanhModelList = [];
  List<CongViecNhanVienResponse> chamTreModelList = [];

  //khai báo seleceted Index
  int selectedIndex = 0;

  //khai báo isLoading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    refreshMoiTaoController = RefreshController();

    //get worl progress
    selectedIndex = int.parse(Get.parameters['tabIndex'].toString());

    getTienDoCongViec();
  }

  ///
  ///  theo doi tien do
  ///
  void getTienDoCongViec() {
    moiTaoModelList.clear();
    dangLamModelList.clear();
    hoanThanhModelList.clear();
    chamTreModelList.clear();
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      congViecNhanVienProvider.paginate(
        page: 1,
        limit: 30,
        filter: "&idNhanVien=$id&sortBy=created_at:desc",
        onSuccess: (value) {
          for (final models in value) {
            final String status = models.trangThai!.toLowerCase();
            if (status == "1") {
              moiTaoModelList.add(models);
            } else if (status == "2") {
              dangLamModelList.add(models);
            } else if (status == "3") {
              hoanThanhModelList.add(models);
            } else {
              chamTreModelList.add(models);
            }
          }

          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// on refresh MỚI TẠO
  ///
  Future<void> onMoiTaoRefresh() async {
    getTienDoCongViec();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshMoiTaoController!.refreshCompleted();
  }

  ///
  /// on loading
  ///
  Future<void> onMoiTaoLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshMoiTaoController!.loadComplete();
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  int tienDo({required String startDate, required String endDate}) {
    return DateConverter.differenceDateyyyyMMdd(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
