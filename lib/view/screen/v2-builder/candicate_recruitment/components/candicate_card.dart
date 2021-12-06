import 'package:flutter/material.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';

import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';

class V2CandidateCard extends StatelessWidget {
  V2CandidateCard(
      {Key? key,
      this.showEmailAndPass = true,
      required this.dangKyViecMoiResponse})
      : super(key: key);
  final bool? showEmailAndPass;
  DangKyViecMoiResponse? dangKyViecMoiResponse;
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
                dangKyViecMoiResponse!.tieuDe.toString(),
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
                          urlImage: dangKyViecMoiResponse!
                              .idTaiKhoan!.hinhDaiDien
                              .toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          dangKyViecMoiResponse!.maSoHoSo.toString(),
                          style: const TextStyle(
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
                            content: dangKyViecMoiResponse!.idTaiKhoan == null
                                ? ''
                                : ' ${dangKyViecMoiResponse!.idTaiKhoan!.hoTen}'),
                        _titleIcon(
                            context: context,
                            icon: Icons.calendar_today,
                            content: dangKyViecMoiResponse!.ngaySinh == null
                                ? ''
                                : ' ${DateConverter.readMongoToString(dangKyViecMoiResponse!.ngaySinh.toString())}'),
                        _titleIcon(
                            context: context,
                            icon: Icons.phone,
                            content: showEmailAndPass!
                                ? dangKyViecMoiResponse!.idTaiKhoan == null
                                    ? ''
                                    : ' ${dangKyViecMoiResponse!.idTaiKhoan!.soDienThoai}'
                                : "*********"),
                        _titleIcon(
                            context: context,
                            icon: Icons.score,
                            content: dangKyViecMoiResponse!.idSoNamKinhNghiem ==
                                    null
                                ? ''
                                : ' ${dangKyViecMoiResponse!.idSoNamKinhNghiem!.tieuDe}'),
                        _titleIcon(
                            context: context,
                            icon: Icons.email,
                            content: showEmailAndPass!
                                ? dangKyViecMoiResponse!.idTaiKhoan == null
                                    ? ''
                                    : ' ${dangKyViecMoiResponse!.idTaiKhoan!.email}'
                                : "*********"),
                        _titleIcon(
                            context: context,
                            icon: Icons.place,
                            content: dangKyViecMoiResponse!.idTaiKhoan == null
                                ? ''
                                : ' ${dangKyViecMoiResponse!.idTaiKhoan!.diaChi}, ${dangKyViecMoiResponse!.idTaiKhoan!.idPhuongXa}, ${dangKyViecMoiResponse!.idTaiKhoan!.idQuanHuyen}, ${dangKyViecMoiResponse!.idTaiKhoan!.idTinhTp}'),
                        _titleIcon(
                            context: context,
                            icon: Icons.family_restroom,
                            content: dangKyViecMoiResponse!.honNhan == null
                                ? ''
                                : dangKyViecMoiResponse!.honNhan.toString() ==
                                        '1'
                                    ? ' Độc thân'
                                    : dangKyViecMoiResponse!.honNhan
                                                .toString() ==
                                            '2'
                                        ? ' Đã lập gia đình'
                                        : ' Khác'),
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
