import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class V1ServiceReviewG1Controller extends GetxController {
  //DonDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  //VatTu
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  List<VatTuResponse> vatTuList = [];

  //
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();
  List<ChiTietVatTuResponse> chiTietVatTuList = [];

  //loading
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
    }
    getListChiTietVatTu();
  }

  ///
  ///vatTu
  ///
  void getListChiTietVatTu() {
    chiTietVatTuProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idDonDichVu=${donDichVuResponse.id}",
      onSuccess: (data) {
        print(data.length);
        chiTietVatTuList = data;
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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'V1JobDetailController downloadFile Could not launch $url';
    }
  }
}
