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
  Map<String, TaiKhoanResponse> taiKhoan = {};

  //loading
  bool isLoading = true;

  //user id
  String userId = "";

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

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
      taiKhoan.clear();
    } else {
      //is load more
      pageMax++;
    }

    //get khach hang
    donDichVuProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoan=$userId&idNhomDichVu=$NHOM_DICH_VU_8&idTrangThaiDonDichVu=$TRUNG_THAU&sortBy=created_at:desc",
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          //for loop
          for (final item in data) {
            final id = item.idTaiKhoanNhanDon!.id;

            //if id tai khoan have not
            if (taiKhoan.containsKey(id) == false) {
              taiKhoan[id!] = item.idTaiKhoanNhanDon!;
            }

            //done for
            if (item.id == data.last.id) {
              //isRefresh
              if (isRefresh == true) {
                refreshController.refreshCompleted();
              } else {
                //is load more
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
        print("V3CustomerManagementController getKhachHang onError $error");
      },
    );
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //reset noData
    refreshController.resetNoData();

    //getWalletHistory
    getKhachHang();
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //getWalletHistory
    getKhachHang(isRefresh: false);
  }

  ///
  ///go to customer detail page
  ///
  void onCustomerDetailClick({required TaiKhoanResponse taiKhoanResponse}) {
    Get.toNamed(AppRoutes.V3_CUSTOMER_DETAIL, arguments: taiKhoanResponse);
  }
}
