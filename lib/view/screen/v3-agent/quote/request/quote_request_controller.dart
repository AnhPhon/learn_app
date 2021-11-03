import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/utils/color_resources.dart';

class V3QuoteRequestController extends GetxController {
  final DanhSachBaoGiaDonDichVuProvider _danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  String tieuDeBaoGia = "Cần báo giá xi măng";
  String loaiCongTrinh = "Nhà tư";
  String tinhThanh = "TP. HCM";
  String quan = "Quận Gò Vấp";
  String phuong = "Phường 9";
  String diaChiCuThe = "Đường Lê Lợi, P9, Quận Gò Vấp, TP.HCM";

  String from = "25/08/2021";
  String to = "20/09/2021";

  String title = "Danh sách báo giá đơn hàng";

  List<Map<String, dynamic>>? infoCard;

  List<String>? noiDungYeuCau;

  List<Map<String, dynamic>>? features;

  bool isCheck = true;

  DanhSachBaoGiaDonDichVuResponse? danhSachBaoGiaDonDichVu;
  DonDichVuProvider? donDichVuProvider;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    infoCard = [
      {
        "label": "Tên vật liệu",
        "value": "Xi măng",
        "input": false,
      },
      {
        "label": "Quy cách",
        "value": "Kim đỉnh",
        "input": false,
      },
      {
        "label": "Số lượng",
        "value": "5",
        "input": false,
      },
      {
        "label": "Đơn vị",
        "value": "Tấn",
        "input": false,
      },
    ];

    noiDungYeuCau = [
      "Yêu cầu cát sạch",
      "Xi măng kim đỉnh",
      "Gạch đại hiệp",
    ];

    features = [
      {
        "title": "Từ chối báo giá",
        "onTap": () {
          Get.back();
        },
        "color": ColorResources.LIGHT_GREY //Color(0XFFB0BAC1)
      },
      {
        "title": "Đồng ý báo giá",
        "onTap": () {},
        "color": ColorResources.THEME_DEFAULT
      },
    ];

    // load thông tin
    loadInfo('61615b51c976b02ef558be71');
  }

  ///
  /// load thongo tin don gia dich vu bằng id
  ///
  void loadInfo(String donGiaDichVuId) {
    _danhSachBaoGiaDonDichVuProvider.paginate(
      limit: 10,
      page: 1,
      filter: "idDonDichVu=$donGiaDichVuId",
      onSuccess: (model) {
        danhSachBaoGiaDonDichVu = model[0];
        tieuDeBaoGia = danhSachBaoGiaDonDichVu!.idDonDichVu.toString();
        // loaiCongTrinh = danhSachBaoGiaDonDichVu!.idDonDichVu!.loa!;

        // tinhThanh = danhSachBaoGiaDonDichVu!.idDonDichVu!.tieuDe!;
        // quan = danhSachBaoGiaDonDichVu!.idDonDichVu!.tieuDe!;
        // phuong = danhSachBaoGiaDonDichVu!.idDonDichVu!.tieuDe!;

        // diaChiCuThe = danhSachBaoGiaDonDichVu!.idDonDichVu!.tieuDe!;
        // phuong = danhSachBaoGiaDonDichVu!.idDonDichVu!.tieuDe!;
        // diaChiCuThe = danhSachBaoGiaDonDichVu!.idDonDichVu!.tieuDe!;

        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }
}
