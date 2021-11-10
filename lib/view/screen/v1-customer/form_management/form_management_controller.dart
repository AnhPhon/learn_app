import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class V1FormManagementController extends GetxController {
  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //DonDichVu
  DonDichVuProvider donDichVuProvider = GetIt.I.get();
  List<DonDichVuResponse> donDichVuList = [];

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  //title appbar
  String title = "Quản lý đơn tạo";

  //user id
  String userId = "";

  //tab
  Map<String, String> titleTabBar = {
    "DPH": "Đã phản hồi",
    "CPH": "Chưa phản hồi",
  };

  //index tab
  int currentIndex = 0;

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getUserId().then((value) => getDonDichVu());
  }

  ///
  ///get userid
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
      donDichVuList.clear();
    } else {
      //isLoadmore
      pageMax++;
    }

    //get donDichVu
    donDichVuProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoan=$userId&idTrangThaiDonDichVu=${(currentIndex == 0) ? DA_PHAN_HOI : CHUA_PHAN_HOI}&sortBy=created_at:desc",
      onSuccess: (data) {
        print(data.length);
        if (data.isEmpty) {
          refreshController.loadNoData();
        } else {
          if (isRefresh == true) {
            donDichVuList = data;

            //remove nhom3, nhom4 da phan hoi
            if (currentIndex == 0) {
              donDichVuList.removeWhere(
                (element) =>
                    element.idNhomDichVu!.id == NHOM_DICH_VU_3 ||
                    element.idNhomDichVu!.id == NHOM_DICH_VU_4,
              );
            }

            donDichVuList.removeWhere(
                (element) => element.idNhomDichVu!.id == NHOM_DICH_VU_8);

            refreshController.refreshCompleted();
          } else {
            donDichVuList = donDichVuList + data;
            refreshController.loadComplete();
          }
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1FormManagementController getDonDichVu onError $error");
      },
    );
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    if (currentIndex != index) {
      //set index
      currentIndex = index;

      //loading
      isLoading = true;

      //resetNoData
      refreshController.resetNoData();

      //getDonDichVu
      getDonDichVu();
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
  /// go to Product Response
  ///
  void onProductResponseClick({required int index}) {
    print(donDichVuList[index].id);
    print(donDichVuList[index].idNhomDichVu!.id);
    if (donDichVuList[index].idNhomDichVu!.id == NHOM_DICH_VU_1) {
      print("NHOM_1");
      Get.toNamed(
        (currentIndex == 0)
            ? AppRoutes.V1_BUILD_ORDER_FEEDBACK
            : AppRoutes.V1_SERVICE_REVIEW_G1,
        arguments: donDichVuList[index],
      );
    } else if (donDichVuList[index].idNhomDichVu!.id == NHOM_DICH_VU_2) {
      print("NHOM_2");
      Get.toNamed(
        (currentIndex == 0)
            ? AppRoutes.V1_BUILD_ORDER_FEEDBACK
            : AppRoutes.V1_SERVICE_REVIEW_G2,
        arguments: donDichVuList[index],
      );
    } else if (donDichVuList[index].idNhomDichVu!.id == NHOM_DICH_VU_3 &&
        currentIndex == 1) {
      print("NHOM_3");
      Get.toNamed(
        AppRoutes.V1_SERVICE_REVIEW_G3,
        arguments: donDichVuList[index],
      );
    } else if (donDichVuList[index].idNhomDichVu!.id == NHOM_DICH_VU_4 &&
        currentIndex == 1) {
      print("NHOM_4");
      Get.toNamed(
        AppRoutes.V1_SERVICE_REVIEW_G4,
        arguments: donDichVuList[index],
      );
    } else if (donDichVuList[index].idNhomDichVu!.id == NHOM_DICH_VU_5) {
      print("NHOM_5");
      Get.toNamed(
        (currentIndex == 0)
            ? AppRoutes.V1_GROUP_ORDER_FEEDBACK5
            : AppRoutes.V1_SERVICE_REVIEW_G5,
        arguments: donDichVuList[index],
      );
    } else if (donDichVuList[index].idNhomDichVu!.id == NHOM_DICH_VU_6) {
      print("NHOM_6");
      Get.toNamed(
        (currentIndex == 0)
            ? AppRoutes.V1_GROUP_ORDER_FEEDBACK6
            : AppRoutes.V1_SERVICE_REVIEW_G6,
        arguments: donDichVuList[index],
      );
    }
  }
}
