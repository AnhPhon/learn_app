import 'package:get/get.dart';
import 'package:template/routes/route_path/transfers_routers.dart';
import 'package:tiengviet/tiengviet.dart';

class ContactController extends GetxController {
  final List<Map<String, String>> contact = [
    {'name': "Nguyễn Văn Hùng", 'phone': "0352983212"},
    {'name': 'Lê Phú Quý', 'phone': "0352983212"},
    {'name': "Nguyễn một tỷ", 'phone': "43432423432"},
    {'name': 'Phạm Văn Đô La', 'phone': "3243432432"},
    {'name': 'Hùng Văn Tỷ Phú', 'phone': "432432423"},
    {'name': "Nguyễn Văn Hùng", 'phone': "4324324324"},
    {'name': 'Lê Phú Quý', 'phone': "0352983212"},
    {'name': "Nguyễn một tỷ", 'phone': "6565434234"},
    {'name': 'Phạm Văn Đô La', 'phone': "0352983212"},
    {'name': 'Hùng Văn Tỷ Phú', 'phone': "0352983212"},
    {'name': "Nguyễn Văn Hùng", 'phone': "2432423123"},
    {'name': 'Lê Phú Quý', 'phone': "0352983212"},
    {'name': "Nguyễn một tỷ", 'phone': "0352983212"},
    {'name': 'Phạm Văn Đô La', 'phone': "0352983212"},
    {'name': 'Hùng Văn Tỷ Phú', 'phone': "0352983212"},
  ];

  Map<String, List<Map<String, String>>> data = {};

  @override
  void onInit() {
    super.onInit();
    sortByAphabet();
  }

  void sortByAphabet() {
    contact.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
    for (final e in contact) {
      final String word = e['name']![0];
      if (data.containsKey(word) == false) {
        data[word] = [];
      }
      data[word]!.add(e);
    }
  }

  void onSearch({required String term}) {
    if(term.isEmpty) {
      sortByAphabet();
      update();
      return;
    }
    data.clear();
    for (final e in contact) {
      final String word = e['name']![0];
      if (TiengViet.parse(word).contains(TiengViet.parse(term))) {
        if (data.containsKey(word) == false) {
          data[word] = [];
        }
        data[word]!.add(e);
      }
    }
    update();
  }

  ///
  /// go to transfer detail
  ///
  void onToTransfersPage(){
    Get.toNamed(TransfersRouters.TRANSFERS_DETAIL);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
