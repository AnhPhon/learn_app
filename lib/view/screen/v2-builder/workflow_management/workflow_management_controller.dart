import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2WorkflowManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  // cong viec dang lam
  List<DonDichVuResponse> dangLam = [];

  // cong viec hoan thanh
  List<DonDichVuResponse> hoanThanh = [];

  //khai báo isLoading
  bool isLoading = true;

  //Khai báo isRecruiting
  bool isRecruiting = true;

  @override
  void onInit() {
    super.onInit();

    // get data theo id người dùng
    sl.get<SharedPreferenceHelper>().userId.then(
      (id) {
        taiKhoanProvider.find(
          id: id!,
          onSuccess: (values) {
            // read cong viec nhan vien
            _readCongViecNhanVien();
          },
          onError: (error) {
            print(error);
          },
        );
      },
    );
  }

  ///
  /// get cong viec
  ///
  void _readCongViecNhanVien() {
    donDichVuProvider.paginate(
      page: 1,
      limit: 20,
      filter: "&sortBy=created_at:desc",
      onSuccess: (values) {
        for (final value in values) {
          if (value.idTrangThaiDonHang != null) {
            final String tieuDe = value.idTrangThaiDonHang!.tieuDe.toString();
            if (value.idNhomDichVu!.nhomDichVu! == "3" ||
                value.idNhomDichVu!.nhomDichVu! == "4") {
              if (tieuDe.toLowerCase() == "đang xử lý" ||
                  tieuDe.toLowerCase() == "dang tuyen") {
                dangLam.add(value);
              } else {
                hoanThanh.add(value);
              }
            }
          }
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///Click to Work done page
  ///
  void onClickToWorkDonePage() {
    Get.toNamed(AppRoutes.V2_WORK_DONE);
  }

  ///
  ///Click to Work in progress
  ///
  void onClickToWorkInProgressPage() {
    Get.toNamed(AppRoutes.V2_WORK_IN_PROGRESS);
  }

  ///
  /// format date
  ///
  String getDeadline(String end) {
    final DateTime current = DateTime.now();
    final DateTime dateEnd = DateTime.parse(end);

    return "${current.difference(dateEnd).inDays} ngày";
  }
}
