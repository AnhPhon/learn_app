import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2DetailWorkInProgressController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  //Khai báo isLoading
  bool isLoading = true;

  String title = "Thợ ốp lát công trình khách 5 sao";
  String description = "Mô tả công việc";
  String address = "Địa chị (quận huyện)";
  String startTime = "12/09/2021";
  String endTime = "12/09/2021";

  //Bảng khối lượng công việc
  String nameJob = "Lát gạch phòng ngủ 600*600";
  String ruleJob = "Dùng keo, gạch thạch bàn mã TB123";
  String mass = "20";
  String unit = "m2";

  List<Map<String, String>> bangKhoiLuongCongViecs = [];
  List<String> urlHinhAnhKhoiLuongList = [];
  List<String> urlHinhAnhBangVeList = [];

  // file
  String fileName = "không có";

  @override
  void onInit() {
    super.onInit();

    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      // get don dich vu
      getDonDichVu(workFlowId!);

      // get bao gia
      getBaoGia(workFlowId);
    });
  }

  ///
  /// get data don dich vu
  ///
  void getDonDichVu(String workFlowId) {
    donDichVuProvider.find(
      id: workFlowId,
      onSuccess: (model) {
        // set adress
        address = "";
        if (model.idQuanHuyen != null) {
          address += model.idQuanHuyen!.ten!;
        }

        if (model.idQuanHuyen != null) {
          address += model.idQuanHuyen!.ten!;
        }

        // set title
        title = model.tieuDe!;

        // set start time
        startTime = formatDate(model.ngayBatDau!);

        // set end time
        endTime = formatDate(model.ngayKetThuc!);
        description = model.moTaChiTiet ?? model.moTa!;

        // xử lý trường dữ liệu image
        for (final image in model.hinhAnhBanKhoiLuongs!) {
          if (image.toString().trim().isNotEmpty) {
            urlHinhAnhKhoiLuongList.add(image.toString());
          }
        }

        // lấy hình ảnh bảng vẽ
        urlHinhAnhBangVeList = model.hinhAnhBanVes!;
        // for (final banVe in model.hinhAnhBanVe!.split(",")) {
        //   if (banVe.trim().isNotEmpty) {
        //     urlHinhAnhBangVeList.add(banVe);
        //   }
        // }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// get bao gia
  ///
  void getBaoGia(String workFlowId) {
    // chưa hiểu nhân công tạm bỏ qua

    // load danh sách báo giá đơn dịch vụ
    danhSachBaoGiaDonDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idDonDichVu=$workFlowId",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          fileName = models[0].file ?? "";
        }
        for (final element in models) {
          // lấy hình ảnh báo giá
          urlHinhAnhKhoiLuongList.addAll(
            element.idDonDichVu!.hinhAnhBanKhoiLuongs!,
          );
          // urlHinhAnhBangVeList.add(
          //   element.idDonDichVu!.hinhAnhBanVe!,
          // );
          urlHinhAnhBangVeList = element.idDonDichVu!.hinhAnhBanVes!;

          // lấy các thông tin về vật tư
          vatTuProvider.paginate(
            page: 1,
            limit: 50,
            filter: "&idDonDichVu=${element.idDonDichVu!.id}",
            onSuccess: (vatTuList) {
              // duyệt vật tư liên quan với id đơn dịch vụ
              for (final vatTu in vatTuList) {
                bangKhoiLuongCongViecs.add({
                  "tencongviec": element.idDonDichVu!.tieuDe!,
                  "quycach": vatTu.quyCach!,
                  "mass": vatTu.donGia!,
                  "unit": vatTu.donVi!,
                });
              }
            },
            onError: (error) {
              print(
                "TermsAndPolicyController getTermsAndPolicy onError $error",
              );
            },
          );
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
  /// get file khoi luong
  ///

  ///
  /// format date
  ///
  String formatDate(String date) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
  }
}
