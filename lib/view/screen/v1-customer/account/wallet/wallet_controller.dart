import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/lich_su_vi_tien_response.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/lich_su_vi_tien_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1WalletController extends GetxController {
  //ViTien
  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
  ViTienResponse viTienResponse = ViTienResponse();

  //LichSuViTien
  LichSuViTienProvider lichSuViTienProvider =
      GetIt.I.get<LichSuViTienProvider>();
  List<LichSuViTienResponse> lichSuViTienResponse = [];

  //map date time
  Map<String, Map<String, List<LichSuViTienResponse>>> lichSuViTien = {};
  String? year;
  String? month;

  //tile appbar
  String title = "Ví của bạn";

  //show or hide
  bool isShow = false;

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get load data
    getWalletInformation();
  }

  ///
  ///get wallet information
  ///
  void getWalletInformation() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      viTienProvider.paginate(
        page: 1,
        limit: 5,
        filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
        onSuccess: (value) {
          //check is not empty
          if (value.isNotEmpty) {
            viTienResponse = value[0];
          }

          //get wallet history
          getWalletHistory();
          update();
        },
        onError: (error) {
          print("V1WalletController getWalletInformation onError $error");
        },
      );
    });
  }

  ///
  ///get wallet history
  ///
  void getWalletHistory() {
    lichSuViTienProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idViTien=${viTienResponse.id}&sortBy=created_at:desc",
      onSuccess: (value) {
        
        //check is not empty
        if (value.isNotEmpty) {
          lichSuViTienResponse = value;

          for (final item in value) {
            //get month & year
            final valueSplit = item.createdAt!.substring(0, 10).split("-");
            year = valueSplit[0];
            month = valueSplit[1];

            //if key is year have not yet then create
            if (lichSuViTien.containsKey(year) == false) {
              lichSuViTien[year!] = {};
            }
            //if key is month in year have not yet then create
            if (lichSuViTien[year]!.containsKey(month) == false) {
              lichSuViTien[year]![month!] = [];
            }
            //add to list
            lichSuViTien[year]![month]!.add(item);
          }
        }
        
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1WalletController getWalletHistory onError $error");
      },
    );
  }

  ///
  ///set show/hide
  ///
  void setShow() {
    isShow = !isShow;
    update();
  }

  ///
  ///recharge
  ///
  void onRecharge() {
    Get.toNamed(
        "${AppRoutes.V1_BEFORE_RECHARGE}?balance=${viTienResponse.tongTien}");
  }

  ///
  ///get back
  ///
  void onBtnBackClick() {
    Get.back();
  }
}
