import 'package:get/get.dart';

class V2DetailWorkInProgressController extends GetxController {
//Khai báo isLoading
  bool isLoading = true;

  String nameProject = "Thợ ốp lát công trình khách 5 sao";
  String description =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ";
  String address = "Quận Hải Châu";
  String startTime = "12/09/2021";
  String endTime = "12/09/2021";

  //Bảng khối lượng công việc
  String nameJob = "Lát gạch phòng ngủ 600*600";
  String ruleJob = "Dùng keo, gạch thạch bàn mã TB123";
  String mass = "20";
  String unit = "m2";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
