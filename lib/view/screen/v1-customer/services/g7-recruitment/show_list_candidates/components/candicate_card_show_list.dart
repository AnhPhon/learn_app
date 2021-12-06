import 'package:flutter/material.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';

import 'package:template/helper/dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';

class CandidateCardShowList extends StatelessWidget {
  DangKyViecMoiResponse? dangKyViecMoiResponse;

  CandidateCardShowList(
      {Key? key, this.dangKyViecMoiResponse, this.showEmailAndPass = true})
      : super(key: key);
  final bool? showEmailAndPass;
  @override
  Widget build(BuildContext context) {
    print(dangKyViecMoiResponse!.idPhuongXa);
    return dangKyViecMoiResponse == null ? const SizedBox.shrink() : Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child: BoxShadowWidget(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
              child: Text(
                dangKyViecMoiResponse == null ? '' : dangKyViecMoiResponse!.tieuDe.toString(),
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
                          urlImage: dangKyViecMoiResponse == null ? '' : dangKyViecMoiResponse!
                              .idTaiKhoan!.hinhDaiDien
                              .toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          dangKyViecMoiResponse == null ? '' : dangKyViecMoiResponse!.maSoHoSo.toString(),
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
                            content: dangKyViecMoiResponse!.tenUngVien == null
                                ? ''
                                : ' ${dangKyViecMoiResponse!.tenUngVien}'),
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
                                    : ' ${dangKyViecMoiResponse!.soDienThoai}'
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
                                ? dangKyViecMoiResponse!.email == null
                                    ? ''
                                    : ' ${dangKyViecMoiResponse!.email}'
                                : "*********"),
                        _titleIcon(
                            context: context,
                            icon: Icons.place,
                            content: Validate.nullOrEmpty(dangKyViecMoiResponse!.idPhuongXa) || Validate.nullOrEmpty(dangKyViecMoiResponse!.idQuanHuyen) || Validate.nullOrEmpty(dangKyViecMoiResponse!.idTinhTp)
                                ? ''
                                : '${dangKyViecMoiResponse!.idPhuongXa!.ten}, ${dangKyViecMoiResponse!.idQuanHuyen!.ten}, ${dangKyViecMoiResponse!.idTinhTp!.ten}'),
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
