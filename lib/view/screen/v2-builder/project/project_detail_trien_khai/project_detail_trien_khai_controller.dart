import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2ProjectDetailTrienKhaiController extends GetxController {
  String title = "Đang tải";

  String? idProject;

  DuAnKhachHangProvider duAnKhachHangProvider = GetIt.I.get<DuAnKhachHangProvider>();
  DuAnKhachHangResponse? duAnKhachHangResponse;

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if(arguments != null && arguments['idProject'] != null){
      idProject = arguments!['idProject'].toString();
      title = arguments!['title'].toString();
      print('V2ProjectDetailTrienKhaiController onInit $idProject');

      duAnKhachHangProvider.find(
        id: idProject.toString(),
        onSuccess: (data) {
          duAnKhachHangResponse = data;
          update();
        },
        onError: (error) {
          print('V2ProjectDetailTrienKhaiController onInit onError $error');
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool kiemTraIdHangMucXayDungs(){
    if (duAnKhachHangResponse!.idHangMucXayDungs != null && duAnKhachHangResponse!.idHangMucXayDungs!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void moViewDangKyViecMoi() {
    Get.toNamed(AppRoutes.V2_PROJECT_DANG_KY_TRIEN_KHAI, arguments: {'idProject': duAnKhachHangResponse!.id.toString(), 'title': title});
  }
}
