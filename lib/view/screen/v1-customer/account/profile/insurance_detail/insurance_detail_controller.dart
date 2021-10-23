import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/bao_hiem_response.dart';
import 'package:template/provider/bao_hiem_provider.dart';

class V1InsuranceDetailController extends GetxController {

  //BaoHiem
  BaoHiemProvider baoHiemProvider = GetIt.I.get<BaoHiemProvider>();
  List<BaoHiemResponse> baoHiemResponse = [];

  //CircularProgressIndicator
  bool isLoading = true;

  //title appbar
  String title = "Chi tiết nội dung bảo hiểm";

  @override
  void onInit() {
    super.onInit();
    //get load data
    getInsuranceDetail();
  }

  ///
  ///get insurance detail
  ///
  void getInsuranceDetail() {
    baoHiemProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&loai=2&sortBy=created_at:desc",
      onSuccess: (value) {
        baoHiemResponse = value;
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1InsuranceDetailController getInsuranceDetail onError $error");
      },
    );
  }
}
