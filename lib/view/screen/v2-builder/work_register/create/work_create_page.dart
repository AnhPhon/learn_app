import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/chuc_vu_response.dart';
import 'package:template/data/model/response/chuyen_mon_response.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/dia_diem_dang_ky_lam_viec_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_tot_nghiep_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/data/model/response/trinh_do_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/add_info_button_widget.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/choose_ability.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/custom_file_button.dart';
import 'package:template/view/screen/v2-builder/work_register/create/work_create_controller.dart';

class V2WorkCreatePage extends GetView<V2WorkCreateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Đăng ký việc mới"),
      body: GetBuilder(
        init: V2WorkCreateController(),
        builder: (V2WorkCreateController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                form(context, controller),
                priviewButton(),
                const SizedBox(
                  height: Dimensions.SIZE_LARGE,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget text({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: TextHighlight(
        title: title,
        content: content,
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
        ),
      ),
    );
  }

  Widget contentPrivew({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: TextHighlight(title: title, content: content),
    );
  }

  ///
  /// form tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget form(BuildContext context, V2WorkCreateController controller) {
    print("2321321321321 ${controller.ngaySinh.replaceAll("T", " ")}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề cần tuyển
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.titleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Tiêu đề công việc",
          hidden: false,
          label: "Tiêu đề",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(title: "Tên ứng viên: ", content: controller.tenUngVien),
              text(title: "Giới tính: ", content: controller.gioiTinh),
              text(
                title: "Ngày sinh: ",
                content: controller.ngaySinh.toString().trim().isEmpty
                    ? ""
                    : DateConverter.isoStringToVNDateOnly(
                        controller.ngaySinh.replaceAll("T", " "),
                      ),
              ),
              text(title: "Điện thoại: ", content: controller.dienThoai),
              text(title: "Email: ", content: controller.email),
            ],
          ),
        ),

        //Chỗ ở hiện tại
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "123B/22 Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Chỗ ở hiện tại",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // hôn nhân
        DropDownButton<String>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          onChanged: (val) {
            controller.honNhanChange(val.toString());
          },
          data: controller.honNhanRefer.toList(),
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.honNhan,
          obligatory: true,
          label: "Hôn nhân",
          hint: controller.honNhan,
        ),

        // Hình thức làm việc
        DropDownButton<HinhThucLamViecResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          onChanged: (val) {
            controller.hinhThucLamViecChange(val!);
          },
          data: controller.hinhThucLamViec,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.hinhThucLamViecIndex,
          obligatory: true,
          label: "Hình thức làm việc",
          hint: "Hình thức làm việc",
        ),

        const Label(label: "Mục tiêu nghê nghiệp", obligatory: true),
        Container(
          width: DeviceUtils.getScaledWidth(context, 1),
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxShadowWidget(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(
                controller.mucTieuNgheNghiep
                    .toString()
                    .replaceAll("null", "Không có"),
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                )),
          ),
        ),

        aualificationsAndQualifications(context),

        requiredCandidate(context),

        experience(context),

        // Cum ngoại ngữ
        language(context),
        computerScience(context),

        otherInformation(context)
      ],
    );
  }

  ///
  /// yêu cầu về lương kinh nghiêm chức vụ
  ///
  Widget requiredCandidate(BuildContext context) {
    return Column(
      children: [
        const Label(
            label: "Chọn chức vụ, kinh nghiệm, mức lương", obligatory: false),
        // Chức vụ hiện tại *
        DropDownButton<ChucVuResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          paddingTop: 0,
          onChanged: (val) {
            controller.onChucVuHienTaiChange(val!);
          },
          data: controller.chucVuList,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.chucVuHienTaiIndex,
          obligatory: true,
          label: "Chức vụ hiện tại",
          hint: "Chức vụ hiện tại *",
        ),

        // Chức vụ mong muốn *
        DropDownButton<ChucVuResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          onChanged: (val) {
            controller.onChucVuMongMuonChange(val!);
          },
          data: controller.chucVuList,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.chucVuMongMuonIndex,
          obligatory: true,
          label: "Chức vụ mong muốn",
          hint: "Chức vụ mong muốn",
        ),

        // Năm kinh nghiệm *
        DropDownButton<SoNamKinhNghiemResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          onChanged: (val) {
            controller.onNamKinhNghiemChange(val!);
          },
          data: controller.soNamKinhNghiemList,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.soNamKinhNghiemIndex,
          obligatory: true,
          label: "Năm kinh nghiệm",
          hint: "Năm kinh nghiệm",
        ),

        // Mức lương đề xuất *
        DropDownButton<MucLuongDuKienResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          onChanged: (val) {
            controller.onMucLuongDeXuatChange(val!);
          },
          data: controller.mucLuongDuKienList,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.mucLuongDuKienIndex,
          obligatory: true,
          label: "Mức lương đề xuất",
          hint: "Mức lương đề xuất",
        ),

        // Nơi làm việc *
        DropDownButton<DiaDiemDangKyLamViecResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          onChanged: (val) {
            controller.onNoiLamViecChange(val!);
          },
          data: controller.diaDiemDangKyLamViecList,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.diaDiemDangKyLamViecIndex,
          obligatory: true,
          label: "Nơi làm việc",
          hint: "Chọn tỉnh/TP",
        ),

        // Ngành nghề mong muốn ứng tuyển *
        DropDownButton<ChuyenNganhChinhResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          onChanged: (val) {
            controller.onNgheNghiepMongMuonUngTuyenChange(val!);
          },
          data: controller.chuyenNganhChinhList,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.chuyenNganhChinhIndex,
          obligatory: true,
          label: "Ngành nghề mong muốn ứng tuyển",
          hint: "Chọn ngành nghề",
        ),
      ],
    );
  }

  ///
  /// Bằng cấp
  ///
  Widget aualificationsAndQualifications(BuildContext context) {
    return Column(
      children: [
        const Label(label: "Bằng cấp và trình độ", obligatory: false),

        // Trình độ
        DropDownButton<TrinhDoHocVanResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          paddingTop: 0,
          onChanged: (val) {
            controller.trinhDoChange(val!);
          },
          data: controller.trinhDo,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.trinhDoIndex,
          obligatory: true,
          label: "Trình độ",
          hint: "Cùi",
        ),

        // Chuyên môn *
        DropDownButton<ChuyenMonResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          paddingTop: 0,
          onChanged: (val) {
            controller.chuyenMonChange(val!);
          },
          data: controller.chuyenMon,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.chuyenMonIndex,
          obligatory: true,
          label: "Chuyên môn",
          hint: "Chuyên môn",
        ),

        // Tốt nghiệp lọai *
        DropDownButton<LoaiTotNghiepResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          paddingTop: 0,
          onChanged: (val) {
            controller.loaiTotNghiepChange(val!);
          },
          data: controller.loaiTotNghiep,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.loaiTotNghiepIndex,
          obligatory: true,
          label: "Tốt nghiệp lọai",
          hint: "Tốt nghiệp lọai",
        ),

        // Năm tốt nghiệp *
        TextFieldDate(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          allowEdit: true,
          controller: controller.namTotNghiepController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-12-2021",
          label: "Năm tốt nghiệp",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          isDate: true,
        ),

        //Đơn vị đào tạo *
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.donViDaotaoController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Đơn vị đào tạo",
          hidden: false,
          label: "Đơn vị đào tạo",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        const Label(label: "Ảnh bằng cấp (nếu có)", obligatory: true),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(
            images: controller.anhBangCap,
            isAddImage: true,
          ),
        ),

        AddInfoButton(
            title: "Thêm bằng cấp mới",
            onPress: () {
              controller.themBangCapMoi();
            }),

        // List thêm
        Column(
          children: List.generate(
            controller.bangBangCapDisplay.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: BoxShadowWidget(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHighlight(
                        title: "Trình độ: ",
                        content: controller.bangBangCapDisplay[index]["trinhDo"]
                            .toString(),
                      ),
                      contentPrivew(
                          title: "Chuyên môn: ",
                          content: controller.bangBangCapDisplay[index]
                                  ["chuyenMon"]
                              .toString()),
                      contentPrivew(
                          title: "Tốt nghiệp loại: ",
                          content: controller.bangBangCapDisplay[index]
                                  ["loaiTotNghiep"]
                              .toString()),
                      contentPrivew(
                          title: "Năm tốt nghiệp: ",
                          content: controller.bangBangCapDisplay[index]
                                  ["namTotNghiep"]
                              .toString()),
                      contentPrivew(
                        title: "Đơn vị đào tạo: ",
                        content: controller.bangBangCapDisplay[index]
                                ["donViDaoTao"]
                            .toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Kinh nghiệm
  ///
  Widget experience(BuildContext context) {
    return Column(
      children: [
        //Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)
        const Label(
            label: "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",
            obligatory: false),
        // từ
        TextFieldDate(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          paddingTop: 0,
          allowEdit: true,
          controller: controller.startTimeController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-12-2021",
          label: "Từ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          isDate: true,
        ),

        // đến
        TextFieldDate(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          allowEdit: true,
          controller: controller.endTimeController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-12-2021",
          label: "Đến",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          isDate: true,
        ),

        //Đơn vị  *
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.donViController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Đơn vị",
          hidden: false,
          label: "Đơn vị",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        //Chức vụ *
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.chucVuController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Chức vụ",
          hidden: false,
          label: "Chức vụ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        //Mức lương *
        Row(
          children: [
            InputField(
              allowEdit: true,
              allowMultiline: false,
              controller: controller.mucLuongController,
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              holdplacer: "Mức lương",
              hidden: false,
              label: "Mức lương",
              obligatory: true,
              typeInput: TextInputType.text,
              width: DeviceUtils.getScaledWidth(context, 0.5),
            ),
            // Đơn vị
            DropDownButton<String>(
              onChanged: (val) {},
              data: const [],
              width: DeviceUtils.getScaledWidth(context, 0.5),
              value: "US",
              obligatory: false,
              label: "",
              hint: "USD",
            ),
          ],
        ),

        //Công việc phụ trách *
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.congViecPhuTrachController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Công việc phụ trách",
          hidden: false,
          label: "Công việc phụ trách",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        //thành tích đạt được *
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.ketQuaController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Kết quả / thành tích đạt được",
          hidden: false,
          label: "Kết quả / thành tích đạt được",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        AddInfoButton(
            title: "Thêm kê khai kinh nghiệm",
            onPress: () {
              controller.themKeKhaiKinhNghiem();
            }),

        // List thêm
        Column(
          children: List.generate(
            controller.keKhaiKinhNghiemDisplay.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                vertical: Dimensions.PADDING_SIZE_SMALL,
              ),
              child: BoxShadowWidget(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      contentPrivew(
                          title: "Chức vụ hiện tại: ",
                          content:
                              "${controller.keKhaiKinhNghiemDisplay[index]['chucVuHienTai']}"),
                      contentPrivew(
                          title: "Chức vụ mong muốn: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['chucVuMongMuon']
                              .toString()),
                      contentPrivew(
                          title: "Số năm kinh nghiệm: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['soNamKinhNghiem']
                              .toString()),
                      contentPrivew(
                          title: "Ngành nghề mong muốn: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['nganhNgheMongMuon']
                              .toString()),
                      contentPrivew(
                          title: "Nơi Làm Việc: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['noiLamViec']
                              .toString()),
                      contentPrivew(
                        title:
                            "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",
                        content: "",
                      ),
                      contentPrivew(
                          title: "Thời gian: ",
                          content:
                              "${controller.keKhaiKinhNghiemDisplay[index]['thoiGianBatDau']} - ${controller.keKhaiKinhNghiemDisplay[index]['thoiGianKetThuc']}"),
                      contentPrivew(
                          title: "Đơn vị: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['donVi']
                              .toString()),
                      contentPrivew(
                          title: "Chức vụ: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['chucVu']
                              .toString()),
                      contentPrivew(
                          title: "Mức lương: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['mucLuong']
                              .toString()),
                      contentPrivew(
                          title: "Công việc phụ trách: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['congViecPhuTrach']
                              .toString()),
                      contentPrivew(
                          title: "Kết quả / thành tích đạt được: ",
                          content: controller.keKhaiKinhNghiemDisplay[index]
                                  ['ketQua']
                              .toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        const Label(label: "Ảnh hồ sơ xin việc (nếu có)", obligatory: false),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(
            images: [],
            isAddImage: true,
          ),
        ),

        //File hồ sơ xin việc (nếu có)
        CustomFileButton(
          title: "Load file",
          onTap: () {
            controller.launchURL();
          },
          verticalPadding: Dimensions.PADDING_SIZE_DEFAULT,
        ),

        //Kỹ năng và sở trường làm việc
        const Label(label: "Kỹ năng và sở trường làm việc", obligatory: false),
        if (controller.kyNangSotruong != "null" &&
            controller.kyNangSotruong.isNotEmpty)
          Container(
            width: DeviceUtils.getScaledWidth(context, 1),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: BoxShadowWidget(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(
                controller.kyNangSotruong.toString(),
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                ),
              ),
            ),
          ),
      ],
    );
  }

  ///
  /// Ngôn ngữ
  ///
  Widget language(BuildContext context) {
    return Column(
      children: [
        //Ngoại ngữ *
        const Label(label: "Ngoại ngữ", obligatory: true),
        // Chọn ngoại ngữ
        DropDownButton<NgoaiNguResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          paddingTop: 0,
          onChanged: (val) {},
          data: controller.ngoaiNguResponseList,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.ngoaiNguResponseIndex,
          obligatory: true,
          label: "Chọn ngoại ngữ",
          hint: "Chọn ngoại ngữ",
        ),

        // Trình độ
        DropDownButton<TrinhDoResponse>(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          isColorFieldWhite: true,
          onChanged: (val) {},
          data: controller.trinhDoList,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.trinhDoResponseIndex,
          obligatory: true,
          label: "Trình độ",
          hint: "Trình độ",
        ),

        Table(
          defaultColumnWidth:
              FixedColumnWidth(DeviceUtils.getScaledWidth(context, 1) / 5),
          children: [
            chooseAbility(context,
                title: "", ability: ["Giỏi", "Khá", "Trung", 'Yếu']),
            chooseAbility(context, title: "Nghe", ability: [
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguNghe,
                  value: 1,
                  groupValue: controller.ngoaiNguListenSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguNghe,
                  value: 2,
                  groupValue: controller.ngoaiNguListenSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguNghe,
                  value: 3,
                  groupValue: controller.ngoaiNguListenSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguNghe,
                  value: 4,
                  groupValue: controller.ngoaiNguListenSkill)
            ]),
            chooseAbility(context, title: "Nói", ability: [
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguNoi,
                  value: 1,
                  groupValue: controller.ngoaiNguSpeakSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguNoi,
                  value: 2,
                  groupValue: controller.ngoaiNguSpeakSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguNoi,
                  value: 3,
                  groupValue: controller.ngoaiNguSpeakSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguNoi,
                  value: 4,
                  groupValue: controller.ngoaiNguSpeakSkill)
            ]),
            chooseAbility(context, title: "Đọc", ability: [
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguDoc,
                  value: 1,
                  groupValue: controller.ngoaiNguReadSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguDoc,
                  value: 2,
                  groupValue: controller.ngoaiNguReadSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguDoc,
                  value: 3,
                  groupValue: controller.ngoaiNguReadSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguDoc,
                  value: 4,
                  groupValue: controller.ngoaiNguReadSkill)
            ]),
            chooseAbility(context, title: "Viết", ability: [
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguViet,
                  value: 1,
                  groupValue: controller.ngoaiNguWriteSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguViet,
                  value: 2,
                  groupValue: controller.ngoaiNguWriteSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguViet,
                  value: 3,
                  groupValue: controller.ngoaiNguWriteSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.ngoaiNguViet,
                  value: 4,
                  groupValue: controller.ngoaiNguWriteSkill)
            ]),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: LongButton(
            title: "Thêm bằng tiếng anh",
            color: ColorResources.THEME_DEFAULT,
            onPressed: () {
              controller.ngoaiNguThem();
            },
          ),
        ),
        // List thêm
        Column(
          children: List.generate(
            controller.ngoaiNguList.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: BoxShadowWidget(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextHighlight(
                        title: "Ngôn ngữ: ",
                        content: "Tiếng anh",
                      ),
                      contentPrivew(
                          title: "Trình độ: ",
                          content: controller.ngoaiNguList[index].trinhDo
                              .toString()),
                      contentPrivew(
                          title: "Nghe: ",
                          content:
                              controller.ngoaiNguList[index].nghe.toString()),
                      contentPrivew(
                          title: "Nói: ",
                          content:
                              controller.ngoaiNguList[index].noi.toString()),
                      contentPrivew(
                          title: "Đọc: ",
                          content:
                              controller.ngoaiNguList[index].doc.toString()),
                      contentPrivew(
                          title: "Viết: ",
                          content:
                              controller.ngoaiNguList[index].viet.toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///
  ///Tin học
  ///
  Widget computerScience(BuildContext context) {
    return Column(
      children: [
        //Tin học
        const Label(label: "Tin học", obligatory: true),
        Table(
          defaultColumnWidth:
              FixedColumnWidth(DeviceUtils.getScaledWidth(context, 1) / 5),
          children: [
            chooseAbility(context,
                title: "", ability: ["Giỏi", "Khá", "Trung", 'Yếu']),
            chooseAbility(context, title: "Word", ability: [
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocWord,
                  value: 1,
                  groupValue: controller.tinHocWordSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocWord,
                  value: 2,
                  groupValue: controller.tinHocWordSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocWord,
                  value: 3,
                  groupValue: controller.tinHocWordSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocWord,
                  value: 4,
                  groupValue: controller.tinHocWordSkill),
            ]),
            chooseAbility(context, title: "Excel", ability: [
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocExcel,
                  value: 1,
                  groupValue: controller.tinHocExcelSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocExcel,
                  value: 2,
                  groupValue: controller.tinHocExcelSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocExcel,
                  value: 3,
                  groupValue: controller.tinHocExcelSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocExcel,
                  value: 4,
                  groupValue: controller.tinHocExcelSkill)
            ]),
            chooseAbility(context, title: "Internet", ability: [
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocInternet,
                  value: 1,
                  groupValue: controller.tinHocInternetSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocInternet,
                  value: 2,
                  groupValue: controller.tinHocInternetSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocInternet,
                  value: 3,
                  groupValue: controller.tinHocInternetSkill),
              RadioButton(
                  title: "",
                  onChanged: controller.tinHocInternet,
                  value: 4,
                  groupValue: controller.tinHocInternetSkill)
            ]),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: LongButton(
            title: "Thêm bằng tin học",
            color: ColorResources.THEME_DEFAULT,
            onPressed: () {
              controller.tinHocThem();
            },
          ),
        ),
        if (controller.tinHocRequest == null)
          const SizedBox()
        else
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_SMALL),
                child: BoxShadowWidget(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: SizedBox(
                    width: DeviceUtils.getScaledWidth(context, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextHighlight(title: "Bằng tin học", content: ''),
                        contentPrivew(
                            title: "Word: ",
                            content: controller.tinHocRequest!.word.toString()),
                        contentPrivew(
                            title: "Excel: ",
                            content:
                                controller.tinHocRequest!.excel.toString()),
                        contentPrivew(
                            title: "Internet: ",
                            content:
                                controller.tinHocRequest!.internet.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }

  Widget otherInformation(BuildContext context) {
    return Column(
      children: [
        // Phần mềm hỗ trợ công việc từng ngành
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.phanMemHoTroController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Phần mềm hỗ trợ công việc từng ngành",
          hidden: false,
          label: "Phần mềm hỗ trợ công việc từng ngành",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Sở thích thể hiện trình độ / khả năng tư duy
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.soThichTheHienTrinhDoController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Sở thích thể hiện trình độ / khả năng tư duy",
          hidden: false,
          label: "Sở thích thể hiện trình độ / khả năng tư duy",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Sở thích thể hiện kỹ năng
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.soThichTheHienKyNangController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Sở thích thể hiện kỹ năng",
          hidden: false,
          label: "Sở thích thể hiện kỹ năng",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Sở thích thể hiện tích cách
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.soThichTheHienTinhCachController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Sở thích thể hiện tích cách",
          hidden: false,
          label: "Sở thích thể hiện tích cách",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
      ],
    );
  }

  ///
  /// Button
  ///
  Widget priviewButton() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
        title: "Xem trước hồ sơ",
        color: ColorResources.PRIMARYCOLOR,
        onPressed: () {
          controller.onClickPreviewButton();
        },
      ),
    );
  }
}
