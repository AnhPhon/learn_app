import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/candidate_controller.dart';

class DialogContent extends GetView<V1CandidateController> {
  const DialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: V1CandidateController(),
        builder: (V1CandidateController controller) {
          return SizedBox(
            width: DeviceUtils.getScaledWidth(context, 1),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      DropDownButton<MucLuongDuKienResponse>(
                        onChanged: (MucLuongDuKienResponse? val) =>
                            controller.onChangeMucLuongDuKien(val!),
                        data: controller.mucLuongDuKienListModel,
                        width: DeviceUtils.getScaledWidth(context, 1),
                        value: controller.mucLuongDuKien,
                        obligatory: false,
                        label: "Mức lương",
                        hint: "Mức lương",
                        isSort: false,
                      ),
                      //Ngoại ngữ
                      Padding(
                        padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                        child: DropDownButton<NgoaiNguResponse>(
                          onChanged: (NgoaiNguResponse? val) =>
                              controller.onChangeNgoaiNgu(val!),
                          data: controller.ngoaiNguListModel,
                          width: DeviceUtils.getScaledWidth(context, 1),
                          value: controller.ngoaiNguResponse,
                          obligatory: false,
                          label: "Ngoại ngữ",
                          hint: "Chọn ngoại ngữ",
                        ),
                      ),
                      //Hình thức làm việc
                      Padding(
                        padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                        child: DropDownButton<HinhThucLamViecResponse>(
                          onChanged: (HinhThucLamViecResponse? val) =>
                              controller.onChangeHinhThucLamViec(val!),
                          data: controller.hinhThucLamViecListModel,
                          width: DeviceUtils.getScaledWidth(context, 1),
                          value: controller.hinhThucLamViecResponse,
                          obligatory: false,
                          label: "Hình thức làm việc",
                          hint: "Chọn hình thức làm việc",
                          isSort: false,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
