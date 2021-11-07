import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class V1ServiceReviewG1Controller extends GetxController {
  //DonDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();
  List<String> hinhAnhBanVe = [];

  //VatTu
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  List<VatTuResponse> vatTuList = [];

  //loading
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
    }
    // lấy hình ảnh bảng vẽ
    for (final banVe in donDichVuResponse.hinhAnhBanVes!) {
      if (banVe.trim().isNotEmpty) {
        hinhAnhBanVe.add(banVe);
      }
    }
    getListChiTietVatTu();
  }

  ///
  ///vatTu
  ///
  void getListChiTietVatTu() {
    vatTuProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idDonDichVu=${donDichVuResponse.id}",
      onSuccess: (data) {
        print(data.length);
        vatTuList = data;
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1JobDetailController getListChiTietVatTu onError $error");
      },
    );
  }

  ///
  ///download file
  ///
  Future<void> downloadFile({required String url}) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'V1JobDetailController downloadFile Could not launch $url';
    }
  }
}
