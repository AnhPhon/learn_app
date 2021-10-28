import 'package:flutter/material.dart';
import 'package:template/data/model/request/loai_bao_cao_nhan_vien.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class V4DropButtonAppBar extends StatelessWidget {
  const V4DropButtonAppBar({
    Key? key,
    required this.hint,
    required this.onChanged,
    required this.data,
    this.value,
    // this.selectedItemBuilder,
    // required this.onPressed,

  }) : super(key: key);

  final String hint;
  final Function(BaoCaoNhanVienModel? value) onChanged;
  final List<BaoCaoNhanVienModel> data;
  final BaoCaoNhanVienModel? value;
  // final DropdownButtonBuilder? selectedItemBuilder;
  // final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<BaoCaoNhanVienModel>(
        dropdownColor: ColorResources.APPBARCOLOR,
        hint: Text(hint),
        value: value,
        icon: const Icon(
          Icons.filter_alt_outlined,
          color: ColorResources.WHITE,
        ),
        // ignore: avoid_redundant_argument_values
        iconSize: Dimensions.ICON_SIZE_DEFAULT,
        elevation: 16,
        // selectedItemBuilder: (BuildContext context) {
        //   return onClickToDailyReport(context);
        // },
        onChanged: onChanged,
        // onTap: onTap,
        items: data
            .map<DropdownMenuItem<BaoCaoNhanVienModel>>(
                (BaoCaoNhanVienModel e) => DropdownMenuItem<BaoCaoNhanVienModel>(
                    value: e,
                    child: Text(
                      e.tieuDe.toString(),
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: ColorResources.WHITE,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )))
            .toList(),
      ),
    );
  }
}
