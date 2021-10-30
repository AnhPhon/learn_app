import 'package:flutter/material.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/helper/date_converter.dart';

import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';

class CandidateCard extends StatelessWidget {
  DangKyViecMoiResponse? dangKyViecMoiResponse;

  CandidateCard(
      {Key? key, this.dangKyViecMoiResponse, this.showEmailAndPass = true})
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
              child: TextHighlight(
                  title: "Tiêu đề: ",
                  content: dangKyViecMoiResponse!.tieuDe.toString()),
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
                        TextHighlight(
                            title: "Tên: ",
                            content: dangKyViecMoiResponse!.idTaiKhoan!.hoTen
                                .toString()),
                        TextHighlight(
                            title: "Ngày sinh: ",
                            content: DateConverter.readMongoToString(
                                dangKyViecMoiResponse!.ngaySinh.toString())),
                        TextHighlight(
                            title: "Điện thoại: ",
                            content: showEmailAndPass!
                                ? dangKyViecMoiResponse!.idTaiKhoan!.soDienThoai
                                    .toString()
                                : "*********"),
                        TextHighlight(
                            title: "Kinh nghiệm: ",
                            content: dangKyViecMoiResponse!
                                .idSoNamKinhNghiem!.tieuDe
                                .toString()),
                        TextHighlight(
                            title: "Email: ",
                            content: showEmailAndPass!
                                ? dangKyViecMoiResponse!.idTaiKhoan!.email
                                    .toString()
                                : "*************"),
                        TextHighlight(
                            title: "Chỗ ở hiện tại: ",
                            content:
                                '${dangKyViecMoiResponse!.idTaiKhoan!.diaChi}, ${dangKyViecMoiResponse!.idTaiKhoan!.idPhuongXa}, ${dangKyViecMoiResponse!.idTaiKhoan!.idQuanHuyen}, ${dangKyViecMoiResponse!.idTaiKhoan!.idTinhTp}'),
                        TextHighlight(
                            title: "Hôn nhân: ",
                            content:
                                dangKyViecMoiResponse!.honNhan.toString() == '1'
                                    ? 'Độc thân'
                                    : dangKyViecMoiResponse!.honNhan
                                                .toString() ==
                                            '2'
                                        ? 'Đã lập gia đình'
                                        : 'Khác'),
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
}
