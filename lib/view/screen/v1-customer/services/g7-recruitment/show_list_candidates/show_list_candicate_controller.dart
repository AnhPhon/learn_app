import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/danh_sach_ung_tuyen_response.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';

class ShowListCandicateController extends GetxController {
  final DanhSachUngTuyenProvider danhSachUngProvider =
      GetIt.I.get<DanhSachUngTuyenProvider>();

  List<DanhSachUngTuyenResponse> danhSachUngTuyenList = [];
  RefreshController refreshController = RefreshController();
  bool isLoading = true;
  int limitMax = 5;
  int pageMax = 1;
  String idTuyenDung = '';
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      idTuyenDung = Get.arguments as String;
      getCandicate(isRefresh: true);
    }
  }

  ///
  /// lam moi
  ///
  void onRefresh() {
    getCandicate(isRefresh: true);
  }

  ///
  /// lam moi
  ///
  void onLoadMore() {
    getCandicate(isRefresh: false);
  }

  ///
  /// lấy tất cả ứng viên ứng tuyển vào tin này
  ///
  void getCandicate({required bool isRefresh}) {
    print("Endpoint: ${'&idTuyenDung=$idTuyenDung&sortBy=created_at:desc'}");
    if (isRefresh) {
      limitMax = 5;
      pageMax = 1;
      danhSachUngTuyenList.clear();
    } else {
      pageMax++;
    }
    danhSachUngProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&idTuyenDung=$idTuyenDung&sortBy=created_at:desc',
        onSuccess: (data) {
          print("Độ dài: ${data.length}");
          if (data.isEmpty) {
            refreshController.loadNoData();
          } else {
            danhSachUngTuyenList.addAll(data);
            if (isRefresh) {
              refreshController.resetNoData();
              refreshController.refreshCompleted();
            } else {
              refreshController.loadComplete();
            }
          }

          isLoading = false;
          update();
        },
        onError: (onError) {
          print(
              "danh sach ung vien ung tuyen vao tin tuyen dung ShowListCandicateController getCandicate");
        });
  }

  ///
  /// Onlick đến xem thông tin hồ sơ ưng tuyển
  ///
  void onClickProfile({required DangKyViecMoiResponse dangKyViecMoiModel}) {
    Get.toNamed(AppRoutes.V1_CANDICATE_PROFILE, arguments: dangKyViecMoiModel);
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
