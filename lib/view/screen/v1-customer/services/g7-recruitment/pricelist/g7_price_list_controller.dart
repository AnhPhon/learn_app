import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/data/model/response/bang_gia_dang_tin_response.dart';
import 'package:template/data/model/response/bang_gia_loc_ho_so_response.dart';
import 'package:template/provider/bang_gia_dang_tin_provider.dart';
import 'package:template/provider/bang_gia_loc_ho_so_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1G7PriceListController extends GetxController {
  //provider

  final BangGiaDangTinProvider bangGiaDangTinProvider =
      GetIt.I.get<BangGiaDangTinProvider>();
  final BangGiaLocHoSoProvider bangGiaLocHoSoProvider =
      GetIt.I.get<BangGiaLocHoSoProvider>();

  //value model
  List<BangGiaDangTinResponse> bangGiaDangTinModel = [];
  List<BangGiaLocHoSoResponse> bangGiaLocHoSoModel = [];
  //value tuyển dụng
  TuyenDungRequest tuyenDungRequest = TuyenDungRequest();

  // isloading
  bool isLoading = true;

  //value chọn bảng giá
  String? chooseDangTin;
  String? chooseLocHoSo;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tuyenDungRequest = Get.arguments as TuyenDungRequest;
    print('tuyenDungRequest $tuyenDungRequest');
    getDataBangGiaDangTin();
    getDataBangGiaLocHoSo();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///
  /// load data hình thức làm việc
  ///
  void getDataBangGiaDangTin() {
    //list hinh thuc lam iec
    bangGiaDangTinProvider.all(
        onSuccess: (value) {
          //add list
          bangGiaDangTinModel = value;

          //set chọn đầu tiên
          chooseDangTin = value.first.id;
          // isLoading = false;
          update();
        },
        onError: (error) => print(error));
  }

  ///
  /// load data hình thức làm việc
  ///
  void getDataBangGiaLocHoSo() {
    //list hinh thuc lam iec
    bangGiaLocHoSoProvider.all(
        onSuccess: (value) {
          //add list
          bangGiaLocHoSoModel = value;

          //set chọn đầu tiên
          chooseLocHoSo = value.first.id;
          isLoading = false;
          update();
        },
        onError: (error) => print(error));
  }

  ///
  ///Chọn đăng tin
  ///
  void getChangeDangTin(String val) {
    chooseDangTin = val.toString();
    update();
  }

  ///
  ///Chọn lọc hồ sơ
  ///
  void getChangeLocHoSo(String val) {
    chooseLocHoSo = val;
    update();
  }

  ///
  /// Nhấn tiếp tục
  ///
  void onClickContinueButton() {
    Get.toNamed(AppRoutes.V1_ORDER_INFORAMTION);
  }
}
