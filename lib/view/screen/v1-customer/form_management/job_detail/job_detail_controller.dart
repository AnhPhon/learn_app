import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class V1JobDetailController extends GetxController {
  //DonDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();
  List<String> hinhAnhBanVe = [];

  //VatTu
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  List<VatTuResponse> vatTuList = [];

  //title appbar
  String title = "Xem đơn công việc";

  //loading
  bool isLoading = true;

  //note
  String note =
      "Đối với dự án có khối lượng lớn, gửi bản vẽ qua email baogia5sao@gmail.com; chúng tôi sẽ có đội ngũ đến khảo sát và báo giá.\nHoặc khách hàng yêu cầu chúng tôi sẽ đến khảo sát báo giá trực tiếp ";

  @override
  void onInit() {
    super.onInit();
    donDichVuResponse = Get.arguments as DonDichVuResponse;
    // lấy hình ảnh bảng vẽ
    for (final banVe in donDichVuResponse.hinhAnhBanVes!) {
      if (banVe.trim().isNotEmpty) {
        hinhAnhBanVe.add(banVe);
      }
    }
    getVatTu();
  }

  ///
  ///vatTu
  ///
  void getVatTu() {
    vatTuProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idDonDichVu=${donDichVuResponse.id}",
      onSuccess: (data) {
        vatTuList = data;
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1JobDetailController getVatTu onError $error");
      },
    );
  }

  ///
  ///download file
  ///
  Future<void> downloadFile({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'V1JobDetailController downloadFile Could not launch $url';
    }
  }
}
