import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/dang_ky_viec_moi_model.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';

import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';

import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/work_register/component/v2_add_image_list_horizontal.dart';

import 'package:template/view/screen/v2-builder/work_register/preview/work_preview_controller.dart';

class V2WorkPreviewPage extends GetView<V2WorkPreviewController> {
  DangKyViecMoiModel? dangKyModel;
  List<Map<String, String>>? bangBangCapDisplay;
  @override
  V2WorkPreviewController controller = Get.put(V2WorkPreviewController());

  V2WorkPreviewPage({this.dangKyModel, this.bangBangCapDisplay});
  @override
  Widget build(BuildContext context) {
    print(dangKyModel.toString());
    return Scaffold(
      appBar: const AppBarWidget(title: "Hồ sơ ứng tuyển"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_LARGE,
              ),

              //Tiêu đề hồ sơ ứng tuyển
              TextHighlight(
                title: "Tiều đề: ",
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

              //Kê khai kinh nghiệm
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  //Tiêu đề
                  const Text(
                    "Kê khai kinh nghiệm: ",
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
                          content: dangKyModel!.tinHoc!.excel.toString(),
                        ),

                        //Internet
                        TextHighlight(
                          title: "Internet: ",
                          titleStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: ColorResources.BLACK,
                          ),
                          content: dangKyModel!.tinHoc!.internet.toString(),
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
                  //Tiêu đề
                  const Text(
                    "Sở thích: ",
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
                    title: "+ ",
                    titleStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: ColorResources.BLACK,
                    ),
                    content: dangKyModel!.soThichTheHienKyNang.toString(),
                  ),

                  //Sở thích thể hiện tính cách
                  TextHighlight(
                    title: "+ ",
                    titleStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: ColorResources.BLACK,
                    ),
                    content: dangKyModel!.soThichTheHienTinhCach.toString(),
                  ),

                  //Sở thích thể hiện trình độ
                  TextHighlight(
                    title: "+ ",
                    titleStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: ColorResources.BLACK,
                    ),
                    content: dangKyModel!.soThichTheHienTrinhDo.toString(),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //Ảnh bằng cấp(nếu có)
              V2ImageListHorizontalAdd(
                onDelete: (String file, List<String> files) =>
                    controller.onDeleteImage(
                  file: file,
                  files: files,
                ),
                labelBold: true,
                label: "Ảnh bằng cấp(nếu có)",
                pickImage: () => controller.pickAnhBangCap(),
                imageFileList: controller.dangKyViecMoiRequest.anhBangCaps ??
                    controller.getAnhBangCap(),
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //Ảnh hồ sơ xin việc(nếu có)
              V2ImageListHorizontalAdd(
                onDelete: (String file, List<String> files) =>
                    controller.onDeleteImage(
                  file: file,
                  files: files,
                ),
                labelBold: true,
                label: "Ảnh hồ sơ xin việc(nếu có)",
                pickImage: () => controller.pickAnhHoSoXinViec(),
                imageFileList:
                    controller.dangKyViecMoiRequest.anhHoSoXinViecs ??
                        controller.getAnhHoSoXinViec(),
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //File hồ sơ xin việc
              Column(
                children: [
                  //show file
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "File hồ sơ xin việc (nếu có)",
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_SMALL,
                  ),

                  //add file
                  GestureDetector(
                    onTap: controller.pickFiles,
                    child: BoxShadowWidget(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_LARGE,
                            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add,
                                size: Dimensions.ICON_SIZE_EXTRA_LARGE),
                            Text("Cập nhật file hồ sơ xin việc"),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_SMALL,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.getFileNameBaoGia().isEmpty &&
                          controller.getFileNameBaoGia().toString() == "")
                        const SizedBox()
                      else
                        Expanded(
                          child: Text(
                            controller.getFileNameBaoGia(),
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              //
              const SizedBox(
                height: 30,
              ),

              //Button hoàn thiện và lưu trữ ứng tuyển
              _btnHoanThienVaLuuTru(),

              //
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///  //Avatar và MSHS
  ///
  Widget _avatarHoSoUngTuyen(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Expanded(
                child: TextHighlight(
                  title: "MSHS: ",
                  content: dangKyModel!.dienThoai.toString().substring(4, 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///Thông tin cá nhân ứng viên
  ///
  Widget _thongTinCaNhan(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, .6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Tên ứng viên
          TextHighlight(
            title: "Tên ứng viên: ",
            content: dangKyModel!.tenUngVien.toString(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Giới tinh
          TextHighlight(
            title: "Giới tính: ",
            content: dangKyModel!.gioiTinh.toString(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Ngày Sinh
          TextHighlight(
            title: "Ngày sinh: ",
            content: controller.formatDateTime(
                dateTime: dangKyModel!.ngaySinh.toString()),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Điện thoại
          TextHighlight(
            title: "Điện thoại: ",
            content: dangKyModel!.dienThoai.toString(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Email
          TextHighlight(
            title: "Email: ",
            content: dangKyModel!.email.toString(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Chổ ở hiện nay
          TextHighlight(
            title: "Chổ ở hiện nay: ",
            content: dangKyModel!.choOHienTai.toString(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          //Hôn nhân
          TextHighlight(
            title: "Hôn nhân: ",
            content: dangKyModel!.honNhan.toString(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
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
      dangKyModel!.bangBangCaps!.length,
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
              content: bangBangCapDisplay![index]["trinhDo"].toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Chuyên ngành
            TextHighlight(
              title: 'Chuyên ngành: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: bangBangCapDisplay![index]["chuyenMon"].toString(),
            ),
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
              content: bangBangCapDisplay![index]["loaiTotNghiep"].toString(),
            ),
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
              content: bangBangCapDisplay![index]["namTotNghiep"].toString(),
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
              content: bangBangCapDisplay![index]["donViDaoTao"].toString(),
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
            // Chức vụ hiện tại
            TextHighlight(
              title: 'Chức vụ hiện tại: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.keKhaiKinhNghiems![index]['chucVuHienTai']
                  .toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Chức vụ mong muốn
            TextHighlight(
              title: 'Chức vụ mong muốn: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.keKhaiKinhNghiems![index]['chucVuMongMuon']
                  .toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Số năm kinh nghiệm
            TextHighlight(
              title: 'Số năm kinh nghiệm: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.keKhaiKinhNghiems![index]['soNamKinhNghiem']
                  .toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Ngành nghề mong muốn:
            TextHighlight(
              title: 'Ngành nghề mong muốn: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.keKhaiKinhNghiems![index]
                      ['nganhNgheMongMuon']
                  .toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Nơi Làm Việc
            TextHighlight(
              title: 'Nơi Làm Việc: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: dangKyModel!.keKhaiKinhNghiems![index]['noiLamViec']
                  .toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Kê khai kinh nghiệm rõ ràng
            const TextHighlight(
              title: "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",
              content: "",
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Thời gian
            TextHighlight(
              title: 'Thời gian: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content:
                  "Từ  ${dangKyModel!.keKhaiKinhNghiems![index]['thoiGianBatDau']}  Đến  ${dangKyModel!.keKhaiKinhNghiems![index]['thoiGianKetThuc']}",
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Đơn vị
            TextHighlight(
              title: 'Đơn vị: ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content:
                  dangKyModel!.keKhaiKinhNghiems![index]['donVi'].toString(),
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
              content:
                  dangKyModel!.keKhaiKinhNghiems![index]['chucVu'].toString(),
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
                  "${dangKyModel!.keKhaiKinhNghiems![index]['mucLuong'].toString()} USD",
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
              content: dangKyModel!.keKhaiKinhNghiems![index]
                      ['congViecPhuTrach']
                  .toString(),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),

            //Kết quả / thành tích đạt được
            TextHighlight(
              title: 'Kết quả / thành tích đạt được: ',
              content:
                  dangKyModel!.keKhaiKinhNghiems![index]['ketQua'].toString(),
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
            const TextHighlight(
              title: 'Ngôn ngữ: ',
              titleStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.BLACK,
              ),
              content: "Tiếng Anh",
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
          controller.toDonePage(dangKyModel!);
        });
  }
}
