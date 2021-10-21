import 'tai_khoan_response.dart';

class DangKyThueResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? file;
  String? trangThai;
  List<dynamic>? hinhAnhs;
  String? loai;

  String? createdAt;
  String? updatedAt;

  DangKyThueResponse({
      this.id,
      this.idTaiKhoan,
      this.file,
      this.trangThai,
      this.hinhAnhs,
      this.loai,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  DangKyThueResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }
    file = json['file'].toString();
    trangThai = json['trangThai'].toString();
    hinhAnhs = json['hinhAnhs'] as List<dynamic>;
    loai = json['loai'].toString();

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

    // check null file
    if (file != null) data['file'] = file;

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai;

    // check null hinhAnh
    if (hinhAnhs != null) data['hinhAnh'] = hinhAnhs; 

    // check null loai
    if (loai != null) data['loai'] = loai; 


    return data;
  }
}
