import 'tinh_tp_response.dart';

class QuanHuyenResponse {
  String? id;
  TinhTpResponse? idTinhTp;
  String? ten;

  String? createdAt;
  String? updatedAt;

  QuanHuyenResponse(
      {this.id, this.idTinhTp, this.ten, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  QuanHuyenResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTinhTp
    if (json['idTinhTp'] != null && json['idTinhTp'].toString().length != 24) {
      idTinhTp =
          TinhTpResponse.fromJson(json['idTinhTp'] as Map<String, dynamic>);
    } else {
      idTinhTp = null;
    }
    if(json['ten'] != null) ten = json['ten'].toString();

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

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null ten
    if (ten != null) data['ten'] = ten;

    return data;
  }

  @override
  String toString() {
    return ten.toString();
  }

}
