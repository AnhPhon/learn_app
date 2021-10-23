import 'package:flutter/material.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/helper/date_converter.dart';

import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
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
            TextHighlight(
                title: "Tiêu đề: ",
                content: dangKyViecMoiResponse!.tieuDe.toString()),
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
                        child: Image.asset(
                          Images.admin_background,
                          height: Dimensions.AVATAR_SQUARE_SIZE_EXTRA_LARGE,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          "MSHS: 123456789",
                          style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
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
                                dangKyViecMoiResponse!.idTaiKhoan!.ngaySinh
                                    .toString())),
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
                            content: dangKyViecMoiResponse!.honNhan.toString()),
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
