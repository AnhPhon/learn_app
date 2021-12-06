import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';

import 'tai_khoan_response.dart';
import 'loai_tot_nghiep_response.dart';

class BangBangCapResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  TrinhDoHocVanResponse? idTrinhDo;
  LoaiCongViecResponse? idChuyenMon;
  LoaiTotNghiepResponse? idLoaiTotNghiep;
  String? namTotNghiep;
  String? donViDaoTao;
  List<dynamic>? anhBangCap;

  String? createdAt;
  String? updatedAt;

  BangBangCapResponse(
      {this.id,
      this.idTaiKhoan,
      this.idTrinhDo,
      this.idChuyenMon,
      this.idLoaiTotNghiep,
      this.namTotNghiep,
      this.donViDaoTao,
      this.anhBangCap,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  BangBangCapResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }

    // mapping idTrinhDo
    if (json['idTrinhDoHocVan'] != null &&
        json['idTrinhDoHocVan'].toString().length != 24) {
      idTrinhDo = TrinhDoHocVanResponse.fromJson(
          json['idTrinhDoHocVan'] as Map<String, dynamic>);
    } else {
      idTrinhDo = null;
    }

    // mapping idChuyenMon
    if (json['idLoaiCongViec'] != null &&
        json['idLoaiCongViec'].toString().length != 24) {
      idChuyenMon = LoaiCongViecResponse.fromJson(
          json['idLoaiCongViec'] as Map<String, dynamic>);
    } else {
      idChuyenMon = null;
    }

    // mapping idLoaiTotNghiep
    if (json['idLoaiTotNghiep'] != null &&
        json['idLoaiTotNghiep'].toString().length != 24) {
      idLoaiTotNghiep = LoaiTotNghiepResponse.fromJson(
          json['idLoaiTotNghiep'] as Map<String, dynamic>);
    } else {
      idLoaiTotNghiep = null;
    }
    namTotNghiep = json['namTotNghiep'].toString();
    donViDaoTao = json['donViDaoTao'].toString();

    if (json['anhBangCaps'] != null) {
      anhBangCap = json['anhBangCaps'] as List<dynamic>;
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

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null idTrinhDo
    if (idTrinhDo != null) data['idTrinhDoHocVan'] = idTrinhDo;

    // check null idChuyenMon
    if (idChuyenMon != null) data['idLoaiCongViec'] = idChuyenMon;

    // check null idLoaiTotNghiep
    if (idLoaiTotNghiep != null) data['idLoaiTotNghiep'] = idLoaiTotNghiep;

    // check null namTotNghiep
    if (namTotNghiep != null) data['namTotNghiep'] = namTotNghiep;

    // check null donViDaoTao
    if (donViDaoTao != null) data['donViDaoTao'] = donViDaoTao;

    // check null anhBangCap
    if (anhBangCap != null) {
      data['anhBangCaps'] = anhBangCap;
    }

    return data;
  }

  @override
  String toString() {
    // TODO: return all properties
    return 'id: $id \n anhBangCap: $anhBangCap ';//....
  }


  // get id
  String getId(){
    return id.toString();
  }
  // get label
  String getlabel(){
    return namTotNghiep.toString();
  }
}
