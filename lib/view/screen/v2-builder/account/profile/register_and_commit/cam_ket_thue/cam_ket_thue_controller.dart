import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V2CamketThueController extends GetxController
    with SingleGetTickerProviderMixin {
  bool isChecked1 = false;

  bool isChecked2 = false;

  String title = "Hợp đồng nguyên tắc với FSS";

  TabController? tabController;
  String? content;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    content = """
      Là công dân Việt Nam, bản thân mỗi công dân phải hiểu rõ và chấp hành nghiêm túc Quy định pháp luật Việt Nam và Nộp thuế chính là quyền và nghĩa vụ của mỗi công dân. Tại đây, FSS đề cập đến việc tuân thủ việc kê khai và nộp thuế TNCN đối với cá nhân, tổ chức có thu nhập chịu thuế theo quy định tại Thông tư 111/2013/TT-BTC.
      Nếu bạn là cá nhân cư trú không ký hợp đồng lao động hoặc ký hợp đồng lao động thời vụ, dịch vụ (dưới 03 tháng) và có mức thu nhập được chi trả trên 2.000.000vnđ/lần chi trả thì bạn có nghĩa vụ nộp thuế TNCN 10% trên mức thu nhập. Người chi trả sẽ khấu trừ tạm thời phần thuế phải nộp vào khoản tiền thu nhập của bạn trước khi thanh toán.
      Nếu bạn là cá nhân chỉ có duy nhất thu nhập thuộc đối tượng phải khấu trừ thuế theo tỷ lệ nêu trên nhưng ước tính tổng mức thu nhập chịu thuế của cá nhân sau khi trừ gia cảnh chưa đến mức phải nộp thuế (không quá 108.000.000vnđ trong 1 năm) thì bạn có thể làm cam kết thuế theo mẫu 02/CK-TNCN để không bị khấu trừ thuế TNCN vào thu nhập của bạn.
      Lợi ích của việc cam kết thuế theo mẫu 02/CK-TNCN theo quy định của Tổng Cục Thuế.
      """;
    tabController = TabController(length: 3, vsync: this);
  }

  ///
  ///set selected checkBox
  ///
  void setSeletedCheckBox1(bool? value) {
    isChecked1 = value!;
    update();
  }

  ///
  ///set selected checkBox
  ///
  void setSeletedCheckBox2(bool? value) {
    isChecked2 = value!;
    update();
  }

  ///
  /// on finish click
  ///
  void onFinishClick() {
    Get.back();
  }
}
