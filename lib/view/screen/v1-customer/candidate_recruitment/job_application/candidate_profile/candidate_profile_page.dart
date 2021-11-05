import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/candicate_card.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/job_application/candidate_profile/candidate_profile_controller.dart';

class V1CandidateProfilePage extends GetView<V1CandidateProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ ứng tuyển'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: GetBuilder(
          init: V1CandidateProfileController(),
          builder: (V1CandidateProfileController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Thông tin người
                  CandidateCard(
                    showEmailAndPass: controller.isView,
                    dangKyViecMoiResponse: controller.dangKyViecMoiResponse,
                  ),
                  // Nội dung hồ sơ
                  content(context, controller: controller),
                ],
              ),
            );
          }),
    );
  }

  ///
  ///Nội dung hồ sơ
  ///

  Widget content(BuildContext context,
      {required V1CandidateProfileController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.isView)
            Container()
          else
            TextHighlight(
              title: "Số tiền bị trừ khi xem hồ sơ: ",
              content:
                  "${CurrencyConverter.currencyConverterVND(controller.tongTienThanhToan)} VNĐ",
              titleStyle: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: ColorResources.BLACK),
            ),
          if (controller.isView)
            Container()
          else
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.isShowSoDuError) {
                      controller.showDialogAcceptError();
                    } else {
                      controller.showDialogAccept();
                    }
                  },
                  child: const Text("Xem hồ sơ"),
                ),
              ),
            ),
          // Nội dung hồ sơ
          const Padding(
            padding: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
            child: Text(
              "Địa điểm đăng ký làm việc: ",
              style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ...List.generate(
              controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs!.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.MARGIN_SIZE_SMALL),
                    child: Text(
                      "+ ${controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idPhuongXa}, ${controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idQuanHuyen}, ${controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idTinhTp}",
                    ),
                  )),

          Padding(
            padding:
                const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
            child: TextHighlight(
              title: "Mục tiêu nghề ngiệp: ",
              titleStyle: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.bold),
              content:
                  controller.dangKyViecMoiResponse.mucTieuNgheNghiep.toString(),
            ),
          ),
          //Bằng cấp và trình độ

          const Text(
            "Bằng cấp và trình độ: ",
            style: TextStyle(
                color: ColorResources.BLACK,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold),
          ),
          ...List.generate(
              controller.dangKyViecMoiResponse.idBangBangCaps!.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.MARGIN_SIZE_SMALL),
                    child: Text(
                      "Trình độ học vấn: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].idTrinhDo.toString()} \nChuyên ngành: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].idChuyenMon.toString()} \nTốt nghiệp loại: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].idLoaiTotNghiep.toString()} \nĐơn vị đào tạo: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].donViDaoTao.toString()}",
                    ),
                  )),
          const Text(
            "Chức vụ, kinh nghiệm, mức lương,...: ",
            style: TextStyle(
                color: ColorResources.BLACK,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
            child: Text(
                'Chức vụ hiện tại: ${controller.dangKyViecMoiResponse.chucVuHienTai.toString()} \nChức vụ mong muốn: ${controller.dangKyViecMoiResponse.chucVuMongMuon.toString()} \nSố năm kinh nghiệm: ${controller.dangKyViecMoiResponse.idSoNamKinhNghiem.toString()} \nMức lương đề xuất tối thiểu: ${PriceConverter.convertPrice(context, double.parse(controller.dangKyViecMoiResponse.mucLuongDeXuat.toString(), (error)=> 0))} vnđ/tháng \nNơi làm việc mong muốn nhất: ${controller.dangKyViecMoiResponse.noiLamViec.toString()}\nNgành nghề mong muốn ứng tuyển: ${controller.tenNganhNgheMongMuon}'),
          ),

          const Text(
            "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",
            style: TextStyle(
                color: ColorResources.BLACK,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold),
          ),

          ...List.generate(
              controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems!.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.MARGIN_SIZE_SMALL),
                    child: Text(
                      "Từ ${DateConverter.readMongoToString(controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].thoiGianBatDau.toString())} đến ${DateConverter.readMongoToString(controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].thoiGianKetThuc.toString())} \n- Đơn vị: ${controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].donVi.toString()}\n- Chức vụ: ${controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].chucVu.toString()} \n- Mức lương: ${PriceConverter.convertPrice(context, double.parse(controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].mucLuong.toString()))} vnđ/tháng\n- Công việc phụ trách: ${controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].congViecPhuTrach.toString()} \n- Kết quả, thành tích đạt được: ${controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].ketQua.toString()}",
                    ),
                  )),

          Padding(
            padding:
                const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
            child: TextHighlight(
              title: "Kỹ năng và sở trường làm việc: ",
              titleStyle: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.bold),
              content:
                  controller.dangKyViecMoiResponse.kyNangSoTruong.toString(),
            ),
          ),

          const Text(
            "Ngoại ngữ: ",
            style: TextStyle(
                color: ColorResources.BLACK,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold),
          ),

          ...List.generate(
              controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems!.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.MARGIN_SIZE_SMALL),
                    child: Text(
                      "- Ngôn ngữ: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].loaiNgoaiNgu.toString()}\n+ Nghe: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].nghe.toString()}\n+ Đọc: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].doc.toString()}\n+ Nói: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].noi.toString()}\n+ Viết: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].viet.toString()}\n- Trình độ: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].trinhDo.toString()}",
                    ),
                  )),

          Padding(
            padding:
                const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
            child: TextHighlight(
              title: "Tin học:",
              titleStyle: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.bold),
              content:
                  '\n- Word : ${controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc == null ? '': controller.dangKyViecMoiResponse.idTinHoc!.word.toString()}\n- Excel: ${controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc!.excel.toString()}\n- Internet: ${controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc!.internet.toString()}',
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
            child: TextHighlight(
              title: "Phần mềm hỗ trợ công việc đối với từng ngành nghề: ",
              titleStyle: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.bold),
              content:
                  "\n - ${controller.dangKyViecMoiResponse.idTinHoc == null ? '' :controller.dangKyViecMoiResponse.idTinHoc!.phanMemHoTro.toString()}",
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
            child: TextHighlight(
              title: "Sở thích: ",
              titleStyle: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.bold),
              content:
                  "\n- ${controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc!.soThichTrinhDo.toString()} \n- ${ 
                    controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc!.soThichKyNang.toString()}\n- ${
                      controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc!.soTichTinhCach.toString()}",
            ),
          ),

          const Text(
            "Ảnh bằng cấp (nếu có)",
            style: TextStyle(
                color: ColorResources.BLACK,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold),
          ),
          if (controller.dangKyViecMoiResponse.idBangBangCaps!.isNotEmpty &&
              controller.isView)
            ...List.generate(
              controller.dangKyViecMoiResponse.idBangBangCaps!.length,
              (index) => Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                child: SizedBox(
                  height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
                  width: DeviceUtils.getScaledWidth(context, 1),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      child: FadeInImageCustom(
                        height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
                        width: 1,
                        urlImage: controller.dangKyViecMoiResponse
                            .idBangBangCaps![index].anhBangCap
                            .toString(),
                      )),
                ),
              ),
            )
          else
            const Text(
              "Ảnh bằng cấp hiện tại không có hoặc bị ẩn",
              style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.RED),
            ),

          const Label(
            label: "Ảnh hồ sơ xin việc (nếu có)",
            obligatory: false,
            horizontalPadding: 0,
          ),
          if (controller.dangKyViecMoiResponse.anhHoSoXinViecs!.isNotEmpty &&
              controller.isView)
            ...List.generate(
                controller.dangKyViecMoiResponse.anhHoSoXinViecs!.length,
                (index) => SizedBox(
                      height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
                      width: DeviceUtils.getScaledWidth(context, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.MARGIN_SIZE_SMALL),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                            child: FadeInImageCustom(
                              height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
                              width: 1,
                              urlImage: controller
                                  .dangKyViecMoiResponse.anhHoSoXinViecs![index]
                                  .toString(),
                            )),
                      ),
                    ))
          else
            const Text(
              "Ảnh hồ sơ xin việc hiện tại không có hoặc bị ẩn",
              style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.RED),
            ),
          const Label(
            label: "File hồ sơ xin việc (nếu có)",
            obligatory: false,
            horizontalPadding: 0,
          ),
          if (controller.isView)
            fileCv(context: context, controller: controller)
          else
            const Text(
              "File này hiện tại không có hoặc bị ẩn",
              style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.RED),
            ),
          // Tạo 1 khoảng trắng dưới khỏi ẩn 1 widget
          const SizedBox(
            height: Dimensions.AVATAR_SQUARE_SIZE_EXTRA_SMALL,
          )
        ],
      ),
    );
  }

  ///
  /// Nút tải CV
  ///

  Widget fileCv(
      {required BuildContext context,
      required V1CandidateProfileController controller}) {
    return BoxShadowWidget(
      child: GestureDetector(
        onTap: () => controller.onBtnDownloadCv(
            url: controller.dangKyViecMoiResponse.fileHoSoXinViec.toString()),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, .75),
                child: Text(
                    controller.dangKyViecMoiResponse.fileHoSoXinViec.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
              ),
              const Icon(Icons.download, color: ColorResources.PRIMARYCOLOR)
            ],
          ),
        ),
      ),
    );
  }
}
