import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1JobManagementController extends GetxController {
  //refresh controller for load more refresh
  List<RefreshController> refreshController = [];

  //DonDichVu
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  List<DonDichVuResponse> donDichVuList = [];

  //title appbar
  String title = "Quản lý công việc";

  //tab
  List titleTabBar = [
    "Việc đang làm",
    "Việc đã làm",
  ];

  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 5;

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
  void getDonDichVu() {
    donDichVuProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isNotEmpty) {
          donDichVuList = data;
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
  /// go to Product Response
  ///
  void onProductResponseClick() {}
}
