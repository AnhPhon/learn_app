
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candicate/candicate_controller.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Lọc mức lương
                GetBuilder(
                  init: V1CandicateController(),
                  builder: (V1CandicateController controller) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mức lương"),
                              Text("< ${CurrencyConverter.currencyConverterVND(controller.salary.toDouble())} VNĐ")
                            ],
                          ),
                        ),
                        Slider(
                          max: 100000000,
                          value: controller.salary.toDouble(), onChanged: (val){
                          controller.onChangedSalary(val);
                        }),
                      ],
                    );
                  },
                ),
                //
                //Ngoại ngữ
                DropDownButton<String>(
                  onChanged: (val){}, 
                  data: const [
                    "Tiếng Anh","Tiếng Việt","Tiếng Pháp"
                  ], 
                  width: DeviceUtils.getScaledWidth(context,1),
                  value: "Tiếng Anh", 
                  obligatory: false,
                  label: "Ngoại ngữ",
                  hint: "Chưa chọn",
                ),
                //Ngoại ngữ
                DropDownButton<String>(
                  onChanged: (val){}, 
                  data: const [
                    "Chưa chọn","Toàn thời gian","Bán thời gian","Thích thì làm không thì nghỉ"
                  ], 
                  width: DeviceUtils.getScaledWidth(context,1),
                  value: "Chưa chọn", 
                  obligatory: false,
                  label: "Hình thức làm việc",
                  hint: "Chưa chọn",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
