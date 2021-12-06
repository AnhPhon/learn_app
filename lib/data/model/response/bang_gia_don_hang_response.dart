import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/utils/validate.dart';

class BangGiaDonHangResponse {
  String? id;
  String? tieuDe;
  String? giaTien;
  String? donViTinh;
  LoaiCongViecResponse? idLoaiCongViec;

  String? createdAt;
  String? updatedAt;

  BangGiaDonHangResponse({this.id, this.tieuDe, this.giaTien, this.donViTinh, this.idLoaiCongViec, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  BangGiaDonHangResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tieuDe = json['tieuDe'].toString();
    giaTien = json['giaTien'].toString();
    donViTinh = json['donViTinh'].toString();
    if (json['idLoaiCongViec'] != null && json['idLoaiCongViec'] != 'null' && json['idLoaiCongViec'].toString().length != 24) {
      idLoaiCongViec = LoaiCongViecResponse.fromJson(json['idLoaiCongViec'] as Map<String, dynamic>);
      print('Parse id loai cong viec $idLoaiCongViec');
    } else {
      idLoaiCongViec = null;
    }

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    // check null giaTien
    if (giaTien != null) data['giaTien'] = giaTien;

    // check null donViTinh
    if (donViTinh != null) data['donViTinh'] = donViTinh;

    // check null idLoaiCongViec
    if (idLoaiCongViec != null) data['idLoaiCongViec'] = idLoaiCongViec;

    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return tieuDe!;
  }

  ///this method will prevent the override of toString
  bool filterSearchByName(String filter) {
    final String _s = Validate.removeVietnameseTones(tieuDe.toString());
    return _s.contains(filter);
  }

  ///this method will prevent the override of toString
  String showNameDropDown() {
    return tieuDe!;
  }
}
