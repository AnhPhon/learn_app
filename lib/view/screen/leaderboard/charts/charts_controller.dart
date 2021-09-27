import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/personal_honor_model.dart';
import 'package:template/provider/personal_honor_provider.dart';

class ChartsController extends GetxController {
  PersonalHonorProvider personalHonorProvider =
      GetIt.I.get<PersonalHonorProvider>();
  List<PersonalHonorModel> personalHonorList = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getChart();
  }

  ///
  ///get charts from idContext
  ///
  void getChart() {
    personalHonorProvider.paginate(
        page: 1,
        limit: 100,
        filter: "&idContext=${Get.parameters['idChart']}",
        onSuccess: (value) {
          personalHonorList = value;
          personalHonorList.sort((a, b) =>
              int.parse(a.position!).compareTo(int.parse(b.position!)));
          update();
          isLoading = false;
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///get user name from id user
  ///
  void getName() {}
}
