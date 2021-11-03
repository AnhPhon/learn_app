import 'tai_khoan_response.dart';

class LoaiVanChuyenResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? tieuDe;

  String? createdAt;
  String? updatedAt;

  LoaiVanChuyenResponse(
      {this.id, this.idTaiKhoan, this.tieuDe, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  LoaiVanChuyenResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }
    tieuDe = json['tieuDe'].toString();

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

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    return data;
  }

  @override
  String toString() {
    return tieuDe.toString();
  }
}
