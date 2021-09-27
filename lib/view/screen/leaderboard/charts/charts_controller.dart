import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/personal_honor_provider.dart';

class ChartsController extends GetxController {
  PersonalHonorProvider personalHonorProvider =
      GetIt.I.get<PersonalHonorProvider>();

  @override
  void onInit() {
    super.onInit();
  }

  ///
  ///get charts from idContext
  ///
  // void getChart() {
  //   personalHonorProvider.paginate(
  //       page: 1,
  //       limit: 100,
  //       filter: "&idContext=",
  //       onSuccess: onSuccess,
  //       onError: onError);
  // }
}
