import 'quan_huyen_response.dart';

class PhuongXaResponse {
  String? id;
  QuanHuyenResponse? idQuanHuyen;
  String? ten;

  String? createdAt;
  String? updatedAt;

  PhuongXaResponse(
      {this.id, this.idQuanHuyen, this.ten, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  PhuongXaResponse.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) id = json['id'].toString();

    // mapping idQuanHuyen
    if (json['idQuanHuyen'] != null &&
        json['idQuanHuyen'].toString().length != 24) {
      idQuanHuyen = QuanHuyenResponse.fromJson(
          json['idQuanHuyen'] as Map<String, dynamic>);
    } else {
      idQuanHuyen = null;
    }
    ten = json['ten'].toString();

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

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null ten
    if (ten != null) data['ten'] = ten;

    return data;
  }

  @override
  String toString() {
    return ten!;
  }
}
