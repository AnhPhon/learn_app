import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/helper/izi_validate.dart';

class V1ProjectDetailController extends GetxController {
  String title = "Chi tiết dự án";

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  String place = "Hòa Khánh Nam, Liên Chiểu, Đà Nẵng";

  String introduce =
      "1. Tổng quan dự án:\n- Quy mô: Phân khu cao cấp thuộc KĐT Đà Nẵng Pearl.\n- Chủ đầu tư: Công ty CP Đất Xanh Miền Trung.\n- Đơn vị quy hoạch: SOM Singapore.\n- Đơn vị giám sát: Công ty Delta Mỹ.\n\n2. Tiện ích nội khu:\n- Quảng trường ánh sáng nơi diễn ra các lễ hội trình diễn nghệ thuật, tiệc BBQ ngoài trời.\n- Bến du thuyền và khu biểu diễn nhạc nước trên sông Cổ Cò.\n- Khu thể thao: Sân tennis, sân bóng rổ, đường chạy bộ thể thao.";


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
      print('V1ProjectDetailController onInit $idProject');

      duAnKhachHangProvider.find(
        id: idProject.toString(),
        onSuccess: (data) {
          duAnKhachHangResponse = data;
          update();
        },
        onError: (error) {
          print('V1ProjectDetailController onInit onError $error');
        },
      );
    }
  }

  String getDDiaDiemCuTheFull() {
    String s = '';
    if (Validate.nullOrEmpty(duAnKhachHangResponse!.diaDiem) == false) {
      s += duAnKhachHangResponse!.diaDiem.toString();
    }
    if (Validate.nullOrEmpty(duAnKhachHangResponse!.idPhuongXa) == false) {
      s += s == '' ? '' : ', ';
      s += duAnKhachHangResponse!.idPhuongXa.toString();
    }
    if (Validate.nullOrEmpty(duAnKhachHangResponse!.idQuanHuyen) == false) {
      s += s == '' ? '' : ', ';
      s += duAnKhachHangResponse!.idQuanHuyen.toString();
    }
    if (Validate.nullOrEmpty(duAnKhachHangResponse!.idTinhTp) == false) {
      s += s == '' ? '' : ', ';
      s += duAnKhachHangResponse!.idTinhTp.toString();
    }
    return s;
  }

}
