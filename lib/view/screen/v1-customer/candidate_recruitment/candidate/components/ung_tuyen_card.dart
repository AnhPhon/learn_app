import 'package:flutter/material.dart';
import 'package:template/data/model/response/danh_sach_ung_tuyen_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';

class UngTuyenCard extends StatelessWidget {
  DanhSachUngTuyenResponse? danhSachUngTuyenResponse;

  UngTuyenCard(
      {Key? key, this.danhSachUngTuyenResponse, this.showEmailAndPass = true})
      : super(key: key);
  final bool? showEmailAndPass;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: BoxShadowWidget(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
              child: Text(
                danhSachUngTuyenResponse!.idTuyenDung!.tieuDe.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        child: FadeInImageCustom(
                          height: 0.3,
                          width: 1,
                          urlImage: danhSachUngTuyenResponse!.idTuyenDung!
                              .idTaiKhoan!.hinhDaiDien
                              .toString(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          "Mã số",
                          style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleIcon(
                            context: context,
                            icon: Icons.people,
                            content: danhSachUngTuyenResponse!.idTuyenDung!.hoTenLienHe == null
                                ? ''
                                : ' ${danhSachUngTuyenResponse!.idTuyenDung!.hoTenLienHe}'),
                        _titleIcon(
                            context: context,
                            icon: Icons.calendar_today,
                            content: danhSachUngTuyenResponse!.idTuyenDung!.idTaiKhoan!.ngaySinh == null
                                ? ''
                                : ' ${DateConverter.readMongoToString(danhSachUngTuyenResponse!.idTuyenDung!.idTaiKhoan!.ngaySinh.toString())}'),
                        _titleIcon(
                            context: context,
                            icon: Icons.phone,
                            content: showEmailAndPass!
                                ? danhSachUngTuyenResponse!.idTuyenDung!.idTaiKhoan == null
                                    ? ''
                                    : ' ${danhSachUngTuyenResponse!.idTuyenDung!.idTaiKhoan!.soDienThoai}'
                                : "*********"),
                        _titleIcon(
                            context: context,
                            icon: Icons.score,
                            content: danhSachUngTuyenResponse!.idTuyenDung!.idSoNamKinhNghiem ==
                                    null
                                ? ''
                                : ' ${danhSachUngTuyenResponse!.idTuyenDung!.idSoNamKinhNghiem!.tieuDe}'),
                        _titleIcon(
                            context: context,
                            icon: Icons.email,
                            content: showEmailAndPass!
                                ? danhSachUngTuyenResponse!.idTuyenDung == null
                                    ? ''
                                    : ' ${danhSachUngTuyenResponse!.idTuyenDung!.emailLienHe}'
                                : "*********"),
                        _titleIcon(
                            context: context,
                            icon: Icons.place,
                            content: danhSachUngTuyenResponse!.idTuyenDung!.diaChi == null
                                ? ''
                                : ' ${danhSachUngTuyenResponse!.idTuyenDung!.diaChi}, ${danhSachUngTuyenResponse!.idTuyenDung!.idTinhTp!.ten}, ${danhSachUngTuyenResponse!.idTuyenDung!.idQuanHuyen!.ten}, ${danhSachUngTuyenResponse!.idTuyenDung!.idPhuongXa!.ten}'),
                        
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _titleIcon(
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
}
