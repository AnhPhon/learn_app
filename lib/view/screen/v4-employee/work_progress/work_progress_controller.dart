import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/cong_viec_nhan_vien_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V4WorkProgressController extends GetxController
    with SingleGetTickerProviderMixin {
  GetIt sl = GetIt.instance;

  //Công việc nhân viên Provider
  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  // refresher controller MỚI TẠO
  RefreshController refreshMoiTaoController =
      RefreshController(initialRefresh: true);

  //refresher controller ĐANG LÀM
  RefreshController refreshDangLamController =
      RefreshController(initialRefresh: true);

  //refresher controller HOÀN THÀNH
  RefreshController refreshHoanThanhController =
      RefreshController(initialRefresh: true);

  //refresher controller CHẬM TRỄ
  RefreshController refreshChamTreController =
      RefreshController(initialRefresh: true);

  List<CongViecNhanVienResponse> moiTaoModelList = [];
  List<CongViecNhanVienResponse> dangLamModelList = [];
  List<CongViecNhanVienResponse> hoanThanhModelList = [];
  List<CongViecNhanVienResponse> chamTreModelList = [];

  //Khai báo Thời gian thực tế hiện tại
  String ngayThucTe = DateConverter.estimatedDateOnly(DateTime.now());

  //convert datet time do yyyy-MM-dd
  String tienDoChamTre = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //khai báo seleceted Index
  int selectedIndex = 0;

  //khai báo isLoading
  bool isLoading = true;

  // page for for load more refresh MỚI TẠO
  int pageMaxMoiTao = 1;
  int limitMaxMoitao = 5;

  // page for for load more refresh ĐANG LÀM
  int pageMaxDangLam = 1;
  int limitMaxDangLam = 5;

  // page for for load more refresh HOÀN THÀNH
  int pageMaxHoanThanh = 1;
  int limitMaxHoanThanh = 5;

  // page for for load more refresh CHẬM TRỄ
  int pageMaxChamTre = 1;
  int limitMaxChamTre = 5;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //get worl progress
    selectedIndex = int.parse(Get.parameters['tabIndex'].toString());

    // Get Data tiến độ công việc MỚI TẠO
    getTienDoCongViecMoiTao(isRefresh: true);

    // Get Data tiến độ công việc ĐANG LÀM
    getTienDoCongViecDangLam(isRefresh: true);

    // Get Data tiến độ công việc HOÀN THÀNH
    getTienDoCongViecHoanThanh(isRefresh: true);

    // Get Data tiến độ công việc CHẬM TRỄ
    getTienDoCongViecChamTre(isRefresh: true);
  }

  @override
  void onClose() {
    refreshMoiTaoController.dispose();
    refreshDangLamController.dispose();
    refreshHoanThanhController.dispose();
    refreshChamTreController.dispose();
    super.onClose();
  }

  ///
  ///  Get Data tiến độ công việc MỚI TẠO
  ///
  void getTienDoCongViecMoiTao({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMaxMoiTao = 1;
      moiTaoModelList.clear();
    } else {
      //is load more
      pageMaxMoiTao++;
    }

    sl.get<SharedPreferenceHelper>().userId.then((id) {
      congViecNhanVienProvider.paginate(
        page: pageMaxMoiTao,
        limit: limitMaxMoitao,
        filter: "&idNhanVien=$id&trangThai=1&sortBy=created_at:desc",
        onSuccess: (value) {
          //check isEmpty
          if (value.isEmpty) {
            refreshMoiTaoController.loadNoData();
          } else {
            //is Refresh
            if (isRefresh) {
              moiTaoModelList = value;
              refreshMoiTaoController.refreshCompleted();
            } else {
              //is load more
              moiTaoModelList = moiTaoModelList.toList() + value;
              refreshMoiTaoController.loadComplete();
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
  ///  Get Data tiến độ công việc ĐANG LÀM
  ///
  void getTienDoCongViecDangLam({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMaxDangLam = 1;
      dangLamModelList.clear();
    } else {
      //is load more
      pageMaxDangLam++;
    }

    sl.get<SharedPreferenceHelper>().userId.then((id) {
      congViecNhanVienProvider.paginate(
        page: pageMaxDangLam,
        limit: limitMaxDangLam,
        filter: "&idNhanVien=$id&trangThai=2&sortBy=created_at:desc",
        onSuccess: (value) {
          //check isEmpty
          if (value.isEmpty) {
            refreshDangLamController.loadNoData();
          } else {
            if (isRefresh) {
              dangLamModelList = value;
              refreshDangLamController.refreshCompleted();
            } else {
              //is load more
              dangLamModelList = dangLamModelList.toList() + value;
              refreshDangLamController.loadComplete();
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
  ///  Get Data tiến độ công việc HOÀN THÀNH
  ///
  void getTienDoCongViecHoanThanh({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMaxHoanThanh = 1;
      hoanThanhModelList.clear();
    } else {
      //is load more
      pageMaxHoanThanh++;
    }

    sl.get<SharedPreferenceHelper>().userId.then((id) {
      congViecNhanVienProvider.paginate(
        page: pageMaxHoanThanh,
        limit: limitMaxHoanThanh,
        filter: "&idNhanVien=$id&trangThai=3&sortBy=created_at:desc",
        onSuccess: (value) {
          //check isEmpty
          if (value.isEmpty) {
            refreshHoanThanhController.loadNoData();
          } else {
            if (isRefresh) {
              hoanThanhModelList = value;
              refreshHoanThanhController.refreshCompleted();
            } else {
              //is load more
              hoanThanhModelList = hoanThanhModelList.toList() + value;
              refreshHoanThanhController.loadComplete();
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
  ///  Get Data tiến độ công việc CHẬM TRỄ
  ///
  void getTienDoCongViecChamTre({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMaxChamTre = 1;
      chamTreModelList.clear();
    } else {
      //is load more
      pageMaxChamTre++;
    }

    sl.get<SharedPreferenceHelper>().userId.then((id) {
      congViecNhanVienProvider.paginate(
        page: pageMaxChamTre,
        limit: limitMaxChamTre,
        filter: "&idNhanVien=$id&trangThai=4&sortBy=created_at:desc",
        onSuccess: (value) {
          //check isEmpty
          if (value.isEmpty) {
            refreshChamTreController.loadNoData();
          } else {
            if (isRefresh) {
              chamTreModelList = value;
              refreshChamTreController.refreshCompleted();
            } else {
              //is load more
              chamTreModelList = chamTreModelList.toList() + value;
              refreshChamTreController.loadComplete();
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
  Future onMoiTaoRefresh() async {
    refreshMoiTaoController.resetNoData();
    getTienDoCongViecMoiTao(isRefresh: true);
  }

  ///
  /// on loading MỚI TẠO
  ///
  Future onMoiTaoLoading() async {
    getTienDoCongViecMoiTao(isRefresh: false);
  }

  ///
  /// on refresh DANG LÀM
  ///
  Future onDangLamRefresh() async {
    refreshDangLamController.resetNoData();
    getTienDoCongViecDangLam(isRefresh: true);
  }

  ///
  /// on loading ĐANG LÀM
  ///
  Future onDangLamLoading() async {
    getTienDoCongViecDangLam(isRefresh: false);
  }

  ///
  /// on refresh HOÀN THÀNH
  ///
  Future onHoanThanhRefresh() async {
    refreshHoanThanhController.resetNoData();
    getTienDoCongViecHoanThanh(isRefresh: true);
  }

  ///
  /// on loading HOÀN THÀNH
  ///
  Future onHoanThanhLoading() async {
    getTienDoCongViecHoanThanh(isRefresh: false);
  }

  ///
  /// on refresh CHẬM TRỄ
  ///
  Future onChamTreRefresh() async {
    refreshChamTreController.resetNoData();
    getTienDoCongViecChamTre(isRefresh: true);
  }

  ///
  /// on loading CHẬM TRỄ
  ///
  Future onChamTreLoading() async {
    getTienDoCongViecChamTre(isRefresh: false);
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  /// Tính tiến độ công việc
  ///
  int tienDo({required String startDate, required String endDate}) {
    return DateConverter.differenceDateyyyyMMdd(
      startDate: startDate,
      endDate: endDate,
    );
  }

  ///
  ///Click to Work done page
  ///
  void onClickToDetailNewWork(String idNewWork) {
    sl.get<SharedPreferenceHelper>().saveIdNewWork(id: idNewWork);
    Get.toNamed(AppRoutes.V4_DETAIL_WORK)!.then((value) {
      // Get Data tiến độ công việc MỚI TẠO
      getTienDoCongViecMoiTao(isRefresh: true);

      // Get Data tiến độ công việc ĐANG LÀM
      getTienDoCongViecDangLam(isRefresh: true);

      // Get Data tiến độ công việc HOÀN THÀNH
      getTienDoCongViecHoanThanh(isRefresh: true);

      // Get Data tiến độ công việc CHẬM TRỄ
      getTienDoCongViecChamTre(isRefresh: true);
    });
  }

  ///
  ///Back and reset Home Page
  ///
  void backHome() {
    Get.back(result: true);
  }
}
