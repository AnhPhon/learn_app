import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2ProjectDangKyTrienKhaiController extends GetxController {
  String title = "Chi tiết dự án";

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  String place = "Hòa Khánh Nam, Liên Chiểu, Đà Nẵng";

  String introduce =
      "1. Tổng quan dự án:\n- Quy mô: Phân khu cao cấp thuộc KĐT Đà Nẵng Pearl.\n- Chủ đầu tư: Công ty CP Đất Xanh Miền Trung.\n- Đơn vị quy hoạch: SOM Singapore.\n- Đơn vị giám sát: Công ty Delta Mỹ.\n\n2. Tiện ích nội khu:\n- Quảng trường ánh sáng nơi diễn ra các lễ hội trình diễn nghệ thuật, tiệc BBQ ngoài trời.\n- Bến du thuyền và khu biểu diễn nhạc nước trên sông Cổ Cò.\n- Khu thể thao: Sân tennis, sân bóng rổ, đường chạy bộ thể thao.";


  String? idProject;

  DuAnKhachHangProvider duAnKhachHangProvider = GetIt.I.get<DuAnKhachHangProvider>();
  DuAnKhachHangResponse? duAnKhachHangResponse;

  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  List<NhomDichVuResponse>? nhomDichVuResponse;
  NhomDichVuResponse currentNhomDichVuResponse = NhomDichVuResponse.fromJson({});

  LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  List<LoaiCongViecResponse>? loaiCongViecResponse;
  LoaiCongViecResponse currentLoaiCongViecResponse = LoaiCongViecResponse.fromJson({});

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if(arguments != null && arguments['idProject'] != null){
      idProject = arguments!['idProject'].toString();
      title = arguments!['title'].toString();
      print('V2ProjectDangKyTrienKhaiController onInit $idProject');

      duAnKhachHangProvider.find(
        id: idProject.toString(),
        onSuccess: (data) {
          duAnKhachHangResponse = data;
          update();
        },
        onError: (error) {
          print('V2ProjectDangKyTrienKhaiController duAnKhachHangProvider all onError $error');
        },
      );

      nhomDichVuProvider.all(
        onSuccess: (data) {
          if(data.isNotEmpty){
            // Selectbox khong cho phep init null gia tri, nen chon 1 gia tri dau tien de init
            updateNhomDichVu(data[0]);
          }
          nhomDichVuResponse = data;
          print('nhomDichVuResponse $nhomDichVuResponse');
          print('currentNhomDichVuResponse $currentNhomDichVuResponse');
          update();
        },
        onError: (error) {
          print('V2ProjectDangKyTrienKhaiController nhomDichVuProvider onError all $error');
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

  // Chon nhom dich vu va lay danh sach cong viec
  void updateNhomDichVu(NhomDichVuResponse nhomDichVuResponse) {
    currentNhomDichVuResponse = nhomDichVuResponse;

    loaiCongViecProvider.paginate(
      filter: '&idNhomDichVu=${currentNhomDichVuResponse.id.toString()}',
      limit: 100,
      page: 1,
      onSuccess: (data) {
        if(data.isNotEmpty){
          currentLoaiCongViecResponse  = data[0];
        }
        loaiCongViecResponse = data;
        print('loaiCongViecResponse $loaiCongViecResponse');
        print('currentLoaiCongViecProvider $currentLoaiCongViecResponse');
        update();
      },
      onError: (error) {
        print('V2ProjectDangKyTrienKhaiController loaiCongViecProvider onError all $error');
      },
    );
    update();
  }

}
