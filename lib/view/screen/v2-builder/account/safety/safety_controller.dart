import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/thong_tin_f_s_s_response.dart';
import 'package:template/provider/thong_tin_f_s_s_provider.dart';

class V2SafetyController extends GetxController{
  //thong tin ffs
  ThongTinFSSProvider thongTinFSSProvider = GetIt.I.get<ThongTinFSSProvider>();
  ThongTinFSSResponse thongTinFSSResponse = ThongTinFSSResponse();

  //CircularProgressIndicator
  bool isLoading = true;

  //title appbar
  String title = "Hướng dẫn an toàn lao động";

  @override
  void onInit() {
    super.onInit();

    //get load data
    getSafety();
  }

  ///
  ///get safety
  ///
  void getSafety() {
    thongTinFSSProvider.all(
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          thongTinFSSResponse = data.first;
        }
        isLoading = false;
        update();
      },
      onError: (error){
        print("V2HelpController getHelp onError $error");
      },
    );
  }
}