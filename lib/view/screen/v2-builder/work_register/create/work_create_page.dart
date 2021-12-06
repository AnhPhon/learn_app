import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:template/data/model/response/chuc_vu_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/loai_tot_nghiep_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/add_info_button_widget.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/choose_ability.dart';
import 'package:template/view/screen/v2-builder/work_register/component/v2_money_format_validation.dart';
import 'package:template/view/screen/v2-builder/work_register/component/v2_number_input_widget.dart';
import 'package:template/view/screen/v2-builder/work_register/create/work_create_controller.dart';

class V2WorkCreatePage extends GetView<V2WorkCreateController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2WorkCreateController>(
      init: V2WorkCreateController(),
      builder: (V2WorkCreateController controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Scaffold(
              appBar: AppBarWidget(
                title: "Đăng ký việc mới",
                leading: IconButton(
                  onPressed: () {
                    controller.getBackAndReload();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorResources.WHITE,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    form(context, controller),
                    priviewButton(),
                    const SizedBox(
                      height: Dimensions.SIZE_LARGE,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget text({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: TextHighlight(
        title: title,
        content: content,
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_LARGE,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget contentPrivew({required String title, required String content}) {
    return TextHighlight(title: title, content: content);
  }

  ///
  /// form tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget form(BuildContext context, V2WorkCreateController controller) {
    print("2321321321321 ${controller.ngaySinh.replaceAll("T", " ")}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_LARGE,
        ),
        // Tiêu đề cần tuyển
        InputField(
          textInputAction: TextInputAction.done,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.titleController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Tiêu đề ứng tuyển",
          hidden: false,
          label: "Tiêu đề ứng tuyển",
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
              text(
                  title: "Giới tính: ",
                  content: Validate.getGenderString(controller.gioiTinh)),
              text(
                title: "Ngày sinh: ",
                content: controller.ngaySinh.toString().trim().isEmpty
                    ? ""
                    : DateConverter.isoStringToVNDateOnly(
                        controller.ngaySinh.replaceAll("T", " "),
                      ),
              ),
              text(title: "Điện thoại: ", content: controller.dienThoai),
              if (controller.email.isNotEmpty &&
                  controller.email.toString() != "null")
                text(
                    title: "Email: ",
                    content: controller.email
                        .toString()
                        .replaceAll("null", "Không có"))
              else
                text(title: "Email: ", content: "Không có"),
              text(title: "Địa chỉ thường trú hiện tại", content: "")
            ],
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Địa chỉ chọn tỉnh
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: SearchDropDownButton<TinhTpResponse>(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_SMALL,
              vertical: Dimensions.PADDING_SIZE_LARGE - 2,
            ),
            label: "Tỉnh/Tp",
            hint: "Chọn Tỉnh/Tp",
            data: controller.tinhTpListModel.isNotEmpty
                ? controller.tinhTpListModel
                : [],
            width: double.infinity,
            value: controller.tinhTp,
            obligatory: true,
            fillColor: ColorResources.WHITE,
            isEnable: controller.tinhTpListModel.isNotEmpty,
            onChanged: (value) => controller.tinhTpListModel.isNotEmpty
                ? controller.onChangedTinhTp(value!)
                : null,
          ),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(
            context,
            Dimensions.SCALE_DEFAULT,
          ),
        ),
        // DropDownButton<TinhTpResponse>(
        //   isColorFieldWhite: true,
        //   onChanged: (item) => controller.onChangedTinhTp(item!),
        //   data: controller.tinhTpListModel.isNotEmpty
        //       ? controller.tinhTpListModel
        //       : [],
        //   width: DeviceUtils.getScaledWidth(context, 1),
        //   value: controller.tinhTp,
        //   obligatory: true,
        //   label: "Tỉnh/Tp",
        //   hint: "Chọn tỉnh",
        //   padding: const EdgeInsets.only(
        //     left: Dimensions.PADDING_SIZE_DEFAULT,
        //     right: Dimensions.PADDING_SIZE_DEFAULT,
        //   ),
        // ),
        // const SizedBox(
        //   height: Dimensions.MARGIN_SIZE_DEFAULT,
        // ),

        // Địa chỉ chọn huyện
        DropDownButton<QuanHuyenResponse>(
          isColorFieldWhite: true,
          onChanged: (item) => controller.onChangedQuanHuyen(item!),
          data: controller.quanHuyenListModel.isNotEmpty
              ? controller.quanHuyenListModel
              : [],
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.quanHuyenResponse,
          obligatory: true,
          label: "Quận/Huyện",
          hint: "Chọn quận/huyện",
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        // Địa chỉ chọn xã
        DropDownButton<PhuongXaResponse>(
          isColorFieldWhite: true,
          onChanged: (item) => controller.onChangedPhuongXa(item!),
          data: controller.phuongXaListModel.isNotEmpty
              ? controller.phuongXaListModel
              : [],
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.phuongXaResponse,
          obligatory: true,
          label: "Phường/Xã",
          hint: "Chọn phường/xã",
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        //Chỗ ở hiện tại
        InputField(
          textInputAction: TextInputAction.done,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập chỗ ở hiện tại",
          hidden: false,
          label: "Chỗ ở hiện tại",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // hôn nhân
        DropDownButton<String>(
            isColorFieldWhite: true,
            onChanged: (item) => controller.onchangHonNhanString(item),
            data: controller.honNhanListString,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.honNhanString,
            obligatory: true,
            label: "Hôn nhân",
            hint: "Chọn tình trạng hôn nhân",
            padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT,
            )),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
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
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //Mục tiêu nghề nghiệp
        InputWidget(
          labelBold: true,
          // textInputAction: TextInputAction.done,
          isColorFieldWhite: true,
          fillColor: ColorResources.WHITE,
          maxLine: 5,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          label: "Mục tiêu nghề nghiệp",
          obligatory: true,
          hintText: "Nhập mục tiêu nghề nghiệp",
          textEditingController: controller.mucTieuNgheNghiepController,
          width: 1,
        ),

        // Bằng cấp
        aualificationsAndQualifications(context),

        //Yêu cầu
        requiredCandidate(context),

        //Kinh nghiệm
        experience(context),

        // Cum ngoại ngữ
        language(context),

        //tin học
        computerScience(context),

        //thông tin khác
        otherInformation(context),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
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
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Chức vụ hiện tại *
        DropDownButton<ChucVuResponse>(
          isSort: false,
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
          hint: "Chức vụ hiện tại",
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Chức vụ mong muốn *
        DropDownButton<ChucVuResponse>(
          isSort: false,
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
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Năm kinh nghiệm *
        DropDownButton<SoNamKinhNghiemResponse>(
          isSort: false,
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
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Mức lương đề xuất *
        DropDownButton<MucLuongDuKienResponse>(
          isSort: false,
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
          label: "Mức lương mong muốn",
          hint: "Chọn mức lương mong muốn",
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //Nơi làm việc
        noiLamViec(
          context: context,
          label: "Chọn nơi làm việc",
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Ngành nghề mong muốn ứng tuyển *
        diaDiemKhacWidget(context: context, label: "Ngành nghề ứng tuyển"),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
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
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        const Label(label: "Bằng cấp và trình độ", obligatory: false),

        // Trình độ
        SearchDropDownButton<TrinhDoHocVanResponse>(
          isSort: false,
          customHintText: controller.customHintTextTrinhDo,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL,
            vertical: Dimensions.PADDING_SIZE_LARGE - 2,
          ),
          label: "Trình độ học vấn",
          hint: "Vui lòng chọn trình độ",
          data: controller.trinhDoHocVanList,
          width: double.infinity,
          value: controller.trinhDoHocVanResponseIndex,
          obligatory: true,
          fillColor: ColorResources.WHITE,
          isEnable: controller.trinhDoHocVanList.isNotEmpty,
          onChanged: (val) => controller.trinhDoHocVanList.isNotEmpty
              ? controller.trinhDoHocVanChange(val!)
              : null,
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(
            context,
            Dimensions.SCALE_DEFAULT,
          ),
        ),

        // Chuyên môn *
        SearchDropDownButton<LoaiCongViecResponse>(
          customHintText: controller.customHintTextChuyenMon,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL,
            vertical: Dimensions.PADDING_SIZE_LARGE - 2,
          ),
          label: "Chuyên môn",
          hint: "Vui lòng chọn chuyên môn",
          data: controller.chuyenMon,
          width: double.infinity,
          value: controller.chuyenMonIndex,
          obligatory: true,
          fillColor: ColorResources.WHITE,
          isEnable: controller.chuyenMon.isNotEmpty,
          onChanged: (val) => controller.chuyenMon.isNotEmpty
              ? controller.chuyenMonChange(val!)
              : null,
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(
            context,
            Dimensions.SCALE_DEFAULT,
          ),
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
          hint: "Vui lòng chọn loại tốt nghiệp",
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Năm tốt nghiệp *
        InputWidget(
          firstDate: DateTime(1900),
          labelBold: true,
          isddMMyyyy: true,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT + 2,
            horizontal: Dimensions.PADDING_SIZE_SMALL,
          ),
          obligatory: true,
          allowEdit: false,
          isDate: true,
          isColorFieldWhite: true,
          fillColor: ColorResources.WHITE,
          hintText: "Vui lòng chọn năm tốt nghiệp",
          label: "Năm tốt nghiệp",
          textEditingController: controller.namTotNghiepController,
          width: 1,
          suffixIcon: const Icon(
            Icons.date_range,
            size: Dimensions.ICON_SIZE_SMALL,
            color: ColorResources.PRIMARYCOLOR,
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        //Đơn vị đào tạo *
        InputField(
          textInputAction: TextInputAction.done,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.donViDaotaoController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Đơn vị đào tạo",
          hidden: false,
          label: "Đơn vị đào tạo",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(
                label: "Ảnh bằng cấp (nếu có)",
                obligatory: false,
                paddingTitle: 0),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: BoxImage(
                images: controller.anhBangCaps,
                isAddImage: true,
                onPress: () =>
                    controller.pickAnhBangCaps(data: controller.anhBangCaps),
                onDelete: (String file, List<String> files) =>
                    controller.onDeleteImage(
                  file: file,
                  files: files,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        const Text(
          "(Bạn có thể thêm nhiều bằng cấp mới)",
          style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_SMALL,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: ColorResources.BLACK),
          textAlign: TextAlign.center,
        ),

        AddInfoButton(
            title: "Lưu bằng cấp",
            onPress: () {
              controller.themBangCapMoi();
            }),

        // List thêm
        Column(
            children: controller.bangBangCapDisplayResponse
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, 1),
                      child: BoxShadowWidget(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: SizedBox(
                          width: DeviceUtils.getScaledWidth(context, 1),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextHighlight(
                                    title: "Trình độ: ",
                                    content: e.idTrinhDo!.tieuDe.toString(),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Chuyên môn: ",
                                      content: e.idChuyenMon!.tenCongViec
                                          .toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Tốt nghiệp loại: ",
                                      content:
                                          e.idLoaiTotNghiep!.tieuDe.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Năm tốt nghiệp: ",
                                      content: e.namTotNghiep.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                    title: "Đơn vị đào tạo: ",
                                    content: e.donViDaoTao.toString(),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: Dimensions.MARGIN_SIZE_EXTRA_SMALL - 15,
                                right: Dimensions.MARGIN_SIZE_EXTRA_SMALL - 15,
                                child: IconButton(
                                  onPressed: () => controller.deleteBangCap(e),
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: ColorResources.RED,
                                    size: Dimensions.ICON_SIZE_DEFAULT,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList()),
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
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // từ
        InputWidget(
          focusNode: controller.focusUpKeKhaiKinhNghiem,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT + 2,
            horizontal: Dimensions.PADDING_SIZE_SMALL + 2,
          ),
          obligatory: true,
          label: "Từ",
          labelBold: true,
          hintText: "Vui lòng chọn thời gian bắt đầu",
          isColorFieldWhite: true,
          fillColor: ColorResources.WHITE,
          textEditingController: controller.startTimeController,
          width: 1,
          allowEdit: false,
          isDate: true,
          isddMMyyyy: true,
          suffixIcon: const Icon(
            Icons.date_range,
            size: Dimensions.ICON_SIZE_SMALL,
            color: ColorResources.PRIMARYCOLOR,
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // đến
        InputWidget(
          labelBold: true,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT + 2,
            horizontal: Dimensions.PADDING_SIZE_SMALL + 2,
          ),
          obligatory: true,
          label: "Đến",
          hintText: "Vui lòng chọn thời gian kết thúc",
          isColorFieldWhite: true,
          fillColor: ColorResources.WHITE,
          textEditingController: controller.endTimeController,
          width: 1,
          allowEdit: false,
          isDate: true,
          isddMMyyyy: true,
          suffixIcon: const Icon(
            Icons.date_range,
            size: Dimensions.ICON_SIZE_SMALL,
            color: ColorResources.PRIMARYCOLOR,
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //Đơn vị  *
        InputField(
          // autoFocus: true,
          // onSubmitted: (v) {
          //   FocusScope.of(context).requestFocus(controller.focusChucVu);
          // },

          textInputAction: TextInputAction.next,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.donViController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Đơn vị công tác",
          hidden: false,
          label: "Đơn vị công tác",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //Chức vụ *
        InputField(
          // autoFocus: true,
          // onSubmitted: (v) {
          //   FocusScope.of(context).requestFocus(controller.focusMucLuong);
          // },
          // focusNode: controller.focusChucVu,
          textInputAction: TextInputAction.next,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.chucVuController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Chức vụ",
          hidden: false,
          label: "Chức vụ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //Mức lương *
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            V2MoneyInputWidget(
              textInputAction: TextInputAction.next,
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              isColorFieldWhite: true,
              fillColor: ColorResources.WHITE,
              contentPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT + 2,
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              textEditingController: controller.mucLuongController,
              thousandsSeparator: true,
              hintText: "Mức lương",
              label: "Mức lương",
              obligatory: true,
              textInputType: TextInputType.number,
              width: 0.6,
            ),

            // Đơn vị
            InputWidget(
              thousandsSeparator: true,
              padding: const EdgeInsets.only(
                right: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT + 3,
                horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE + 4,
              ),
              textEditingController: controller.vndController,
              hintText: "",
              allowEdit: false,
              label: "",
              textInputType: TextInputType.number,
              width: 0.3,
            ),
          ],
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //Công việc phụ trách *
        InputField(
          // focusNode: controller.focusCongViecPhuTrach,
          textInputAction: TextInputAction.next,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.congViecPhuTrachController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Công việc phụ trách",
          hidden: false,
          label: "Công việc phụ trách",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //thành tích đạt được *
        InputWidget(
          labelBold: true,
          // autofocus: true,
          // focusNode: controller.focusKetQuaThanhTich,
          // textInputAction: TextInputAction.done,
          autofocus: true,
          focusNode: controller.focusKetQuaThanhTich,
          isColorFieldWhite: true,
          fillColor: ColorResources.WHITE,
          maxLine: 5,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          hintText: "Kết quả / thành tích đạt được",
          label: "Kết quả / thành tích đạt được",
          obligatory: true,
          textEditingController: controller.ketQuaController,
          width: 1,
        ),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_LARGE,
        ),

        const Text(
          "(Bạn có thể thêm nhiều kê khai kinh nghiệm)",
          style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_SMALL,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: ColorResources.BLACK),
          textAlign: TextAlign.center,
        ),
        AddInfoButton(
            title: "Lưu kê khai kinh nghiệm",
            onPress: () {
              controller.themKeKhaiKinhNghiem();
              FocusScope.of(context)
                  .requestFocus(controller.focusUpKeKhaiKinhNghiem);
            }),

        // List thêm
        Column(
            children: controller.keKhaiKinhNghiemResponseList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, 1),
                      child: BoxShadowWidget(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: SizedBox(
                          width: DeviceUtils.getScaledWidth(context, 1),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: Dimensions.PADDING_SIZE_LARGE,
                                    ),
                                    child: contentPrivew(
                                      title:
                                          "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",
                                      content: "",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Thời gian: ",
                                      content:
                                          "${e.thoiGianBatDau} - ${e.thoiGianKetThuc}"),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Đơn vị công tác: ",
                                      content: e.donVi.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Chức vụ: ",
                                      content: e.chucVu.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Mức lương: ",
                                      content:
                                          "${e.mucLuong.toString()} VND/Tháng"),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Công việc phụ trách: ",
                                      content: e.congViecPhuTrach.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Kết quả / thành tích đạt được: ",
                                      content: e.ketQua.toString()),
                                ],
                              ),
                              Positioned(
                                top: Dimensions.MARGIN_SIZE_EXTRA_SMALL - 15,
                                right: Dimensions.MARGIN_SIZE_EXTRA_SMALL - 15,
                                child: IconButton(
                                  onPressed: () =>
                                      controller.deleteKeKhaiKinhNghiem(e),
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: ColorResources.RED,
                                    size: Dimensions.ICON_SIZE_DEFAULT,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList()),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(
                label: "Ảnh hồ sơ xin việc(nếu có)",
                obligatory: false,
                paddingTitle: 0),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: BoxImage(
                images: controller.anhHoSoXinViecs,
                isAddImage: true,
                onPress: () => controller.pickAnhHoSoXinViecs(
                    data: controller.anhHoSoXinViecs),
                onDelete: (String file, List<String> files) =>
                    controller.onDeleteImage(
                  file: file,
                  files: files,
                ),
              ),
            ),
            attchFile(context, controller: controller),
          ],
        ),

        //Kỹ năng và sở trường làm việc
        const Label(label: "Kỹ năng và sở trường làm việc", obligatory: true),
        if (controller.kyNangVaSoTruongLamViecController.toString() != "null" &&
            controller.kyNangVaSoTruongLamViecController.toString().isNotEmpty)
          InputWidget(
            maxLine: 5,
            hintText: "Nhập kỹ năng và sở trường làm việc",
            isColorFieldWhite: true,
            fillColor: ColorResources.WHITE,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            textEditingController: controller.kyNangVaSoTruongLamViecController,
            width: 1,
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
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        const Label(label: "Ngoại ngữ", obligatory: true),

        // Chọn ngoại ngữ
        InputField(
          textInputAction: TextInputAction.next,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.ngoaiNguController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập loại ngoại ngữ",
          hidden: false,
          label: "Loại ngoại ngữ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Trình độ
        InputField(
          textInputAction: TextInputAction.done,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.trinhDoController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập trình độ",
          hidden: false,
          label: "Trình độ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        Table(
          defaultColumnWidth:
              FixedColumnWidth(DeviceUtils.getScaledWidth(context, 1) / 5),
          children: [
            chooseAbility(context,
                title: "", ability: ["Giỏi", "Khá", "TB", 'Yếu']),
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
        const Text(
          "(Bạn có thể thêm nhiều bằng cấp ngoại ngữ)",
          style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_SMALL,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: ColorResources.BLACK),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: LongButton(
            title: "Thêm bằng ngoại ngữ",
            color: ColorResources.THEME_DEFAULT,
            onPressed: () {
              controller.ngoaiNguThem();
            },
          ),
        ),

        // List thêm
        Column(
            children: controller.ngoaiNguResponseList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, 1),
                      child: BoxShadowWidget(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: SizedBox(
                          width: DeviceUtils.getScaledWidth(context, 1),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  contentPrivew(
                                      title: "Ngôn ngữ: ",
                                      content: e.loaiNgoaiNgu.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Trình độ: ",
                                      content: e.trinhDo.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Nghe: ",
                                      content: e.nghe.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Nói: ",
                                      content: e.noi.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Đọc: ",
                                      content: e.doc.toString()),
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                  contentPrivew(
                                      title: "Viết: ",
                                      content: e.viet.toString()),
                                ],
                              ),
                              Positioned(
                                top: Dimensions.MARGIN_SIZE_EXTRA_SMALL - 15,
                                right: Dimensions.MARGIN_SIZE_EXTRA_SMALL - 15,
                                child: IconButton(
                                  onPressed: () => controller.deleteNgoaiNgu(e),
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: ColorResources.RED,
                                    size: Dimensions.ICON_SIZE_DEFAULT,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList()),
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
                title: "", ability: ["Giỏi", "Khá", "TB", 'Yếu']),
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
      ],
    );
  }

  Widget otherInformation(BuildContext context) {
    return Column(
      children: [
        // Phần mềm hỗ trợ công việc từng ngành
        InputField(
          // onSubmitted: (v) {
          //   FocusScope.of(context).requestFocus(controller.focusSoThichTrinhDo);
          // },
          textInputAction: TextInputAction.next,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.phanMemHoTroController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Phần mềm hỗ trợ các chuyên ngành",
          hidden: false,
          label: "Phần mềm hỗ trợ công việc từng ngành",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Sở thích thể hiện trình độ / khả năng tư duy
        InputField(
          // onSubmitted: (v) {
          //   FocusScope.of(context).requestFocus(controller.focusSoThichKyNang);
          // },
          // focusNode: controller.focusSoThichTrinhDo,
          textInputAction: TextInputAction.next,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.soThichTheHienTrinhDoController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Đọc sách/ lập trình/viết sách",
          hidden: false,
          label: "Sở thích thể hiện trình độ / khả năng tư duy",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Sở thích thể hiện kỹ năng
        InputField(
          // onSubmitted: (v) {
          //   FocusScope.of(context)
          //       .requestFocus(controller.focusSoThichTinhCach);
          // },
          // focusNode: controller.focusSoThichKyNang,
          textInputAction: TextInputAction.next,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.soThichTheHienKyNangController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Ca hát/văn nghệ/nấu ăn",
          hidden: false,
          label: "Sở thích thể hiện kỹ năng",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        // Sở thích thể hiện tích cách
        InputField(
          // onSubmitted: (v) {
          //   FocusScope.of(context).requestFocus(controller.focusCapTren);
          // },
          // focusNode: controller.focusSoThichTinhCach,
          textInputAction: TextInputAction.next,
          allowEdit: true,
          allowMultiline: false,
          controller: controller.soThichTheHienTinhCachController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Thể thao/ du lịch/leo núi",
          hidden: false,
          label: "Sở thích thể hiện tích cách",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //Tiêu đề tham khảm
        Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.MARGIN_SIZE_DEFAULT,
            top: Dimensions.MARGIN_SIZE_DEFAULT,
            right: Dimensions.MARGIN_SIZE_DEFAULT,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: Dimensions.FONT_SIZE_LARGE),
                  children: [
                    TextSpan(
                      text: "Người tham khảo",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: " (Không bắt buộc)",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        //Tham khảo
        Column(
          children: [
            // Người tham khảo
            InputField(
              // onSubmitted: (v) {
              //   FocusScope.of(context).requestFocus(controller.focusChucDanh);
              // },
              // focusNode: controller.focusCapTren,
              textInputAction: TextInputAction.next,
              allowEdit: true,
              allowMultiline: false,
              controller: controller.nguoiThamKhaoController,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              holdplacer: "Cấp trên công ty cũ",
              hidden: false,
              label: "Cấp trên công ty cũ",
              obligatory: false,
              typeInput: TextInputType.text,
              width: DeviceUtils.getScaledWidth(context, 1),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),

            // Chức danh
            InputField(
              // onSubmitted: (v) {
              //   FocusScope.of(context).requestFocus(controller.focusCongTy);
              // },
              // focusNode: controller.focusChucDanh,
              textInputAction: TextInputAction.next,
              allowEdit: true,
              allowMultiline: false,
              controller: controller.chucdanhController,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              holdplacer: "Chức danh",
              hidden: false,
              label: "Chức danh",
              obligatory: false,
              typeInput: TextInputType.text,
              width: DeviceUtils.getScaledWidth(context, 1),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),

            // Công ty
            InputField(
              // onSubmitted: (v) {
              //   FocusScope.of(context).requestFocus(controller.focusSDT);
              // },
              // focusNode: controller.focusCongTy,
              textInputAction: TextInputAction.next,
              allowEdit: true,
              allowMultiline: false,
              controller: controller.congTyController,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              holdplacer: "Công ty",
              hidden: false,
              label: "Công ty",
              obligatory: false,
              typeInput: TextInputType.text,
              width: DeviceUtils.getScaledWidth(context, 1),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),

            // Số điện thoại
            V2InputWidget(
              focusNode: controller.focusSDT,
              fillColor: ColorResources.WHITE,
              isColorFieldWhite: true,
              textEditingController: controller.soDienThoaiController,
              hintText: "Số điện thoại",
              justNumber: true,
              label: "Số điện thoại",
              textInputType: TextInputType.number,
              contentPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT + 2,
                horizontal: Dimensions.PADDING_SIZE_SMALL + 2,
              ),
              width: 1,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
          ],
        ),
      ],
    );
  }

  Widget attchFile(BuildContext context,
      {required V2WorkCreateController controller}) {
    return Column(
      children: [
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        const Label(
          label: "File hồ sơ xin việc (nếu có)",
          obligatory: false,
        ),
        AttachButton(
          title: "Thêm tập tin",
          color: ColorResources.WHITE,
          onPressed: controller.pickFiles,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        if (controller.hoSoXinViecsFile.toString() != "null")
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Wrap(
              children: [
                Text(
                  controller.hoSoXinViecsFile.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
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

  ///
  /// Loại công trình
  ///
  Widget diaDiemKhacWidget({
    required String label,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '*',
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              )
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          MultiSelectDialogField<LoaiCongViecResponse?>(
            onSelectionChanged: (value) {
              if (value.length > 5) {
                IZIAlert.error(
                    message:
                        "Vui lòng không được chọn quá 5 ngành nghề ứng tuyển!");
              } else {}
            },
            searchHint: "Tìm kiếm ngành nghề ứng tuyển...",
            searchable: true,
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
              border: const Border(
                bottom: BorderSide(
                  color: ColorResources.PRIMARYCOLOR,
                ),
                left: BorderSide(
                  color: ColorResources.PRIMARYCOLOR,
                ),
                right: BorderSide(
                  color: ColorResources.PRIMARYCOLOR,
                ),
                top: BorderSide(
                  color: ColorResources.PRIMARYCOLOR,
                ),
              ),
            ),
            closeSearchIcon: const Icon(Icons.close),
            initialValue: controller.chuyenNganhChinhSelected,
            items: controller.chuyenNganhChinhList!
                .map((e) => MultiSelectItem(e, e.tenCongViec.toString()))
                .toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              controller.onNgheNghiepMongMuonUngTuyenChanged(values);
              FocusScope.of(context).requestFocus(FocusNode());
            },
            buttonIcon: const Icon(Icons.arrow_drop_down),
            buttonText: const Text("Chọn ngành nghề ứng tuyển",
                style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.GREY,
                )),
            cancelText: const Text("Hủy bỏ"),
            confirmText: const Text("Chọn"),
            title: const Text(
              "Chọn ngành nghề ứng tuyển",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Noi làm việc
  ///
  Widget noiLamViec({
    required String label,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '*',
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              )
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
          MultiSelectDialogField<String?>(
            searchHint: "Tìm kiếm nơi làm việc..",
            searchable: true,
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
              border: const Border(
                bottom: BorderSide(
                  color: ColorResources.PRIMARYCOLOR,
                ),
                left: BorderSide(
                  color: ColorResources.PRIMARYCOLOR,
                ),
                right: BorderSide(
                  color: ColorResources.PRIMARYCOLOR,
                ),
                top: BorderSide(
                  color: ColorResources.PRIMARYCOLOR,
                ),
              ),
            ),
            closeSearchIcon: const Icon(Icons.close),
            items: controller.tinhTpResponseList
                .map((e) => MultiSelectItem<String?>(
                    e.ten.toString(), e.ten.toString()))
                .toList(),
            initialValue: controller.noiLamViecListString,
            listType: MultiSelectListType.CHIP,
            onConfirm: (List<String?> results) {
              controller.noiLamViecListString = results;
              print(controller.noiLamViecListString);
              FocusScope.of(context).requestFocus(FocusNode());
            },
            buttonIcon: const Icon(Icons.arrow_drop_down),
            buttonText: const Text("Chọn nơi làm việc",
                style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.GREY,
                )),
            cancelText: const Text("Hủy bỏ"),
            confirmText: const Text("Chọn"),
            title: const Text(
              "Chọn nơi làm việc",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
