import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3TaiKhoanCuaBanController extends GetxController
    with SingleGetTickerProviderMixin {
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();

  String title = "Tài khoản của bạn";

  bool isLoading = true;
  double viTien = 0;
  double canThanhToan = 0;
  double tienConLai = 0;

  String labelTien = "Còn dư";
  List<List<dynamic>> labels = [];

  @override
  void onInit() {
    super.onInit();
    canThanhToan = Get.arguments as double;
    labels = [
      ["Số dư của bạn", viTien],
      ["Số tiền cần thanh toán", canThanhToan],
      [labelTien, tienConLai],
    ];
    loadData();
    update();
  }

  ///
  /// load data
  ///
  void loadData() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      viTienProvider.paginate(
        page: 1,
        limit: 2,
        filter: "&idTaiKhoan=$userId",
        onSuccess: (data) {
          if (data.isNotEmpty) {
            viTien = double.parse(data.first.tongTien!);
            tienConLai = viTien - canThanhToan;
            if (tienConLai < 0) {
              labelTien = "Còn thiếu";
              tienConLai = tienConLai * 1;
            }

            labels = [
              ["Số dư của bạn", viTien],
              ["Số tiền cần thanh toán", canThanhToan],
              [labelTien, tienConLai],
            ];
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
        },
      );
    });
  }

  ///
  /// on Nap Tien Click
  ///
  void onNapTienClick() {
    Get.toNamed(AppRoutes.V3_THONG_TIN_THANH_TOAN);
  }

  ///
  /// on Dong Y Thanh Toan Click
  ///
  void onDongYThanhToanClick() {
    Get.toNamed(AppRoutes.V3_THONG_BAO_THANH_CONG);
  }
}
