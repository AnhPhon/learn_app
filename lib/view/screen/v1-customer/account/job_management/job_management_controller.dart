import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class V1JobManagementController extends GetxController {
  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //DonDichVu
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  List<DonDichVuResponse> donDichVuList = [];

  List<DonDichVuResponse> viecDangLam = [];
  List<DonDichVuResponse> viecDaLam = [];

  //title appbar
  String title = "Quản lý công việc";

  //tab
  List titleTabBar = [
    "Việc đang làm",
    "Việc đã làm",
  ];

  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 10;

  //user id
  String userId = "";

  //current index
  int currentIndex = 0;

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getUserId().then((value) {
      getDonDichVu();
    });
  }

  ///
  ///get user id
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///get DonDichVu
  ///
  void getDonDichVu({bool? isRefresh = true}) {
    //isRefresh
    if (isRefresh == true) {
      pageMax = 1;
      viecDangLam.clear();
      viecDaLam.clear();
    } else {
      //is load more
      pageMax++;
    }

    //get don dich vu
    donDichVuProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          donDichVuList = data;

          //for loop
          for (final item in data) {
            viecDangLam.addIf(
                item.idTrangThaiDonDichVu!.id == CHOT_GIA ||
                    item.idTrangThaiDonDichVu!.id == TRUNG_THAU,
                item);
            viecDaLam.addIf(
                item.idTrangThaiDonDichVu!.id == CHUA_NGHIEM_THU ||
                    item.idTrangThaiDonDichVu!.id == DA_NGHIEM_THU ||
                    item.idTrangThaiDonDichVu!.id == DA_QUYET_TOAN,
                item);

            //last in for
            if (item.id == data.last.id) {
              if (isRefresh == true) {
                refreshController.refreshCompleted();
              } else {
                refreshController.loadComplete();
              }
              isLoading = false;
              update();
            }
          }
        } else {
          refreshController.loadNoData();
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print("V1JobManagementController getDonDichVu onError $error");
      },
    );
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      update();
    }
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //reset noData
    refreshController.resetNoData();

    //getDonDichVu
    getDonDichVu();
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //getDonDichVu
    getDonDichVu(isRefresh: false);
  }

  ///
  /// go to work page
  ///
  void onWorkPageClick({required DonDichVuResponse donDichVuResponse}) {
    if (currentIndex == 0) {
      Get.toNamed(AppRoutes.V1_WORK_IN_PROGRESS, arguments: donDichVuResponse);
    } else {
      Get.toNamed(AppRoutes.V1_WORK_DONE, arguments: donDichVuResponse);
    }
  }

  ///
  /// format date
  ///
  String getDeadline(String end) {
    final DateTime current = DateTime.now();
    final DateTime dateEnd = DateConverter.convertStringToDatetime(
      end.replaceAll("T", " ").substring(
            0,
            end.length - 1,
          ),
    );

    return "${dateEnd.difference(current).inDays} ngày";
  }
}
