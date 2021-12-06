import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class V3CustomerManagementController extends GetxController {
  //TextEditingController
  final searchController = TextEditingController();

  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //DonDichVu
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  //tai khoan
  List<TaiKhoanResponse> taiKhoanList = [];

  //loading
  bool isLoading = true;
  bool isLoadingSearch = false;

  //user id
  String userId = "";

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  //onchange icon (search or close)
  bool isSearched = false;

  //title appbar
  String title = "Quản lý khách hàng";

  @override
  void onInit() {
    super.onInit();
    getUserId().then((value) {
      getKhachHang();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///get khach hang
  ///
  void getKhachHang({bool? isRefresh = true}) {
    //isRefresh
    if (isRefresh == true) {
      pageMax = 1;
      taiKhoanList.clear();
    } else {
      //is load more
      pageMax++;
    }

    //get khach hang
    donDichVuProvider.paginateKhachHang(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoanNhanDon=$userId&idNhomDichVu=$NHOM_DICH_VU_8&idTrangThaiDonDichVu=$TRUNG_THAU&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isEmpty) {
          refreshController.loadNoData();
        } else {
          if (isRefresh == true) {
            taiKhoanList = data;
            refreshController.refreshCompleted();
          } else {
            taiKhoanList = taiKhoanList.toList() + data;
            refreshController.loadComplete();
          }
        }

        isLoading = false;
        isLoadingSearch = false;
        update();
      },
      onError: (error) {
        print("V3CustomerManagementController getKhachHang onError $error");
      },
    );
  }

  ///
  ///search
  ///
  void searchKhachHang(BuildContext context, {bool? isRefresh = true}) {
    //isRefresh
    if (isRefresh == true) {
      pageMax = 1;
      taiKhoanList.clear();
    } else {
      //is load more
      pageMax++;
    }

    //get khach hang
    donDichVuProvider.paginateKhachHang(
      page: pageMax,
      limit: limitMax,
      filter:
          "&keyword=${searchController.text}&idTaiKhoanNhanDon=$userId&idNhomDichVu=$NHOM_DICH_VU_8&idTrangThaiDonDichVu=$TRUNG_THAU&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isEmpty) {
          refreshController.loadNoData();
        } else {
          if (isRefresh == true) {
            taiKhoanList = data;
            refreshController.refreshCompleted();
          } else {
            taiKhoanList = taiKhoanList.toList() + data;
            refreshController.loadComplete();
          }
        }

        FocusScope.of(context).requestFocus(FocusNode());
        isSearched = true;
        isLoadingSearch = false;
        update();
      },
      onError: (error) {
        print("V3CustomerManagementController getKhachHang onError $error");
      },
    );
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh(BuildContext context) async {
    //reset noData
    refreshController.resetNoData();

    //isSearched
    if (isSearched) {
      searchKhachHang(context);
    } else {
      //getKhachHang
      getKhachHang();
    }
  }

  ///
  /// on loading
  ///
  Future<void> onLoading(BuildContext context) async {
    //isSearched
    if (isSearched) {
      searchKhachHang(context);
    } else {
      //getKhachHang
      getKhachHang(isRefresh: false);
    }
  }

  ///
  ///onSearch
  ///
  void onSearch(BuildContext context) {
    if (searchController.text.isNotEmpty) {
      isLoadingSearch = true;
      update();
      searchKhachHang(context);
    }
  }

  ///
  ///clear search
  ///
  void clearSearch(BuildContext context) {
    isLoadingSearch = true;
    isSearched = false;
    //clear text
    searchController.clear();

    //reset noData
    refreshController.resetNoData();

    //reload
    getKhachHang();
    FocusScope.of(context).requestFocus(FocusNode());

    update();
  }

  ///
  ///go to customer detail page
  ///
  void onCustomerDetailClick({required TaiKhoanResponse taiKhoanResponse}) {
    Get.toNamed(AppRoutes.V3_CUSTOMER_DETAIL, arguments: taiKhoanResponse);
  }
}
