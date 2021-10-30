import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/provider/tin_tuc_provider.dart';

class V1NewsDetailController extends GetxController {
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();
  TinTucResponse tinTucModel = TinTucResponse();

  String title = "Chi tiết tin tức";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getNewsById();
  }

  ///
  ///get news by id
  ///
  void getNewsById() {
    tinTucProvider.find(
      id: Get.parameters['id'].toString(),
      onSuccess: (value) {
        tinTucModel = value;
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }
}
