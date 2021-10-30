import 'package:template/data/model/response/bao_hiem_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';

class DangKyBaoHiemResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  BaoHiemResponse? idBaoHiem;
  String? file;
  String? trangThai;
  String? ngayHetHan;
  String? phi;

  String? createdAt;
  String? updatedAt;

  DangKyBaoHiemResponse(
      {this.id,
      this.idTaiKhoan,
      this.idBaoHiem,
      this.file,
      this.trangThai,
      this.ngayHetHan,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  DangKyBaoHiemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }

    // mapping idBaoHiem
    if (json['idBaoHiem'] != null &&
        json['idBaoHiem'].toString().length != 24) {
      idBaoHiem =
          BaoHiemResponse.fromJson(json['idBaoHiem'] as Map<String, dynamic>);
    } else {
      idBaoHiem = null;
    }
    file = json['file'].toString();
    trangThai = json['trangThai'].toString();
    ngayHetHan = json['ngayHetHan'].toString();
    phi = json['phi'].toString();

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

    // check null idBaoHiem
    if (idBaoHiem != null) data['idBaoHiem'] = idBaoHiem;

    // check null file
    if (file != null) data['file'] = file;

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai;

    // check null ngayHetHan
    if (ngayHetHan != null) data['ngayHetHan'] = ngayHetHan;

    // check null phi
    if (phi != null) data['phi'] = phi;

    return data;
  }
}
