import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/dang_ky_viec_moi_model.dart';
import 'package:template/data/model/response/bang_bang_cap_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/work_register/component/v2_box_image.dart';
import 'package:template/view/screen/v2-builder/work_register/preview/work_preview_controller.dart';

// ignore: must_be_immutable
class V2WorkPreviewPage extends GetView<V2WorkPreviewController> {
  //Model để hiển thị data
  DangKyViecMoiModel? dangKyModel;

  List<BangBangCapResponse>? bangBangCapDisplayResponse;

  String? idTuyenDung;

  V2WorkPreviewPage({
    this.dangKyModel,
    this.idTuyenDung,
    this.bangBangCapDisplayResponse,
  });
  @override
  Widget build(BuildContext context) {
    print(dangKyModel.toString());
    return GetBuilder<V2WorkPreviewController>(
        init: V2WorkPreviewController(),
        builder: (V2WorkPreviewController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Scaffold(
              appBar: const AppBarWidget(
                title: "Hồ sơ ứng tuyển",
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL + 3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_LARGE,
                      ),

                      //Tiêu đề hồ sơ ứng tuyển
                      TextHighlight(
                        title: "Tiều đề ứng tuyển: ",
                        content: dangKyModel!.tieuDe.toString(),
                      ),
                      const SizedBox(
                        height: Dimensions.BORDER_RADIUS_DEFAULT,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Avatar và MSHS
                          _avatarHoSoUngTuyen(context),
                          const SizedBox(
                            width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Thông tin cá nhân ứng viên
                          _thongTinCaNhan(context),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),
                      //Mục tiêu nghề nghiệp
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Tiêu đề
                          const Text(
                            "Hình thức làm việc: ",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Nội dung
                          Text(
                            dangKyModel!.hinhThucLamViecLabel
                                .toString()
                                .replaceAll("null", "Không có"),
                            style: const TextStyle(
                              color: ColorResources.BLACK,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //Mục tiêu nghề nghiệp
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Tiêu đề
                          const Text(
                            "Mục tiêu nghề nghiệp: ",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Nội dung
                          Text(
                            dangKyModel!.mucTieuNgheNghiep
                                .toString()
                                .replaceAll("null", "Không có"),
                            style: const TextStyle(
                              color: ColorResources.BLACK,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //Bằng cấp và trình độ
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Tiêu đề
                          const Text(
                            "Bằng cấp và trình độ: ",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Thông tin bằng cấp và trình độ
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _listBangCapVaTrinhDo(context),
                          )
                          //Nội dung
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Chức vụ, kinh nghiệm, mức lương",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_SMALL,
                          ),

                          //Chức vụ hiện tại
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Chức vụ hiện tại: ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                TextSpan(
                                  text: dangKyModel!.chucVuHienTai.toString(),
                                  style: const TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Chức vụ mong muốn
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Chức vụ mong muốn: ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                TextSpan(
                                  text: dangKyModel!.chucVuMongMuon.toString(),
                                  style: const TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Năm kinh nghiệm
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Năm kinh nghiệm: ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                TextSpan(
                                  text: dangKyModel!.namKinhNghiem.toString(),
                                  style: const TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Mức lương đề xuất
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Mức lương mong muốn: ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                TextSpan(
                                  text: dangKyModel!.mucLuongDeXuat!.tieuDe
                                      .toString(),
                                  style: const TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Nơi làm việc
                          const Text(
                            "Nơi làm việc",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              dangKyModel!.noiLamViec!.length,
                              (index) => Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: ColorResources.BLACK,
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                      ),
                                      children: [
                                        const TextSpan(text: "- "),
                                        TextSpan(
                                          text: dangKyModel!.noiLamViec![index],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Text(
                            "Ngành nghề ứng tuyển",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              dangKyModel!.nghanhNgheMongMuon!.length,
                              (index) => Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: ColorResources.BLACK,
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                      ),
                                      children: [
                                        const TextSpan(text: "- "),
                                        TextSpan(
                                          text: dangKyModel!
                                              .nghanhNgheMongMuon![index]!
                                              .tenCongViec
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //Kê khai kinh nghiệm
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Tiêu đề
                          const Text(
                            "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Thông tin Kê khai kinh nghiệm
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _listKeKhaiKinhNghiem(context),
                          )
                          //Nội dung
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //Kỹ năng và sở trường làm việc
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Tiêu đề
                          const Text(
                            "Kỹ năng và sở trường làm việc: ",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Thông tin kĩ năng vào sở trường làm việc
                          Text(
                            dangKyModel!.kyNangSoTruong
                                .toString()
                                .replaceAll("null", "Không có"),
                            style: const TextStyle(
                              color: ColorResources.BLACK,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          //Nội dung
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      // Ngoại ngữ
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Tiêu đề
                          const Text(
                            "Ngoại ngữ: ",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Thông tin Ngoại ngữ
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _listNgoaiNgu(context),
                          )
                          //Nội dung
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //Tin học
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //Tiêu đề
                          const Text(
                            "Tin học: ",
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Thông tin kĩ năng vào sở trường làm việc
                          Container(
                            width: DeviceUtils.getScaledWidth(context, 1),
                            decoration: BoxDecoration(
                                color: ColorResources.WHITE,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_SMALL,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 2),
                                    blurRadius: 2,
                                    color: ColorResources.BLACK.withAlpha(30),
                                  )
                                ]),
                            padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL,
                            ),
                            margin: const EdgeInsets.only(
                              bottom: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Word
                                TextHighlight(
                                  title: "Word: ",
                                  titleStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                    color: ColorResources.BLACK,
                                  ),
                                  content: dangKyModel!.tinHoc!.word.toString(),
                                ),

                                //Excel
                                TextHighlight(
                                  title: "Excel: ",
                                  titleStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                    color: ColorResources.BLACK,
                                  ),
                                  content:
                                      dangKyModel!.tinHoc!.excel.toString(),
                                ),

                                //Internet
                                TextHighlight(
                                  title: "Internet: ",
                                  titleStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                    color: ColorResources.BLACK,
                                  ),
                                  content:
                                      dangKyModel!.tinHoc!.internet.toString(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //Sở thích
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          if (dangKyModel!.phanMemHoTro != null &&
                              dangKyModel!.phanMemHoTro.toString() != "null" &&
                              dangKyModel!.phanMemHoTro!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Tiêu đề
                                const Text(
                                  "Phần mềm hổ trợ công việc từng ngành: ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                ),

                                //Thông tin sở thích

                                //Sở thích thể hiện kỹ năng
                                TextHighlight(
                                  title: "- ",
                                  titleStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                    color: ColorResources.BLACK,
                                  ),
                                  content: dangKyModel!.phanMemHoTro.toString(),
                                ),
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_SMALL,
                                ),
                              ],
                            )
                          else
                            const SizedBox(),
                          if (dangKyModel!.soThichTheHienTrinhDo != null &&
                              dangKyModel!.soThichTheHienTrinhDo.toString() !=
                                  "null" &&
                              dangKyModel!.soThichTheHienTrinhDo!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Sở thích thể hiện trình độ
                                const Text(
                                  "Sở thích thể hiện trình độ/ khả năng tư duy: ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                ),
                                TextHighlight(
                                  title: "- ",
                                  titleStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                    color: ColorResources.BLACK,
                                  ),
                                  content: dangKyModel!.soThichTheHienTrinhDo
                                      .toString(),
                                ),
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                                ),
                              ],
                            )
                          else
                            const SizedBox(),
                          if (dangKyModel!.soThichTheHienKyNang != null &&
                              dangKyModel!.soThichTheHienKyNang.toString() !=
                                  "null" &&
                              dangKyModel!.soThichTheHienKyNang!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Tiêu đề
                                const Text(
                                  "Sở thích thể hiện kỹ năng: ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                ),

                                //Thông tin sở thích

                                //Sở thích thể hiện kỹ năng
                                TextHighlight(
                                  title: "- ",
                                  titleStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                    color: ColorResources.BLACK,
                                  ),
                                  content: dangKyModel!.soThichTheHienKyNang
                                      .toString(),
                                ),
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_SMALL,
                                ),
                              ],
                            )
                          else
                            const SizedBox(),
                          if (dangKyModel!.soThichTheHienTinhCach != null &&
                              dangKyModel!.soThichTheHienTinhCach.toString() !=
                                  "null" &&
                              dangKyModel!.soThichTheHienTinhCach!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Sở thích thể hiện tính cách
                                const Text(
                                  "Sở thích thể hiện tính cách: ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                ),
                                TextHighlight(
                                  title: "- ",
                                  titleStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                    color: ColorResources.BLACK,
                                  ),
                                  content: dangKyModel!.soThichTheHienTinhCach
                                      .toString(),
                                ),
                                const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_SMALL,
                                ),
                              ],
                            )
                          else
                            const SizedBox(),
                        ],
                      ),

                      //Ảnh bằng cấp(nếu có)
                      if (dangKyModel!.anhBangCapsList!.isEmpty)
                        Container()
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Label(
                                horizontalPadding:
                                    Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                label: "Ảnh bằng cấp(nếu có)",
                                obligatory: false,
                                paddingTitle: 0),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: V2BoxImage(
                                images: dangKyModel!.anhBangCapsList,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      if (dangKyModel!.anhHoSoXinViecs!.isEmpty)
                        Container()
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Label(
                                horizontalPadding:
                                    Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                label: "Ảnh hồ sơ xin việc(nếu có)",
                                obligatory: false,
                                paddingTitle: 0),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: V2BoxImage(
                                // ignore: cast_nullable_to_non_nullable
                                images: dangKyModel!.anhHoSoXinViecs,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      if (dangKyModel!.fileHoSoXinViec!.isNotEmpty &&
                          dangKyModel!.fileHoSoXinViec!.toString() != "" &&
                          dangKyModel!.fileHoSoXinViec!.toString() != "null" &&
                          dangKyModel!.fileHoSoXinViec != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Label(
                              horizontalPadding:
                                  Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                              label: "File hồ sơ xin việc",
                              obligatory: false,
                              paddingTitle: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dangKyModel!.fileHoSoXinViec.toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //Tham khảo(không bắt buộc)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (dangKyModel!.nguoiThamKhao!.isNotEmpty ||
                              dangKyModel!.chucDanh!.isNotEmpty ||
                              dangKyModel!.congTy!.isNotEmpty ||
                              dangKyModel!.soDienThoai!.isNotEmpty)
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: ColorResources.BLACK,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Tham khảo",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "(Không bắt buộc)",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Người tham khảo
                          if (dangKyModel!.nguoiThamKhao!.isNotEmpty)
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Người tham khảo: ",
                                    style: TextStyle(
                                      color: ColorResources.BLACK,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                  TextSpan(
                                    text: dangKyModel!.nguoiThamKhao.toString(),
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Chức danh
                          if (dangKyModel!.chucDanh!.isNotEmpty)
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Chức danh: ",
                                    style: TextStyle(
                                      color: ColorResources.BLACK,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                  TextSpan(
                                    text: dangKyModel!.chucDanh.toString(),
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Công ty
                          if (dangKyModel!.congTy!.isNotEmpty)
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Công ty: ",
                                    style: TextStyle(
                                      color: ColorResources.BLACK,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                  TextSpan(
                                    text: dangKyModel!.congTy.toString(),
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),

                          //Số điện thoại
                          if (dangKyModel!.soDienThoai!.isNotEmpty)
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Số điện thoại: ",
                                    style: TextStyle(
                                      color: ColorResources.BLACK,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                  TextSpan(
                                    text: dangKyModel!.soDienThoai.toString(),
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      if (dangKyModel!.tuyenDung == false)
                        //Button hoàn thiện và lưu trữ ứng tuyển
                        _btnHoanThienVaLuuTru()
                      else

                        //Cập nhập hồ sơ ứng tuyển
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallButton(
                              onPressed: () => controller.backToCreatePage(),
                              height: 55,
                              title: "Cập nhập",
                              color: ColorResources.GREY,
                            ),
                            SmallButton(
                              onPressed: () => controller.dangKyTuyenDung(
                                idTuyenDung: idTuyenDung,
                                dangKiModel: dangKyModel!,
                              ),
                              height: 55,
                              title: "Nộp hồ sơ ứng tuyển",
                              color: ColorResources.PRIMARYCOLOR,
                            ),
                          ],
                        ),

                      //
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  ///
  ///  //Avatar và MSHS
  ///
  Widget _avatarHoSoUngTuyen(BuildContext context) {
    return SizedBox(
      width: DeviceUtils.getScaledWidth(context, .35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: DeviceUtils.getScaledWidth(context, .33),
            height: DeviceUtils.getScaledWidth(context, .4),
            decoration: BoxDecoration(
                color: ColorResources.WHITE,
                borderRadius: BorderRadius.circular(
                  Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    color: ColorResources.BLACK.withAlpha(40),
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                Dimensions.BORDER_RADIUS_EXTRA_SMALL,
              ),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                image: controller.taiKhoanResponse!.hinhDaiDien.toString(),
                fit: BoxFit.cover,
                imageErrorBuilder: (c, o, s) => Container(
                  height: DeviceUtils.getScaledHeight(context, 0.16),
                  width: DeviceUtils.getScaledWidth(context, 0.38),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.placeholder),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.BORDER_RADIUS_DEFAULT,
          ),

          // Mã số hồ sơ
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextHighlight(
          //         title: "MSHS: ",
          //         content: dangKyModel!.maSoHoSo.toString(),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  ///
  ///Thông tin cá nhân ứng viên
  ///
  Widget _thongTinCaNhan(BuildContext context) {
    return SizedBox(
      width: DeviceUtils.getScaledWidth(context, .56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Tên ứng viên
          _iconAndText(
            context: context,
            content: dangKyModel!.tenUngVien.toString(),
            icon: Icons.people,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Giới tinh
          _iconAndText(
            context: context,
            content: Validate.getGenderString(dangKyModel!.gioiTinh.toString()),
            icon: Icons.favorite_outlined,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Ngày Sinh
          _iconAndText(
            context: context,
            content: controller.formatDateTime(
                dateTime: dangKyModel!.ngaySinh.toString()),
            icon: Icons.calendar_today,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Điện thoại
          _iconAndText(
            context: context,
            content: dangKyModel!.dienThoai.toString(),
            icon: Icons.phone,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Email
          if (dangKyModel!.email!.isNotEmpty &&
              dangKyModel!.email.toString() != "null")
            _iconAndText(
              context: context,
              content:
                  dangKyModel!.email.toString().replaceAll("null", "Không có"),
              icon: Icons.email,
            )
          else
            _iconAndText(
              context: context,
              content: "Không có",
              icon: Icons.email,
            ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Chổ ở hiện nay
          if (dangKyModel!.phuongXaResponse != null)
            _iconAndText(
              context: context,
              content:
                  "${dangKyModel!.choOHienTai.toString()}, ${dangKyModel!.tinhTpResponse!.ten},  ${dangKyModel!.quanHuyenResponse!.ten}, ${dangKyModel!.phuongXaResponse!.ten}",
              icon: Icons.place,
            )
          else
            _iconAndText(
              context: context,
              content:
                  "${dangKyModel!.choOHienTai.toString()}, ${dangKyModel!.tinhTpResponse!.ten},  ${dangKyModel!.quanHuyenResponse!.ten}",
              icon: Icons.place,
            ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Hôn nhân
          _iconAndText(
            context: context,
            content: dangKyModel!.honNhan!.toString(),
            icon: Icons.family_restroom,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),
        ],
      ),
    );
  }

  ///
  /// Icon và Tiêu đề
  ///
  Widget _iconAndText(
      {required BuildContext context,
      required IconData icon,
      required String content}) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              icon,
              size: DeviceUtils.getScaledWidth(context, 0.05),
              color: ColorResources.PRIMARYCOLOR,
            ),
          ),
          const WidgetSpan(
              child: SizedBox(
            width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          )),
          TextSpan(
            text: content,
            style: const TextStyle(
                color: ColorResources.BLACKGREY,
                fontWeight: FontWeight.normal,
                fontSize: Dimensions.FONT_SIZE_LARGE),
          ),
        ],
      ),
    );
  }

  ///
  ///Thông tin bằng cấp và trình độ
  ///
  List<Widget> _listBangCapVaTrinhDo(BuildContext context) {
    return List.generate(
      bangBangCapDisplayResponse!.length,
      (index) => Container(
        width: DeviceUtils.getScaledWidth(context, 1),
        decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(
              Dimensions.BORDER_RADIUS_SMALL,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2,
                color: ColorResources.BLACK.withAlpha(30),
              )
            ]),
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_SMALL,
        ),
        margin: const EdgeInsets.only(
          bottom: Dimensions.PADDING_SIZE_SMALL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trình độ học vấn
            TextHighlight(
              title: 'Trình độ học vấn: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: bangBangCapDisplayResponse![index]
                  .idTrinhDo!
                  .tieuDe
                  .toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Chuyên ngành
            TextHighlight(
                title: 'Chuyên môn: ',
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK,
                ),
                content: bangBangCapDisplayResponse![index]
                    .idChuyenMon!
                    .tenCongViec
                    .toString()),

            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Tốt nghiệp loại
            TextHighlight(
                title: 'Tốt nghiệp loại: ',
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK,
                ),
                content:
                    bangBangCapDisplayResponse![index].namTotNghiep.toString()),

            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Năm tốt nghiệp
            TextHighlight(
              title: 'Năm tốt nghiệp: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content:
                  bangBangCapDisplayResponse![index].namTotNghiep.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Đơn vị đào tạo
            TextHighlight(
              title: 'Đơn vị đào tạo: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content:
                  bangBangCapDisplayResponse![index].donViDaoTao.toString(),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///Kê khai kinh nghiệm
  ///
  List<Widget> _listKeKhaiKinhNghiem(BuildContext context) {
    return List.generate(
      dangKyModel!.keKhaiKinhNghiems!.length,
      (index) => Container(
        width: DeviceUtils.getScaledWidth(context, 1),
        decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(
              Dimensions.BORDER_RADIUS_SMALL,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2,
                color: ColorResources.BLACK.withAlpha(30),
              )
            ]),
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_SMALL,
        ),
        margin: const EdgeInsets.only(
          bottom: Dimensions.PADDING_SIZE_SMALL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Kê khai kinh nghiệm rõ ràng

            //Thời gian
            TextHighlight(
              title: 'Thời gian: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content:
                  "Từ  ${dangKyModel!.keKhaiKinhNghiems![index].thoiGianBatDau}  Đến  ${dangKyModel!.keKhaiKinhNghiems![index].thoiGianKetThuc}",
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Đơn vị
            TextHighlight(
              title: 'Đơn vị công tác: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.keKhaiKinhNghiems![index].donVi.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Chức vụ
            TextHighlight(
              title: 'Chức vụ: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.keKhaiKinhNghiems![index].chucVu.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Mức lương
            TextHighlight(
              title: 'Mức lương: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content:
                  "${dangKyModel!.keKhaiKinhNghiems![index].mucLuong.toString()} VND/Tháng",
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Công việc phụ trách
            TextHighlight(
              title: 'Công việc phụ trách: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.keKhaiKinhNghiems![index].congViecPhuTrach
                  .toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Kết quả / thành tích đạt được
            TextHighlight(
              title: 'Kết quả / thành tích đạt được: ',
              content: dangKyModel!.keKhaiKinhNghiems![index].ketQua.toString(),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///Ngoại ngữ
  ///
  List<Widget> _listNgoaiNgu(BuildContext context) {
    return List.generate(
      dangKyModel!.ngoaiNguList!.length,
      (index) => Container(
        width: DeviceUtils.getScaledWidth(context, 1),
        decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(
              Dimensions.BORDER_RADIUS_SMALL,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2,
                color: ColorResources.BLACK.withAlpha(30),
              )
            ]),
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_SMALL,
        ),
        margin: const EdgeInsets.only(
          bottom: Dimensions.PADDING_SIZE_SMALL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Ngôn ngữ
            TextHighlight(
              title: 'Ngôn ngữ: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content:
                  dangKyModel!.ngoaiNguList![index].loaiNgoaiNgu.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Trình độ
            TextHighlight(
              title: 'Trình độ: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.ngoaiNguList![index].trinhDo.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            // Nghe
            TextHighlight(
              title: 'Nghe: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.ngoaiNguList![index].nghe.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Nói
            TextHighlight(
              title: 'Nói: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.ngoaiNguList![index].noi.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Đọc
            TextHighlight(
              title: 'Đọc: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.ngoaiNguList![index].doc.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Viết
            TextHighlight(
              title: 'Viết: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.ngoaiNguList![index].viet.toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///Button hoàn thiện và lưu trữ ứng tuyển
  ///
  Widget _btnHoanThienVaLuuTru() {
    return LongButton(
        title: "Hoàn thiện và lưu trữ ứng tuyển",
        color: ColorResources.PRIMARYCOLOR,
        onPressed: () {
          controller.toDonePage(
            dangKyModel!,
          );
        });
  }
}
