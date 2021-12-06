import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/images.dart';

class ShippingMethodController extends GetxController {
  //donHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  DonHangResponse donHangResponse = DonHangResponse();
  DonHangRequest donHangRequest = DonHangRequest();

  //index
  int shippingMethodIndex = 0;

  //image list
  List<String> imageShipping = [
    Images.shipping_normal,
    Images.shipping_method,
  ];

  //title app bar
  String title = "Loại vận chuyển";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      donHangResponse = Get.arguments as DonHangResponse;
      shippingMethodIndex =
          int.parse(donHangResponse.loaiVanChuyen.toString()) - 1;
    }
  }

  ///
  /// set selected payment method
  ///
  void setSelectedShippingMethod(int? index) {
    shippingMethodIndex = index!;
    update();
  }

  ///
  /// done
  ///
  void onBtnDoneClick() {
    if ((shippingMethodIndex + 1).toString() != donHangResponse.loaiVanChuyen) {
      //set data
      donHangRequest.id = donHangResponse.id;
      donHangRequest.loaiVanChuyen = (shippingMethodIndex + 1).toString();

      //update
      donHangProvider.update(
        data: donHangRequest,
        onSuccess: (data) {
          Get.back(result: true);
          Alert.success(message: "Cập nhật loại vận chuyển thành công");
        },
        onError: (error) {
          print("ShippingMethodController onBtnDoneClick onError $error");
        },
      );
    }
  }
}
