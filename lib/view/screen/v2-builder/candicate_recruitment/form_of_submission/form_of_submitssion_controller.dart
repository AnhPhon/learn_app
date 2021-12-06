import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import '../../../../../di_container.dart';

class V2FormOfSubmitssionController extends GetxController {
  //Provider
  final dangKyViecMoiProvider = GetIt.I.get<DangKyViecMoiProvider>();

  //Danh sách ứng tuyển Provider
  DanhSachUngTuyenProvider danhSachUngTuyenProvider =
      GetIt.I.get<DanhSachUngTuyenProvider>();
  //idTuyenDung
  String? idTuyenDung;

  //isLoading
  bool isLoading = true;

  //userId
  // String? userId;

  //check data user đăng ký việc mới
  bool isDangKyViecMoiWithUser = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idTuyenDung = Get.parameters['idTuyenDung'];
    isLoading = false;
    update();
  }

  ///
  /// Nhân nút đánh văn bản
  ///
  void onClickTextTyingButton() {
    // get đăng ký việc kiểm tra đã có đăng ký chưa
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter: "&idTaiKhoan=$userId",
        onSuccess: (data) {
          if (data.isNotEmpty) {
            danhSachUngTuyenProvider.paginate(
              page: 1,
              limit: 1,
              filter: "&idTaiKhoanUngTuyen=$userId&idTuyenDung=$idTuyenDung",
              onSuccess: (models) {
                if (models.isNotEmpty) {
                  Alert.error(
                      message: 'Bạn đã ứng tuyển tin tuyển dụng này rồi!');
                } else {
                  Get.toNamed(
                      '${AppRoutes.V2_WORK_CREATE}?tuyenDung=true&idTuyenDung=$idTuyenDung');
                }
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
          } else {
            Alert.error(
                message:
                    'Bạn phải đăng ký việc mới trước khi thực hiện ứng tuyển');
          }
        },
        onError: (error) {
          Alert.error(
              message:
                  'Bạn phải đăng ký việc mới trước khi thực hiện ứng tuyển');
          print("TermsAndPolicyController checkRegister onError $error");
        },
      );
    });
  }

  ///
  /// Nhấn vào nút nộp cv
  ///
  void onClickCvButton() {
    sl.get<SharedPreferenceHelper>().userId.then((values) {
      danhSachUngTuyenProvider.paginate(
        page: 1,
        limit: 1,
        filter: "&idTaiKhoanUngTuyen=$values&idTuyenDung=$idTuyenDung",
        onSuccess: (models) {
          if (models.isNotEmpty) {
            Alert.error(message: 'Bạn đã ứng tuyển tin tuyển dụng này rồi!');
          } else {
            Get.toNamed('${AppRoutes.V2_CV}?idTuyenDung=$idTuyenDung')!
                .then((value) => {
                      if (value != null && value == true)
                        {Get.back(result: true)}
                    });
          }
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }
}
