import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:template/data/model/request/danh_sach_tho_thau_bao_gia_request.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_tho_thau_bao_gia_provider.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/nhom_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class V2ProjectDangKyTrienKhaiController extends GetxController {
  String title = "Chi tiết dự án";

  String urlImage = "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  String place = "Hòa Khánh Nam, Liên Chiểu, Đà Nẵng";

  String introduce = "1. Tổng quan dự án:\n- Quy mô: Phân khu cao cấp thuộc KĐT Đà Nẵng Pearl.\n- Chủ đầu tư: Công ty CP Đất Xanh Miền Trung.\n- Đơn vị quy hoạch: SOM Singapore.\n- Đơn vị giám sát: Công ty Delta Mỹ.\n\n2. Tiện ích nội khu:\n- Quảng trường ánh sáng nơi diễn ra các lễ hội trình diễn nghệ thuật, tiệc BBQ ngoài trời.\n- Bến du thuyền và khu biểu diễn nhạc nước trên sông Cổ Cò.\n- Khu thể thao: Sân tennis, sân bóng rổ, đường chạy bộ thể thao.";

  String? idProject;

  DuAnKhachHangProvider duAnKhachHangProvider = GetIt.I.get<DuAnKhachHangProvider>();
  DuAnKhachHangResponse? duAnKhachHangResponse;

  NhomDichVuProvider nhomDichVuProvider = GetIt.I.get<NhomDichVuProvider>();
  List<NhomDichVuResponse>? nhomDichVuResponse;
  NhomDichVuResponse currentNhomDichVuResponse = NhomDichVuResponse.fromJson({});

  LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  List<LoaiCongViecResponse>? loaiCongViecResponse;
  List<LoaiCongViecResponse>? currentLoaiCongViecResponseList = [];
  List<MultiSelectItem<LoaiCongViecResponse?>> loaiCongViecMultiSelectItem = [];

  DanhSachThoThauBaoGiaRequest danhSachThoThauBaoGiaRequest = DanhSachThoThauBaoGiaRequest.fromJson({
    'idLoaiCongViecs': [],
    'idMatHangDacTrungs': [],
    'idDuAnKhachHang': '',
    'idDuAnKhachHang': '',
    'tienCoc': 0,
    'giaBao': 0,
    'idNhomCuaHang': '',
    'taiKhoanBaoGia': '',
  });

  DanhSachThoThauBaoGiaProvider danhSachThoThauBaoGiaProvider = GetIt.I.get<DanhSachThoThauBaoGiaProvider>();

  TextEditingController textDateController = TextEditingController();
  TextEditingController soLuongNguoiLamController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['idProject'] != null) {

      idProject = arguments!['idProject'].toString();
      title = arguments!['title'].toString();

      danhSachThoThauBaoGiaRequest.idDuAnKhachHang = idProject;
      danhSachThoThauBaoGiaRequest.taiKhoanBaoGia = sl.get<SharedPreferenceHelper>().userId.toString();

      getChiTietDuAn();

      getNhomDichVu();
    }
  }

  void getChiTietDuAn() {
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
  }

  void getNhomDichVu() {
    nhomDichVuProvider.all(
      onSuccess: (data) {
        if (data.isNotEmpty) {
          // Selectbox khong cho phep init null gia tri, nen chon 1 gia tri dau tien de init
          selectedNhomCongViec(data[0]);
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

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }

  bool kiemTraIdHangMucXayDungs() {
    if (duAnKhachHangResponse!.idHangMucXayDungs != null && duAnKhachHangResponse!.idHangMucXayDungs!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void selectedNhomCongViec(NhomDichVuResponse nhomDichVuResponse) {
    currentNhomDichVuResponse = nhomDichVuResponse;
    danhSachThoThauBaoGiaRequest.idNhomDichVu = currentNhomDichVuResponse.id.toString();
    update();
    updateNhomDichVu(nhomDichVuResponse);
  }

  void selectedCongViecPhuHop(List<LoaiCongViecResponse?> results) {
    currentLoaiCongViecResponseList = results.cast<LoaiCongViecResponse>();
    danhSachThoThauBaoGiaRequest.idLoaiCongViecs = currentLoaiCongViecResponseList!.map((e) => e.id.toString()).toList();
  }

  void moViewDangKyViecMoi() {
    if (danhSachThoThauBaoGiaRequest.idLoaiCongViecs == null || danhSachThoThauBaoGiaRequest.idLoaiCongViecs!.isEmpty) {
      Get.snackbar(
        'Lỗi', // title
        'Hãy chọn ít nhất 1 công việc', // message
        shouldIconPulse: true,
        isDismissible: true,
        backgroundColor: ColorResources.RED,
        colorText: ColorResources.WHITE,
        icon: const Icon(
          Icons.error_outline,
          color: ColorResources.WHITE,
        ),
        duration: const Duration(seconds: 3),
      );
    } else if (danhSachThoThauBaoGiaRequest.idNhomDichVu == null || danhSachThoThauBaoGiaRequest.idNhomDichVu!.isEmpty) {
      Get.snackbar(
        'Lỗi', // title
        'Hãy chọn ít nhất 1 nhóm', // message
        shouldIconPulse: true,
        isDismissible: true,
        backgroundColor: ColorResources.RED,
        colorText: ColorResources.WHITE,
        icon: const Icon(
          Icons.error_outline,
          color: ColorResources.WHITE,
        ),
        duration: const Duration(seconds: 3),
      );
    } else if (danhSachThoThauBaoGiaRequest.thoiGianBatDauLam == null || danhSachThoThauBaoGiaRequest.thoiGianBatDauLam!.isEmpty) {
      Get.snackbar(
        'Lỗi', // title
        'Hãy chọn ngày bắt đầu làm', // message
        shouldIconPulse: true,
        isDismissible: true,
        backgroundColor: ColorResources.RED,
        colorText: ColorResources.WHITE,
        icon: const Icon(
          Icons.error_outline,
          color: ColorResources.WHITE,
        ),
        duration: const Duration(seconds: 3),
      );
    } else if (danhSachThoThauBaoGiaRequest.soLuongNguoi == null || danhSachThoThauBaoGiaRequest.soLuongNguoi! <= 0) {
      Get.snackbar(
        'Lỗi', // title
        'Số lượng người làm không hợp lệ', // message
        shouldIconPulse: true,
        isDismissible: true,
        backgroundColor: ColorResources.RED,
        colorText: ColorResources.WHITE,
        icon: const Icon(
          Icons.error_outline,
          color: ColorResources.WHITE,
        ),
        duration: const Duration(seconds: 3),
      );
    } else {
      guiYeuCauDangKy();
    }
  }

  void guiYeuCauDangKy() {
    try {
      EasyLoading.show(status: "Loading ...");
      danhSachThoThauBaoGiaProvider.add(
        data: danhSachThoThauBaoGiaRequest,
        onSuccess: (data) {
          EasyLoading.dismiss();
          Future.delayed(Duration.zero, () {
            Get.snackbar(
              'Thành công', // title
              'Đã gửi yêu cầu thành công', // message
              shouldIconPulse: true,
              isDismissible: true,
              backgroundColor: ColorResources.GREEN,
              colorText: ColorResources.WHITE,
              icon: const Icon(
                Icons.error_outline,
                color: ColorResources.WHITE,
              ),
              duration: const Duration(seconds: 3),
            );
          });
        },
        onError: (error) {
          EasyLoading.dismiss();
          print('V2ProjectDangKyTrienKhaiController danhSachThoThauBaoGiaProvider onError $error');
        },
      );
    } catch (error) {
      EasyLoading.dismiss();
      print('V2ProjectDangKyTrienKhaiController danhSachThoThauBaoGiaProvider catch $error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Chon nhom dich vu va lay danh sach cong viec
  void updateNhomDichVu(NhomDichVuResponse nhomDichVuResponse) {
    loaiCongViecProvider.paginate(
      filter: '&idNhomDichVu=${currentNhomDichVuResponse.id.toString()}',
      limit: 100,
      page: 1,
      onSuccess: (data) {
        currentLoaiCongViecResponseList = [];
        loaiCongViecResponse = [];
        loaiCongViecMultiSelectItem = [];
        if (data.isNotEmpty) {
          loaiCongViecResponse = data;
          loaiCongViecMultiSelectItem = loaiCongViecResponse!.map((e) => MultiSelectItem(e, e.tenCongViec.toString())).toList();
        }

        update();
      },
      onError: (error) {
        print('V2ProjectDangKyTrienKhaiController loaiCongViecProvider onError all $error');
      },
    );
  }
}
