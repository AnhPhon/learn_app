class DuAnKhachHangRequest {
  String? id;
  String? idTaiKhoan;
  String? ten;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? diaDiem;
  String? gioiThieu;
  String? giaDuyet;
  String? idHangMucXayDung;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? thoiGianYeuCau;
  String? file;
  String? hinhAnhDaiDien;
  String? idTrangThaiDuAn;
  String? taiKhoanTrungThau;
  DuAnKhachHangRequest({
      this.id,
      this.idTaiKhoan,
      this.ten,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaDiem,
      this.gioiThieu,
      this.giaDuyet,
      this.idHangMucXayDung,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.thoiGianYeuCau,
      this.file,
      this.hinhAnhDaiDien,
      this.idTrangThaiDuAn,
      this.taiKhoanTrungThau});
  
  ///
  /// From JSON
  ///
  DuAnKhachHangRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    ten = json['ten'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    diaDiem = json['diaDiem'].toString();
    gioiThieu = json['gioiThieu'].toString();
    giaDuyet = json['giaDuyet'].toString();
    idHangMucXayDung = json['idHangMucXayDung'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    thoiGianYeuCau = json['thoiGianYeuCau'].toString();
    file = json['file'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();
    idTrangThaiDuAn = json['idTrangThaiDuAn'].toString();
    taiKhoanTrungThau = json['taiKhoanTrungThau'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['ten'] = ten;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['diaDiem'] = diaDiem;
    data['gioiThieu'] = gioiThieu;
    data['giaDuyet'] = giaDuyet;
    data['idHangMucXayDung'] = idHangMucXayDung;
    data['ngayBatDau'] = ngayBatDau;
    data['ngayKetThuc'] = ngayKetThuc;
    data['thoiGianYeuCau'] = thoiGianYeuCau;
    data['file'] = file;
    data['hinhAnhDaiDien'] = hinhAnhDaiDien;
    data['idTrangThaiDuAn'] = idTrangThaiDuAn;
    data['taiKhoanTrungThau'] = taiKhoanTrungThau;
    return data;
  }
}
