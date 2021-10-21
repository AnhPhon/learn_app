import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/lien_he_cong_ty_response.dart';
import 'package:template/provider/lien_he_cong_ty_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class V1HelpController extends GetxController {
  //LienHeCongTy
  LienHeCongTyProvider lienHeCongTyProvider =
      GetIt.I.get<LienHeCongTyProvider>();
  LienHeCongTyResponse lienHeCongTyResponse = LienHeCongTyResponse();

  //CircularProgressIndicator
  bool isLoading = true;

  //title appbar
  String title = "Hỗ trợ";

  @override
  void onInit() {
    super.onInit();

    //get load data
    getContact();
  }

  ///
  ///get contact
  ///
  void getContact() {
    lienHeCongTyProvider.all(
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          lienHeCongTyResponse = value.first;
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1HelpController getContact onError $error");
      },
    );
  }

  ///
  ///btn contact
  ///
  Future<void> btnContact({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'V1HelpController btnContact Could not launch $url';
    }
  }
}
