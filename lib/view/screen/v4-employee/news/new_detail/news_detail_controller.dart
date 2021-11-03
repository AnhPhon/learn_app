import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tin_tuc_request.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/provider/tin_tuc_provider.dart';

class V4NewsDetailController extends GetxController {
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();
  TinTucResponse tinTucResponse = TinTucResponse();
  TinTucRequest tinTucRequest = TinTucRequest();

  //
  String title = "Chi tiết tin tức";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      tinTucResponse = Get.arguments as TinTucResponse;
    }

    countView();
  }

  ///
  ///count view
  ///
  void countView() {
    //set data
    tinTucRequest.id = tinTucResponse.id;
    tinTucRequest.luotXem =
        (int.parse(tinTucResponse.luotXem.toString()) + 1).toString();

    //update view
    tinTucProvider.update(
      data: tinTucRequest,
      onSuccess: (data) {
        print("update view success");
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V4NewsDetailController countView onError $error");
      },
    );
  }
}
