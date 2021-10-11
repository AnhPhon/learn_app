import 'package:get/get.dart';

class V2DetailWorkDoneController extends GetxController {
  List<Map<String, dynamic>>? deploymentItems;

  //Khai báo isLoading
  bool isLoading = true;

  String nameProject = "Thợ ốp lát công trình khách 5 sao";
  String city = 'Đà Nẵng';
  String address = 'BT 170 Nguyễn Đình Thi Hòa Xuân – Đà Nẵng';
  String introduce =
      "Dự án biệt thự 170 Nguyễn Đình Thi là dự án được xây dựng trên thành phố Đà Nẵng với tổng diện tích hơn 1000m2";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    deploymentItems = [
      {
        "title": "Ốp lát",
      },
      {
        "title": "Xây trát",
      },
      {
        "title": "Chống thấm",
      },
      {
        "title": "Nội thất",
      },
      {
        "title": "Sơn bả",
      },
      {
        "title": "Nhôm kính",
      },
    ];
  }
}
