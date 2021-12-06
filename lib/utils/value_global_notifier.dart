import 'package:get/get_rx/src/rx_stream/rx_stream.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:template/data/model/response/chi_tiet_don_hang_response.dart';

class ValueGlobalNotifier {
  RxInt unreadNotify = 0.obs;
  RxMap<String, bool> smartRefreshNoData = <String, bool>{}.obs;
  GetStream<Map<String, bool>>? smartRefreshNoDataStream;

  RxList<ChiTietDonHangResponse> chiTietDonHangListNotify = [ChiTietDonHangResponse()].obs;

  void changeUnreadNotifyNumber(numberCount) {
    if (numberCount != unreadNotify) {
      unreadNotify = unreadNotify;
      // print("Call changeUnreadNotifyNumber $unreadNotify");
    }
  }

  void changeChiTietDonHangList(List<ChiTietDonHangResponse> chiTietList) {
    if (chiTietList != chiTietDonHangListNotify) {
      chiTietDonHangListNotify.value = chiTietList;
    }
  }

  void changeSmartRefreshNoDataStatus(String key, bool flag) {
    smartRefreshNoData[key] = flag;
  }
}
