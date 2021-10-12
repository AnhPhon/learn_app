class NhanVienRequest {
  String? id;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? hoTen;
  String? soDienThoai;
  String? gioiTinh;
  String? cMND;
  String? ngayCap;
  String? noiCap;
  String? diaChi;
  String? hinhDaiDien;
  String? anhMTCMND;
  String? anhMSCMND;
  String? matKhau;
  String? tokenDevice;
  NhanVienRequest({
      this.id,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.hoTen,
      this.soDienThoai,
      this.gioiTinh,
      this.cMND,
      this.ngayCap,
      this.noiCap,
      this.diaChi,
      this.hinhDaiDien,
      this.anhMTCMND,
      this.anhMSCMND,
      this.matKhau,
      this.tokenDevice});
  
  ///
  /// From JSON
  ///
  NhanVienRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    hoTen = json['hoTen'].toString();
    soDienThoai = json['soDienThoai'].toString();
    gioiTinh = json['gioiTinh'].toString();
    cMND = json['cMND'].toString();
    ngayCap = json['ngayCap'].toString();
    noiCap = json['noiCap'].toString();
    diaChi = json['diaChi'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();
    anhMTCMND = json['anhMTCMND'].toString();
    anhMSCMND = json['anhMSCMND'].toString();
    matKhau = json['matKhau'].toString();
    tokenDevice = json['tokenDevice'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['hoTen'] = hoTen;
    data['soDienThoai'] = soDienThoai;
    data['gioiTinh'] = gioiTinh;
    data['cMND'] = cMND;
    data['ngayCap'] = ngayCap;
    data['noiCap'] = noiCap;
    data['diaChi'] = diaChi;
    data['hinhDaiDien'] = hinhDaiDien;
    data['anhMTCMND'] = anhMTCMND;
    data['anhMSCMND'] = anhMSCMND;
    data['matKhau'] = matKhau;
    data['tokenDevice'] = tokenDevice;
    return data;
  }
}
