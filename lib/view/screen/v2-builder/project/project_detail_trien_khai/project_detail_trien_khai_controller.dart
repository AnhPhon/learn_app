import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_tho_thau_bao_gia_provider.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/validate.dart';

class V2ProjectDetailTrienKhaiController extends GetxController {
  String title = "Đang tải";

  String? idProject;

  DuAnKhachHangProvider duAnKhachHangProvider = GetIt.I.get<DuAnKhachHangProvider>();
  DuAnKhachHangResponse? duAnKhachHangResponse;

  DanhSachThoThauBaoGiaProvider danhSachThoThauBaoGiaProvider = GetIt.I.get<DanhSachThoThauBaoGiaProvider>();
  bool coTheBaoGia = false;

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['idProject'] != null) {
      idProject = arguments!['idProject'].toString();
      title = arguments!['title'].toString();

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

      kiemTraBaoGia();
    }
  }

  // Neu du an dang xay dung tra ve true
  bool kiemTraIdTrangThaiDuAnDangXayDung() {
    if (duAnKhachHangResponse!.idTrangThaiDuAn != null && duAnKhachHangResponse!.idTrangThaiDuAn!.id.toString() == TRANG_THAI_DU_AN['DANG_TRIEN_KHAI']['id']) {
      return true;
    } else {
      return false;
    }
  }

  ///
  /// Neu hang muc xay dung co du lieu tra ve true
  ///
  bool kiemTraIdHangMucXayDungs() {
    if (duAnKhachHangResponse!.idHangMucXayDungs != null && duAnKhachHangResponse!.idHangMucXayDungs!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> moViewDangKyViecMoi() async {
    await Get.toNamed(AppRoutes.V2_PROJECT_DANG_KY_TRIEN_KHAI, arguments: {'idProject': duAnKhachHangResponse!.id.toString(), 'title': title})!.then((value){
      if(value != null && value == true){
        kiemTraBaoGia();
      }
    });
  }

  ///
  /// Kiem tra da bao gia hay chua
  ///
  Future<void> kiemTraBaoGia() async {
    final String? idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    danhSachThoThauBaoGiaProvider.paginate(
      limit: 1,
      page: 1,
      filter: '&idDuAnKhachHang=$idProject&idTaiKhoanBaoGia=$idTaiKhoanBaoGia',
      onSuccess: (data) {
        if (data.isEmpty) {
          coTheBaoGia = true;
          update();
        } else {
          coTheBaoGia = false;
          update();
        }
      },
      onError: (error) {
        print('V2ShorthandedGroup1Controller kiemTraBaoGiaDonDichVu onError $error');
      },
    );
  }

  ///
  /// Dinh dang dia chi output
  ///
  String getDDiaDiemCuTheFull() {
    String s = '';
    if (Validate.checkValueIsNullEmpty(duAnKhachHangResponse!.diaDiem) == false) {
      s += duAnKhachHangResponse!.diaDiem.toString();
    }
    if (Validate.checkValueIsNullEmpty(duAnKhachHangResponse!.idPhuongXa) == false) {
      s += s == '' ? '' : ', ';
      s += duAnKhachHangResponse!.idPhuongXa.toString();
    }
    if (Validate.checkValueIsNullEmpty(duAnKhachHangResponse!.idQuanHuyen) == false) {
      s += s == '' ? '' : ', ';
      s += duAnKhachHangResponse!.idQuanHuyen.toString();
    }
    if (Validate.checkValueIsNullEmpty(duAnKhachHangResponse!.idTinhTp) == false) {
      s += s == '' ? '' : ', ';
      s += duAnKhachHangResponse!.idTinhTp.toString();
    }
    return s;
  }


  ///
  /// Remove all css property height from content
  ///
  String removeHeightImage(String html) {
    final _html = html.replaceAllMapped(
      RegExp(r'(<img[^>]+)(height=)', caseSensitive: false),
      (match) => '${match.group(1)}_${match.group(1)}',
    ).replaceAllMapped(
      RegExp(r'(<img[^>]+)(width=)', caseSensitive: false),
          (match) => '${match.group(1)}_${match.group(1)}',
    );

    return _html;
  }
}
