import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1NewsController extends GetxController {
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();

  String title = "Tin tức";

  List<TinTucResponse> tinTucModelList = [];

  @override
  void onInit() {
    super.onInit();
    getAllTinTuc();
  }

  ///
  ///get all tin tuc
  ///
  void getAllTinTuc() {
    tinTucProvider.all(
      onSuccess: (value) {
        tinTucModelList = value;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick() {
    Get.toNamed(AppRoutes.V1_NEWS_DETAIL);
  }
}
