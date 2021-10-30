import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/lich_su_vi_tien_request.dart';
import 'package:template/data/model/request/tuyen_dung_request.dart';
import 'package:template/data/model/request/vi_tien_request.dart';
import 'package:template/data/model/response/bang_gia_dang_tin_response.dart';
import 'package:template/data/model/response/bang_gia_loc_ho_so_response.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/data/repository/lich_su_vi_tien_repository.dart';
import 'package:template/data/repository/tuyen_dung_repository.dart';
import 'package:template/data/repository/vi_tien_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/bang_gia_dang_tin_provider.dart';
import 'package:template/provider/bang_gia_loc_ho_so_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

class V1G7PriceListController extends GetxController {
  //provider

  final BangGiaDangTinProvider bangGiaDangTinProvider =
      GetIt.I.get<BangGiaDangTinProvider>();
  final BangGiaLocHoSoProvider bangGiaLocHoSoProvider =
      GetIt.I.get<BangGiaLocHoSoProvider>();
  final TuyenDungRepository tuyenDungRepository =
      GetIt.I.get<TuyenDungRepository>();

  //value model
  List<BangGiaDangTinResponse> bangGiaDangTinModel = [];
  List<BangGiaLocHoSoResponse> bangGiaLocHoSoModel = [];
  //value tuyển dụng
  TuyenDungRequest tuyenDungRequest = TuyenDungRequest();

  //Provider
  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
  //Reponse
  ViTienResponse viTienResponse = ViTienResponse();

  //update ví tiền
  ViTienRepository viTienRepository = ViTienRepository();

  //value ViTienRequest
  ViTienRequest viTienRequest = ViTienRequest();

  //lichSuViTien
  LichSuViTienRequest lichSuViTienRequest = LichSuViTienRequest();
  LichSuViTienRepository lichSuViTienRepository = LichSuViTienRepository();

  // isloading
  bool isLoading = true;

  //value chọn bảng giá
  String? chooseDangTin;
  String? chooseLocHoSo;

  //value tính tiền
  double tienDangTin = 0;
  double tienLocHoSo = 0;
  double tongTien = 0;

  //userId
  String? userId;

  //số dư tài khoản
  double soDuTaiKhoan = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //set value tuyển dụng
    tuyenDungRequest = Get.arguments as TuyenDungRequest;

    //get load data bảng giá
    getDataBangGiaDangTin();
    //thông tin ví tiền
    getDataViTien();
  }

  @override
  void onClose() {
    // TODO: implement onClose
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
          getChangeDangTin(value.first.id.toString());
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7PriceListController getDataBangGiaDangTin $error'));
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
          getChangeLocHoSo(value.first.id.toString());
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1G7PriceListController getDataBangGiaLocHoSo $error'));
  }

  ///
  ///get balance
  ///
  void getDataViTien() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      //set isUser
      userId = value;
      //load ví tiền
      viTienProvider.paginate(
        page: 1,
        limit: 5,
        filter: "&idTaiKhoan=$userId",
        onSuccess: (value) {
          viTienResponse = value.first;
          soDuTaiKhoan = double.parse(viTienResponse.tongTien.toString());

          update();
        },
        onError: (error) {
          print("PaymentAccountController getBalance onError $error");
        },
      );
    });
  }

  ///
  ///Chọn đăng tin
  ///
  void getChangeDangTin(String val) {
    chooseDangTin = val.toString();

    //set tiền
    tienDangTin = 0;
    tienDangTin = double.parse(bangGiaDangTinModel
        .firstWhere((element) => element.id!.contains(val))
        .donGia
        .toString());

    update();
  }

  ///
  ///Chọn lọc hồ sơ
  ///
  void getChangeLocHoSo(String val) {
    chooseLocHoSo = val;

    //set tiền
    tienLocHoSo = 0;
    tienLocHoSo = double.parse(bangGiaLocHoSoModel
        .firstWhere((element) => element.id!.contains(val))
        .donGia
        .toString());
    update();
  }

  ///
  /// Nhấn tiếp tục
  ///
  void onClickContinueButton() {
    tongTien = 0;
    tongTien = tienDangTin;
    //set value tuyendung
    tuyenDungRequest.soTien = tongTien.toStringAsFixed(0);
    tuyenDungRequest.tienCoc = '0';
    tuyenDungRequest.loaiTin = '2';

    Get.toNamed(
            '${AppRoutes.ORDER_INFORMATION}?soTien=${tuyenDungRequest.soTien!}&tienCoc=${tuyenDungRequest.tienCoc}&isTuyenDung=true')!
        .then((value) => {
              //đã thanh toán
              if (value != null && value['type'] == 1)
                {
                  //set trạng thái đã thanh toán
                  tuyenDungRequest.idTrangThaiThanhToan =
                      app_constants.TUYEN_DUNG_DA_THANH_TOAN,
                  tuyenDungRequest.phiDichVu = value['phiDichVu'].toString(),
                  tuyenDungRequest.khuyenMai = value['khuyenMai'].toString(),
                  tuyenDungRequest.tongDon = value['tongTien'].toString(),

                  //insert db
                  tuyenDungRepository.add(tuyenDungRequest).then((value) => {
                        if (value.response.data == 5)
                          {
                            Get.back(result: true),
                            Alert.success(
                                message: 'Đăng tin tuyển dụng thành công'),
                          }
                        else
                          {
                            Alert.error(message: 'Vui lòng thực hiện lại'),
                            //insert và update lại ví tiền
                            viTienRequest.id = viTienResponse.id,
                            viTienRequest.idTaiKhoan =
                                viTienResponse.idTaiKhoan!.id.toString(),
                            viTienRequest.tongTien = soDuTaiKhoan.toString(),
                            viTienRepository
                                .update(viTienRequest)
                                .then((value) {
                              //update ví tiền thành công
                              if (value.response.data != null) {
                                //set data lịch sử ví tiền
                                lichSuViTienRequest.idTaiKhoan = userId;
                                lichSuViTienRequest.idViTien =
                                    viTienResponse.id;
                                lichSuViTienRequest.noiDung =
                                    "Cộng lại tiền đăng tin không thành công";
                                lichSuViTienRequest.loaiGiaoDich = "1";
                                lichSuViTienRequest.trangThai = "2";
                                lichSuViTienRequest.soTien =
                                    tuyenDungRequest.tongDon;

                                //insert db lịch sử ví tiền
                                lichSuViTienRepository.add(lichSuViTienRequest);
                              }
                            }),
                          }
                      })
                }
              //chưa thanh toán
              else if (value != null && value['type'] == 2)
                {
                  //set trạng thái chưa thanh toán
                  tuyenDungRequest.idTrangThaiThanhToan =
                      app_constants.TUYEN_DUNG_CHUA_THANH_TOAN,
                  tuyenDungRequest.phiDichVu = value['phiDichVu'].toString(),
                  tuyenDungRequest.khuyenMai = value['khuyenMai'].toString(),
                  tuyenDungRequest.tongDon = value['tongTien'].toString(),
                  //insert db
                  tuyenDungRepository.add(tuyenDungRequest).then((value) => {
                        if (value.response.data != null)
                          {
                            Get.back(result: true),
                            Alert.success(
                                message: 'Đăng tin tuyển dụng thành công'),
                          }
                        else
                          {
                            Alert.error(message: 'Vui lòng thực hiện lại'),
                          }
                      })
                }
            });
  }
}
