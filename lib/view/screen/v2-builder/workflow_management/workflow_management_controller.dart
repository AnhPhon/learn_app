import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2WorkflowManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  // refresher controller
  RefreshController? refreshDangLamController;
  RefreshController? refreshHoanThanhController;

  // cong viec dang lam
  List<DonDichVuResponse>? dangLam;

  // cong viec hoan thanh
  List<DonDichVuResponse>? hoanThanh = [];

  //khai báo isLoading
  bool isLoading = true;

  //Khai báo isRecruiting
  bool isRecruiting = true;

  final String dangTuyenKey = "đang tuyển";
  final String dangXuLyKey = "đang xử lý";
  final String dangLamKey = "đang làm";
  final String daLamKey = "đã làm";
  final String dangGiaoKey = "đang giao";
  final String hoanThanhKey = "hoàn thành";

  @override
  void onInit() {
    super.onInit();
    // refresh init
    refreshDangLamController = RefreshController();
    refreshHoanThanhController = RefreshController();

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
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      },
    );
  }

  ///
  /// get cong viec
  ///
  void _readCongViecNhanVien() {
    dangLam = [];
    hoanThanh = [];

    sl.get<SharedPreferenceHelper>().userId.then((id) {
      donDichVuProvider.paginate(
        page: 1,
        limit: 30,
        filter: "&idTaiKhoan=$id",
        onSuccess: (values) {
          for (final value in values) {
            if (value.idTrangThaiDonDichVu != null &&
                value.idNhomDichVu != null) {
              final String tieuDe =
                  value.idTrangThaiDonDichVu!.tieuDe.toString();
              final String nhomDichVu = value.idNhomDichVu!.nhomDichVu!;
              if (nhomDichVu == "3" || nhomDichVu == "4") {
                if (tieuDe.toLowerCase() == dangXuLyKey ||
                    tieuDe.toLowerCase() == dangTuyenKey ||
                    tieuDe.toLowerCase() == dangLamKey ||
                    tieuDe.toLowerCase() == dangGiaoKey) {
                  dangLam!.add(value);
                } else {
                  hoanThanh!.add(value);
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
    });
  }

  ///
  ///Click to Work done page
  ///
  void onClickToWorkDonePage(String idDonDichVu) {
    sl.get<SharedPreferenceHelper>().saveWorkFlow(id: idDonDichVu);
    Get.toNamed(AppRoutes.V2_WORK_DONE)!.then((value) {
      if (value == true) {
        EasyLoading.showSuccess("Gửi thành công");
      }
    });
  }

  ///
  ///Click to Work in progress
  ///
  void onClickToWorkInProgressPage(String idDonDichVu) {
    sl.get<SharedPreferenceHelper>().saveWorkFlow(id: idDonDichVu);
    Get.toNamed(AppRoutes.V2_WORK_IN_PROGRESS)!.then((value) {
      if (value == true) {
        EasyLoading.showSuccess("Gửi thành công");
      }
    });
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

    return "${current.difference(dateEnd).inDays} ngày";
  }

  ///
  /// on refresh
  ///
  Future<void> onDangLamRefresh() async {
    _readCongViecNhanVien();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshDangLamController!.refreshCompleted();
  }

  ///
  /// on loading
  ///
  Future<void> onDangLamLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshDangLamController!.loadComplete();
  }

  ///
  /// on refresh
  ///
  Future<void> onHoanThanhRefresh() async {
    _readCongViecNhanVien();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshHoanThanhController!.refreshCompleted();
  }

  ///
  /// on loading
  ///
  Future<void> onHoanThanhLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshHoanThanhController!.loadComplete();
  }
}
