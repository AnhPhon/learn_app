import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:template/data/model/response/bang_gia_don_hang_response.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_cong_trinh_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:template/utils/validate.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchDropDownButton<T> extends StatelessWidget {
  const SearchDropDownButton({
    Key? key,
    this.hint = "",
    this.onChanged,
    required this.data,
    required this.width,
    required this.value,
    this.label,
    this.customHintText = false,
    required this.obligatory,
    this.paddingTop = Dimensions.PADDING_SIZE_LARGE,
    this.isColorFieldWhite = false,
    this.isEnable = true,
    this.isHideLineButton = false,
    this.padding,
    this.fillColor,
    this.smallSizeHintText = false,
    this.valueClearSelected,
    this.contentPadding,
    this.focusNode,
    this.fontSize,
    this.highLightHint = false,
    this.isSort = true,
  }) : super(key: key);
  final String? hint;
  final double width;
  final Function(T? value)? onChanged;
  final String? label;
  final bool? obligatory;
  final List<T> data;
  final double? paddingTop;
  final bool? isColorFieldWhite, isSort;
  final T? value;
  final bool? isEnable;
  final EdgeInsetsGeometry? padding;
  final bool? isHideLineButton;
  final Color? fillColor;
  final T? valueClearSelected;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final double? fontSize;
  final bool? highLightHint, smallSizeHintText, customHintText;

  @override
  Widget build(BuildContext context) {
    //sort list
    if (isSort!) {
      sortWithClearSelected();
    }

    return Container(
      // height: 55,
      width: width,
      padding: padding ?? EdgeInsets.zero,

      child: Column(
        children: [
          if (label != null)
            Container(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                        text: label,
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                          fontWeight: FontWeight.w600,
                          color: ColorResources.BLACK,
                        ),
                        children: [
                      if (obligatory!)
                        const TextSpan(
                          text: '*',
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )
                      else
                        const TextSpan(),
                    ])))
          else
            const SizedBox.shrink(),
          DropdownSearch<T>(
            key: UniqueKey(),
            // searchDelay: const Duration(microseconds: 0),
            enabled: isEnable!,
            items: data.map((e) => e).toList(),
            // hint: hint,
            dropdownBuilder: (context, selectedItem) {
              return Text(
                Validate.checkValueIsNullEmpty(value) == false
                    ? selectedItem
                        .toString()
                        .replaceAll('Phường', '')
                        .replaceAll('Xã', '')
                        .replaceAll('Thị trấn', '')
                    : hint!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: smallSizeHintText == false
                      ? Dimensions.FONT_SIZE_LARGE
                      : Dimensions.FONT_SIZE_DEFAULT,
                  color: customHintText == false
                      ? isEnable! || highLightHint!
                          ? ColorResources.BLACK
                          : ColorResources.GREY
                      : ColorResources.GREY,
                ),
              );
            },
            dropdownSearchDecoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: smallSizeHintText == false
                      ? Dimensions.FONT_SIZE_LARGE
                      : Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: highLightHint!
                      ? ColorResources.BLACK
                      : ColorResources.BLACK.withOpacity(0.4)),
              isDense: true,
              filled: true,
              fillColor: fillColor ?? Colors.transparent,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledSize(context, 0.025),
                    vertical: DeviceUtils.getScaledSize(context, 0.03),
                  ),
              disabledBorder: OutlineInputBorder(
                borderSide: isHideLineButton!
                    ? BorderSide.none
                    : const BorderSide(color: ColorResources.PRIMARYCOLOR),
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: isHideLineButton!
                    ? BorderSide.none
                    : const BorderSide(color: ColorResources.PRIMARYCOLOR),
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                borderSide: isHideLineButton!
                    ? BorderSide.none
                    : const BorderSide(color: ColorResources.PRIMARY),
              ),
            ),
            // ),
            showAsSuffixIcons: true,
            dropdownSearchTextAlign: TextAlign.center,
            dropDownButton: Icon(Icons.arrow_drop_down,
                color: highLightHint! && isEnable!
                    ? ColorResources.BLACK
                    : ColorResources.BLACK.withOpacity(0.4)),
            showSearchBox: true,
            onChanged: (val) {
              onChanged!(val);
              DeviceUtils.unFocus(context);
            },
            selectedItem: value,
            itemAsString: (T? item) => itemAsString(item),
            filterFn: (T? item, String? filter) => filterFn(item, filter),
            emptyBuilder: (context, searchEntry) =>
                const Center(child: Text("Không có dữ liệu")),
          ),
        ],
      ),
    );
  }

  String itemAsString(T? item) {
    if (item != null) {
      if (item.runtimeType == String) {
        return item.toString();
      } else {
        return item.toString();
      }
    }
    return 'Không có';
  }

  bool filterFn(T? item, String? filter) {
    final _filter = Validate.removeVietnameseTones(filter.toString());
    if (item != null) {
      if (item.runtimeType == String) {
        return Validate.removeVietnameseTones(item.toString())
            .contains(_filter);
      } else {
        final String _s = Validate.removeVietnameseTones(item.toString());
        return _s.contains(_filter);
      }
    }
    return false;
  }

  List sortWithClearSelected() {
    if (isSort == true) {
      data.sort((a, b) => TiengViet.parse(a.toString().toLowerCase())
          .compareTo(TiengViet.parse(b.toString().toLowerCase())));
    }

    if (data.isNotEmpty) {
      final value = data.first;
      if (value.runtimeType == LoaiCongViecResponse) {
        final index = (data as List<LoaiCongViecResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == NhomDichVuResponse) {
        final index = (data as List<NhomDichVuResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == TinhTpResponse) {
        final index = (data as List<TinhTpResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == QuanHuyenResponse) {
        final index = (data as List<QuanHuyenResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == PhuongXaResponse) {
        final index = (data as List<PhuongXaResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == LoaiCongTrinhResponse) {
        final index = (data as List<LoaiCongTrinhResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == DanhMucSanPhamResponse) {
        final index = (data as List<DanhMucSanPhamResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == BangGiaDonHangResponse) {
        final index = (data as List<BangGiaDonHangResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == HinhThucLamViecResponse) {
        final index = (data as List<HinhThucLamViecResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == TrinhDoHocVanResponse) {
        final index = (data as List<TrinhDoHocVanResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == ChuyenNganhChinhResponse) {
        final index = (data as List<ChuyenNganhChinhResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == SoNamKinhNghiemResponse) {
        final index = (data as List<SoNamKinhNghiemResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == MucLuongDuKienResponse) {
        final index = (data as List<MucLuongDuKienResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == ThoiGianLamViecResponse) {
        final index = (data as List<ThoiGianLamViecResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == VatTuResponse) {
        final index = (data as List<VatTuResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      } else if (value.runtimeType == NhomCuaHangResponse) {
        final index = (data as List<NhomCuaHangResponse>).indexWhere(
            (element) => Validate.checkValueIsNullEmpty(element.id));
        if (index != -1) {
          data.insert(0, data.removeAt(index));
        }
        return data;
      }
    }

    return data;
  }
}
