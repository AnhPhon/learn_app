import 'package:get/get.dart';

class V4ReportController extends GetxController {
  //khai báo isLoading
  bool isLoading = true;

  //set model để thiết kế UI danh sách báo cáo
  List<Map<String, dynamic>>? uiReport;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    uiReport = [
      {
        "title": "Báo cáo công việc theo yêu cầu",
        "subtitle": "Phòng A trục A",
        "description": "Phòng D,E,F của công trình A",
        "address": "Ngũ Hành Sơn",
        "daysReport": "06/10/2021",
      },
      {
        "title": "Báo cáo công việc theo yêu cầu",
        "subtitle": "Phòng B trục B",
        "description": "Phòng D,E,F của công trình B",
        "address": "Ngũ Hành Sơn",
        "daysReport": "06/10/2021",
      },
      {
        "title": "Báo cáo công việc theo yêu cầu",
        "subtitle": "Phòng C trục C",
        "description": "Phòng D,E,F của công trình B",
        "address": "Ngũ Hành Sơn",
        "daysReport": "06/10/2021",
      },
      {
        "title": "Báo cáo công việc theo yêu cầu",
        "subtitle": "Phòng C trục C",
        "description": "Phòng D,E,F của công trình B",
        "address": "Ngũ Hành Sơn",
        "daysReport": "06/10/2021",
      },
    ];
  }
}
