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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null ten
    if (ten != null) data['ten'] = ten; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null diaDiem
    if (diaDiem != null) data['diaDiem'] = diaDiem; 

    // check null gioiThieu
    if (gioiThieu != null) data['gioiThieu'] = gioiThieu; 

    // check null giaDuyet
    if (giaDuyet != null) data['giaDuyet'] = giaDuyet; 

    // check null idHangMucXayDung
    if (idHangMucXayDung != null) data['idHangMucXayDung'] = idHangMucXayDung; 

    // check null ngayBatDau
    if (ngayBatDau != null) data['ngayBatDau'] = ngayBatDau; 

    // check null ngayKetThuc
    if (ngayKetThuc != null) data['ngayKetThuc'] = ngayKetThuc; 

    // check null thoiGianYeuCau
    if (thoiGianYeuCau != null) data['thoiGianYeuCau'] = thoiGianYeuCau; 

    // check null file
    if (file != null) data['file'] = file; 

    // check null hinhAnhDaiDien
    if (hinhAnhDaiDien != null) data['hinhAnhDaiDien'] = hinhAnhDaiDien; 

    // check null idTrangThaiDuAn
    if (idTrangThaiDuAn != null) data['idTrangThaiDuAn'] = idTrangThaiDuAn; 

    // check null taiKhoanTrungThau
    if (taiKhoanTrungThau != null) data['taiKhoanTrungThau'] = taiKhoanTrungThau; 


    return data;
  }
}
