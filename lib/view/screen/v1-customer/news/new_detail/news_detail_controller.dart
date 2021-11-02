import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tin_tuc_request.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1NewsDetailController extends GetxController {
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();
  TinTucResponse tinTucResponse = TinTucResponse();
  TinTucRequest tinTucRequest = TinTucRequest();

  //
  String title = "Chi tiết tin tức";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().idTinTuc.then((idTinTuc) {
      tinTucProvider.find(
        id: idTinTuc.toString(),
        onSuccess: (data) {
          tinTucResponse = data;

          tinTucRequest.id = tinTucResponse.id;
          tinTucRequest.luotXem =
              (int.parse(tinTucResponse.luotXem.toString()) + 1).toString();
          countView();
          update();
        },
        onError: (error) {
          print("V1NewsDetailController tinTucProvider onError $error");
        },
      );
    });
  }

  ///
  ///count view
  ///
  void countView() {
    //update view
    tinTucProvider.update(
      data: tinTucRequest,
      onSuccess: (data) {
        print("update view success");
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1NewsDetailController countView onError $error");
      },
    );
  }
}
