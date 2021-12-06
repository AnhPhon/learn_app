import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/thong_tin_f_s_s_response.dart';
import 'package:template/provider/thong_tin_f_s_s_provider.dart';

class V1InsuranceDetailController extends GetxController {
  //thong tin ffs
  ThongTinFSSProvider thongTinFSSProvider = GetIt.I.get<ThongTinFSSProvider>();
  ThongTinFSSResponse thongTinFSSResponse = ThongTinFSSResponse();

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
    thongTinFSSProvider.all(
      onSuccess: (data) {
        //check is note empt
        if (data.isNotEmpty) {
          thongTinFSSResponse = data.first;
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1InsuranceDetailController getInsuranceDetail onError $error");
      },
    );
  }
}
