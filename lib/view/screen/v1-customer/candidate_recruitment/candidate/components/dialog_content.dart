import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/candidate_controller.dart';

class DialogContent extends GetView<V1CandidateController> {
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
                  init: V1CandidateController(),
                  builder: (V1CandidateController controller) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Mức lương"),
                              Text(
                                  "< ${CurrencyConverter.currencyConverterVND(controller.salary.toDouble())} VNĐ")
                            ],
                          ),
                        ),
                        Slider(
                            max: 100000000,
                            value: controller.salary.toDouble(),
                            onChangeEnd: (val) =>
                                controller.onChangedEndSalary(val),
                            onChanged: (val) {
                              controller.onChangedSalary(val);
                            }),
                      ],
                    );
                  },
                ),
                //
                //Ngoại ngữ
                DropDownButton<NgoaiNguResponse>(
                  onChanged: (NgoaiNguResponse? val) =>
                      controller.onChangeNgoaiNgu(val!),
                  data: controller.ngoaiNguListModel,
                  width: DeviceUtils.getScaledWidth(context, 1),
                  value: controller.ngoaiNguResponse,
                  obligatory: false,
                  label: "Ngoại ngữ",
                  hint: "Chọn ngoại ngữ",
                ),
                //Ngoại ngữ
                DropDownButton<HinhThucLamViecResponse>(
                  onChanged: (HinhThucLamViecResponse? val) =>
                      controller.onChangeHinhThucLamViec(val!),
                  data: controller.hinhThucLamViecListModel,
                  width: DeviceUtils.getScaledWidth(context, 1),
                  value: controller.hinhThucLamViecResponse,
                  obligatory: false,
                  label: "Hình thức làm việc",
                  hint: "Chọn hình thức làm việc",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
