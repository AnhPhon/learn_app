import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/candicate_card.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/job_application/candidate_profile/candidate_profile_controller.dart';
import 'package:template/view/screen/v1-customer/services/reference_price_list/view_image/view_full_sreen_image.dart';

class V1CandidateProfilePage extends GetView<V1CandidateProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ ứng tuyển'),
        centerTitle: true,
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios)),
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
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK),
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
              ),
            );
          }),
    );
  }

  ///
  ///Nội dung hồ sơ
  ///

  Widget content(BuildContext context, {required V1CandidateProfileController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.isView)
            Container()
          else
            TextHighlight(
              title: "Số tiền bị trừ khi xem hồ sơ: ",
              content: "${CurrencyConverter.currencyConverterVND(controller.tongTienThanhToan)} VNĐ",
              titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.BLACK),
            ),
          if (controller.isView)
            Container()
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
          // Giới tính
          if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.gioiTinh.toString()))
            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: TextHighlight(
                title: "Giới tính: ",
                titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                content: Validate.getGenderString(controller.dangKyViecMoiResponse.gioiTinh),
              ),
            ),
          // Địa chỉ
          // if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idTinhTp.toString()) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idQuanHuyen.toString()) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idPhuongXa.toString()))

          if (controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs!.isNotEmpty)
            if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs!.first.idTinhTp) && !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs!.first.idQuanHuyen) && !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs!.first.idPhuongXa))
              const Padding(
                padding: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                child: Text(
                  "Địa điểm đăng ký làm việc: ",
                  style: TextStyle(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold),
                ),
              ),
          if (controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs!.isNotEmpty)
            ...List.generate(
                controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs!.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                      child: Text(
                        "+ ${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idPhuongXa) ? '' : controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idPhuongXa!.id == TAT_CA_PHUONG_XA ? '' : controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idPhuongXa!.ten} "
                        '${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idQuanHuyen) ? '' : controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idQuanHuyen!.id == TAT_CA_QUAN_HUYEN ? '' : controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idQuanHuyen!.ten} '
                        "${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idTinhTp) ? '' : controller.dangKyViecMoiResponse.idDiaDiemDangKyLamViecs![index].idTinhTp!.ten}",
                      ),
                    )),

          if (controller.dangKyViecMoiResponse.idHinhThucLamViec != null)
            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: TextHighlight(
                title: "Hình thức làm việc: ",
                titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                content: controller.dangKyViecMoiResponse.idHinhThucLamViec!.tieuDe.toString(),
              ),
            ),

          if (controller.dangKyViecMoiResponse.mucTieuNgheNghiep.toString() != 'null')
            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: TextHighlight(
                title: "Mục tiêu nghề ngiệp: ",
                titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                content: controller.dangKyViecMoiResponse.mucTieuNgheNghiep.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.mucTieuNgheNghiep.toString(),
              ),
            ),
          // Kinh nghiệm
          // if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idSoNamKinhNghiem.toString()))
          //   Padding(
          //     padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
          //     child: TextHighlight(
          //       title: "Số năm kinh nghiệm: ",
          //       titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
          //       content: controller.dangKyViecMoiResponse.idSoNamKinhNghiem!.tieuDe!,
          //     ),
          //   ),

          //Bằng cấp và trình độ
          if (controller.dangKyViecMoiResponse.idBangBangCaps!.isNotEmpty)
            const Text(
              "Bằng cấp và trình độ: ",
              style: TextStyle(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold),
            ),
          ...List.generate(
              controller.dangKyViecMoiResponse.idBangBangCaps!.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                    child: Text("Trình độ học vấn: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].idTrinhDo!.tieuDe ?? ''}"
                        '\nChuyên ngành: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].idChuyenMon!.tenCongViec ?? ''}'
                        '\nTốt nghiệp loại: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].idLoaiTotNghiep ?? ''} '
                        '\nNăm tốt nghiệp: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].namTotNghiep ?? ''} '
                        '\nĐơn vị đào tạo: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].donViDaoTao ?? ''}'),
                  )),

          if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.chucVuHienTai) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.chucVuMongMuon) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idMucLuongDuKien) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idSoNamKinhNghiem) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.noiLamViec) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idNganhNgheMongMuons))
            const Text(
              "Chức vụ, kinh nghiệm, mức lương,... ",
              style: TextStyle(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold),
            ),
          // if (controller.dangKyViecMoiResponse.chucVuHienTai.toString() != 'null' && controller.dangKyViecMoiResponse.chucVuMongMuon.toString() != 'null' && controller.dangKyViecMoiResponse.idSoNamKinhNghiem.toString() != 'null' && controller.dangKyViecMoiResponse.mucLuongDeXuat.toString() != 'null' && controller.dangKyViecMoiResponse.noiLamViec.toString() != 'null' && controller.tenNganhNgheMongMuon != '')
          // Padding(
          //   padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
          //   child: Text(
          //     'Chức vụ hiện tại: ${controller.dangKyViecMoiResponse.chucVuHienTai.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.chucVuHienTai.toString()} \nChức vụ mong muốn: ${controller.dangKyViecMoiResponse.chucVuMongMuon.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.chucVuMongMuon.toString()} \nSố năm kinh nghiệm: ${controller.dangKyViecMoiResponse.idSoNamKinhNghiem.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.idSoNamKinhNghiem.toString()} \nMức lương mong muốn: ${controller.dangKyViecMoiResponse.idMucLuongDuKien == null ? '' : controller.dangKyViecMoiResponse.idMucLuongDuKien!.tieuDe} ${controller.dangKyViecMoiResponse.mucLuongDeXuat.toString() == 'null' ? '' : 'vnđ/tháng'} \nNơi làm việc: ${controller.dangKyViecMoiResponse.noiLamViec!.isEmpty ? '' : controller.dangKyViecMoiResponse.noiLamViec!.map((e) => '\n\t- $e').toList().toString().replaceAll('[', '').replaceAll(']', '')}\nNgành nghề mong muốn ứng tuyển: ${controller.tenNganhNgheMongMuon.split(',').map((e) => '\n\t- ${e.trim()}').toList().toString().replaceAll('[', '').replaceAll(']', '')}',
          //   ),
          // ),

          // Kinh nghiệm , mức lương

          // if (controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems!.isNotEmpty)
          //   const Text(
          //     "Chức vụ kinh nghiệm mức lương",
          //     style: TextStyle(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold),
          //   ),
          if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.chucVuHienTai) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.chucVuMongMuon) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idMucLuongDuKien) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idSoNamKinhNghiem) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.noiLamViec) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idNganhNgheMongMuons))
            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: Text(
                '${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.chucVuHienTai) ? '' : '- Chức vụ hiện tại: ${controller.dangKyViecMoiResponse.chucVuHienTai}'}'
                '${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.chucVuMongMuon) ? '' : '\n- Chức vụ mong muốn: ${controller.dangKyViecMoiResponse.chucVuMongMuon.toString()}'} '
                '${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idMucLuongDuKien) ? '' : '\n- Mức lương đề xuất: ${controller.dangKyViecMoiResponse.idMucLuongDuKien!.tieuDe}'}'
                '${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idSoNamKinhNghiem) ? '' : '\n- Năm kinh nghiệm: ${controller.dangKyViecMoiResponse.idSoNamKinhNghiem!.tieuDe!.toString()}'} '
                '${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.noiLamViec) ? '' : '\n- Chọn nơi làm việc: ${controller.dangKyViecMoiResponse.noiLamViec!.map((e) => '\n\t+ $e').toList().toString().replaceAll('[', '').replaceAll(']', '')}'}'
                '${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.idNganhNgheMongMuons) ? '' : '\n- Chọn ngành nghề muốn ứng tuyển: ${controller.dangKyViecMoiResponse.idNganhNgheMongMuons!.map((e) => '\n\t+ ${e.tenCongViec}').toList().toString().replaceAll('[', '').replaceAll(']', '')}'}',
              ),
            ),

          if (controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems!.isNotEmpty)
            const Text(
              "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",
              style: TextStyle(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold),
            ),

          ...List.generate(
              controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems!.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                    child: Text(
                      "Từ ${DateConverter.readMongoToString(controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].thoiGianBatDau.toString())} đến ${DateConverter.readMongoToString(controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].thoiGianKetThuc.toString())}"
                      '\n- Đơn vị: ${controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].donVi.toString()}'
                      '\n- Chức vụ: ${controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].chucVu.toString()} '
                      '\n- Mức lương: ${PriceConverter.convertPrice(context, double.parse(controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].mucLuong.toString()))} vnđ/tháng'
                      '\n- Công việc phụ trách: ${controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].congViecPhuTrach.toString()} '
                      '\n- Kết quả, thành tích đạt được: ${controller.dangKyViecMoiResponse.idKeKhaiKinhNghiems![index].ketQua.toString()}',
                    ),
                  )),

          if (controller.dangKyViecMoiResponse.kyNangSoTruong.toString() != 'null')
            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: TextHighlight(
                title: "Kỹ năng và sở trường làm việc: ",
                titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                content: controller.dangKyViecMoiResponse.kyNangSoTruong.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.kyNangSoTruong.toString(),
              ),
            ),
          if (controller.dangKyViecMoiResponse.idNgoaiNgus!.isNotEmpty)
            const Text(
              "Ngoại ngữ: ",
              style: TextStyle(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold),
            ),

          ...List.generate(
              controller.dangKyViecMoiResponse.idNgoaiNgus!.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                    child: Text(
                      "- Ngôn ngữ: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].loaiNgoaiNgu.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.idNgoaiNgus![index].loaiNgoaiNgu.toString()}\n- Trình độ: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].trinhDo.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.idNgoaiNgus![index].trinhDo.toString()}\n+ Nghe: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].nghe.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.idNgoaiNgus![index].nghe.toString()}\n+ Đọc: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].doc.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.idNgoaiNgus![index].doc.toString()}\n+ Nói: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].noi.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.idNgoaiNgus![index].noi.toString()}\n+ Viết: ${controller.dangKyViecMoiResponse.idNgoaiNgus![index].viet.toString() == 'null' ? '' : controller.dangKyViecMoiResponse.idNgoaiNgus![index].viet.toString()}",
                    ),
                  )),
          if (controller.dangKyViecMoiResponse.idTinHoc != null)
            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: TextHighlight(
                title: "Tin học:",
                titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                content: '\n- Word : ${controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc!.word.toString()}\n- Excel: ${controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc!.excel.toString()}\n- Internet: ${controller.dangKyViecMoiResponse.idTinHoc == null ? '' : controller.dangKyViecMoiResponse.idTinHoc!.internet.toString()}',
              ),
            ),
          if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.phanMemHoTro.toString()))
            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: TextHighlight(
                title: "Phần mềm hỗ trợ công việc từng ngành: ",
                titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                content: "\n${Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.phanMemHoTro.toString()) ? '' : '-${controller.dangKyViecMoiResponse.phanMemHoTro.toString()}'}",
              ),
            ),
          // if (controller.dangKyViecMoiResponse.soThichTrinhDo.toString() !=
          //         'null' &&
          //     controller.dangKyViecMoiResponse.soThichKyNang.toString() !=
          //         'null' &&
          //     controller.dangKyViecMoiResponse.soTichTinhCach.toString() !=
          //         'null')
          if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.soThichTrinhDo) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.soThichKyNang) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.soTichTinhCach))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                  child: TextHighlight(
                    title: "Sở thích thể hiện trình độ/khả năng tư duy: ",
                    titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                    content: Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.soThichTrinhDo) ? '' : controller.dangKyViecMoiResponse.soThichTrinhDo.toString(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                  child: TextHighlight(
                    title: "Sở thích thể hiện kỹ năng: ",
                    titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                    content: Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.soThichKyNang) ? '' : controller.dangKyViecMoiResponse.soThichKyNang.toString(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                  child: TextHighlight(
                    title: "Sở thích thể hiện tính cách: ",
                    titleStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.BLACK, fontWeight: FontWeight.bold),
                    content: Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.soTichTinhCach) ? '' : controller.dangKyViecMoiResponse.soTichTinhCach.toString(),
                  ),
                ),
              ],
            ),

          if (controller.dangKyViecMoiResponse.idBangBangCaps!.isNotEmpty && controller.isView)
            const Text(
              "Ảnh bằng cấp (nếu có)",
              style: TextStyle(color: ColorResources.BLACK, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold),
            ),
          if (controller.dangKyViecMoiResponse.idBangBangCaps!.isNotEmpty && controller.isView)
            ...List.generate(controller.dangKyViecMoiResponse.idBangBangCaps!.length, (index) {
              print('Ảnh Bằng cấp: ${controller.dangKyViecMoiResponse.idBangBangCaps![index].anhBangCap}');
              return Column(
                children: controller.dangKyViecMoiResponse.idBangBangCaps![index].anhBangCap!.map(
                  (element) {
                    return GestureDetector(
                      onTap: () => Get.to(() => ViewFullScreenImage(image: element.toString())),
                      child: Hero(
                        tag: 'Ảnh Bằng cấp',
                        child: Padding(
                          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                          child: SizedBox(
                            height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
                            width: DeviceUtils.getScaledWidth(context, 1),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                                child: FadeInImageCustom(
                                  height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
                                  width: 1,
                                  urlImage: element.toString(),
                                  fit: BoxFit.contain,
                                )),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            })
          else
            (controller.dangKyViecMoiResponse.chucVuHienTai != 'null')
                ? const Text(
                    "Ảnh bằng cấp hiện tại không có hoặc bị ẩn",
                    style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.RED),
                  )
                : const SizedBox.shrink(),
          if (controller.dangKyViecMoiResponse.anhHoSoXinViecs!.isNotEmpty && controller.isView)
            const Label(
              label: "Ảnh hồ sơ xin việc (nếu có)",
              obligatory: false,
              horizontalPadding: 0,
            ),
          if (controller.dangKyViecMoiResponse.anhHoSoXinViecs!.isNotEmpty && controller.isView)
            ...List.generate(
                controller.dangKyViecMoiResponse.anhHoSoXinViecs!.length,
                (index) => GestureDetector(
                      onTap: () => Get.to(() => ViewFullScreenImage(image: controller.dangKyViecMoiResponse.anhHoSoXinViecs![index].toString())),
                      child: Hero(
                        tag: 'Ảnh hồ sơ xin việc',
                        child: Padding(
                          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                          child: SizedBox(
                            height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
                            width: DeviceUtils.getScaledWidth(context, 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                              child: FadeInImageCustom(
                                height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
                                width: 1,
                                urlImage: controller.dangKyViecMoiResponse.anhHoSoXinViecs![index].toString(),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
          else
            (controller.dangKyViecMoiResponse.chucVuHienTai != 'null')
                ? const Text(
                    "Ảnh hồ sơ xin việc hiện tại không có hoặc bị ẩn",
                    style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.RED),
                  )
                : const SizedBox.shrink(),

          if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.nguoiThamKhao) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.emailThamKhao) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.chucDanh) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.congTy) || !Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.soDienThoai))
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Label(
                    label: "Người tham khảo",
                    obligatory: false,
                    horizontalPadding: 0,
                  ),
                  if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.nguoiThamKhao)) Text('Cấp trên công ty cũ: ${controller.dangKyViecMoiResponse.nguoiThamKhao!}'),
                  if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.emailThamKhao)) Text('Email: ${controller.dangKyViecMoiResponse.emailThamKhao!}'),
                  if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.chucDanh)) Text('Chức danh: ${controller.dangKyViecMoiResponse.chucDanh!}'),
                  if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.congTy)) Text('Công ty: ${controller.dangKyViecMoiResponse.congTy!}'),
                  if (!Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.soDienThoai)) Text('Số điện thoại: ${controller.dangKyViecMoiResponse.soDienThoai!}'),
                ],
              ),
            ),

          if (controller.dangKyViecMoiResponse.fileHoSoXinViec != 'null' && controller.isView)
            const Label(
              label: "File hồ sơ xin việc (nếu có)",
              obligatory: false,
              horizontalPadding: 0,
            ),
          if (controller.isView)
            fileCv(context: context, controller: controller)
          else
            const Text(
              "File hồ sơ xin việc hiện tại không có hoặc bị ẩn",
              style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.RED),
            ),
          // Tạo 1 khoảng trắng dưới khỏi ẩn 1 widget
          const SizedBox(
            height: Dimensions.AVATAR_SQUARE_SIZE_EXTRA_SMALL,
          ),
        ],
      ),
    );
  }

  ///
  /// Nút tải CV
  ///

  Widget fileCv({required BuildContext context, required V1CandidateProfileController controller}) {
    return Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.fileHoSoXinViec)
        ? const Text('')
        : BoxShadowWidget(
            child: GestureDetector(
              onTap: () => controller.onBtnDownloadCv(url: controller.dangKyViecMoiResponse.fileHoSoXinViec.toString()),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .75),
                      child: Text(Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.fileHoSoXinViec) ? '' : controller.dangKyViecMoiResponse.fileHoSoXinViec.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                          )),
                    ),
                    if (Validate.checkValueIsNullEmpty(controller.dangKyViecMoiResponse.fileHoSoXinViec)) const Icon(Icons.download, color: ColorResources.PRIMARYCOLOR)
                  ],
                ),
              ),
            ),
          );
  }
}
